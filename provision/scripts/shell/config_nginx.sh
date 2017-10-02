
#!/bin/bash
# Bootstrapper to configure nginx

sudo service nginx start

sudo cp /srv_configs/nginx.conf /etc/nginx/sites-available/site.conf
sudo chmod 644 /etc/nginx/sites-available/site.conf

sudo ln -s /etc/nginx/sites-available/site.conf /etc/nginx/sites-enabled/site.conf
sudo service nginx restart

# clean /var/www
sudo rm -Rf /var/www

# symlink /var/www => /vagrant
sudo ln -s /app /var/www
