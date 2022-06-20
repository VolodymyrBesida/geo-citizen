# resources
    resource_group_name        = "geo-group-demo"
    resource_group_location    = "Canada Central"

# services
    service_plan_name          = "ASP-geogroup-973a"
    service_plan_os_type       = "Linux"
    service_plan_sku_name      = "B1"

# webapp
    webapp_name                                  = "web-geo-citizen"
    webapp_site_config_linux_fx_version          = "TOMCAT|9.0-jre8"
    webapp_site_config_always_on                 = true
    webapp_site_config_java_version              = "8"
    webapp_site_config_java_container            = "JAVA"
    webapp_site_config_java_container_version    = "8"

# server + database
    # server
        postgre-flexible-server-name             = "demodb-server"
        postgre-flexible-server-version          = "12"
        postgre-flexible-server-adminlogin       = "postgres"
        postgre-flexible-server-adminpassword    = "Password1"
        postgre-flexible-server-storage-mb       = 32768
        postgre-flexible-server-sku-name         = "GP_Standard_D4s_v3"
    # database
        postgre-flexible-server-database-name        = "demodb-psql"
        postgre-flexible-server-database-collation   = "en_US.utf8"
        postgre-flexible-server-database-charset     = "utf8"
    # firewall
        postgre-flexible-server-firewall-rule-name                     = "allow-all-connections"
        postgre-flexible-server-firewall-rule-allow-all-get-address-start    = "0.0.0.0"
        postgre-flexible-server-firewall-rule-allow-all-get-address-end    = "255.255.255.255"

# project variables
    project_name = "citizen"
    repository_url = "https://github.com/VolodymyrBesida/geo-citizen"
