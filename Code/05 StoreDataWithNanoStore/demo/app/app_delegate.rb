class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"

    init_nanostore
    init_data
    
    open HomeScreen.new(nav_bar: true)


  end

  def init_nanostore
    documents_path         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    NanoStore.shared_store = NanoStore.store(:file, documents_path + "/nano.db")
  end

  # 初始化数据
  def init_data
    if Todo.count == 0
      todo = Todo.new
      todo.content = "完成Todo列表页设计"
      todo.created_at = Time.now
      todo.save

      todo = Todo.new
      todo.content = "陪女朋友看电影"
      todo.created_at = Time.now
      todo.save
    end
  end

end
