===========================================
MANUAL FOR THE MEMORABLE PASSWORD GENERATOR
===========================================

Get yourself an API key for WordsAPI.
-------------------------------------
This tool uses WordsAPI (www.wordsapi.com) to generate random phrases. A key is free, but if you downloaded this off GitHub you won't have one included. Go to https://rapidapi.com/dpventures/api/wordsapi/pricing and grab yourself a free key for 2500 requests a day (that's 1250 passwords a day!) Paste the key into the WordsApiKey.txt file in the res folder and you're good to go.


The first time you launch, you may need to install a couple of dependencies.
----------------------------------------------------------------------------
When this tool runs, it checks to see if you have curl (https://curl.se/) and jq (https://stedolan.github.io/jq/) installed. It needs these in order to call WordsAPI and sort out the resutling JSON response. If you don't it will ask you if it can install them. They're very small and safe, but by all means don't take my word for it. Once you're satisfied that they're safe, you can let it install them, but you will need to run Memorable Password Generator as administrator for it to have the necessary permissions. Right click, and hit 'run as administrator' (it's in 'more options' if you're running >= Windows 11).

This tool uses chocolatey to install these programs, so that will need to be installed first.


Decide where you want this tool to live.
----------------------------------------------------------
This tool expects its parent directory (with it inside) to be placed directly in your C: drive, but you can put it anywhere you like - as long as you reset the shortcut by double-clicking resetShortcut.vbs in this folder. This tells the shortcut where everything it needs to function is located.

Once you've done that, you're free to copy or move the shortcut, pin it to start or your taskbar, whatever you like. You can also find it in your start menu by typing 'Memorable Password Generator'.


How it works.
-------------
The tool uses WordsAPI to collect one adjective and one noun to make a memorable (though usually somewhat nonsensical) phrase. Our brains like patterns like this, so even though a 'squared flooding' doesn't really make sense, it sticks in the mind a little better than *totally* random phrases. Not safe enough though - bitwarden's password strength rating tool reports this would take a little under an hour to crack. So we pick a random letter to change to a special character, capitalise the first letter of the noun and add a 2 digit number to the end. Now that same password strength rating tool reckons we'll be good for 2 months!


That's it, really!
------------------
There's not much more to say... run the tool, hit any key to copy the new password, and use it with relative confidence.