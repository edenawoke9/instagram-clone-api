class AddVideoToPost < ActiveRecord::Migration[8.0]
  def change
   
        add_column :posts, :is_video, :boolean, default: false, null: false
      

    
    
  end
end
