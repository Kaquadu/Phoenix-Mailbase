defmodule Mailbase.Sender do
  alias Mailbase.Mailer
  import Bamboo.Mailer
  import Bamboo.Email

  def send_email(receivers, schedule, user_data) do
    receivers
    |> Enum.each(fn receiver ->
      receiver.email |> IO.inspect
      receiver
      |> create_email(schedule, user_data)
      |> set_config(user_data)
      |> Mailer.deliver_now()
      end)
  end

  def set_config(receiver, user_data) do
    receiver
    |> Bamboo.ConfigAdapter.Email.put_config(%{
      server: user_data.server_name,
      hostname: user_data.domain_name,
      username: user_data.hosting_mail,
      password: user_data.hosting_password,
      port: user_data.port,
      tls: :if_available,
      allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"],
      ssl: true
      })
  end

  def create_email(receiver, schedule, user_data) do
    new_email(
      to: receiver.email,
      from: user_data.hosting_mail,
      subject: schedule.email_title,
      html_body: schedule.email_text,
      text_body: schedule.email_text
    )
  end
end
