1. Cозданы входные переменные для приватного ключа, имени зоны
Создан файл terraform.tfvars.example

2.Выходные переменные для первого задания
 
output "external_ip_address_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}
output "external_ip_address_app2" {
  value = yandex_compute_instance.app2.network_interface.0.nat_ip_address
}

3. Второй инстанс создан копированием кода создания первого инстанса
Код рабочий, но увеличился в размере, это неудобно читать и редактировать

Выходные переменные для второго задания

output "external_ip_address_app" {
  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
}
output "external_ip_address_app2" {
  value = yandex_compute_instance.app2.network_interface.0.nat_ip_address
}
output "external_ip_address_load_balancer" {
  value = yandex_alb_load_balancer.app-balancer.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

4. Код изменен так, чтобы управлять количеством создаваемых инстансов через переменную в variables.tf
Добавлена переменна app_instance_count, по умолчанию она равна 1


Homework 9

В первой части задания реализовано хранение state файла в Yandex Object

Созданы две директории
В директории prod state файл хранится локально
В директории stage state файл хранится в Yandex Object
