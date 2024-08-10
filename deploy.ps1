# Import the module
Import-Module AWS.Tools.CloudFormation

$StackName = 'awsvpcstack'
$TemplateBody = Get-Content -Path cloudformation-vpc.yml -Raw

function Test-StackExists {
    param (
        [Parameter(Mandatory=$true)]
        [string]$StackName
    )
    try {
        Get-CFNStack -StackName $StackName
        return $true
    }
    catch {
        return $false
    }
}

try {
    # Check if the cmdlet exists
    if (-not (Get-Command New-CFNStack -ErrorAction SilentlyContinue)) {
        throw "New-CFNStack cmdlet not found. Make sure AWS.Tools.CloudFormation is properly installed and imported."
    }

    if (Test-StackExists -StackName $StackName) {
        Write-Output "Stack $StackName already exists. Attempting to update..."
        $result = Update-CFNStack -StackName $StackName -TemplateBody $TemplateBody -ErrorAction Stop
        Write-Output "Stack update initiated. Stack ID: $($result.StackId)"
    }
    else {
        Write-Output "Creating new stack $StackName..."
        $result = New-CFNStack -StackName $StackName -TemplateBody $TemplateBody -ErrorAction Stop
        Write-Output "Stack creation initiated. Stack ID: $($result.StackId)"
    }
}
catch {
    Write-Error "Failed to create or update stack: $_"
    exit 1
}