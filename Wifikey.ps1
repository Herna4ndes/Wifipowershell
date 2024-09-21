(netsh wlan show profiles) | Select-String "Todos os perfis de usuário" | ForEach-Object {
    $_.Line -match ":(.*)$"
    $profile = $matches[1].Trim()
    Write-Host "nProfile: $profile"
    $keyContent = (netsh wlan show profile name="$profile" key=clear) | Select-String "Conteúdo da chave"
    if ($keyContent) {
        $keyContent.Line -match ":(.*)$"
        $password = $matches[1].Trim()
        Write-Host "Senha: $password"
    } else {
        Write-Host "Senha não encontrada ou não configurada."
    }
}