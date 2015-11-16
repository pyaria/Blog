ActionMailer::Base.smtp_settings = {
  address:              "smtp.gmail.com",
  port:                 "587", # specific to gmail server
  enable_starttls_auto: true, # specific to gmail server
  authentication:       :plain, # specific to gmail server
  user_name:            ENV["email_user_name"], #answerawesome
  password:             ENV["email_password"], #Sup3r$ecret
}
