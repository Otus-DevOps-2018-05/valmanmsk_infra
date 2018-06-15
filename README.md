# valmanmsk_infra
valmanmsk Infra repository
ДЗ-3:
bastion_IP = 35.187.169.128
someinternalhost_IP = 10.142.0.2
1. ssh -i ~/.ssh/appuser -At appuser@35.187.169.128 ssh 10.142.0.2
2. In .ssh/config add:
Host someinternalhost
        HostName 10.142.0.2
        Port 22
        User appuser
        ProxyCommand ssh -i ~/.ssh/appuser -At appuser@35.187.169.128 'nc %h %p'

OR:
Host someinternalhost
        HostName 10.142.0.2
        Port 22
        User appuser
        ProxyCommand ssh -o 'ForwardAgent yes' -i ~/.ssh/appuser appuser@35.187.169.128 'nc %h %p'

