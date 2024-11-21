resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "centos" {
  family = var.vm_family_centos
}

resource "yandex_compute_instance" "clickhouse" {

  name = "clickhouse"

  platform_id = var.default_platform_id
  zone        = var.default_zone

  resources {
    cores    = var.vms_resources["clickhouse"].cores
    memory   = var.vms_resources["clickhouse"].memory
    core_fraction = var.vms_resources["clickhouse"].core_fraction

  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat     = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = local.ssh_key
    user-data = "#cloud-config\nusers:\n  - name: centos\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${local.ssh_key}"
  }
}

resource "yandex_compute_instance" "vector" {

  name = "vector"

  platform_id = var.default_platform_id
  zone        = var.default_zone

  resources {
    cores    = var.vms_resources["vector"].cores
    memory   = var.vms_resources["vector"].memory
    core_fraction = var.vms_resources["vector"].core_fraction

  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat     = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = local.ssh_key
    user-data = "#cloud-config\nusers:\n  - name: centos\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${local.ssh_key}"
  }
}

resource "yandex_compute_instance" "lighthouse" {

  name = "lighthouse"

  platform_id = var.default_platform_id
  zone        = var.default_zone

  resources {
    cores    = var.vms_resources["lighthouse"].cores
    memory   = var.vms_resources["lighthouse"].memory
    core_fraction = var.vms_resources["lighthouse"].core_fraction

  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.centos.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat     = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = local.ssh_key
    user-data = "#cloud-config\nusers:\n  - name: centos\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${local.ssh_key}"
  }
}