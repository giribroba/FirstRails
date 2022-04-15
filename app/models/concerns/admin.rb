module Admin
    private
        def is_admin
            params[:key] == Rails.application.credentials.dig(:admin_key)
        end
end