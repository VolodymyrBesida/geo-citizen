terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
	  version = "3.9.0"
    }
  }
   backend "azurerm" {
       resource_group_name = "geo-group"
       storage_account_name = "citizentorage"
       container_name = "tfstate"
       key = "0ftDgYM9DcG+1NrMeLb62nMb9MICA+kvxaeky6gNCbR6YGhrXTbYZJZtYB9a5nh44ttGCNaxQ+jt+ASt9u0W6g=="
       use_azuread_auth = true
       subscription_id = "d234834b-33d7-47c3-b9c5-ded4cbc51e51"
       tenant_id = "c7594211-196a-4f40-8291-c5d79c3d1f9f"
   }
}

# provider
    provider "azurerm" {
        features {
            key_vault {
                purge_soft_delete_on_destroy = true
            }
        }
    }

# module
    module "naming" {
        source  = "Azure/naming/azurerm"
        version = "0.1.1"
        prefix  = ["${var.project_name}"]
    }

# resource group
    resource "azurerm_resource_group" "geo-group" {
        name     = var.resource_group_name
        location = var.resource_group_location

        tags = {
            environment = var.env
            managedBy   = "terraform"
            gitrepo     = var.repository_url
        }
    }

    resource "azurerm_resource_group" "geo-group-additional-resource" {
        name     = "geo-group-additional-resource"
        location = "Central US"

        tags = {
            environment = var.env
            managedBy   = "terraform"
            gitrepo     = var.repository_url
        }
    }

# storage account
    resource "azurerm_storage_account" "storage-account" {
        name                     = module.naming.storage_account.name_unique
        resource_group_name      = azurerm_resource_group.geo-group-additional-resource.name
        location                 = azurerm_resource_group.geo-group-additional-resource.location
        account_tier             = "Standard"
        account_replication_type = "LRS"

        tags = {
            environment = var.env
            managedBy   = "terraform"
            gitrepo     = var.repository_url
        }
    }

    resource "azurerm_storage_share" "sashare" {
        name                 = module.naming.storage_share.name_unique
        storage_account_name = azurerm_storage_account.storage-account.name
        quota                = 50
    }

# service plan
    resource "azurerm_service_plan" "app-plan" {
        name                = var.service_plan_name
        resource_group_name = azurerm_resource_group.geo-group-additional-resource.name
        location            = azurerm_resource_group.geo-group-additional-resource.location
        os_type             = var.service_plan_os_type
        sku_name            = var.service_plan_sku_name

        tags = {
            environment = var.env
            managedBy   = "terraform"
            gitrepo     = var.repository_url
        }
    }

# server + database + firewall
    # server
        resource "azurerm_postgresql_flexible_server" "postgre-flexible-server" {
            name                   = var.postgre-flexible-server-name
            resource_group_name    = azurerm_resource_group.geo-group.name
            location               = "East US"
            version                = var.postgre-flexible-server-version
            administrator_login    = var.postgre-flexible-server-adminlogin
            administrator_password = var.postgre-flexible-server-adminpassword
            storage_mb             = var.postgre-flexible-server-storage-mb
            sku_name               = "GP_Standard_D4s_v3"

            tags = {
                environment = var.env
                managedBy   = "terraform"
                gitrepo     = var.repository_url
            }

        }
    # database
        resource "azurerm_postgresql_flexible_server_database" "postgre-flexible-server-database" {
            name      = var.postgre-flexible-server-database-name
            server_id = azurerm_postgresql_flexible_server.postgre-flexible-server.id
            collation = var.postgre-flexible-server-database-collation
            charset   = var.postgre-flexible-server-database-charset

        }
    # firewall
        resource "azurerm_postgresql_flexible_server_firewall_rule" "postgre-flexible-server-firewall-rule" {
            name             = var.postgre-flexible-server-firewall-rule-name
            server_id        = azurerm_postgresql_flexible_server.postgre-flexible-server.id
            start_ip_address = var.postgre-flexible-server-firewall-rule-allow-all-get-address-start
            end_ip_address   = var.postgre-flexible-server-firewall-rule-allow-all-get-address-end
        }

# web app
    resource "azurerm_linux_web_app" "webapp" {
        name                = var.webapp_name
        resource_group_name = azurerm_resource_group.geo-group-additional-resource.name
        location            = "Central US"
        service_plan_id     = azurerm_service_plan.app-plan.id

        site_config {
            always_on              = true
            application_stack {
                java_server = "TOMCAT"
                java_version = "1.8"
            }
        }

        connection_string {
            name = "Database"
            type = "PostgreSQL"
            value = "postgres://postgres:${azurerm_postgresql_flexible_server.postgre-flexible-server.administrator_password}@demodb-server.postgres.database.azure.com/postgres?sslmode=require"
        }

        storage_account {
            name         = var.storage_account_name
            type         = var.storage_account_type
            account_name = azurerm_storage_account.storage-account.name
            access_key   = azurerm_storage_account.storage-account.primary_access_key
            share_name   = azurerm_storage_share.sashare.name
            mount_path   = var.storage_account_mounth_path
        }

        tags = {
            environment = var.env
            managedBy   = "terraform"
            gitrepo     = var.repository_url
        }
    }

