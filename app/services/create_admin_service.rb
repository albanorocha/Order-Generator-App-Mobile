class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|

        user.name = Rails.application.secrets.admin_name
        user.username = Rails.application.secrets.admin_username
        user.company = Rails.application.secrets.admin_company
        user.password = Rails.application.secrets.admin_password
        user.password_confirmation = Rails.application.secrets.admin_password
        user.admin!
      end
  end
end
