# 11 NAT Gateways (VPC) Demo

## Idea

![diagram.png](assets/diagram.png)

## Architecture

![11-nat-gateways-vpc-demo.jpg](../assets/11-nat-gateways-vpc-demo.jpg)

## Implementation

![img.png](assets/img.png)
![img_1.png](assets/img_1.png)
![img_2.png](assets/img_2.png)
![img_3.png](assets/img_3.png)
![img_4.png](assets/img_4.png)
![img_5.png](assets/img_5.png)
![img_6.png](assets/img_6.png)
![img_7.png](assets/img_7.png)
![img_9.png](assets/img_9.png)
![img_10.png](assets/img_10.png)

**This Configuration:**
- Name: `my-nat-gateway`
- Mode: **Zonal**
- Subnet: `subnet-009e8b50dbbcef834` (public-subnet)
- Connectivity: **Public**
- Elastic IP: `eipalloc-07da1fde224e0961e`

**Regional Availability Mode for NAT Gateways**

AWS has introduced a **Regional** availability mode for NAT gateways, alongside the existing **Zonal** mode.

**Modes**
- 🌐 Regional *(New)*: Automatically scales across all AZs in the region. Simplifies setup for multi-AZ architectures - no need to deploy one gateway per AZ.
- 🏢 Zonal: Scoped to a single AZ and subnet. Offers granular control and keeps traffic within the zone. Best when AZ-level isolation is required.

**When to use Regional:** New VPCs or workloads where operational simplicity matters more than per-AZ traffic control. Reduces the number of Elastic IPs and route table entries to manage.

**When to prefer Zonal:** Use when you need traffic to stay within a specific AZ — for cost control, compliance, or fault isolation. Useful when cross-AZ data transfer charges are a concern.

![img_11.png](assets/img_11.png)
![img_12.png](assets/img_12.png)
![img_13.png](assets/img_13.png)
![img_14.png](assets/img_14.png)
