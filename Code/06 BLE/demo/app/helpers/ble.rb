module BLE

  def init_connect
    NSLog("开始扫描蓝牙设备")
    @peripheral     = nil
  end

  def connect_band
    return if Config::DEBUG

      uuid = NSUUID.alloc.initWithUUIDString(Config::PEDO_SERVICE)
      # peripherals = @manager.retrievePeripheralsWithIdentifiers([uuid])
      peripherals = @manager.retrieveConnectedPeripheralsWithServices([uuid])

      if peripherals.length == 1
        NSLog("1 开始连接运动手环")
        @peripheral = peripherals[0]
        CurUser.device_sport  = @peripheral.name
        connect(@peripheral)
      else
        start_scan
      end
    # else
      # start_scan
    # end
  end

  def connect(peripheral)
      @manager.connectPeripheral(peripheral, options:{
      CBConnectPeripheralOptionNotifyOnConnectionKey: false,
      CBConnectPeripheralOptionNotifyOnDisconnectionKey: true,
      CBConnectPeripheralOptionNotifyOnNotificationKey: false
      })
  end

  def start_scan
    NSLog("正在扫描")
    return if Config::DEBUG
    if @manager.nil?
      NSLog("@manager 不存在")
      return
    end

    @manager.scanForPeripheralsWithServices(nil, options:nil)
  end

  # 停止扫描蓝牙设备
  def stop_scan
    if @manager.nil?
      NSLog("@manager 不存在")
      return
    end
    @manager.stopScan
  end


  def centralManagerDidUpdateState(manager)  
    if manager.state == CBCentralManagerStatePoweredOn
    	NSLog("State: PoweredOn")
    end
  end


  def centralManager(manager, 
                   didDiscoverPeripheral: peripheral, 
                       advertisementData: data, 
                                    RSSI: rssi)


        @peripheral = peripheral

        NSLog("1 开始连接")
        manager.connectPeripheral(peripheral, options:{
          CBConnectPeripheralOptionNotifyOnConnectionKey: false,
          CBConnectPeripheralOptionNotifyOnDisconnectionKey: true,
          CBConnectPeripheralOptionNotifyOnNotificationKey: false
          })

  end

  def centralManager(manager, didConnectPeripheral: peripheral)

    peripheral.delegate = self
    NSLog("2 连接成功：#{peripheral.name}")
    peripheral.discoverServices(nil)
    NSLog("结束扫描手环Services")
      
  end


  def peripheral(peripheral, didDiscoverServices:error)
    return if error || peripheral.services.nil?

    peripheral.services.each do |service|
      peripheral.discoverCharacteristics(nil, forService:service)
    end
  end

  def equal(obj, uuid_string)
    obj.UUID.isEqual(CBUUID.UUIDWithString(uuid_string))
  end

 

  def peripheral(peripheral, didDiscoverCharacteristicsForService: service,
            error: error)  
      # peripheral.writeValue(data, forCharacteristic:char, type:CBCharacteristicWriteWithResponse)
  end

  def peripheral(peripheral, didUpdateNotificationStateForCharacteristic:char, error:error)
    if error
      #App.alert("error: #{error.localizedDescription}")
    else
      NSLog("Upadete Notification")
    end
  end


  def peripheral(peripheral, didWriteValueForCharacteristic:char, error:error)
    # App.alert(char.value.description)
    NSLog("写入成功")
    if error
      
    else
      
    end
  end

  def peripheral(peripheral, didUpdateValueForCharacteristic:char, error: error)
    if !error
        
    else
      NSLog("更新数据失败，原因:%@", error.localizedDescription)
    end
  end


  
  def centralManager(central, didDisconnectPeripheral: peripheral, error:error)

    NSLog("蓝牙已经断开")
    @peripheral = nil
  end

  def centralManager(manager, 
            didFailToConnectPeripheral: peripheral,
            error: error)
    NSLog("2 连接失败：#{peripheral.name}")
  end

end