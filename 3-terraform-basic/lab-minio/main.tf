resource "local_file" "state" {
  content  = "This configuration uses ${var.remote-state} state"
  filename = "/root/${var.remote-state}"
}