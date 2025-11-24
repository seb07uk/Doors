Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Tworzenie głównego okna formularza
$form = New-Object System.Windows.Forms.Form
$form.Text = "Door's v1.0"
$form.Size = New-Object System.Drawing.Size(300, 564)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# Dodanie ikony aplikacji
$iconPath = Join-Path $PSScriptRoot "graphics\app.ico"
if (Test-Path $iconPath) {
    $form.Icon = New-Object System.Drawing.Icon($iconPath)
}

# Wczytanie tła z pliku (z obsługą błędów)
$bgPath = Join-Path $PSScriptRoot "graphics\bgp2.png"
if (Test-Path $bgPath) {
    try {
        $backgroundImage = [System.Drawing.Image]::FromFile($bgPath)
        $form.BackgroundImage = $backgroundImage
        $form.BackgroundImageLayout = "Stretch"
    } catch {
        Write-Warning "Nie udało się wczytać tła."
    }
}

# Pasek stanu na dole
$statusBar = New-Object System.Windows.Forms.StatusStrip
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = "Gotowe"
$statusBar.Items.Add($statusLabel)
$form.Controls.Add($statusBar)

# Menu główne
$menuStrip = New-Object System.Windows.Forms.MenuStrip
$fileMenu = New-Object System.Windows.Forms.ToolStripMenuItem("App")
$exitItem = New-Object System.Windows.Forms.ToolStripMenuItem("Close")
$exitItem.Add_Click({ $form.Close() })
$fileMenu.DropDownItems.Add($exitItem)

$helpMenu = New-Object System.Windows.Forms.ToolStripMenuItem("Help")
$aboutItem = New-Object System.Windows.Forms.ToolStripMenuItem("About")
$aboutItem.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Door's v1.0`n`nby Sebastian Januchowski")
})
$helpMenu.DropDownItems.Add($aboutItem)

$menuStrip.Items.Add($fileMenu)
$menuStrip.Items.Add($helpMenu)
$form.MainMenuStrip = $menuStrip
$form.Controls.Add($menuStrip)

# Funkcja pomocnicza do tworzenia przycisków z efektem hover
function Dodaj-Przycisk {
    param (
        [string]$tekst,
        [int]$left,
        [int]$top,
        [scriptblock]$akcja = $null
    )
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $tekst
    $btn.Size = New-Object System.Drawing.Size(120, 35)
    $btn.Location = New-Object System.Drawing.Point($left, $top)
    $btn.BackColor = 'WhiteSmoke'
    $btn.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $btn.TabStop = $false

    if ($akcja) { $btn.Add_Click($akcja) }

    # Efekt hover
    $btn.Add_MouseEnter({ $btn.BackColor = 'LightGray' })
    $btn.Add_MouseLeave({ $btn.BackColor = 'WhiteSmoke' })

    $form.Controls.Add($btn)
}

# --- Przyciski trybów ---
Dodaj-Przycisk "Safe Mode" 90 60 { Start-Process "wscript.exe" -ArgumentList "vbs\SafeMode.vbs" }
Dodaj-Przycisk "Safe Mode with Command Prompt" 90 100 { Start-Process "wscript.exe" -ArgumentList "vbs\SafeModeCMD.vbs" }
Dodaj-Przycisk "Safe Mode with Networking" 90 140 { Start-Process "wscript.exe" -ArgumentList "vbs\SafeMode_net.vbs" }
Dodaj-Przycisk "Normal Mode" 90 180 { Start-Process "wscript.exe" -ArgumentList "vbs\NormalMode.vbs" }

# Logo z obsługą błędów
$logoPath = Join-Path $PSScriptRoot "graphics\logo.png"
if (Test-Path $logoPath) {
    try {
        $logo = New-Object System.Windows.Forms.PictureBox
        $logo.Image = [System.Drawing.Image]::FromFile($logoPath)
        $logo.SizeMode = "StretchImage"
        $logo.Size = New-Object System.Drawing.Size(260, 80)
        $logo.Location = New-Object System.Drawing.Point(20, 220)
        $form.Controls.Add($logo)
    } catch {
        Write-Warning "Nie udało się wczytać logo."
    }
}

# --- Przyciski systemowe ---
$topStart = 310
$left1 = 20
$left2 = 150
$spacing = 40

Dodaj-Przycisk "Lock" $left1 ($topStart + 0 * $spacing) { rundll32.exe user32.dll,LockWorkStation }
Dodaj-Przycisk "Sleep" $left1 ($topStart + 1 * $spacing) { shutdown.exe /h }
Dodaj-Przycisk "Sign out" $left1 ($topStart + 2 * $spacing) { shutdown.exe /l }

Dodaj-Przycisk "Restart" $left2 ($topStart + 0 * $spacing) { shutdown.exe /r /t 0 }
Dodaj-Przycisk "Shutdown" $left2 ($topStart + 1 * $spacing) { shutdown.exe /s /t 0 }
Dodaj-Przycisk "Hibernate" $left2 ($topStart + 2 * $spacing) { shutdown.exe /h }

# --- Ikonowe przyciski ---
function Dodaj-IkonowyPrzycisk {
    param (
        [string]$plik,
        [int]$x,
        [int]$y,
        [scriptblock]$akcja,
        [string]$tekstFallback
    )
    $btn = New-Object System.Windows.Forms.Button
    $btn.Size = New-Object System.Drawing.Size(40,40)
    $btn.Location = New-Object System.Drawing.Point($x,$y)
    $btn.FlatStyle = "Flat"
    $btn.FlatAppearance.BorderSize = 0
    $btn.TabStop = $false

    if (Test-Path $plik) {
        try {
            $btn.BackgroundImage = [System.Drawing.Image]::FromFile($plik)
            $btn.BackgroundImageLayout = "Stretch"
        } catch {
            $btn.Text = $tekstFallback
        }
    } else {
        $btn.Text = $tekstFallback
    }

    $btn.Add_Click($akcja)
    $form.Controls.Add($btn)
    return $btn
}

$emailBtn = Dodaj-IkonowyPrzycisk (Join-Path $PSScriptRoot "graphics\email.png") 50 450 { Start-Process "mailto:polsoft.its@fastservice.com" } "Email"
$chomikBtn = Dodaj-IkonowyPrzycisk (Join-Path $PSScriptRoot "graphics\chomik.png") 125 450 { Start-Process "https://chomikuj.pl/polsoft-its" } "Chomik"
$githubBtn = Dodaj-IkonowyPrzycisk (Join-Path $PSScriptRoot "graphics\github.png") 200 450 { Start-Process "https://github.com/seb07uk" } "GitHub"

# ToolTip
$toolTip = New-Object System.Windows.Forms.ToolTip
$toolTip.SetToolTip($emailBtn, "Wyślij email do Polsoft ITS")
$toolTip.SetToolTip($chomikBtn, "Otwórz stronę Polsoft ITS")
$toolTip.SetToolTip($githubBtn, "Otwórz stronę GitHub")

# --- Skróty klawiszowe ---
$form.KeyPreview = $true
$form.Add_KeyDown({
    param($sender, $e)

    # Alt+F4 -> zamknij aplikację
    if ($e.Alt -and $e.KeyCode -eq [System.Windows.Forms.Keys]::F4) {
        $form.Close()
    }

    # Alt+H -> pokaż okno About
    if ($e.Alt -and $e.KeyCode -eq [System.Windows.Forms.Keys]::H) {
        [System.Windows.Forms.MessageBox]::Show("Door's v1.0`n`nby Sebastian Januchowski")
    }
})

# Uruchomienie aplikacji
[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::Run($form)