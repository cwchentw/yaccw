# wwhich.ps1 - Simulate Unix which on Windows
# Copyright (c) 2020 Michael Chen
# Licensed under MIT.


param (
  [switch]$h = $false,
  [switch]$help = $false,
  [switch]$a = $false,
  [switch]$all = $false
)

# Show the help info and exit the program.
if ($h -or $help) {
  Write-Output "Usage: $0 [option] [command]"
  Write-Output ""
  Write-Output "Option:"
  Write-Output "  -h    -help     Show help info and exit"
  Write-Output "  -a    -all      Show all possible path(s)"
  Write-Output ""
  Write-Output "[command] is the name of a console command"

  exit 0
}

# Check whether the target command exists.
$targetCommand = $args[0]

if (!$targetCommand) {
  Write-Error "No valid target"
  exit 1
}

# Get all file extensions of executable.
$exts = @()

foreach ($ext in $env:pathext -Split ';') {
  $exts += '*' + $ext
}

# .ps1 is not listed in $env:pathext.
$exts += '*' + '.ps1'

# Get all environment variables presenting paths.
$envs = @{}

foreach ($e in Get-ChildItem env:) {
  if (($e.value -Match '^[a-z]\:\\') `
      -and -not ($e.value -Match '\.[a-z]+$|;')) {
    $envs.Add('%' + $e.Name + '%', $e.Value)
  }
}

$found = $false

# Search the target command in each path of PATH.
foreach ($dir In $Env:Path -Split ';') {
  foreach ($k In $envs.keys) {
    $dir = $dir -Replace $k, $envs[$k]
  }

  foreach ($exec In Get-ChildItem $dir -Include $exts -Name -ErrorAction SilentlyContinue) {
    $p = [io.path]::GetFileNameWithoutExtension($exec)
    $q = [io.path]::GetFileNameWithoutExtension($targetCommand)

    if ($p -eq $q) {
      Write-Output $dir\$exec
      $found = $true

      if ((-not $a) -and (-not $all)) {
        break
      }
    }
  }

  # Only show the first path found unless
  #  the user use either `-a` or `-all` argument.
  if ((-not $a) -and (-not $all)) {
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