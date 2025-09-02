# 使用OpenJDK 8作为基础镜像（Nacos 2.4.1推荐）
FROM openjdk:8-slim  

# 配置环境变量
ENV NACOS_VERSION=2.4.1
ENV NACOS_HOME=/home/nacos
ENV MODE=standalone
ENV PREFER_HOST_MODE=hostname

# 安装必要工具
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget \
      curl \
      vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 下载并解压Nacos
RUN wget -q https://github.com/alibaba/nacos/releases/download/${NACOS_VERSION}/nacos-server-${NACOS_VERSION}.tar.gz -O /tmp/nacos.tar.gz && \
    mkdir -p ${NACOS_HOME} && \
    tar -zxf /tmp/nacos.tar.gz -C ${NACOS_HOME} --strip-components=1 && \
    rm -f /tmp/nacos.tar.gz

# 暴露端口
EXPOSE 8848 9848 9849

# 启动脚本
CMD ["sh", "-c", "${NACOS_HOME}/bin/startup.sh -m ${MODE} && tail -f ${NACOS_HOME}/logs/start.out"]
    
