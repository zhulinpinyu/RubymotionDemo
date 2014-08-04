class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    init_nanostore
    open HomeScreen.new(nav_bar: true)

  end

  def init_nanostore
    documents_path         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0]
    NanoStore.shared_store = NanoStore.store(:file, documents_path + "/nano.db")
  end

end
