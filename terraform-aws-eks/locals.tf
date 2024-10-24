
locals {   
node_subnets = [var.node_group_subnet_id_1, var.node_group_subnet_id_2] 
subnets = [var.subnet_id_1, var.subnet_id_2]
}
