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
  },
  GetVehicleBulkDownloadURLs = {
    name     = "GetVehicleBulkDownloadURLs",
    handler  = "app.handler",
    memory   = 256,
    timeout  = 60,
    env_vars = {},
    mts      = false,
    dva      = false,
    recalls  = false,
    cvs      = false,
    bulk     = true,
  }
}
