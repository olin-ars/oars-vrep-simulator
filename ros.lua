local ros = {}

function ros.init("")
   moduleName=0
   moduleVersion=0
   index=0
   pluginNotFound=true
   while moduleName do
      moduleName,moduleVersion=simGetModuleName(index)
      if (moduleName=='RosInterface') then
	 pluginNotFound=false
      end
      index=index+1
   end
   
   if (not pluginNotFound) then
      local sysTime=simGetSystemTimeInMs(-1) 
      local cameraTopicName='camera/image_raw'
      local simulationTimeTopicName='simTime'
      local velocityTopicName='vel_cmd'
      local lidarTopicName='lidar/scan'
      local gpsTopicName = 'gps/fix'
      local imuTopicName='imu'
      local proximityTopicName='proximity/range'
      local proximitySensorCount=5

      -- Prepare the sensor publisher and the motor speed subscribers:
      cameraPub=simExtRosInterface_advertise('/'..cameraTopicName,'sensor_msgs/Image')
      simTimePub=simExtRosInterface_advertise('/'..simulationTimeTopicName,'std_msgs/Float32')
      lidarPub=simExtRosInterface_advertise('/'..lidarTopicName,'sensor_msgs/LaserScan')
      imuPub=simExtRosInterface_advertise('/'..imuTopicName,'sensor_msgs/Imu')
      gpsPub=simExtRosInterface_advertise('/'..gpsTopicName,'sensor_msgs/NavSatFix')
      proximityPub = {}
      for sensorNum=1,proximitySensorCount do
	 proximityPub[i]=simExtRosInterface_advertise('/'..proximityTopicName..sensorNum,'sensor_msgs/Range')
      end
      velocitySub=simExtRosInterface_subscribe('/'..velocityTopicName,'std_msgs/Float32','setVelocity_cb')
      simExtRosInterface_publisherTreatUInt8ArrayAsString(cameraPub)
   end
end
