#!/usr/bin/env sh

set -e

if [ -n "$USE_SYSTEM_CA_CERTS" ]; then
    # OpenJDK images used to create a hook for `update-ca-certificates`. Since we are using an entrypoint anyway, we
    # might as well just generate the truststore and skip the hooks.

    cp -a /certificates/* /usr/local/share/ca-certificates/
    update-ca-certificates

    CACERT=$JAVA_HOME/lib/security/cacerts

    # JDK8 puts its JRE in a subdirectory
    if [ -f "$JAVA_HOME/jre/lib/security/cacerts" ]; then
        CACERT=$JAVA_HOME/jre/lib/security/cacerts
    fi

    trust extract --overwrite --format=java-cacerts --filter=ca-anchors --purpose=server-auth "$CACERT"
fi

exec "$@"
