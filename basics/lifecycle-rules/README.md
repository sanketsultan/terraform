#lifecycle rules

    Terraform lifecycle rules allow you to customize how Terraform handles the creation, update, and deletion of resources. You can use lifecycle rules to prevent accidental deletion of critical resources, ensure that resources are created before others are destroyed, and ignore certain changes to resource attributes.
    
    In this example, we will demonstrate how to use lifecycle rules in a Terraform configuration for an AWS EC2 instance.   
    ```hcl
    resource "aws_instance" "example" {
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
        
        tags = {
            Name          = "terraform-learn-state-ec2"
            drift_example = "v1"
        }
        #adding lifecycle rule to prevent destroy of instance
        lifecycle {
            #prevent_destroy = true
            create_before_destroy = true
            ignore_changes = [ tags ] #ignore changes outside the terraform workflow
        }
    }
    ```
    In this configuration, we have defined a lifecycle block within the aws_instance resource. The lifecycle block contains the following rules:
    - prevent_destroy: This rule, when uncommented, prevents the resource from being destroyed. If you try to run terraform destroy, Terraform will raise an error instead of deleting the resource.
    - create_before_destroy: This rule ensures that when the resource is updated, a new resource
        is created before the old one is destroyed. This is useful for minimizing downtime during updates.
    - ignore_changes: This rule tells Terraform to ignore changes to the specified attributes (in this case, tags) that are made outside of Terraform. This is useful for resources that may be modified manually or by other tools.
    By using lifecycle rules, you can have more control over how Terraform manages your resources and protect critical infrastructure from accidental changes or deletions.
    To apply this configuration, run the following Terraform commands:
    ```bash
    terraform init
    terraform apply
    ```
    After applying the configuration, you can test the lifecycle rules by attempting to modify or delete the resource and observing Terraform's behavior.
    