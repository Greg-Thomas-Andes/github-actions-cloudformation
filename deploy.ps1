# $StackName = 'awsvpcstack'
# $TemplateBody = Get-Content -Path cloudformation-vpc.yml -Raw

# New-CFNStack -StackName $StackName -TemplateBody $TemplateBody

$StackName = 'awsvpcstack'
$TemplateBody = Get-Content -Path cloudformation-vpc.yml -Raw

try {
    $result = New-CFNStack -StackName $StackName -TemplateBody $TemplateBody -ErrorAction Stop
    Write-Output "Stack creation initiated. Stack ID: $($result.StackId)"
}
catch {
    Write-Error "Failed to create stack: $_"
    exit 1
}