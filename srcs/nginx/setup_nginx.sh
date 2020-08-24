# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup_nginx.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jereligi <jereligi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/24 17:28:36 by jereligi          #+#    #+#              #
#    Updated: 2020/08/24 17:28:37 by jereligi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Nginx start
openrc
touch /run/openrc/softlevel
service nginx start

tail -f /dev/null # Freeze command to avoid end of container