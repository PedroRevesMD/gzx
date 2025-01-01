#!/data/data/com.termux/files/usr/bin/bash

write_msg() {
  echo "$1"
}

remove_motd() {
  local dir_motd="/data/data/com.termux/files/usr/etc"

  write_msg "Removendo Mensagens de Boas vindas do Termux.. "

  cd  ~/../usr/etc || { write _msg "Erro: Não foi possível Acessar o Diretório /usr/etc"; exit 1;}

  rm -f "$dir_motd/motd"* 2>/dev/null

  if [[ $? -ne 0 ]]; then
     write_msg "Erro: Não Foi Possível Remover os Arquivos Motd"
     exit 1
  fi
  write_msg "Arquivos Removidos com Sucesso!"
  sleep 2
}

update_apt() {
  write_msg "Atualizando Pacotes do Termux com Apt..."
  apt update && apt upgrade -y 

  if [[ $? -ne 0 ]]; then
     write_msg "Erro: Não Foi Possível Atualizar os Pacotes. Verifique sua Internet"
     exit 1
  fi

  write_msg "Pacotes Atualizados com Sucesso!"
  sleep 2
}

update_pkg() {
  write_msg "Atualizando Pacotes do Termux com pkg..."
  pkg update && pkg upgrade -y

  if [[ $? -ne 0 ]]; then
     write_msg "Erro: Não Foi Possível Atualizar os Pacotes. Verifique sua Internet"
     exit 1
  fi

  write_msg "Pacotes Atualizados com Sucesso!"
}

main() {
  write_msg "Inicializando Customização no Termux..."
  sleep 2
  remove_motd
  update_apt
  update_pkg
}

main
