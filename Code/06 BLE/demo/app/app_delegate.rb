class AppDelegate < PM::Delegate
  include BLE
  status_bar true, animation: :none

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    open HomeScreen.new(nav_bar: true)
  end

end
