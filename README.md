### CNC Mill control environment
**By Joseph Wang**

This docker image allows for quick set up of the software required for sending gcode to a GRBL (<https://github.com/grbl/grbl>) board using CNCjs (<https://cnc.js.org/>). CNCjs when run in this way can be accessed on the local machine at https://127.0.0.1:8090. Official docker images of cncjs also exist at <https://hub.docker.com/r/cncjs/cncjs/tags/#!> but I ran into issues when using them because the wrong version of node was being used (03/01/2022). 

The current fix was posted on the original project's github page under <https://github.com/cncjs/cncjs/issues/489#issuecomment-756459592> and this is what I am using. Note that my original code missed the udev and user permissions; this prevents the container from accessing the arduino and so you won't be able to select from a list of devices in cncjs!

There is a preference script in the current directory if persistent changes are required. Note that copying over this file into the image hasn't been implemented yet as I haven't needed to use it.  

### Prerequisites
You will need to install docker and docker-compose (optional). Instructions can be found here: https://docs.docker.com/get-docker/.

### Install and usage
Clone this repository into your current directory by typing the following into a terminal:

    git clone https://github.com/jjiaoyuwang/milling-control.git

Next, build the docker image by typing the following:

    docker build -t mill-control  .

Plug in your arduino device with GRBL shield, and note its address (usually /dev/ttyACM0). Finally, run the container, replacing 8090 with the desired port and /dev/ttyACM0 with your board's address.  

    docker run -it --rm -p 8090:8080 --device=/dev/ttyACM0 mill-control

### Explanations and notes to self:

- Machine used: <https://www.instructables.com/DIY-3D-Printed-Dremel-CNC/>
- Install GRBL (go to github page or <https://www.instructables.com/How-to-Installuse-GRBL-With-Your-Cnc-Machine/>
- Calculate steps/mm (<https://blog.prusaprinters.org/calculator_3416/>). Send the following commands to set the steps to 400:
    
        $100 = 400
        $101 = 400
        $102 = 400

### Other useful links:
- cncjs github repo: <https://github.com/cncjs/cncjs>
- cncjs quickstart: <https://cnc.js.org/>
- cncjs installation instructions (including building from source and docker): <https://cnc.js.org/docs/installation/>

### Planned features:
- implement watch-directory where a user can place his/her gcode files.
- implement persistent changes by copying over user defined .cncrc file before run. 

