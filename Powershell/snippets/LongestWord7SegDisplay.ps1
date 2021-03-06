# This is an example of how to find the longest english
# word that is readable on an array of 7 segment displays.

# Get list of english words
$Words = (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt").Content -split "`n"

# $BadLetters = "[gkmqvwxz]" # If you accept i and o as readable letters
$BadLetters = "[gkmqvwxzio]"
$LongestAcceptableWord = ""

foreach ($TestWord in $Words) {
    if($TestWord.Length -lt $LongestAcceptableWord.Length -or $TestWord -match $BadLetters){
        continue
    }
    $LongestAcceptableWord = $TestWord
}
$LongestAcceptableWord


###########################

# Shortest code example

#region Setup
$w = (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt").Content -split "`n"
# $b = "[gkmqvwxz]" # If you accept i and o as readable letters
$b,$l = "[gkmqvwxzio]",""
#endregion

# Minified Code, 66 character
($w|?{$_-notmatch$b-and$(if($_.Length-gt$l.Length){$l=$_;1})})[-1]

# Exploded
(
    $w | Where-Object {
        $_ -notmatch $b -and $(
            # This bit of magic lets us use Where-Object like a for loop with out using a loop
            if( $_.Length -gt $l.Length){
                $l=$_
                1 # Return true
            }
        )
    }
)[-1] #Get last item in array
