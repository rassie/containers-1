#!/usr/bin/env bash

set -e

if [ -n "$USE_SYSTEM_CA_CERTS" ]; then

    # RHEL-based images already include a routine to update a java truststore from the system CA bundle within
    # `update-ca-trust`. All we need to do is to link the system CA bundle to the java truststore.

    cp -a /certificates/* /usr/share/pki/ca-trust-source/anchors/
    update-ca-trust

    CACERT=$JAVA_HOME/lib/security/cacerts

    # JDK8 puts its JRE in a subdirectory
    if [ -f "$JAVA_HOME/jre/lib/security/cacerts" ]; then
        CACERT=$JAVA_HOME/jre/lib/security/cacerts
    fi

    ln -sf /etc/pki/ca-trust/extracted/java/cacerts "$CACERT"
fi

exec "$@"
