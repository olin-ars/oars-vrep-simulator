import rospy
import math
from std_msgs.msg import Float32

def motor_driver():
    motor_pubs = []
    for motor in range(0,4):
        print(motor)
        motor_pubs.append(rospy.Publisher('motor' + str(motor+1), Float32, queue_size=10))
    rospy.init_node('motor_driver', anonymous=True)
    rate = rospy.Rate(10)
    t = 0
    while not rospy.is_shutdown():
        #for pub in motor_pubs:
        #    pub.publish(100)
        motor_pubs[0].publish(math.sin(t/10.0))
        motor_pubs[1].publish(math.sin(t/10.0))
        motor_pubs[2].publish(math.sin(t/10.0))
        motor_pubs[3].publish(math.sin(t/10.0))        
        t = t+1
        rate.sleep()

if __name__ == '__main__':
    try:
        motor_driver()
    except rospy.ROSInterruptException:
        pass
