###vm vars

variable "default_platform_id" {
  type = string
  default = "standard-v3"
}

variable "vm_family_centos" {
  type        = string
  default     = "centos-7"
  description = "https://yandex.cloud/ru/docs/compute/concepts/image"
}

variable "vms_resources" {
  type        = map( object({
    core_fraction: number,
    cores: number,
    memory: number,
  }))
  default = {
    clickhouse={
      cores=2
      memory=2
      core_fraction=20
    },
    vector = {
      cores=2
      memory=2
      core_fraction=20
    },
    lighthouse = {
      cores=2
      memory=2
      core_fraction=20
    }
  }
  description = "Определяет параметры ВМ"
}


