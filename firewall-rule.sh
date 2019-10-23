sysctl -w net.ipv4.ip_forward=1
sysctl -p

firewall-cmd --list-all

firewall-cmd --permanent --add-service http 
firewall-cmd --permanent --add-service https 
firewall-cmd --permanent --add-service dns
firewall-cmd --permanent --add-service ssh 
firewall-cmd --permanent --add-protocol icmp

firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -o eth0 -j MASQUERADE 
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth0 -j ACCEPT
firewall-cmd --direct --add-rule ipv4 filter FORWARD 0 -i eth0 -o eth1 -m state --state ESTABLISHED,RELATED -j ACCEPT
firewall-cmd --permanent --direct --passthrough ipv4 -t nat -I POSTROUTING -o eth0 -j  MASQUERADE -s 0.0.0.0/0

firewall-cmd --list-all
firewall-cmd --direct --get-all-rules

firewall-cmd --complete-reload

