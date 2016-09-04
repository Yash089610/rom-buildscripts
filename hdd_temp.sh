#!/bin/bash
CRITTEMP=55

function check {
temperature=$(hddtemp /dev/sda | cut -d : -f3 | sed 's/[^0-9]*//g')
}

function overheat {
if [ $temperature == $CRITTEMP ]; then
  echo "Overheat..."
  killall make
  poweroff
else
  echo " "
fi
}

echo "Starting..."
again=yes
while [ "$again" = "yes" ]
do
sleep 3m
check
overheat
echo "Current temp: " $temperature
done