#!/usr/bin/env bash


BUTTON_STATE_GPIO=25 #GPIO to read button state
BUTTON_SOURCE_GPIO=26 #GPIO to use as +3.3V since dock uses all available ones. 
GPIOBASE=`cat /sys/class/gpio/gpiochip*/base | head -n1`

function opendoor {
    # ssh to doorlock Raspbery Pi and open lock
}

function read_gpio {
    gpio=$(($1+$GPIOBASE))
    read VALUE </sys/class/gpio/gpio${gpio}/value
}

function write_gpio {
    gpio=$(($1+$GPIOBASE))
    if [ 0$2 = 0 ]; then
        VALUE=0
    else
        VALUE=1
    fi
    echo $VALUE >/sys/class/gpio/gpio${gpio}/value
}

function setup_gpio {
    gpio=$(($1+$GPIOBASE))
    echo $gpio > /sys/class/gpio/export
    echo $2 > /sys/class/gpio/gpio${gpio}/direction
}

setup_gpio $BUTTON_STATE_GPIO
setup_gpio $BUTTON_SOURCE_GPIO
write_gpio $BUTTON_SOURCE_GPIO 1
while true; do
    read_gpio $BUTTON_STATE_GPIO
    if [ $VALUE = 1 ]; then
        opendoor
    fi
    sleep 1 # poll once per second
done