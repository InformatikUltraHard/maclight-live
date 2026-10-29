# Build Maclight Live ISO from Windows 10/11

## Easiest method: GitHub Actions (recommended)

Windows does not natively run Debian `live-build`. This repository therefore uses
GitHub Actions to build the ISO on a Linux runner. You do not need WSL, Docker,
a Linux virtual machine, or local administrator rights.

### Requirements

- Windows 10/11
- A GitHub account
- Git for Windows: https://git-scm.com/download/win
- Internet access
- A GitHub repository containing this project

### One-time setup

1. Create a **new empty repository** on GitHub (do not initialize it with a README).
2. Extract this ZIP to a folder such as `C:\\Projects\\maclight-windows-builder`.
3. Open that folder in File Explorer, right-click and select **Open in Terminal**.
4. Run:

   ```powershell
   git init
   git add .
   git commit -m "Initial Maclight Live builder"
   git branch -M main
   git remote add origin https://github.com/YOUR-USER/YOUR-REPO.git
   git push -u origin main
   ```

   Replace `YOUR-USER/YOUR-REPO` with your GitHub repository path.

5. Double-click `Build-Maclight-ISO.cmd`, or open:
   `https://github.com/YOUR-USER/YOUR-REPO/actions/workflows/build-iso.yml`
6. Select **Run workflow**, choose branch `main`, and run it.
7. Wait for the job to complete successfully. Open the completed run and scroll to
   **Artifacts**. Download `maclight-live-amd64-iso`.
8. Extract the downloaded artifact ZIP. It contains the `.iso` and `SHA256SUMS`.

Every push to `main` also triggers a build. The workflow uses a Linux runner because
Debian live-build requires Linux root/chroot and filesystem tooling.

## Optional local build with WSL2

For local builds, install WSL2 and Debian/Ubuntu from an elevated PowerShell prompt:

```powershell
wsl --install -d Debian
```

Restart if Windows asks. Open Debian from the Start menu and run:

```sh
sudo apt update
sudo apt install -y live-build debootstrap xorriso squashfs-tools \
  grub-pc-bin grub-efi-amd64-bin mtools dosfstools git ca-certificates
```

Copy/clone this repository **inside the WSL Linux filesystem**, e.g. `~/src`, not
under `/mnt/c`, for better filesystem performance. Then:

```sh
cd ~/src/maclight-windows-builder
sudo ./auto/config
sudo ./auto/build
```

The output ISO will be in the repository root. WSL builds are optional; GitHub Actions
is the default Windows-friendly method.

## Critical compatibility note

This project currently builds an amd64 hybrid live ISO. The current repository does
not yet provide a verified IA32 EFI loader, so it is **not yet a guaranteed bootable
installer for 32-bit EFI Macs**. Read `docs/efi32.md` before relying on it. An amd64
live image also is not a disk installer unless an installer application and its
partitioning/bootloader configuration are added and tested.
