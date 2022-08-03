#!/bin/bash

# Weather Script for Tawaa-RP
# Requires: weather-util,pom, and sunwait to be installed.

# Usage:  Generates a text file named "taweather" in the root directory of your server's web directory, containing weather info

# Location!  TODO:  Have this change automatically once we actually have some defined.
# The plan here is pretty simple; just get the month as a number and do a quick case thing so that if the month is a certain number, the location is differe$
# Unfortunately we haven't settled on locations yet, so we'll just use somewhere fittingly cloudy and dreary on some large body of water.

# Code for the Monthly weather thingy:

# Locations as an array; each location is set with whatever weather-util will resolve relatively close to the location.
# Months list as just a monthname are placeholders.
# Seattle is used as a zero index here for padding; since we're getting a month as a number we need to have array locations 1-12 filled, so that's 13
# If for some reason the date command returns a zero at least it'll return some data?
# The - in the date command before the m removes the leading zero from the month, otherwise the script throws an error.  I guess 08 isn't the same value as $

#locations=(ksea Novosibirsk Feb 16046 "Puerto Montt" Shillong caz522 saco Aug Sept Oct Nov Tromso)
#location=${locations[$(date +%-m)]}

# Comment this line out so that the location is autoselected.  Alternatively, uncomment this and replace the location code to override.

location="ksea"

# Configure your commands here.  If your command has arguments, enclose it in quotes
# First is the actual weather command to get weather at the location.
# We're doing "quiet" to remove headers; no-cache to (hopefully) force the data to update whenever this command is run.  The output file will be the cache.
# Ideally you should only run the script every so often; if you do it every minute or so I imagine there might be problems.

conditions=$(weather -q --no-cache $location)

# Next:  Sunrise and sunset.  We'll use sunwait for it.  Defaults to a place in England, but we can change that.
                          
sunrise=$(/snap/bin/sunwait list rise)
sunset=$(/snap/bin/sunwait list set)

# And now the moon state.  Pom may be in a different location depending on your distribution; it does seem an absolute path may be required here?

moon=$(/usr/games/pom)

# Actually copy the output to the file, and trim newlines so that it doesn't confuse the bot, as well as add a little bit of versatility
# Since you may not be using a bot that can handle newlines.
# This output works with both Eggdrop and my screen-irssi thing

echo "Current Tawaa Weather: $conditions | $sun | $moon" | tr '\n' ' ' > /var/www/html/taweather.txt
