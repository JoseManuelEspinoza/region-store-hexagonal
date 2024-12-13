require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TiendaRegional
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Excluir subdirectorios innecesarios de `lib`
    config.autoload_lib(ignore: %w(assets tasks))

    # Configurar rutas personalizadas para la carga de controladores, modelos y otras carpetas importantes
    config.autoload_paths += %W(
      #{config.root}/src/core/entities/models
      #{config.root}/src/ports/incoming/controllers
      #{config.root}/src/frameworks_drivers/database/db
      #{config.root}/src/ports/incoming/controllers/concerns
    )

    # Configurar la ruta personalizada para las migraciones
    config.paths['db/migrate'] << Rails.root.join('src/frameworks_drivers/database/db/migrate')

    # Configuración adicional para la aplicación
    # Configura la zona horaria si es necesario
    # config.time_zone = "Central Time (US & Canada)"
    # Añadir rutas adicionales para `eager_load`
    # config.eager_load_paths << Rails.root.join("extras")

    # Permitir consultas asíncronas con ActiveRecord
    config.active_record.async_query_executor = :global_thread_pool

    # Agregar rutas personalizadas para vistas
    config.paths["app/views"] << Rails.root.join("src/frameworks_drivers/web/views")
  end
end