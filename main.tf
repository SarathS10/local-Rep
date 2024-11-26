resource "aws_instance" "my_ec2"{
  ami = data.aws_ami.ami19.id
  instance_type = var.instance_type
  vpc_security_group_ids =[aws_security_group.SG.id]
  key_name = "terraform-key"
  user_data = file("nginx-install.sh")
  tags ={
    Name = "sarath"
  }
provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner at 'date' >> destroytime.txt" #date only come or both d/time
    working_dir = "local-files/"
  }
provisioner "local-exec" {
    command    = "echo The server's IP address is ${self.private_ip} 'date' >> createtime.txt"#we can use self also, right instead of aws_instance and date can see?
    working_dir = "local-files/"
    on_failure = continue
  }
   

}


