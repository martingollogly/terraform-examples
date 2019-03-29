## Terraform Examples

### Getting Started
This is a Terraform script for building a simple VPC network, 

For now we have just one instance running the web server. Nginx in it's default configuration, serving up the default welcome page. To run this use the following command...

```
terraform apply -var-file=dublin.tfvars
```

We want this to be extended, 

you're are tasked with 
* making the alterations detailed below, after completing each stage 
* a test to show the things are still working would be to run the following command and expect to see the Nginx welcome 
page HTML. 
 > Note: It may take some time for the server to be up and running after terraform completes

 Run this to see the resuls ....

```
terraform output nginx_domain | xargs curl
```

## Exercises

Complete exercises 1-3,  

1. We want to be able to run the same stack closer to our customers in the US. Please build the same stack in 
the us-east-1 (Virginia) region. 

> Note: that Virginia has serveral availability zones which we want to use 4 of them so 
that will need to be taken into consideration yet we still want to run a stack in Ireland using the 3 AZs there. We want to reuse as much code as possible, we don't want a separate network definition for each region. Feel free to 
modify the existing code as much as possible in order to do this, you'll also need to consider terraform state each stack
should have it's own state but don't feel you need to go as far as setting up remote state. As for a CIDR block for the 
VPC use whatever you feel like, providing it's compliant with RFC-1918 and does not overlap with the dublin network.

2. The EC2 instance running Nginx went down over the weekend and we had an outage, it's been decided that we need a solution 
that is more resilient than just a single instance. Please implement a solution that you'd be confident would continue 
to run in the event one instance goes down. 

> Note: I Would provision an ALB with multiple instances behind it

3. We are looking to improve the security of our network we've decided we need a bastion server to avoid logging on 
directly to our servers. Add a bastion server, the bastion should be the only route to SSH onto any server in the 
entire VPC.

> Note:I Would spin up a micro instance from an ec2 module created in step 2  or a lambda Lambda which would be locked to ssh from a VPN IP whitelist. The lambda has less overhead and does need to han around after deployment making it more desirable as a deployment option

4. a) The team have decided to use the Java framework Spring Boot to build features for our website. Deploy the following sample 
application into the VPC, reconfigure Nginx as a reverse proxy to the Java app. Provide a modification to the Terraform 
output/curl command to get the hello world text that the application serves. 
https://github.com/spring-projects/spring-boot/tree/master/spring-boot-samples/spring-boot-sample-tomcat
<br> b) Follow the instructions in a) but instead deploy the following application, with an alteration to use an Amazon 
RDS managed database rather than the default H2 in memory database. 
https://github.com/spring-projects/spring-boot/tree/master/spring-boot-samples/spring-boot-sample-data-jpa


