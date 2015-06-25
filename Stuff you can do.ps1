# Speech output
Out-Speech "I'm sorry Dave, I'm afraid I can't do that."

# Open a set of websites as a group
function Open-Webdocs() {
    Start-Process 'http://www.getbreezenow.com';
    Start-Process 'http://docs.angularjs.org';
    Start-Process 'http://getbootstrap.com/css';
}

# dynamic objects
$dog = [PSCustomObject] @{ 
    Name=”Rover” 
    Phone=”913-443-4321" }


# Base 64 Encode/Decode 
function enc64([string] $text) {
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($text);
    return [System.Convert]::ToBase64String($bytes);
}

function dec64([string] $text) {
  $bytes = [System.Convert]::FromBase64String($text);
  return [System.Text.Encoding]::UTF8.GetString($bytes);
}

# Find ASCII Char (or unicode)
[int][char]'a'
[char]97
[char]49849

#  use powershell as a calculator
(2 + 3) * 5
(8mb + 16GB + 2TB) / 1GB

# Check the length of a string
"This string should be less that 50 characters".Length

# Test String Formats
"{0:C}" -f 23422
"{0:F4}" -f 3.14159265