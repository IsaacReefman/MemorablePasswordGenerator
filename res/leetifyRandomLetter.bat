SETLOCAL
@ECHO OFF
::Prepare the temporary substring, index and counter (zero based)
SET /A _strIndex=0
SET /A _matchCount=0
SET _sub=%1

:loop
::Get first character in substring
SET _char=%_sub:~0,1%
::Remove first character from substring
SET _sub=%_sub:~1%
::Check if this character is one of [achilst], if so add its index to _leetChars array and increment _matchCount
ECHO %_char%|FINDSTR /R /C:"[achilst]" >NUL && SET _leetChars[%_matchCount%]=%_strIndex% && SET /A _matchCount+=1
::increment string index
SET /A _strIndex+=1
::check if we're done
IF NOT "%_sub%" == "" GOTO loop

::(first toss the first [not very] random result)
SET /A _toss=%RANDOM%
::Randomly select an integer between 0 and the number of matched characters minus 1.
::this (_leetIndex) is the index of the _leetChars array member we will replace.
::(subsequent instances run within a second of this will still produce same random number)
SET /A _leetIndex=%RANDOM% * %_matchCount% / 32768
::Get the index of the actual character from our string that we will replace (index is stored in _leetChars array)
CALL SET /A _replaceIndex=%%_leetChars[%_leetIndex%]%%
::Re-get the string, as parameter variables don't work for the next thing.
SET _sub=%1
::Get the actual character we're going to leetify
CALL SET _leetIn=%%_sub:~%_replaceIndex%,1%%
IF [%_leetIn%]==[a] SET "_leetOut=@"
IF [%_leetIn%]==[c] SET "_leetOut=("
IF [%_leetIn%]==[h] SET "_leetOut=#"
IF [%_leetIn%]==[i] SET "_leetOut=!"
IF [%_leetIn%]==[l] SET "_leetOut=/"
IF [%_leetIn%]==[s] SET "_leetOut=$"
IF [%_leetIn%]==[t] SET "_leetOut=+"
::Get the parts of the string before and after the leeted character
SET /A _strIndex= %_replaceIndex% + 1
CALL SET _stringStart=%%_sub:~0,%_replaceIndex%%%
CALL SET _stringEnd=%%_sub:~%_strIndex%%%
SET "_leetAdj=%_stringStart%%_leetOut%%_stringEnd%"
::Return the new string with random leetified character 
::(as it may have a "<" in it we now always need delayed expansion, and to use ! instead of %)
ENDLOCAL & SET "_leetAdj=%_leetAdj%"