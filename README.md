<div style="text-align: center;">
 <p align="center"> <img alt="picture" src="https://github.com/seb07uk/Doors/blob/main/graphics/sccreenshot.PNG?raw=true" />
</div>

# <p align="center">Door's v1.0</p>
<p align="center">portable</p>
<br>

A lightweight **PowerShell GUI application** that provides quick access to system modes and actions with a polished interface, custom graphics, and ergonomic usability features.

---

## ✨ Features

- **Custom GUI Window**
  - Centered, fixed-size form with application icon and background image
  - Status bar with live status messages
  - Main menu with *App* and *Help* sections

- **Mode Launchers**
  - Safe Mode
  - Safe Mode with Command Prompt
  - Safe Mode with Networking
  - Normal Mode

- **System Actions**
  - Lock workstation
  - Sleep
  - Sign out
  - Restart
  - Shutdown
  - Hibernate

- **Branding & Graphics**
  - Logo integration with error handling
  - Icon-based buttons for quick access:
    - Email (Polsoft ITS)
    - Chomikuj profile
    - GitHub profile
  - Tooltips for better usability

- **Keyboard Shortcuts**
  - `Alt + F4` → Close application
  - `Alt + H` → Show *About* dialog

---

## 📂 Project Structure
Door's/ │ ├── graphics/ │   ├── app.ico │   ├── bgp2.png │   ├── logo.png │   ├── email.png │   ├── chomik.png │   └── github.png │ ├── vbs/ │   ├── SafeMode.vbs │   ├── SafeModeCMD.vbs │   ├── SafeMode_net.vbs │   └── NormalMode.vbs │ └── Door.ps1   # Main PowerShell script


---

## ⚙️ Requirements

- Windows 10/11
- PowerShell 5.1 or later
- .NET Framework (for WinForms support)

---

## 🚀 Usage

1. Clone or download the repository.
2. Ensure the `graphics` and `vbs` folders are present in the same directory as `Door.ps1`.
3. Run the script in PowerShell:

   ```powershell
   powershell.exe -ExecutionPolicy Bypass -File .\Door.ps1
 ---
 Świetnie, przygotowałem dla Ciebie profesjonalny plik README.md w języku angielskim, który opisuje projekt w sposób przejrzysty, techniczny i atrakcyjny. Uwzględniłem strukturę, funkcjonalności, wymagania oraz instrukcję uruchomienia.

Door's/ │ ├── graphics/ │   ├── app.ico │   ├── bgp2.png │   ├── logo.png │   ├── email.png │   ├── chomik.png │   └── github.png │ ├── vbs/ │   ├── SafeMode.vbs │   ├── SafeModeCMD.vbs │   ├── SafeMode_net.vbs │   └── NormalMode.vbs │ └── Door.ps1   # Main PowerShell script

4. 	Use the GUI to launch modes or perform system actions.

## 🛡️ Safety Notes
• 	Actions like Shutdown, Restart, and Hibernate execute immediately without confirmation.
• 	Ensure you save your work before using these options.
• 	Background and logo images are optional; the app will run even if they are missing.

## 👨‍💻 Author
Sebastian Januchowski
• 	GitHub: seb07uk
• 	Chomikuj: polsoft-its
• 	Email: polsoft.its@fastservice.com

## 📜 License
This project is distributed for educational and personal use.
Feel free to modify and extend it, but please keep credits to the original author.
