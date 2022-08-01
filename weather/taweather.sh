#!/bin/bash

# Weather Script for Tawaa-RP
# Requires: weather-util to be installed.

# Usage:  Generates a text file named "taweather" in the root directory of your server's web directory, containing weather info

# Location!  TODO:  Have this change automatically once we actually have some defined.
# The plan here is pretty simple; just get the month as a number and do a quick case thing so that if the month is a certain number, the location is different
# Unfortunately we haven't settled on locations yet, so we'll just use somewhere fittingly cloudy and dreary on some large body of water.

location="ksea"

# Configure your command here.  If your command has arguments, enclose it in quotes
# We're doing "quiet" to remove headers; no-cache to (hopefully) force the data to update whenever this command is run.  The output file will be the cache.
# Ideally you should only run the script every so often; if you do it every minute or so I imagine there might be problems.

command="weather -q --no-cache $location"

# Actually copy the output to the file, and trim newlines so that it doesn't confuse the bot, as well as add a little bit of versatility
# Since you may not be using a bot that can handle newlines.
# This output works with both Eggdrop and my screen-irssi thing

echo "Current Tawaa Weather: $($command)" | tr '\n' ' ' > /var/www/html/taweather.txt
