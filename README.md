# oars-vrep-simulator
## Set-Up
* [Install V-REP](http://www.coppeliarobotics.com/downloads.html)
* Add paths to V-REP root to `.bashrc`
```export VREP_ROOT_DIR=<PATH-TO-V-REP>
export VREP_ROOT=<PATH-TO-V-REP>```
* From the `programming/ros_packages/` folder found in the V-REP root copy `vrep_common`, `vrep_plugin` and `v_repExtRosInterface` to a catkin workspace `src`
* Build workspace
* Copy `.so` files from `devel/lib` to your V-REP root

## Dependencies
* [OpenCV2](http://opencv.org/downloads.html)


## Troubleshooting
* If you have opencv2 not being found install `libopencv-dev`


## Motor Setup

```
1 /    \ 2
 +------+
 |      |
 |/    \|
 +------+
3        4
```
