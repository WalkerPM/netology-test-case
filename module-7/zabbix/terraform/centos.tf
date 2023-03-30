resource "yandex_compute_instance" "centos" {
  name = "cent"
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = var.centos_image_type
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file(var.ssh_key_path)}"
  }
}