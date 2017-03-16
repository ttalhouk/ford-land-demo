class ServiceMailer < ApplicationMailer
  default from: 'service_notifications@example.com'

  def service_email(user, service_request)
    @user = user
    @service_dept_emails = User.where(admin: true).map{ |admin| admin.email }.join(';')
    @service = service_request
    mail(to: @service_dept_emails, subject: 'Service Request', from: @user.email)
  end

  def service_response_email(admin, user, service_request)
    @admin = admin
    @service = service_request
    mail(to: user.email, subject: 'Service Request Updated', from: admin.email)
  end
end
