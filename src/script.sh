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

main() {
  write_msg "Inicializando Customização no Termux..."
  sleep 2
  remove_motd
}

main


