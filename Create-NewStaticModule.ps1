function New-SeStaticModule {
    param (
        [string]$ModuleName,
        [string]$ModuleRootPath,
        [string]$Author = "Oleksandr Dubyna, struggleendlessly@hotmail.com",
        [string]$CompanyName = "Accenture"
    )
    
    if ( -Not (Test-Path -Path $ModuleRootPath ) ) {
        New-Item -ItemType directory -Path $ModuleRootPath
    }

    $ModuleFullPath = Join-Path -Path $ModuleRootPath -ChildPath $ModuleName

    if ( -Not (Test-Path -Path $ModuleFullPath ) ) {
        New-Item -ItemType directory -Path $ModuleFullPath
    }

    $psm = "psm1"
    $psd = "psd1"  

    $psmFileName = "{0}.{1}" -f $ModuleName, $psm
    $psdFileName = "{0}.{1}" -f $ModuleName, $psd

    $pathToPsm1 = Join-Path -Path $ModuleFullPath -ChildPath $psmFileName
    $pathToPsd1 = Join-Path -Path $ModuleFullPath -ChildPath $psdFileName

    New-Item -ItemType File -Path $pathToPsm1

    New-ModuleManifest -Path $pathToPsd1 -RootModule $psmFileName -Author $Author -CompanyName $CompanyName
}

function New-SeCreateSubFolders {
    param (
        [string]$ModuleName,
        [string]$ModuleRootPath
    )
    
    $path = Join-Path -Path $ModuleRootPath -ChildPath $ModuleName
    $pathToClasses = Join-Path -Path $path -ChildPath "Classes"
    $pathToConfigs = Join-Path -Path $path -ChildPath "Configs"
  
    New-Item -ItemType directory -Path $pathToClasses
    New-Item -ItemType directory -Path $pathToConfigs
}

function New-Se {
    $pathBase = Resolve-Path .

    $pathsArray = New-Object string[] 10
    $pathsArray[0] = Join-Path -Path $pathBase -ChildPath "Accenture"
    $pathsArray[1] = Join-Path -Path $pathBase -ChildPath "HyperV"
    
    $ModuleRootPath = $pathsArray[1]
    $ModuleName = "TopoVm"
    
    $pathTest = Join-Path -Path $ModuleRootPath -ChildPath $ModuleName
    if (!(Test-Path -Path $pathTest )) {
        New-SeStaticModule $ModuleName $ModuleRootPath
        New-SeCreateSubFolders $ModuleName $ModuleRootPath
    }
}

New-Se