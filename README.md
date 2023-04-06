# Postprocessing commands library

## Deploy
1. Unpack archive to postprocessing commands directory. Example:  
    ```bash
    tar --strip 1 -xzf pp_stdlib-0.0.4-master.tar.gz -C /opt/otp/python_computing_node/commands/
    ```
2. Configure `otl_v1` command. Example:  
    ```bash
    cp commands/otl_v1/config.example.ini commands/otl_v1/config.ini
    ```
   Config example:  
    ```ini
   [spark]
   base_address = http://localhost
   username = admin
   password = 12345678

   [caching]
   # 24 hours in seconds
   login_cache_ttl = 86400
   # Command syntax defaults
   default_request_cache_ttl = 100
   default_job_timeout = 100
    ```
3. Configure storages for `readFile` and `writeFile` commands:  
   ```bash
   cp commands/readFile/config.example.ini commands/readFile/config.ini
   ```
   Config example:  
   ```ini
   [storages]
   lookups = /opt/otp/lookups
   external_data = /opt/otp/external_data
   pp_shared = /opt/otp/shared_storage/persistent

   [defaults]
   default_storage = external_data
   ```