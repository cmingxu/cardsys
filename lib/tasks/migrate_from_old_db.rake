require 'erb'

desc "migrate from cardsys_dev db"

# make sure client_id of period-prices set 
#
task :migrate_old_db => :environment do
  SKIP_LIST = ["Department", "UserPower", "Power", "DepartmentPower", "Log", "PeriodablePeriodPrice"]

  class CardPeriodPrice < ActiveRecord::Base
  end
  class CourtPeriodPrice < ActiveRecord::Base
  end

  def insert_statement(table_name, kvpairs)
    ActiveRecord::Base.connection.execute "INSERT into #{table_name}(#{kvpairs.keys.join(',')}) values ('#{kvpairs.values.join('\',\'')}');"
  end

  client_id = 1
  old_db = YAML.load(ERB.new(File.read("#{Rails.root}/config/database.yml")).result)["old"]
  new_db = YAML.load(ERB.new(File.read("#{Rails.root}/config/database.yml")).result)["development"]

  Dir["#{Rails.root}/app/models/**/*"].each do |model_file|
    next if File.directory?(model_file)
    require model_file
  end

  # normal
  ActiveRecord::Base.subclasses.each do |klass|
    klass.establish_connection old_db
    ap klass.table_name
    next if SKIP_LIST.include?(klass.name)
    next unless klass.table_exists?
    klass.unscoped.all.each do |old_record|
      klass.establish_connection new_db
      klass.reset_column_information
      break unless klass.table_exists?
      new_record = klass.new
      kvpair = old_record.attributes.slice(*klass.column_names)
      kvpair[:client_id] = client_id if new_record.attributes.keys.include?(:client_id) || new_record.attributes.keys.include?("client_id")
      insert_statement(klass.table_name, kvpair)
    end
  end

  # special case for periodable_period_price
  CardPeriodPrice.establish_connection old_db
  CourtPeriodPrice.establish_connection old_db
  PeriodablePeriodPrice.establish_connection new_db
  PeriodablePeriodPrice.attr_accessible :periodable_type, :periodable_id

  CardPeriodPrice.all.each do |cpp|
    next if cpp.card_id.nil?
    PeriodablePeriodPrice.create(:periodable_type => "Card", :periodable_id => cpp.card_id, :price => cpp.card_price, :period_price_id => cpp.period_price_id)
  end

  CourtPeriodPrice.all.each do |cpp|
    next if cpp.court_id.nil?
    PeriodablePeriodPrice.create(:periodable_type => "Court", :periodable_id => cpp.court_id, :price => cpp.court_price, :period_price_id => cpp.period_price_id)
  end
end

