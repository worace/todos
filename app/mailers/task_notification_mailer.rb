class TaskNotificationMailer < ApplicationMailer
  default from: "horace@turing.io"

  def cc_email(email, task)
    @task = task
    mail(to: email, subject: 'someone wants to bug u about a task')
  end
end
