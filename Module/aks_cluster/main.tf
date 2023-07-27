terraform{
    required_providers {
      azurerm={
        source = "hashicorp/azurerm"
        version = "=3.9.0"
      }
    }
}
provider "azurerm"{
    features {}
}

resource "azurerm_resource_group" "rg_group" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_network_security_group" "nsg_grp" {
  name                = var.nsg
  location            = azurerm_resource_group.rg_group.location
  resource_group_name = azurerm_resource_group.rg_group.name
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet
  location            = azurerm_resource_group.rg_group.location
  resource_group_name = azurerm_resource_group.rg_group.name
  address_space       = var.address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  #private             = true

  subnet {
    name           = var.subnet1
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.nsg_grp.id
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  kubernetes_version  = var.kubernetes_version
  location            = azurerm_resource_group.rg_group.location
  resource_group_name = azurerm_resource_group.rg_group.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group


  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = var.network_plugin
    load_balancer_sku  = "standard"
    docker_bridge_cidr = var.docker_bridge_cidr
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
  }

  tags = {
    Environment = "Production"
  }
}




