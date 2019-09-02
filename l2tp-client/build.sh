docker run --rm --privileged \
	-v ~/.docker:/root/.docker \
	-v /var/run/docker.sock:/var/run/docker.sock \
	homeassistant/amd64-builder --all -t l2tp-client \
	-r https://github.com/baurzhan/hassio-addons-example.git -b master
#docker run --rm --privileged -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock -v ~/Work/CH/hassio-addons-example/l2tp-client:/data homeassistant/amd64-builder --all -t /data
