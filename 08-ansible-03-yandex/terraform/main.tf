resource "yandex_compute_instance" "vm" {
  for_each = {
    cl_instance = "clickhouse-01"
    v_instance = "vector-01"
    lh_instance = "lighthouse-01"
  }
  
  name        = each.value
  hostname    = "${each.value}.local"
  
  platform_id = "standard-v1"
  
  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos-7-base}"
      type     = "network-hdd"
      size     = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys = "ret:${file("~/.ssh/id_rsa.pub")}"
  }
}
