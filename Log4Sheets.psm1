$global:endpoint = $null

function Get-Log-Endpoint {
<#
 .Synopsis
  Get endpoint url used to POST to for logging.

 .Description
  Returns the endpoint url to which logging requests are made.

 .Example
   # Get the current logging endpoint
   Get-Log-Endpoint
#>
param(
    )
    $endpoint = $global:endpoint;
    if(!$endpoint){
        return "No endpoint currently set. Endpoint must be set with Set-Log-Endpoint.";
    }
    return $endpoint;
}



function Set-Log-Endpoint {
<#
 .Synopsis
  Allows for setting endpoint url to POST to for logging.

 .Description
  Sets the endpoint url to which logging requests are made.

 .Parameter endpoint
  The url of the endpoint to which to POST to for logging

 .Example
   # Set the current logging endpoint
   Set-Log-Endpoint https://example.org/example
#>
param(
    [string] $endpoint
    )
    $global:endpoint = $endpoint;
}

function Log-To-Sheet {
<#
 .Synopsis
  Logs a message to a Google Sheet.

 .Description
  Provides an interface for writing a message and some host information to a Google Sheet.

 .Parameter message
  The message to log

 .Example
   # Log a message to a Google Sheet
   Log-To-Sheet ""
#>
param(
    [string] $message
    )
    $body = @{
        key="Legitlogkey";
        hostname = hostname;
        message=$message
    }
    return (iwr -Body ($body |ConvertTo-JSON) -Method Post $global:endpoint).Content
}

Set-Alias l2s Log-To-Sheet
Export-ModuleMember -Function Log-To-Sheet, Get-Log-Endpoint, Set-Log-Endpoint -Alias l2s
