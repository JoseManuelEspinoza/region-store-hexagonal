namespace :db do
  desc "Clean tables and load fixtures"
  task reload_fixtures: :environment do
    tables = %w[users productos carritos] # Ajusta las tablas según tu base de datos
    tables.each do |table|
      sql = "TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE"
      ActiveRecord::Base.connection.execute(sql)
    end
    Rake::Task['db:fixtures:load'].invoke
  end
end

