class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    open HomeScreen.new(nav_bar: true)

    init_jpush(launchOptions)
  end

  # 初始化极光推送，并打上Tag和Alias
  def init_jpush(options)
    APService.registerForRemoteNotificationTypes(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)
    APService.setupWithOption(options)
    
    # 比如打上版本号，Tag不允许有 . 所以用 _
    tag = NSSet.setWithObject("V3_0")
    APService.setTags(tag, callbackSelector: "tagsAliasCallback", object: self)
  end

  # 极光推送
  # ==========================================
  def application(app, didRegisterForRemoteNotificationsWithDeviceToken:deviceToken)
    APService.registerDeviceToken(deviceToken)
  end

  def application(application, didFailToRegisterForRemoteNotificationsWithError:error)
    NSLog("推送登记失败")
  end

  def application(application, didReceiveRemoteNotification:userInfo)
    # 可以加多一个监听
    #CurUser.notification = userInfo
    #App.notification_center.post 'PushNotification'

    APService.handleRemoteNotification(userInfo)
  end
  # ==========================================
end
