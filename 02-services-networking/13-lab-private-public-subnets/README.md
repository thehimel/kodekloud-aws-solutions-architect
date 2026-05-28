# Lab: Private and Public Subnets

## Architecture

![13-lab-private-public-subnets.jpg](../assets/13-lab-private-public-subnets.jpg)

## Implementation

![img.png](assets/img.png)
![img_1.png](assets/img_1.png)
![img_2.png](assets/img_2.png)
![img_3.png](assets/img_3.png)
![img_4.png](assets/img_4.png)
![img_5.png](assets/img_5.png)
![img_6.png](assets/img_6.png)
![img_7.png](assets/img_7.png)
![img_8.png](assets/img_8.png)
![img_9.png](assets/img_9.png)
![img_10.png](assets/img_10.png)

> Answer: NO. `ssh -i "ec2-user.pem" ec2-user@44.211.191.152`
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

> `ssh -i "ec2-user.pem" ec2-user@44.211.191.152`
![img_26.png](assets/img_26.png)

![img_27.png](assets/img_27.png)
![img_28.png](assets/img_28.png)
![img_29.png](assets/img_29.png)
![img_30.png](assets/img_30.png)
![img_31.png](assets/img_31.png)
![img_32.png](assets/img_32.png)
![img_33.png](assets/img_33.png)
![img_34.png](assets/img_34.png)
![img_35.png](assets/img_35.png)
![img_36.png](assets/img_36.png)
![img_37.png](assets/img_37.png)
![img_38.png](assets/img_38.png)
![img_39.png](assets/img_39.png)
![img_40.png](assets/img_40.png)
![img_41.png](assets/img_41.png)
![img_42.png](assets/img_42.png)
![img_43.png](assets/img_43.png)
![img_44.png](assets/img_44.png)
![img_45.png](assets/img_45.png)

```shell
# From your lab terminal, transfer your ec2-user.pem keypair to your public instance so you can SSH into the private instance from it:
scp -i ec2-user.pem ec2-user.pem ec2-user@44.211.191.152:~/

# SSH into your public subnet instance (kloudswift-ec2):
ssh -i "ec2-user.pem" ec2-user@44.211.191.152

# List the contents of the home directory:
ls

# On your public instance, ensure the correct permissions on the keypair:
chmod 400 ec2-user.pem

# SSH into your instance in the private subnet using its private IP:
ssh -i "ec2-user.pem" ec2-user@10.16.2.141

# Verify internet connectivity from the private instance by running:
ping -c 3 google.com
```

![img_46.png](assets/img_46.png)

```shell
~ on ☁️  (us-east-1) ➜  scp -i ec2-user.pem ec2-user.pem ec2-user@44.211.191.152:~/
ec2-user.pem                                                                 100% 1675    58.2KB/s   00:00    

~ on ☁️  (us-east-1) ➜  ssh -i "ec2-user.pem" ec2-user@44.211.191.152
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'
Last login: Sat May 30 05:14:57 2026 from 34.41.141.216
[ec2-user@ip-10-16-1-24 ~]$ ls
ec2-user.pem
[ec2-user@ip-10-16-1-24 ~]$ chmod 400 ec2-user.pem
[ec2-user@ip-10-16-1-24 ~]$ ssh -i "ec2-user.pem" ec2-user@10.16.2.141
The authenticity of host '10.16.2.141 (10.16.2.141)' can't be established.
ED25519 key fingerprint is SHA256:EQgucRhKYxN8kbfC5MuWmNP9Ze+Y1L5szMWN1c1kAcA.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.16.2.141' (ED25519) to the list of known hosts.
   ,     #_
   ~\_  ####_        Amazon Linux 2023
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   https://aws.amazon.com/linux/amazon-linux-2023
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'
[ec2-user@ip-10-16-2-141 ~]$ ping -c 3 google.com
PING google.com (142.250.31.139) 56(84) bytes of data.
64 bytes from bj-in-f139.1e100.net (142.250.31.139): icmp_seq=1 ttl=108 time=2.81 ms
64 bytes from bj-in-f139.1e100.net (142.250.31.139): icmp_seq=2 ttl=108 time=2.44 ms
64 bytes from bj-in-f139.1e100.net (142.250.31.139): icmp_seq=3 ttl=108 time=2.23 ms

--- google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 2.225/2.493/2.813/0.242 ms
[ec2-user@ip-10-16-2-141 ~]$ 
```
