# data "morpheus_group" "morpheus_lab" {
#   name = "TestVmware"
# #   38 https://docs.morpheusdata.com/en/latest/infrastructure/groups/groups.html
# }

data "morpheus_cloud" "morpheus_vsphere" {
  name = "test vCenter Alletra"
#   10
}

data "morpheus_resource_pool" "vsphere_resource_pool" {
  name     = "Business Advanced"
  cloud_id = data.morpheus_cloud.morpheus_vsphere.id
  # cloud_id = 5126
#   2256
}

data "morpheus_instance_type" "centos_instance" {
  name = "DEV - Datagroup Rocky Linux servers"
#   105
}

data "morpheus_group" "testGroup" {
  # name = "Corbox 3"
  # name = "VMware Testing"
  name = "TestVmware"
}

# data "morpheus_instance_layout" "CentOS8S" {
#   name = "189"
# #   1241 or 1333
# }


data "morpheus_plan" "vmware" {
  name = "4 CPU, 16GB Memory - L"
  provision_type = "VMWare"
#   405
}

resource "morpheus_vsphere_instance" "tf_example_vsphere_instance" {
  name               = "Terraform Instance"
  description        = "Terraform instance example"
  cloud_id           = data.morpheus_cloud.morpheus_vsphere.id
  # group_id           = data.morpheus_group.morpheus_lab.id
  # group_id           = 39
  group_id           = data.morpheus_group.testGroup.id
  instance_type_id   = data.morpheus_instance_type.centos_instance.id
#   instance_layout_id = data.morpheus_instance_layout.CentOS8S.id
  instance_layout_id = 1612
  plan_id            = data.morpheus_plan.vmware.id
  environment        = "dev"
  resource_pool_id   = data.morpheus_resource_pool.vsphere_resource_pool.id
  labels             = ["demo", "terraform"]

  interfaces {
    # network_id = data.morpheus_network.vmnetwork.id
    network_id = 274
  }

  tags = {
    name = "centos"
  }

  evar {
    name   = "application"
    value  = "demo"
    export = true
    masked = true
  }

}