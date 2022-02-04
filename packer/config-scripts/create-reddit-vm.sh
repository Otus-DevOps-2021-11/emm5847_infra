#!/bin/bash
#
#Create VM from existing image
#

packer_json="immutable.json"
packer_variables="variables.json"

cd ..
packer build -var-file="$packer_variables" "$packer_json"

image_name="$(yc compute image get-latest-from-family reddit-full | grep name | awk '{print $2}')"

if [[ $? == 0 ]]
then
    echo "Image is successfully created"
    echo ""
    echo "Creating VM from packer image $image_name"
    echo ""

    yc compute instance create \
      --name reddit-app \
      --hostname reddit-app \
      --cores 2 \
      --memory 2 \
      --preemptible \
      --create-boot-disk image-name=$image_name \
      --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
      --metadata serial-port-enable=1 \
      --metadata name=appuser,groups=sudo,shell="/bin/bash",sudo='ALL=(ALL) NOPASSWD:ALL',ssh-authorized-keys='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhV/MmUsuw4akdI755wWsDDtsrsrgM/HQqyO6trU79FwiP80mVNH4dW1yF7epkc+dKUhSgzXuztOXIAaTbYjuoNT0WwIbQnp4hGML93gq5Kdur+RerClJrz5pZlOAQUlNX5257Lc8F0+EJduDIvTspY3R9eeBHh1Xr2apxhLl8I1xorV0U7OIakt/6oxFKHIIq37PShLK4FUSQ9sTIsBNxQEL5WJVSb5eQScHCgriqKkYrfjDt7EIGo9N8wdk+CCBSe29A77mdyFk/iF0emHzKcM02dmKkMMwFWztnQXW5BDFRLPHYnu2BFa5Wz2SffwJA5WU2WznHUNCIheD4lhvH home@abc'
fi
