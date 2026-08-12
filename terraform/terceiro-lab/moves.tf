moved {
  from = docker_image.nginx
  to   = module.nginx.docker_image.this
}

moved {
  from = docker_container.nginx
  to   = module.nginx.docker_container.this
}
