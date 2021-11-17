source "virtualbox-iso" "workstation" {

  boot_command = [
    " <up><wait><tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/${var.ks_path}<enter><wait>"
  ]

  boot_wait = "10s"
  cpus = var.cpus
  disk_size = var.disk_size
  guest_additions_url = var.guest_additions_url
  guest_additions_path = "VBoxGuestAdditions_{{.Version}}.iso"
  guest_os_type = "RedHat_64"
  hard_drive_interface = "sata"
  headless = var.headless
  http_directory = "http"
  iso_checksum = var.iso_checksum
  iso_url = "${var.mirror}/${var.mirror_directory}/${var.iso_name}"
  output_directory = "${var.build_directory}/packer-${var.template}-virtualbox"
  shutdown_command = "echo 'vagrant' | sudo -S /sbin/halt -h -p"
  ssh_password = "vagrant"
  ssh_port = 22
  ssh_username = "vagrant"
  ssh_wait_timeout = "10000s"
  memory = var.memory
  virtualbox_version_file = ".vbox_version"
  vm_name = var.template
}
