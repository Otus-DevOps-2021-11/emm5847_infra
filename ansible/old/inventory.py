#!/usr/bin/python2

import json
import subprocess
import subprocess as sub
import argparse


yc_instances = sub.Popen(["/home/home/yandex-cloud/bin/yc", "compute", "instance", "list", "--format", "json"],
                         stdin=sub.PIPE, stdout=sub.PIPE, stderr=sub.PIPE)

if True:
    if yc_instances:
        yc_instances = yc_instances.communicate()[0]
        instances = json.loads(yc_instances.decode("utf8"))
        for instance in instances:
            if "reddit-app" in instance["name"]:
                ip_appserver = instance["network_interfaces"][0]["primary_v4_address"]["one_to_one_nat"]["address"]
            if "reddit-db" in instance["name"]:
                ip_dbserver = instance["network_interfaces"][0]["primary_v4_address"]["one_to_one_nat"]["address"]

        output = [
            {
                "_meta": {
                    "hostvars": {
                        "appserver": {
                            "ansible_host": ip_appserver
                        },
                        "dbserver": {
                            "ansible_host": ip_dbserver
                        }
                    }
                },
                "app": {
                    "hosts": ["appserver"],
                },
                "db": {
                    "hosts": [ "dbserver"],
                }
            }
        ]
        json_output = json.dumps(output, indent=2, sort_keys=True)[1: -1]
        print(json_output)
    else:
        print(yc_instances)
