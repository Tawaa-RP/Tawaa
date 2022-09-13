bind pub - !jail pub_jail

proc pub_jail {nick uhand handle chan input} {
        putquick "PRIVMSG $chan :$nick has added the current set of dice to the jail."
}
