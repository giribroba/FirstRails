module Admin
    private
        def is_admin
            
            unless params[:key] == Rails.application.credentials.dig(:admin_key)
                render json: {error: 'Access denied'}, status: :unauthorized
            end

        end
end