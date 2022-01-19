FROM amazonlinux:2 as installer
RUN yum update -y \
  && yum install -y unzip \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \ 
  && unzip awscliv2.zip \
  && ./aws/install --bin-dir /aws-cli-bin/

FROM amazonlinux:2
RUN yum update -y \
  && yum install -y less groff git \
  && yum clean all \
  && rm -rf /var/cache/yum 
COPY --from=installer /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=installer /aws-cli-bin/ /usr/local/bin/
WORKDIR /aws
