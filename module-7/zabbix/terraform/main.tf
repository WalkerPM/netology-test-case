terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.current_zone
  token = var.token
  folder_id = var.folder_id
  cloud_id = var.cloud_id
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = [var.cidr_block]
}

resource "local_file" "inventory" {
 filename = "${var.inventory_path}"
 content = <<EOF
[db]
${yandex_compute_instance.db.network_interface.0.nat_ip_address} ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_ssh_private_key_file=${var.ssh_privkey_path} ansible_user=ubuntu ansible_become=yes cidr_block=${var.cidr_block}
[frontend]
${yandex_compute_instance.frontend.network_interface.0.nat_ip_address} ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_ssh_private_key_file=${var.ssh_privkey_path} ansible_user=ubuntu ansible_become=yes db_address=${yandex_compute_instance.db.network_interface.0.ip_address} backend_address=${yandex_compute_instance.backend.network_interface.0.ip_address}
[backend]
${yandex_compute_instance.backend.network_interface.0.nat_ip_address} ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_ssh_private_key_file=${var.ssh_privkey_path} ansible_user=ubuntu ansible_become=yes db_address=${yandex_compute_instance.db.network_interface.0.ip_address} backend_address=${yandex_compute_instance.backend.network_interface.0.ip_address}
[ubuntu]
${yandex_compute_instance.ubuntu.network_interface.0.nat_ip_address} ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_ssh_private_key_file=${var.ssh_privkey_path} ansible_user=ubuntu ansible_become=yes cidr_block=${var.cidr_block}
[centos]
${yandex_compute_instance.centos.network_interface.0.nat_ip_address} ansible_ssh_common_args='-o StrictHostKeyChecking=no' ansible_ssh_private_key_file=${var.ssh_privkey_path} ansible_user=centos ansible_become=yes cidr_block=${var.cidr_block}
EOF
}
