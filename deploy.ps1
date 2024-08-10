$StackName = 'awsvpcstack'
$TemplateBody = Get-Content -Path cloudformation-vpc.yml -Raw

New-CFNStack -StackName $StackName -TemplateBody $TemplateBody