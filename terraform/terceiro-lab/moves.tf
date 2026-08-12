moved {
  from = docker_image.nginx
  to   = module.nginx.docker_image.this
}

moved {
  from = docker_container.nginx
  to   = module.nginx.docker_container.this
}
moved {
  from = docker_image.redis
  to   = module.redis.docker_image.this
}

moved {
  from = docker_container.redis
  to   = module.redis.docker_container.this
}
moved {
  from = module.nginx
  to   = module.nginx["principal"]
}

moved {
  from = module.nginx_homologacao
  to   = module.nginx["homologacao"]
}
