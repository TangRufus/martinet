require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Migration.create_table :users do |t|
  t.string :name
  t.timestamps null: false
end

class User < ActiveRecord::Base
end
