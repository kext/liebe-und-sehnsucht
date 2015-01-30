class CreateTables < ActiveRecord::Migration
  def change
    # Create Users
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end

    # Create Boards
    create_table :boards do |t|
      t.string :title

      t.timestamps null: false

      t.integer :topic_count
      t.integer :post_count
      t.references :last_post, index: true
    end
    add_foreign_key :boards, :posts, column: :last_post_id

    # Create Topics
    create_table :topics do |t|
      t.string :title
      t.references :board, index: true

      t.timestamps null: false

      t.integer :post_count
      t.timestamp :first_post_at
      t.references :first_post_user, index: true
      t.timestamp :last_post_at
      t.references :last_post_user, index: true
    end
    add_foreign_key :topics, :boards
    add_foreign_key :topics, :users, column: :first_post_user_id
    add_foreign_key :topics, :users, column: :last_post_user_id

    # Create Posts
    create_table :posts do |t|
      t.text :content
      t.references :topic, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :posts, :topics
    add_foreign_key :posts, :users
  end
end
