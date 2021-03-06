class Main < ActiveRecord::Migration
  create_table(:active_admin_comments) do |t|
    t.string :resource_id, :resource_type, null: false
    t.string :author_type, :namespace
    t.integer :author_id
    t.text :body

    t.timestamps
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table(:activities) do |t|
    t.string :title, :address, :age
    t.text :description, :parent_activities, :additional_information, :schedule, :cost
    t.integer :organization_id, :metro_station_id, :region_id
    t.float :users_rating, default: 0.0, null: false
    t.point :location, limit: 0, srid: 4326, geographic: true
    t.boolean :is_educational
    t.has_attached_file :logo
    t.boolean :participant, :approved, null: false, default: false
    t.string :phone, :site
    t.boolean :available, null: false, default: true

    t.timestamps
  end

  create_table(:activity_comments) do |t|
    t.string :commentator, :picture_file_name, :picture_content_type
    t.text :content
    t.integer :picture_file_size, :activity_id
    t.datetime :picture_updated_at
    t.boolean :is_parent, null: false, default: true

    t.timestamps
  end

  create_table(:activity_direction_relations) do |t|
    t.integer :activity_id, :direction_tag_id

    t.timestamps
  end

  create_table(:activity_photos) do |t|
    t.string :attach_file_name, :attach_content_type
    t.integer :attach_file_size, :activity_id
    t.datetime :attach_updated_at

    t.timestamps
  end

  create_table(:activity_votes) do |t|
    t.integer :activity_id, :user_id
    t.float :rate, default: 0.0, null: false

    t.timestamps
  end

  create_table(:admin_users) do |t|
    t.string :email, :encrypted_password, default: "", null: false
    t.string :reset_password_token, :current_sign_in_ip, :last_sign_in_ip
    t.datetime :reset_password_sent_at, :remember_created_at, :current_sign_in_at, :last_sign_in_at
    t.integer :sign_in_count, default: 0
    t.integer :role_id, null: false

    t.timestamps
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table(:age_tags) do |t|
    t.integer :start_year, :end_year

    t.timestamps
  end

  create_table(:article_categories) do |t|
    t.string :title

    t.timestamps
  end

  create_table(:articles) do |t|
    t.string :title, :picture_file_name, :picture_content_type
    t.integer :author_id
    t.text :content, :short_description
    t.integer :article_category_id, :picture_file_size
    t.datetime :picture_updated_at
    t.integer :comments_count
    t.boolean :published, null: false, default: false
    t.timestamps
  end

  create_table(:direction_tags) do |t|
    t.string :name
    t.boolean :is_educational

    t.timestamps
  end

  create_table(:metro_stations) do |t|
    t.string :title

    t.timestamps
  end

  create_table(:organizations) do |t|
    t.string :title, :address
    t.integer :metro_station_id
    t.point :location, limit: 0, srid: 4326, geographic: true

    t.timestamps
  end

  create_table(:roles) do |t|
    t.string :name, null: false

    t.timestamps
  end

  create_table(:taggings) do |t|
    t.integer :tag_id, :taggable_id, :tagger_id
    t.string :taggable_type, :tagger_type
    t.string :context, limit: 128

    t.timestamps
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table(:tags) do |t|
    t.string :name
  end

  create_table(:teachers) do |t|
    t.string :name
    t.text :description
    t.integer :activity_id
    t.has_attached_file :photo

    t.timestamps
  end

  create_table(:users) do |t|
    t.string :email, default: "", null: false
    t.datetime :remember_created_at, :current_sign_in_at, :last_sign_in_at
    t.integer :sign_in_count, default: 0
    t.string :current_sign_in_ip, :last_sign_in_ip, :facebook_id,
    :vkontakte_id, :odnoklassniki_id, :encrypted_password,
    :name, :description
    t.integer :role_id, null: false

    t.string :description
    t.text :about

    t.string :avatar_file_name, :avatar_content_type
    t.integer :avatar_file_size
    t.datetime :attach_updated_at

    t.timestamps
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["odnoklassniki_id"], :name => "index_users_on_odnoklassniki_id"
  add_index "users", ["vkontakte_id"], :name => "index_users_on_vkontakte_id"

  create_table(:video_urls) do |t|
    t.string :relation_type, null: false
    t.integer :relation_id, null: false
    t.text :url, null: false

    t.timestamps
  end

  create_table :pictures do |t|
    t.has_attached_file :picture
    t.string :caption
    t.timestamps
  end

  create_table :activity_age_relations do |t|
    t.integer :activity_id, :age_tag_id

    t.timestamps
  end

  create_table :special_projects do |t|
    t.string :title, :author
    t.text :content
    t.has_attached_file :picture
    t.timestamps
  end


  create_table :comments do |t|
    t.text :text
    t.integer :user_id, :relation_id, null: false
    t.string :relation_type, null: false
    t.boolean :deleted, null: false, default: false

    t.timestamps
  end
  update "ALTER TABLE \"comments\" ADD \"path\" LTREE NULL DEFAULT ''"

  create_table :favourites do |t|
    t.integer :relation_id
    t.string :relation_type
    t.integer :user_id
    t.timestamps
  end

  create_table :contests do |t|
    t.string :name
    t.text :description
    t.text :rules
    t.datetime :started_at
    t.datetime :ended_at
    t.integer :category_id
    t.has_attached_file :picture
    t.boolean :active

    t.timestamps
  end

  add_index :contests, :category_id

  create_table :contest_categories do |t|
    t.string :name

    t.timestamps
  end

  create_table :contest_memberships do |t|
    t.integer :contest_id
    t.integer :user_id
    t.string :picture_file_name
    t.integer :picture_file_size
    t.datetime :picture_updated_at

    t.string :name
    t.text :description

    t.float :rating, default: 0.0, null: false
    t.integer :comments_count, default: 0

    t.timestamps
  end

  add_index :contest_memberships, :contest_id

  create_table :contest_votes do |t|
    t.integer :contest_id
    t.integer :membership_id
    t.integer :rate
    t.integer :user_id

    t.timestamps
  end

  add_index :contest_votes, :contest_id
  add_index :contest_votes, :membership_id

  create_table :user_comment_notifies do |t|
    t.integer :comment_id, :child_comment_id, null: false
    t.boolean :read, null: false, default: false
    t.timestamps
  end

  create_table :sponsors do |t|
    t.string :first_name, :last_name, null: false
    t.text :description
    t.has_attached_file :photo
    t.timestamps
  end

  create_table :regions do |t|
    t.string :title, null: false

    t.timestamps
  end

  create_table :activity_approvals do |t|
    t.integer :activity_id, :user_id, null: false
    t.text :text, null: false

    t.timestamps
  end
end
