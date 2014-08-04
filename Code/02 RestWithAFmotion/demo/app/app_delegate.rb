class AppDelegate < PM::Delegate
  status_bar true, animation: :none

  def on_load(app, options)
    return true if RUBYMOTION_ENV == "test"
    init_afmotion
    
    open HomeScreen.new(nav_bar: true)

  end

  def init_afmotion
    base_url = ""
    AFMotion::Client.build_shared(base_url) do
      header "Accept", "application/json"
      response_serializer :json
    end

    url_cache = NSURLCache.alloc.initWithMemoryCapacity(4 * 1024 * 1024, diskCapacity:20 * 1024 * 1024,diskPath:nil)
    NSURLCache.setSharedURLCache(url_cache)

    AFNetworkActivityIndicatorManager.sharedManager.enabled = true
  end

end
