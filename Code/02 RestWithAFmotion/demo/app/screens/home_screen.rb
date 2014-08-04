class HomeScreen < PM::Screen
  title "Home"

  def on_load
    view.backgroundColor = UIColor.whiteColor
  end



  def load_data
    SVProgressHUD.show
    params = {}
    AFMotion::Client.shared.get("", params) do |result|
      SVProgressHUD.dismiss
      if result.success?
        
      end
    end
  end

  def save
    SVProgressHUD.show
    params = {}
    AFMotion::Client.shared.post("", params) do |result|
      SVProgressHUD.dismiss
      if result.success?
        
      end
    end
  end

end
