class HomeScreen < PM::Screen
  title "home"._

  def on_load
    view.backgroundColor = UIColor.whiteColor

    @name_field = UITextField.alloc.initWithFrame([[10,100],[300,30]])
    @name_field.backgroundColor = UIColor.lightGrayColor
    @name_field.placeholder     = "please_enter_your_name"._
    @name_field.textColor       = UIColor.whiteColor
    @name_field.font            = UIFont.systemFontOfSize(20)
    @name_field.becomeFirstResponder
    
    view.addSubview(@name_field)

    button = UIButton.alloc.initWithFrame([[10,150], [300,40]])
    button.addTarget(self, action: :show_form, forControlEvents:UIControlEventTouchUpInside)
    button.setTitle("next"._, forState:UIControlStateNormal)
    button.backgroundColor = hex_color('#FF9900')
    view.addSubview(button)
  end

  def show_form
    if @name_field.text == ''
      App.alert('please_enter_your_name'._)
    else
      open FormScreen.new(name: @name_field.text)
    end
  end

  def on_return(args={})
    App.alert("your_age"._ + "：#{args[:age]}")
  end

end
