output "backend_int_ip" {
  value = yandex_compute_instance.backend.network_interface.0.nat_ip_address
}
output "db_int_ip" {
  value = yandex_compute_instance.db.network_interface.0.nat_ip_address
}
output "frontend_int_ip" {
  value = yandex_compute_instance.frontend.network_interface.0.nat_ip_address
}