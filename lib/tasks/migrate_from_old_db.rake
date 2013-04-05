require 'erb'

desc "migrate from cardsys_dev db"

#TODO
# add old_id column dynamiclly
# relationship. remove old_id
task :migrate_old_db => :environment do
  SKIT_LIST = %w(Order OrderItem Balance CourtBookRecord Log CoachBookRecord)
  CLIENT_NAMES = %w(bdw ay)

  count = {}

  Dir["#{Rails.root}/app/models/**/*"].each do |model_file|
    next if File.directory?(model_file)
    require model_file
  end

  CLIENT_NAMES.each do |domain|
    (ActiveRecord::Base.send :subclasses).each do |model|
      begin
        next if SKIT_LIST.include?model.name
        old_db = YAML.load(ERB.new(File.read("#{Rails.root}/config/database.yml")).result)["old"]
        new_db = YAML.load(ERB.new(File.read("#{Rails.root}/config/database.yml")).result)["devlelopment"]
        old_connection = model.connection
        model.establish_connection old_db
        next unless model.table_exists?
        datas = model.all 
        model.establish_connection new_db
        datas.each do |data|
          begin
            record = model.new(data.attributes.slice(*model.column_names))
            record.client_id = Client.find_by_domain(domain).id if record.respond_to?(:client_id)
            record.id = data.attributes["id"]
            ap record
            ap record.valid?
            ap record.errors
            ap record.save!(:validate => false)
          rescue Exception => e
            ap e
            if count[model.name]
              count[model.name] += 1
            else
              count[model.name] = 1
            end
            ap count
          end
        end

      end
    end

    ap count
  end
end
