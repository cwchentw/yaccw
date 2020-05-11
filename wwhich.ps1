# wwhich.ps1 - Simulate Unix which on Windows
# Copyright (c) 2020 Michael Chen
# Licensed under MIT.


param (
  [switch]$h = $false,
  [switch]$help = $false,
  [switch]$a = $false,
  [switch]$all = $false
)

if ($h -or $help) {
  Write-Output "Usage: $0 [option] [command]"
  Write-Output ""
  Write-Output "Option:"
  Write-Output "  -h    --help    Show help info and exit"
  Write-Output "  -a    --all     Show all possible path(s)"
  Write-Output ""
  Write-Output "[command] is the name of a console command"

  exit 0
}

$targetCommand=$args[0]

if (!$targetCommand) {
  [Console]::Error.WriteLine("No valid target");
  exit 1
}

# Currently, we hard code specific environment variables.
# Refactor it later.
$systemRoot = [System.Environment]::ExpandEnvironmentVariables("%SystemRoot%");
$userProfile = [System.Environment]::ExpandEnvironmentVariables("%USERPROFILE%");

$found = $false

Foreach($dir In $Env:Path -Split ';')
{
  # Currently, we hard code specific environment variables.
  # Refactor it later.
  $dir = $dir -Replace '%USERPROFILE%',$userProfile
  $dir = $dir -Replace '%SystemRoot%',$systemRoot

  Foreach($exec In Get-ChildItem $dir -Include *.exe, *.bat, *.com, *.cmd -Name -ErrorAction SilentlyContinue) {
    $p = [io.path]::GetFileNameWithoutExtension($exec)
    $q = [io.path]::GetFileNameWithoutExtension($targetCommand)

    if ($p -eq $q) {
       Write-Output $dir\$exec
       $found = $true
       break
    }
  }

  # Only show the first path found unless
  #  the user use either `-a` or `--all` argument.
  if (-not ($a -or $all)) {
    if ($found) {
      break
    }
  }
}

# PowerShell cmdlets won't show in any file path.
# Hence, we fallback to `Get-Command` cmdlet.
if (-Not $found) {
  Get-Command $targetCommand 2>$null

  if ($? -ne $true) {
    exit 1
  }
}