bind pub - !help help

setudef flag help

proc help {nick uhand handle chan input} {
	if {[lsearch -exact [channel info $chan] +help] != -1} {
		putquick "privmsg $chan Dice:  !r xdy - Roll x dice with y sides.  Example:  !r 1d20 rolls a d20."
		putquick "privmsg $chan Weather:  !w - Display current weather conditions for Tawaa."
		putquick "privmsg $chan Join/Part: Channel operators can invite me to a channel with the command '/invite mysteries #channel'.  I will leave the channel if an operator says !leave.  Commands can be toggled on or off with !commands on or !commands off"
		putquick "privmsg $chan For help with other bots, please message the appropriate bot with 'help'.  For example, /msg nickserv help"
		}
	}
