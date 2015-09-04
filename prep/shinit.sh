if [ -e $JRE/lib/net.properties ]; then
  dockerRoute=$(route | grep '*')
  dockerNet=${dockerRoute/\.0.*/.*}
  sed -i $JRE/lib/net.properties -e "s/nonProxyHosts=/nonProxyHosts=${dockerNet}|/"
fi
