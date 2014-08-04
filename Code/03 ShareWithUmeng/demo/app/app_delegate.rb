class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  UMENG_APP_KEY = "your_umeng_key"

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    
    init_umeng
    open HomeScreen.new(nav_bar: true)
  end

  def init_umeng 
    MobClick.startWithAppkey  UMENG_APP_KEY
    UMSocialData.setAppKey    UMENG_APP_KEY
  end

end
