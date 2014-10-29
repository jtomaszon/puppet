exec { "update-alternatives --set editor /usr/bin/vim.tiny":
  path			=> "/usr/bin:/usr/sbin:/bin",
  unless		=> "test /etc/alternatives/editor -ef /usr/bin/vim.tiny",
}
