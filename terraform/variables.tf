# resources
    variable resource_group_name {
    type        = string
    description = "Name of resource group"
    }

    variable resource_group_location {
    type        = string
    description = "Location of resource group"
    }

# servcies
    variable service_plan_name {
    type        = string
    description = "Name of service plan"
    }

    variable service_plan_os_type {
      type        = string
      description = "Type of operation system"
    }
    
    variable service_plan_sku_name {
      type        = string
      description = "Name of sku"
    }
    
# webapp
    variable webapp_name {
      type        = string
      description = "Name of Web App Service"
    }

    variable webapp_site_config_linux_fx_version {
      type        = string
      description = "What should be preinstalled in my container"
    }
    
    variable webapp_site_config_always_on {
      type        = string
      description = "Is my container gonna be allways on?"
    }

    variable webapp_site_config_java_version {
      type        = string
      description = "Java version"
    }
    
    variable webapp_site_config_java_container {
      type        = string
      description = "Name of container"
    }
    
    variable webapp_site_config_java_container_version {
      type        = string
      description = "Java version in container"
    }
    
    

# server + database + firewall
    # server
        variable postgre-flexible-server-name {
        type        = string
        description = "Server name"
        }

        variable postgre-flexible-server-version {
        type        = string
        description = "Version of psql"
        }

        variable postgre-flexible-server-adminlogin {
        type        = string
        description = "Login for admin user in databases"
        }

        variable postgre-flexible-server-adminpassword {
        type        = string
        description = "Password for admin user in databases"
        }

        variable postgre-flexible-server-storage-mb {
        type        = string
        description = "Storage value in mbs"
        }

        variable postgre-flexible-server-sku-name {
        type        = string
        description = "Sku name in server configuration"
        }
    # database
        variable postgre-flexible-server-database-name {
          type        = string
          description = "Name of database"
        }
        
        variable postgre-flexible-server-database-collation {
          type        = string
          description = "Colletion type in database"
        }

        variable postgre-flexible-server-database-charset {
          type        = string
          description = "description"
        }
        
    # firewall
        variable postgre-flexible-server-firewall-rule-name {
          type        = string
          description = "Name of firewall rule"
        }

        variable postgre-flexible-server-firewall-rule-allow-all-get-address-start {
          type        = string
          description = "Allow all addresses to connect to postgresql flexible server what starts from"
        }

        variable postgre-flexible-server-firewall-rule-allow-all-get-address-end {
          type        = string
          description = "Allow all addresses to connect to postgresql flexible server what ends at"
        }
        
        
# project variables
  variable project_name {
    type        = string
    description = "Name of the project"
  }

  variable repository_url {
    type        = string
    description = "Repository url for App Service"
  }

  variable env {
    type        = string
    description = "The type of project environment"
    default     = "production"
  }

  variable branch_pointer {
    type        = string
    description = "Branch pointer for Repository"
    default     = "main"
  }

  variable storage_account_name {
    type        = string
    description = "Name of the storage account"
    default = "citizentorage"
  }

  variable container_name {
    type        = string
    description = "Name of the container where you would store resurces"
    default = "tfstate"
  }

  variable access_key {
    type        = string
    description = "Key for the storage container"
    default = "rWsef/7Kg6CKcwO+jv7b5Km3CSQ7uC67bkxKmbai3O7ikuKReJg0D0sEvbt3+tG9F+SQU6VFA9uZ+AStHVv8ZA=="
  }

  variable "storage_account_type" {
    type        = string
    description = "Type of the storage account"
    default     = "AzureFiles"
  }

  variable "storage_account_mounth_path" {
    type        = string
    description = "The path at which to mount the storage share"
    default     = "/home/site/wwwroot/tf-state"
    }
