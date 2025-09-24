#!/usr/bin/env bash

# Usage: ./harden-vm.sh /path/to/vmname.vmx
# Usage: ./harden-vm.sh dummy --guest

VMX="$1"

if [[ ! -f "$VMX" ]]; then
  echo "[!] Error: Please provide a valid .vmx file path."
  exit 1
fi

echo "[*] Hardening VMX file: $VMX"

# Disable VMCI and VMware integrations
declare -A HARDEN_ENTRIES=(
  ["vmci0.present"]="FALSE"
  ["tools.syncTime"]="FALSE"
  ["isolation.tools.copy.disable"]="TRUE"
  ["isolation.tools.paste.disable"]="TRUE"
  ["isolation.tools.dnd.disable"]="TRUE"
  ["isolation.tools.setGUIOptions.enable"]="FALSE"
  ["isolation.tools.hgfs.disable"]="TRUE"
  ["isolation.tools.diskShrink.disable"]="TRUE"
  ["isolation.tools.diskWiper.disable"]="TRUE"
  ["isolation.tools.autoInstall.disable"]="TRUE"
  ["sharedFolder.maxNum"]="0"
  ["hgfs.mapRootShare"]="FALSE"
  ["hgfs.linkRootShare"]="FALSE"
  ["RemoteDisplay.vnc.port"]="0"
)

for key in "${!HARDEN_ENTRIES[@]}"; do
  grep -q "^$key" "$VMX" &&
    sed -i '' "s|^$key *=.*|$key = \"${HARDEN_ENTRIES[$key]}\"|" "$VMX" ||
    echo "$key = \"${HARDEN_ENTRIES[$key]}\"" >>"$VMX"
done

# Strip shared folders
sed -i '' '/^sharedFolder[0-9]\+.present/d' "$VMX"

# Remove mounted ISOs and DMGs
sed -i '' '/.iso/d' "$VMX"
sed -i '' '/.dmg/d' "$VMX"

# Clean stale entries
sed -i '' '/^vmci0.id/d' "$VMX"
sed -i '' '/^tools.capability.verifiedSamlToken/d' "$VMX"
sed -i '' '/^toolsInstallManager.updateCounter/d' "$VMX"

echo "[+] .vmx hardened."

# Optional: Harden the guest OS (run from inside VM manually if needed)
if [[ "$2" == "--guest" ]]; then
  echo "[*] Disabling VMware Tools and guest integration…"

  sudo systemctl stop open-vm-tools
  sudo apt purge open-vm-tools open-vm-tools-desktop -y
  sudo apt autoremove --purge -y
  sudo apt clean

  sudo rm -f /usr/local/sbin/mount-shared-folders
  sudo rm -f /usr/local/sbin/restart-vm-tools
  sudo pkill -f vmtoolsd

  sudo rmmod vmw_vsock_virtio_transport_common || true
  sudo rmmod vsock || true
  sudo rmmod vmwgfx || true

  echo "[+] Guest hardened. RPC channels gone."
fi
