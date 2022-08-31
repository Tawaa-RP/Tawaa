# March 5, 2012
# http://forum.egghelp.org/viewtopic.php?t=18870


bind raw - invite the341
bind pub - !leave leavechan
bind pub - !commands commands

set oldinvitetime [expr [unixtime] - 60]
set oldchan ""
   

proc the341 {from key text} {
global botnick oldinvitetime oldchan

   set chan [string trimleft [lindex [split $text] 1] :]
   set nick [lindex [split $from !] 0]


   set invitetime [unixtime]
   set diff [expr $invitetime - $oldinvitetime]
   

     if {$diff < 60} {
      putserv "privmsg $nick :I was just invited to $oldchan. Please wait [expr 60 - $diff] seconds before inviting me again."
         return 0
         }

      set oldinvitetime $invitetime
      set oldchan $chan
   
   channel add $chan
        utimer 3 [list do_check $nick $chan]
}



proc do_check {nick chan} {
global botnick

   if {[isop $nick $chan] } {
      putserv "privmsg $chan :Hi there I'm $botnick. I was invited by $nick. Ask me to !leave if you want me to part this channel."
          } else {
      putserv "privmsg $chan :I was invited by a non-op. Please try again with an opped Nick."
      channel remove $chan     
     }
     
}

proc leavechan {nick uhand handle chan input} {

        if {[isop $nick $chan] } {
                putquick "privmsg $chan :$nick has asked me to leave.  Goodbye!"
                channel remove $chan
        } else {
                putserv "privmsg $chan :Sorry. Only a channel operator can ask me to leave."
        }
}

proc commands {nick uhand handle chan input} {
        if {[isop $nick $chan] } {
                switch -regexp --$input {
                        On|on|1 {
                        channel set $chan +weather
                        putserv "privmsg $chan :$nick has turned commands on."
                        }
                        Off|off|0 {
                        channel set $chan -weather
                        putserv "privmsg $chan :$nick has turned commands off."
                        }
                }
        } else {
                putserv "privmsg $chan :Sorry, only an op can change the comand state."
        }
}
