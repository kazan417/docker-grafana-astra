FROM registry.astralinux.ru/astra/ubi18

ARG GF_UID="472"
ARG GF_GID="0"

ENV PATH="/usr/share/grafana/bin:$PATH" \
    GF_PATHS_CONFIG="/etc/grafana/grafana.ini" \
    GF_PATHS_DATA="/var/lib/grafana" \
    GF_PATHS_HOME="/usr/share/grafana" \
    GF_PATHS_LOGS="/var/log/grafana" \
#    GF_PATHS_PLUGINS="/var/lib/grafana/plugins" \
    GF_PATHS_PROVISIONING="/etc/grafana/provisioning"
RUN adduser --system --uid $GF_UID --ingroup "$GF_GID_NAME" grafana;
WORKDIR $GF_PATHS_HOME
RUN apt update;apt install -y grafana;rm -rf /var/lib/apt/lists/*;
RUN    chown -R "grafana:$GF_GID_NAME" "$GF_PATHS_DATA"  "$GF_PATHS_LOGS"  "$GF_PATHS_PROVISIONING" "$GF_PATHS_CONFIG" && \
    chmod -R 777 "$GF_PATHS_DATA"  "$GF_PATHS_LOGS"  "$GF_PATHS_PROVISIONING" "$GF_PATHS_CONFIG"

EXPOSE 3000

ARG RUN_SH=./run.sh

COPY ${RUN_SH} /run.sh

USER "$GF_UID"
ENTRYPOINT [ "/run.sh" ]

