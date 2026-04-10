# KeePass Installer with Plugins (Windows)

PowerShell script that installs [KeePass](https://keepass.info/) via `winget` and automatically downloads the latest versions of popular plugins from GitHub.

## Plugins Included

| Plugin | Description |
|--------|-------------|
| [KeeTheme](https://github.com/xatupal/KeeTheme) | Custom themes for KeePass UI |
| [KeePassWinHello](https://github.com/sirAndros/KeePassWinHello) | Unlock databases with Windows Hello (fingerprint, face, PIN) |
| [ReadablePassphrase](https://github.com/ligos/readablepassphrasegenerator) | Generate human-readable passphrases |
| [KeeAnywhere](https://github.com/Kyrodan/KeeAnywhere) | Cloud storage provider integration (Google Drive, OneDrive, Dropbox, etc.) |

## Usage

Run in an elevated (admin) PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File install-keepass.ps1
```

## How It Works

The script uses the GitHub API to fetch the latest release for each plugin repository, finds the `.plgx` asset, and downloads it to the KeePass plugins directory. No hardcoded versions, always pulls latest.

## Requirements

- Windows 10/11
- [winget](https://github.com/microsoft/winget-cli) (built into Windows 11)
- Internet access to github.com

## License

MIT
