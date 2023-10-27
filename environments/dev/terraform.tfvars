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

