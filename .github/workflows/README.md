# Maclight Live — Windows-friendly ISO builder

A standalone source repository for building a Debian 12 amd64 X11/Xfce live ISO for
older Intel MacBooks. Windows users can trigger builds through GitHub Actions.

## Windows quick start

Read [`WINDOWS-BUILD.md`](WINDOWS-BUILD.md). In brief:

1. Create an empty GitHub repository.
2. Extract this project and push it to GitHub with Git for Windows.
3. Open **Actions → Build Maclight Live ISO → Run workflow**.
4. Download the `maclight-live-amd64-iso` artifact from the completed run.

You can also double-click `Build-Maclight-ISO.cmd` after setting the Git remote.

## Local Linux build

On Debian 12 amd64, install the dependencies listed in `WINDOWS-BUILD.md`, then run:

```sh
sudo ./auto/config
sudo ./auto/build
```

## Important limitations

- This builds a Debian live ISO, not a tested disk installer with a guided installation UI.
- The current image is amd64 + hybrid BIOS/64-bit EFI. It does not yet contain a verified
  IA32 EFI boot path, so 32-bit-EFI MacBook compatibility is not guaranteed.
- The ISO has not been hardware-tested. Idle RAM and ISO-size targets are goals, not
  measured guarantees.
- External theme sources are fetched during build. For strict reproducibility, pin
  commit hashes and package repository snapshots before making releases.

See `docs/efi32.md` for the EFI issue and `docs/assets.md` for asset provenance.
"# maclight-live" 
