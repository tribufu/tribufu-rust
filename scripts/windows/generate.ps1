#!/usr/bin/env pwsh

param(
    [string]$Spec = "https://api.tribufu.com/openapi.json"
)

$ErrorActionPreference = "Stop"
$schema = if ($Spec -match '^https://') {
    Invoke-RestMethod -Uri $Spec
} else {
    Get-Content -LiteralPath $Spec -Raw | ConvertFrom-Json
}
$schema | Add-Member -NotePropertyName servers -NotePropertyValue @(@{ url = "https://api.tribufu.com" }) -Force
$schemaFile = Join-Path ([System.IO.Path]::GetTempPath()) ("tribufu-openapi-" + [guid]::NewGuid() + ".json")

try {
    $schema | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $schemaFile -Encoding utf8
    java -jar ./vendor/openapi-generator/openapi-generator-cli.jar generate `
        -i $schemaFile `
        -g rust `
        -o . `
        --global-property apis,models,supportingFiles,apiDocs=false,modelDocs=false,apiTests=false,modelTests=false `
        --additional-properties=packageName=tribufu-sdk,library=reqwest-trait,supportAsync=true,preferUnsignedInt=true `
        --openapi-normalizer SET_TAGS_FOR_ALL_OPERATIONS=TribufuGenerated `
        --skip-validate-spec
    if ($LASTEXITCODE -ne 0) {
        exit $LASTEXITCODE
    }
} finally {
    if (Test-Path -LiteralPath $schemaFile) {
        Remove-Item -LiteralPath $schemaFile
    }
}

cargo fmt --all
exit $LASTEXITCODE
