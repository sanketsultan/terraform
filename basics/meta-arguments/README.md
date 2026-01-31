#meta-arguments 
Meta-arguments are special arguments that can be used with any resource or module block in Terraform. They provide additional functionality and control over the behavior of resources and modules. Some common meta-arguments include:

- count: 
    The count meta-argument allows you to create multiple instances of a resource or module based on a specified number. It is useful for creating resources in a loop.
    
    Example:
    ```hcl
    resource "aws_instance" "example" {
        count         = 3
        ami           = "ami-0c55b159cbfafe1f0"
        instance_type = "t2.micro"
    }
    ```

    - for_each:
        The for_each meta-argument allows you to create multiple instances of a resource or module based on a map or set of values. It provides more flexibility than count by allowing you to reference specific instances by key.
        
        Example:
        ```hcl
        resource "aws_instance" "example" {
            for_each      = toset(["web", "app", "db"])
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"
            tags = {
                Name = each.value
            }
        }
        ```

    - depends_on:
        The depends_on meta-argument allows you to explicitly specify dependencies between resources, ensuring correct creation and destruction order.
        
        Example:
        '''hcl
        resource "aws_instance" "example" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"
            depends_on    = [aws_security_group.sg_web]
        }
        ```

    - provider:
        The provider meta-argument allows you to specify which provider configuration to use for a specific resource.
        Example:
        ```hcl
        resource "aws_instance" "example" {
            ami           = "ami-0c55b159cbfafe1f0"
            instance_type = "t2.micro"
            provider      = aws.us_east_1
        }
        ```

    - lifecycle:
        The lifecycle meta-argument allows you to customize resource behavior during creation, update, and destruction phases.
        Example:
        ```hcl
        resource "aws_db_instance" "prod" {
            allocated_storage = 100
            engine            = "postgres"
            instance_class    = "db.t3.micro"

            lifecycle {
                prevent_destroy       = true
                create_before_destroy = true
                ignore_changes        = [allocated_storage]
            }
        }
        ```