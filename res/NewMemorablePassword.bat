@ECHO OFF
SETLOCAL DisableDelayedExpansion
MODE CON COLS=78 LINES=3
COLOR F0
CD %~dp0
::Check everything is installed
CALL checkDependencies.bat
::Check that there is a WordsApiKey
FOR /F "delims=" %%G IN (WordsApiKey.txt) DO SET _WordsApiKey=%%G
IF [%_WordsApiKey%]==[] (
   ECHO You have no WordsAPI Key. Go to www.wordsapi.com and get a free key, then
   ECHO paste it into res\WordsApiKey.txt, and try again.
   PAUSE
   EXIT
)
::Get random adjective
CALL curlGetRandomWord.bat pwAdjective
SET _adj=%_rWord%
CALL leetifyRandomLetter.bat %_adj%
::Returns _leetAdj which has a random letter changed for a special character.

::Get random noun
CALL curlGetRandomWord.bat pwNoun
SET _noun=%_rWord%
::separate first letter of Noun
SET _nounStart=%_noun:~0,1%
SET _nounEnd=%_noun:~1%
::capitalise first letter of noun
SETLOCAL EnableDelayedExpansion
FOR %%b IN (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
      SET "_nounStart=!_nounStart:%%b=%%b!"
   )
::add first letter back to noun
SET _noun=%_nounStart%%_nounEnd%

::generate 2 digit random number
::toss a random number away to ensure decent level of randomness
SET /a _rand1=(%RANDOM%)
SET /a _rand1=(%RANDOM%*10/32768)
SET /a _rand2=(%RANDOM%*10/32768)

::combine the three to make the password
SETLOCAL DisableDelayedExpansion
SET "_phrase=%_leetAdj%%_noun%%_rand1%%_rand2%"
ECHO New password is %_phrase%. Press any key to copy it to the clipboard.
PAUSE >NUL
ECHO %_phrase% | CLIP
SET /P _endMsg="Successfully copied to clipboard." <nul
TIMEOUT 10 && EXIT