# SQL Server on AKS - Proof of Concept

---

## Andrew Pruski

### SQL Server DBA, Microsoft Data Platform MVP, & Certified Kubernetes Administrator
<!-- .slide: style="text-align: left;"> -->
<i class="fab fa-twitter"></i><a href="https://twitter.com/dbafromthecold">  @dbafromthecold</a><br>
<i class="fas fa-envelope"></i>  dbafromthecold@gmail.com<br>
<i class="fab fa-wordpress"></i>  www.dbafromthecold.com<br>
<i class="fab fa-github"></i><a href="https://github.com/dbafromthecold">  github.com/dbafromthecold.com</a>

---

<p align="center">
<img src="images/eightkb.png" />
</p>

---

## Session Aim
<!-- .slide: style="text-align: left;"> -->
To go through how we approached testing running SQL Server in Azure Kubernetes Services

---

## Running the Kubernetes cluster
<!-- .slide: style="text-align: left;"> -->
- On-premises vs Cloud<br>
- Node size and configuration<br>
- On-going maintenance?<br>
- Skillset

---

## Deploying SQL Server
<!-- .slide: style="text-align: left;"> -->
- Private registry vs MCR<br>
- Deployments vs Statefulsets<br>
- Helm Charts

---

## Other considerations
<!-- .slide: style="text-align: left;"> -->
- AKS configuration - Node Pools & Availability Zones
- Disaster Recovery<br>
- Performance<br>
- Security

---

## High availability
<!-- .slide: style="text-align: left;"> -->
- Using the built-in Kubernetes features<br>
- SQL Server high availability features unavailable<br>
- Pod recovery<br>
- Node recovery

---

# Demos

---

## Resources
<!-- .slide: style="text-align: left;"> -->
<font size="6">
<a href="https://github.com/dbafromthecold/sqlserverakspoc">https://github.com/dbafromthecold/sqlserverakspoc</a><br>
<a href="http://tinyurl.com/y3x29t3j/summary-of-my-container-series">http://shortlink/summary-of-my-container-series</a><br>
<a href="https://portworx.com/">https://portworx.com</a></br>
<a href="https://docs.microsoft.com/en-us/azure/azure-arc/data/managed-instance-overview">https://shortlink/managed-instance-overview</a>
</font>

<p align="center">
<img src="images/sqlserverakspoc_qrcode.png" />
</p>