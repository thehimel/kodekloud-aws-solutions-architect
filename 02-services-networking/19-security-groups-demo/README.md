# Security Groups - Demo

## Inbound and Outbound Rules

![img.png](assets/img.png)
![img_1.png](assets/img_1.png)
![img_2.png](assets/img_2.png)

> sudo yum install nginx
![img_3.png](assets/img_3.png)

> sudo systemctl start nginx
![img_4.png](assets/img_4.png)

> curl localhost
![img_5.png](assets/img_5.png)

![img_6.png](assets/img_6.png)
![img_7.png](assets/img_7.png)
![img_8.png](assets/img_8.png)
![img_9.png](assets/img_9.png)
![img_10.png](assets/img_10.png)

> `ping google.com` from the instance fails because we removed the outbound rule in the security group.
![img_11.png](assets/img_11.png)

![img_12.png](assets/img_12.png)
![img_13.png](assets/img_13.png)

> Now we can ping google.com from the instance as we have added back the outbound rule in the security group.
![img_14.png](assets/img_14.png)

## Allow Traffic from Resources of Another Security Group

> Existing Security Group
![img_15.png](assets/img_15.png)

> Create a New Instance (For DB)
![img_16.png](assets/img_16.png)

> Allow traffic from all the resources of the security group `launch-wizard-1` to the resources of the security group `launch-wizard-2`.
![img_17.png](assets/img_17.png)
![img_18.png](assets/img_18.png)

![security_group_traffic_rules.png](assets/security_group_traffic_rules.png)
The diagram shows two security groups side by side. Both EC2 instances in `launch-wizard-1` (web server and app server) have outbound traffic permitted into the `launch-wizard-2` group, where the database server lives. The inbound rule on `launch-wizard-2` references `launch-wizard-1` as its source — meaning any resource assigned to that group is automatically allowed, without specifying individual IP addresses.
