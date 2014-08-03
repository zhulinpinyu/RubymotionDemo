class FormScreen < PM::Screen
  attr_accessor :name
  title "表单"

  def on_load
    view.backgroundColor = UIColor.whiteColor

    @name_label = UILabel.alloc.initWithFrame([[10,100],[300,30]])
    @name_label.font = UIFont.systemFontOfSize(25)
    @name_label.text = @name           

    view.addSubview(@name_label)
    
    @age_field = UITextField.alloc.initWithFrame([[10,150],[300,30]])
    @age_field.backgroundColor = UIColor.lightGrayColor
    @age_field.placeholder     = "请输入年龄"
    @age_field.keyboardType    = UIKeyboardTypeNumberPad
    @age_field.textColor       = UIColor.whiteColor
    @age_field.font            = UIFont.systemFontOfSize(25)
    @age_field.becomeFirstResponder
    
    view.addSubview(@age_field)

    button = UIButton.alloc.initWithFrame([[10,200], [300,40]])
    button.addTarget(self, action: :go_back, forControlEvents:UIControlEventTouchUpInside)
    button.setTitle("返回", forState:UIControlStateNormal)
    button.backgroundColor = hex_color('#FF9900')
    view.addSubview(button)
    
  end

  def go_back
    if @age_field.text == ''
      App.alert("请输入年龄")
    else
      close age: @age_field.text.to_i
    end
  end

end
