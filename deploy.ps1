# Import the module
Import-Module AWS.Tools.CloudFormation

$StackName = 'awsvpcstack'
$TemplateBody = Get-Content -Path cloudformation-vpc.yml -Raw

try {
    # Check if the cmdlet exists
    if (-not (Get-Command New-CFNStack -ErrorAction SilentlyContinue)) {
        throw "New-CFNStack cmdlet not found. Make sure AWS.Tools.CloudFormation is properly installed and imported."
    }

    $result = New-CFNStack -StackName $StackName -TemplateBody $TemplateBody -ErrorAction Stop
    Write-Output "Stack creation initiated. Stack ID: $($result.StackId)"
}
catch {
    Write-Error "Failed to create stack: $_"
    exit 1
}