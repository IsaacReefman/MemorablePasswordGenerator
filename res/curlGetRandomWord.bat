SETLOCAL
@ECHO OFF
::Get API Key from WordsApiKey.txt
FOR /F "delims=" %%G IN (WordsApiKey.txt) DO SET _WordsApiKey=%%G
::set universal variables
SET _HostHeader="X-RapidAPI-Host: wordsapiv1.p.rapidapi.com"
SET _KeyHeader="X-RapidAPI-Key: %_WordsApiKey%"
SET "_urlStart=https://wordsapiv1.p.rapidapi.com/words/?random=true"
SET "_LettersMin=&lettersMin=4"
SET "_LettersMax=&lettersMax=8"
SET "_FrequencyMin=&frequencyMin=3"
::set variables for pwAdjective
IF [%1]==[pwAdjective] (
    SET "_PartOfSpeech=&partOfSpeech=adjective"
    SET "_letterPattern=&letterPattern=%%5E%%5Ba-z%%5D%%2A%%5Bachilst%%5D%%2B%%5Ba-z%%5D%%2A%%24"
    GOTO API_Call
)
::set variables for pwNoun
IF [%1]==[pwNoun] (
    SET "_PartOfSpeech=&partOfSpeech=noun"
    GOTO API_Call
)
:API_Call
::get jSon data from API using set parameters
curl -s --request GET -H %_HostHeader% -H %_KeyHeader% --url "%_urlStart%%_PartOfSpeech%%_LettersMin%%_LettersMax%%_FrequencyMin%%_LetterPattern%" > C:\Temp\jSonAPIResult.txt
::use jQuery to get the word from that data
FOR /F "delims=" %%G IN ('"jq -r ".word" C:\Temp\jSonAPIResult.txt"') DO SET "_rWord=%%G"
::Check if there has been some error getting the word from WordsAPI
IF [%_rWord%]==[null] GOTO WordsApiErrorHandler
::delete the text file created for this purpose
DEL C:\Temp\jSonAPIResult.txt
ENDLOCAL & SET _rWord=%_rWord%
EXIT /B

:WordsApiErrorHandler
ECHO WordsAPI error. You likely have an invalid key. 
ECHO Please check this and try again.
::Be sure to clean up
DEL C:\Temp\jSonAPIResult.txt
PAUSE
EXIT