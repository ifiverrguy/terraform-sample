table_name = "your_table_name"
read_capacity  = 10
write_capacity = 10
billing_mode   = "PROVISIONED"
hash_key       = "ID"

attributes = [
  { name = "ID",          type = "S" },
  { name = "Tester",      type = "S" },
  { name = "Year",        type = "S" },
  { name = "TesterGroup", type = "S" }
]

global_secondary_indexes = [
  {
    name            = "TesterYearIndex"
    hash_key        = "Tester"
    range_key       = "Year"
    read_capacity   = 10
    write_capacity  = 10
    projection_type = "ALL"
  },
  {
    name            = "TesterGroupYearIndex"
    hash_key        = "TesterGroup"
    range_key       = "Year"
    read_capacity   = 10
    write_capacity  = 10
    projection_type = "ALL"
  }
]




read_min_capacity = 5
read_max_capacity = 100
read_target_value = 70.0

write_min_capacity = 5
write_max_capacity = 100
write_target_value = 70.0

