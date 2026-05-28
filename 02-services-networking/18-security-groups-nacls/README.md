# Security Groups and NACLs

![img.png](assets/img.png)
![img_1.png](assets/img_1.png)
![img_2.png](assets/img_2.png)
![img_3.png](assets/img_3.png)

> For Stateless Firewalls, you need to allow both inbound and outbound rules for the ephemeral ports (i.e. `1024-65535`) because it does not keep track of the state of connections. If you allow an inbound rule for a specific port, you also need to allow the corresponding outbound rule for the ephemeral ports to ensure that responses can be sent back to the client.
![img_4.png](assets/img_4.png)

![img_5.png](assets/img_5.png)
![img_6.png](assets/img_6.png)

> For Stateful Firewalls, allowing ephemeral ports (i.e. `1024-65535`) is not required as it keeps track of the source and destination IPs. If a request is allowed, the response is allowed.
![img_7.png](assets/img_7.png)

![img_8.png](assets/img_8.png)
![img_9.png](assets/img_9.png)
![img_10.png](assets/img_10.png)
![img_11.png](assets/img_11.png)
![img_12.png](assets/img_12.png)
![img_13.png](assets/img_13.png)
![img_14.png](assets/img_14.png)
![img_15.png](assets/img_15.png)
![img_16.png](assets/img_16.png)
![img_17.png](assets/img_17.png)
![img_18.png](assets/img_18.png)
![img_19.png](assets/img_19.png)
![img_20.png](assets/img_20.png)
![img_21.png](assets/img_21.png)
![img_22.png](assets/img_22.png)
![img_23.png](assets/img_23.png)
![img_24.png](assets/img_24.png)
![img_25.png](assets/img_25.png)

> The diagram shows the key rule: a Network ACL can point to multiple subnets (Subnet A, B, C), but each subnet can only be assigned to one ACL at a time. It's a one-to-many relationship from the ACL's side, and a one-to-one constraint from each subnet's side.
![network_acl_subnet_diagram_v2.svg](assets/network_acl_subnet_diagram_v2.svg)

![network_acl_no_filter_diagram.svg](assets/network_acl_no_filter_diagram.svg)
![network_acl_bypass_v4.svg](assets/network_acl_bypass_v4.svg)

![img_27.png](assets/img_27.png)
![img_28.png](assets/img_28.png)
![img_29.png](assets/img_29.png)
