build {
    sources = [
        "source.virtualbox-iso.workstation"
    ]

    provisioner "shell" {

        environment_vars = [
          "HOME_DIR=/home/vagrant"
        ]

        execute_command = "echo 'vagrant' | {{.Vars}} sudo -S -E sh -eux '{{.Path }}'"
        expect_disconnect = true

        scripts = [
          "scripts/update.sh",
          "_common/motd.sh",
          "_common/sshd.sh",
          "scripts/networking.sh",
          "_common/vagrant.sh",
          "_common/virtualbox.sh",
          "scripts/cleanup.sh",
          "_common/minimize.sh"
        ]
    }

    post-processors {
        post-processor "vagrant" {
            output = "${var.build_directory}/${var.box_basename}.{{.Provider}}.box"
        }

        post-processor "vagrant-cloud" {
            box_tag = "corbolj/centos-8"
            version = var.version
        }
    }
}
