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

choose_mirror() {
  sleep 2
  write_msg "-------------"
  write_msg "Você irá escolher o mirror que mais te serve.."
  write_msg "-------------"
  sleep 2
  for i in {1..5}; do
    write_msg $i
    sleep 2
  done

  termux-change-repo

  if [[ $? -ne 0 ]]; then
     write_msg "Erro: Não Foi Possivel Realizar a Troca do Mirror. Tente Novamente!"
     exit 1
  fi
  write_msg "Mirror Selecionado com Sucesso!"
}

update_packages() {
  update_apt
  update_pkg
}

check_valid_email() {
  email=$1

  if [ -z "$email" ];
  then
    return 1
  elif [[ "$email" =~ ^[[:alnum:]._%+-]+@[[:alnum:].-]+\.[a-zA-Z]{2,}$ ]]
  then
    return 0
  else
    return 1
  fi
}

config_git() {
  write_msg "Iremos dar Inicio a configuracao do git..."
  sleep 1.5
  write_msg "Digite seu email de preferência..."

  while true;
  do
    read -p "Email:" user_email
    if check_valid_email "$user_email";
    then
      git config --global user.email "$user_email"
      write_msg "Git Email configurado com Sucesso!"
      break
    else
      write_msg "Email Invalido, Tente Novamente."
    fi
  done

  while true;
  do
    read -p "Username:" username
    if [ -z "$username" ];
    then
      write_msg "User Invalido, Tente Novamente."
    else
      git config --global user.name "$username"
      write_msg "Git User configurado com Sucesso!"
      break
    fi
  done
}

install_tools() {
  write_msg "Instalando Ferramentas Basicas (Python3, Gcc, wget, neovim "

  if ! pkg i clang python3 neovim wget;
  then
    write_msg "Não foi possivel instalar as ferramentas. Tente novamente..."
    exit 1
  else
    write_msg "Instalacão Concluída com Sucesso!"
  fi
}

main() {
  write_msg "Inicializando Customização no Termux..."
  sleep 2
  remove_motd
  update_packages
  install_tools
  choose_mirror
  config_git
  write_msg "Customização Concluída com Sucesso!"
}

main
