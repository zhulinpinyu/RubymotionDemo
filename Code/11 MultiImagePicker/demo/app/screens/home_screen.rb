class HomeScreen < PM::Screen
  attr_accessor :library
  title "Home"

  def on_load
    view.backgroundColor = UIColor.whiteColor
    
    camera_btn = UIButton.alloc.initWithFrame([[10,100], [300,40]])
    camera_btn.addTarget(self, action: :from_camera, forControlEvents:UIControlEventTouchUpInside)
    camera_btn.setTitle("拍照", forState:UIControlStateNormal)
    camera_btn.backgroundColor = hex_color('#FF9900')
    view.addSubview(camera_btn)

    album_btn = UIButton.alloc.initWithFrame([[10,160], [300,40]])
    album_btn.addTarget(self, action: :from_album, forControlEvents:UIControlEventTouchUpInside)
    album_btn.setTitle("直接从相册选", forState:UIControlStateNormal)
    album_btn.backgroundColor = hex_color('#FF9900')
    view.addSubview(album_btn)

    multi_btn = UIButton.alloc.initWithFrame([[10,220], [300,40]])
    multi_btn.addTarget(self, action: :show_picker, forControlEvents:UIControlEventTouchUpInside)
    multi_btn.setTitle("选择多张照片", forState:UIControlStateNormal)
    multi_btn.backgroundColor = hex_color('#FF9900')
    view.addSubview(multi_btn)
  end


  def from_camera
    BW::Device.camera.rear.picture(media_types: [:movie, :image]) do |result|
      set_photo(result[:original_image])
    end
  end

  def from_album
    BW::Device.camera.any.picture(media_types: [:movie, :image]) do |result|
      set_photo(result[:original_image])
    end
  end

  def set_photo(photo)
      return if photo.nil?
      image_view = UIImageView.alloc.initWithImage(photo)
      image_view.contentMode = UIViewContentModeScaleToFill
      image_view.frame = [[20, 280], [80,80]]
      view.addSubview image_view
  end

  def show_picker
    
    @library = ALAssetsLibrary.alloc.init if @library == nil
    controller = WSAssetPickerController.alloc.initWithAssetsLibrary(@library)  
    controller.delegate = self
    self.presentViewController(controller, animated:true, completion:nil)
  end

  # 取消返回
  def assetPickerControllerDidCancel(sender)
    self.dismissViewControllerAnimated(true, completion:nil)
  end

  # 选中照片后返回
  def assetPickerController(sender, didFinishPickingMediaWithAssets:assets)
    self.dismissViewControllerAnimated(true, completion:-> {
        assets.each_with_index do |asset, index|
          image = UIImage.imageWithCGImage(asset.thumbnail, scale:1.0, orientation:asset.defaultRepresentation.orientation)
          image_view = UIImageView.alloc.initWithImage(image)
          image_view.frame = [[20 + (index % 3) * 100, 280 + (index / 3) * 90], [80,80]]
          view.addSubview image_view
        end
      })
  end




end
