table_name     = "my_dev_table"
read_capacity  = 5
write_capacity = 5
hash_key       = "ID"
cidr_block = "10.0.0.0/16"
api_name = "dev-api-gateway"
waf_countries_allowed = ["US", "CA"]
# Define variable values to be fed into components in the components directory that will each form a part of the examplenv environment...

environment            = "dev"
environment_short_name = "dev"


### app_lambdas ################################################################################
app_lambdas = {
  EnhancedGetVehicleByRegistration = {
    name     = "EnhancedGetVehicleByRegistration",
    handler  = "app.handler",
    memory   = 256,
    timeout  = 60,
    env_vars = {},
    mts      = true,
    dva      = true,
    recalls  = true,
    cvs      = false,
    bulk     = false,
    runtime  = "nodejs14.x"
    http_method = "POST"
    filename      = "./code.zip"
   
  },
   EnhancedGetVehicleByApple = {
    name     = "EnhancedGetVehicleByApple",
    handler  = "app.handler",
    memory   = 256,
    timeout  = 60,
    env_vars = {},
    mts      = true,
    dva      = true,
    recalls  = true,
    cvs      = false,
    bulk     = false,
    runtime  = "nodejs14.x"
    http_method = "PUT"
    filename      = "./code.zip"
   
  },
   EnhancedGetVehicleByMango = {
    name     = "EnhancedGetVehicleByMango",
    handler  = "app.handler",
    memory   = 256,
    timeout  = 60,
    env_vars = {},
    mts      = true,
    dva      = true,
    recalls  = true,
    cvs      = false,
    bulk     = false,
    runtime  = "nodejs14.x"
    http_method = "GET"
    filename      = "./code.zip"
   
  },
   EnhancedGetVehicleByGrapes = {
    name     = "EnhancedGetVehicleByGrapes",
    handler  = "app.handler",
    memory   = 256,
    timeout  = 60,
    env_vars = {},
    mts      = true,
    dva      = true,
    recalls  = true,
    cvs      = false,
    bulk     = false,
    runtime  = "nodejs14.x"
    http_method = "POST"
    filename      = "./code.zip"
   
  }
  
  
}
