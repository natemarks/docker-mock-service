
FROM amazonlinux:2.0.20191217.0
ADD entrypoint.sh .
ADD mock-service .
ADD preflight.yaml .
ADD preflight .
RUN chmod 755 entrypoint.sh preflight mock-service
ENTRYPOINT ["/entrypoint.sh"]
