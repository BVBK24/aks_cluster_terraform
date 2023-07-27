variable "resource_group"{
    description = "name for the resource group"
}
variable "location"{
    description = "location of the resource group"
}
variable "nsg"{
    description= "network security group name"
}
variable "vnet"{
    description= "your vnet name"
}
variable "address_space"{
    description="your vnet address space"
}
variable "subnet1"{
    description="subnet1 name"
}

variable "aks_name"{
    description= "name of the aks cluster"
}
variable "kubernetes_version"{
    description="kubernetes version"
}
variable "cluster_name"{
    description="dns cluster name"
}
variable "node_resource_group"{
    description ="node resource group"
}
variable "system_node_count"{
    description = "system node count"
} 
variable "network_plugin"{
    description ="choose azure cni rather kubenet"
}
variable "docker_bridge_cidr"{
    description ="internal dcoker bridge cidr"
}
variable "service_cidr"{
    description ="internal kubernetes cidr"
}
variable "dns_service_ip"{
    description = "aks dns server ip"
}
