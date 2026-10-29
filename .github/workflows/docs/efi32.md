# 32-bit EFI validation notes

A 32-bit EFI firmware requires an EFI application with PE/COFF machine type IA32
at `EFI/BOOT/BOOTIA32.EFI`. A normal amd64 ISO has `BOOTX64.EFI`; installing the
package name `grub-efi-ia32` in an amd64 chroot is not a valid solution because
the package is architecture-specific.

Before publishing an image for a specific Mac:

1. Confirm CPU architecture with `lscpu`; a Core 2 Duo is normally x86-64.
2. Confirm EFI bitness from the model/firmware documentation or a known boot test.
3. Inspect the ISO: `xorriso -indev image.iso -report_el_torito as_mkisofs`.
4. Inspect EFI files in the ISO with `7z l image.iso | grep -Ei 'BOOTIA32|BOOTX64'`.
5. If using a third-party IA32 GRUB binary, verify its provenance, license, and hash.
6. Boot the exact machine and verify it can load the amd64 kernel and initramfs.

The live-build output from this repository is a hybrid BIOS + **64-bit EFI** ISO.
The `--uefi` option alone does not mean both EFI architectures are supported.
Do not advertise 32-bit EFI support until the IA32 loader has been integrated and
tested end-to-end. A dual-architecture EFI ISO usually requires a carefully built
EFI System Partition image containing both loaders and a GRUB configuration that
can locate the live kernel/initramfs; this project intentionally does not fabricate
a `BOOTIA32.EFI` binary or pretend a filename rename changes its architecture.
