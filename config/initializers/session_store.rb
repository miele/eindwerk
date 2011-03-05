# Be sure to restart your server when you modify this file.

Skarminkels::Application.config.session_store :cookie_store, :key => '_skarminkels_session'

Rails.application.config.middleware.insert_before(
  ActionDispatch::Session::CookieStore,
  FlashSessionCookieMiddleware,
  Rails.application.config.session_options[:key]
)

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Skarminkels::Application.config.session_store :active_record_store
