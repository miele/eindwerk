require 'rack/oauth2'

class FacebooksController < ApplicationController
 
  # handle Facebook Auth Cookie generated by JavaScript SDK
  def show
    auth = Facebook.auth.from_cookie(cookies)
    authenticate Facebook.identify(auth.user)
    redirect_to dashboard_url
  end

  # handle Normal OAuth flow: start
  def new
  
  fb_auth = FbGraph::Auth.new('155275974530339', '309d340d359061c890906926e8139e4a')
  fb_auth.client # => Rack::OAuth2::Client
  
    client = fb_auth.client
  client.redirect_uri = "http://localhost:3000/config_keys"

  # redirect user to facebook
  redirect_to client.authorization_uri(
    :scope => [:email, :read_stream, :offline_access]
  )

  # in callback
  client.authorization_code = params[:code]
  access_token = client.access_token!  # => Rack::OAuth2::AccessToken
  FbGraph::User.me(access_token).fetch # => FbGraph::User
  
  end

  # handle Normal OAuth flow: callback
  def create
    client.authorization_code = params[:code]
    access_token = client.access_token!
    puts access_token
  end

  def destroy
    unauthenticate
    redirect_to root_url
  end

  private

  def client
    unless @client
      @client = Facebook.auth.client
      @client.redirect_uri = callback_facebook_url
    end
    @client
  end

end
