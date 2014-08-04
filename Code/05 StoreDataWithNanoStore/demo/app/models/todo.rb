class Todo < NanoStore::Model
  attribute :content
  attribute :created_at
  attribute :status
  # 0 undone 1 done

  def self.destroy
    self.all.each {|w| w.delete }
  end
  
  def done
    self.status = 1
    self.save
  end

  def is_done?
    status == 1
  end

end