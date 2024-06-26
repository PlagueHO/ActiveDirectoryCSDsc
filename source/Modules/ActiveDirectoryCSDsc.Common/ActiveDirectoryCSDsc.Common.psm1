$script:resourceHelperModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\Modules\DscResource.Common'

Import-Module -Name $script:resourceHelperModulePath

# Import Localization Strings
$script:localizedData = Get-LocalizedData -DefaultUICulture 'en-US'

<#
    .SYNOPSIS
        Restarts a System Service

    .PARAMETER Name
        Name of the service to be restarted.
#>
function Restart-ServiceIfExists
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [System.String]
        $Name
    )

    Write-Verbose -Message ($script:localizedData.GetServiceInformation -f $Name)
    $servicesService = Get-Service @PSBoundParameters -ErrorAction Continue -Verbose:$VerbosePreference

    if ($servicesService)
    {
        Write-Verbose -Message ($script:localizedData.RestartService -f $Name)
        $servicesService | Restart-Service -Force -ErrorAction Stop -Verbose:$VerbosePreference
    }
    else
    {
        Write-Verbose -Message ($script:localizedData.UnknownService -f $Name)
    }
}

Export-ModuleMember -Function @(
    'Restart-ServiceIfExists'
)
