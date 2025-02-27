variable "db_identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class for RDS"
  type        = string
}

variable "db_allocated_storage" {
  description = "Storage size for RDS (GB)"
  type        = number
}

variable "db_storage_type" {
  description = "Type of storage (e.g., gp2, io1)"
  type        = string
  default     = "gp2"
}

variable "db_username" {
  description = "Master database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master database password"
  type        = string
  sensitive   = true
}

variable "db_subnet_group_name" {
  description = "Subnet group name for RDS"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for RDS"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Whether to skip final snapshot before RDS deletion"
  type        = bool
  default     = true
}
