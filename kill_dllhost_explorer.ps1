# Script para matar o dllhost.exe que está travando o Explorer
# Salve como: kill_dllhost_explorer.ps1

# Lista todos os dllhost.exe
$dllhosts = Get-Process dllhost -ErrorAction SilentlyContinue

foreach ($proc in $dllhosts) {
    try {
        # Pega o comando completo usado pelo processo
        $cmd = (Get-CimInstance Win32_Process -Filter "ProcessId=$($proc.Id)").CommandLine

        # Se o comando contém referências ao Explorer (miniaturas, shell, etc.)
        if ($cmd -match ".*\:\{.*\}") {
            Write-Host "Matando dllhost.exe PID $($proc.Id) → $cmd"
            Stop-Process -Id $proc.Id -Force
        }
    } catch {
        Write-Host "Erro ao processar PID $($proc.Id)"
    }
}