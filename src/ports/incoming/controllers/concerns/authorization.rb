module Authorization
  extend ActiveSupport::Concern

  included do
    private

    def authorize!
      unless Current.user&.admin?
        redirect_to productos_path, alert: "Necesitas permisos de administrador para esta acción"
      end
    end
  end
end
