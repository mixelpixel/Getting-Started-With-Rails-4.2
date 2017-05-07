# more info: http://edgeguides.rubyonrails.org/active_record_migrations.html

class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text

      t.timestamps null: false
    end
  end
end
