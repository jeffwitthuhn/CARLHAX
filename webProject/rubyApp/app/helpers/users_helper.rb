module UsersHelper
  NAME_FROM_EMAIL_REGEX = /^[^@]*/i

  def admin?
    current_user.admin?
  end

  def extract_name_from email
    email.match NAME_FROM_EMAIL_REGEX
  end
end
