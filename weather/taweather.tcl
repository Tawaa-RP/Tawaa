#Eggdrop Script for Taweather
#Meant to be used in conjunction with the taweather.sh script.
#Debugging can be manually toggled on/off by commenting or uncommenting lines which start with 'putlog'
#Comments can be identified as starting with '#', as these lines are.

#This first debug action is to actually print out to the log that the script is starting to load.  This can be helpful in cases where you might have multiple conflicting versions of the script, or just
#-otherwise aren't sure if it's loading or not.
putlog "Loading Weather Script..."

#Because we have to get stuff from the web, we need the http package.
package require http
package require tls
#This function sets the script to work on channels which are defined as working with weather.
#This needs to be set on a per channel basis according to the instructions for your version of the eggdrop
setudef flag weather

#This sets a keybinding for eggdrop to look for.  If someone types this in a channel or starts a line with it, it'll trigger the pub_w script
bind pub - !w pub_w
#And Cron!  We'll get weather every hour this way.  You can tailor it to your liking, although I like hourly.
bind cron - {0 * * * *} cron:weather
#Here we set the user agent for the script.  We can set it to whatever, so we'll say we're curl because technically that's what's getting used?
set agent "curl/7.68.0"
#A debug line to print out the previous agent message to the log file.  This will help verify that the agent is set properly.  Yes, this has been an issue before.
putlog "User Agent is set to:  $agent"
#Now, the actual pub_w function.  It takes the nickname of the person who issued the command, user handle, handle, channel, and any additional input in the line.
proc pub_w {nick uhand handle chan input} {
        #Check to see if the channel actually has weather set on it.
        if {[lsearch -exact [channel info $chan] +weather] != -1} {
        #Debug:  Output that a user is running the script, as well as the channel.  This can be useful to verify that there's not actually some issue with the script being set to run in a channel, or that
        #-the bot isn't in the channel, or whatever.
        putlog "$nick requested weather data in $chan, running script"
        #Pulls two global variables - the bot's nickname and the agent variable
        global botnick agent
        #Debug:  Verify the agent variable is correct.  As a global variable, it can be overwritten by other scripts,even if they aren't run.  This is actually an issue I encountered, hence why it's here.
        putlog "Agent is set to:  $agent"
        set query "https://irc.trekkie1701c.com/taweather.txt"
        }
#Setting up to make the query.  We're setting the user agent to whatever is in the agent variable.
set http [::http::config -useragent $agent]
#Setting up the URL we're going to query.
set http [::http::geturl $query]
#Visit the first URL and copy it to the variable 'html'
set html [::http::data $http]; ::http::cleanup $http

#Debug: Verify the URL is correct.  You never know if something was typo'd or changed.
putlog "URL is: $query"
#Debug:  Verify the response received was correct. Maybe the website responded with something unparsable.
putlog "Content of URL is:  $html"

#The moon.  This site is cool.  Check out their man pages.
set moon "Moon Phases http://www.die.net/moon/"
#Send the messages to the channel, in the order of weather data, ADDS, and then live camera/moon phases.
putquick "PRIVMSG $chan $html"

putquick "PRIVMSG $chan $moon"
}

#Now the actual cron function.  It takes the arguments of minute, hour, etc.  Set how often you want it to fire off
#At the top of the file.

proc cron:weather {minute hour day month weekday} {
#Fire off pub_w.  We *could* write a separate function for this, but eh.  It's easier just to replace everything but the channel
#With whatever since it doesn't need it, and then just run the code we already have.
        pub_w "cron" "cron" "cron" "#Tawaa" "cron"

}

#Debug:  Post a message that this has loaded successfully.  This should appear before any of the above runs, due to how sourcing a script in Eggdrop works.
#Effectively, this all might as well be in the config file, which is also why the 'agent' variable has become a global variable, and why 'botnick' can just be grabbed, as, so far as this script was concerned
#That was set a few dozen lines ago before this was technically loaded.
putlog "Weather Script loaded successfully."

