# Be sure to restart your server when you modify this file.

Skarminkels::Application.config.session_store :cookie_store, :key => '_skarminkels_session'

# ActionController::Base.session = {
#     :key         => '_uploadify_rails_session',
#     :secret      => '9c710acbd1f9a1ff1b3ba15f34c79b34'
#   }
# test test
# Rails.application.config.middleware.insert_before(
#   ActionDispatch::Session::CookieStore,
#   FlashSessionCookieMiddleware,
#   Rails.application.config.session_options[:key]
# )

Rails.application.config.middleware.insert_before(
  Rails.application.config.session_store,
  FlashSessionCookieMiddleware, 
  Rails.application.config.session_options[:key])

# ActionController::Dispatcher.middleware.insert_before(
#     ActionController::Session::CookieStore,
#     FlashSessionCookieMiddleware, # <-- here is where it goes!
#     ActionController::Base.session_options[:key]
#     )

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Skarminkels::Application.config.session_store :active_record_store
