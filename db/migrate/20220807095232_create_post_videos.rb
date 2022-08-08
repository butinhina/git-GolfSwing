class CreatePostVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :post_videos do |t|

      t.timestamps
      t.integer :customer_id
      t.text :report
    end
  end
end
