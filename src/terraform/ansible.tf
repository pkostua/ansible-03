resource "local_file" "ansible_inventory" {
  filename = "${path.module}/../ansible/inventory/prod.yml"
  content  = templatefile("${path.module}/inventory.tftpl", {
    vector_ip   = yandex_compute_instance.vector.network_interface[0].nat_ip_address
    clickhouse_ip = yandex_compute_instance.clickhouse.network_interface[0].nat_ip_address
    lighthouse_ip = yandex_compute_instance.lighthouse.network_interface[0].nat_ip_address
  })
}

resource "null_resource" "web_hosts_provision" {
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.clickhouse, yandex_compute_instance.vector, yandex_compute_instance.lighthouse]

  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "eval $(ssh-agent) && cat ~/.ssh/id_ed25519 | ssh-add -"
    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок

  }

  #Запуск ansible-playbook
  /*provisioner "local-exec" {
    command = <<EOT
          ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/../ansible/inventory/prod.yml ${abspath(path.module)}/../site.yml
    EOT
  }*/

}
