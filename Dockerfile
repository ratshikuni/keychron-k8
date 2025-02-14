FROM ghcr.io/qmk/qmk_cli:latest
RUN qmk setup -y
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 
ENTRYPOINT ["/entrypoint.sh"]
