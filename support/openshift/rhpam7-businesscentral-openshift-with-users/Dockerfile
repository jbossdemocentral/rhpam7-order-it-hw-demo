FROM registry.access.redhat.com/rhpam-7/rhpam70-businesscentral-openshift:1.2

ADD ./contrib/application-users.properties /opt/eap/standalone/configuration/application-users.properties
ADD ./contrib/application-roles.properties /opt/eap/standalone/configuration/application-roles.properties
USER root
RUN chown jboss:root /opt/eap/standalone/configuration/application-users.properties && \
			chown jboss:root /opt/eap/standalone/configuration/application-roles.properties && \
			chmod 664 /opt/eap/standalone/configuration/application-users.properties && \
			chmod 664 /opt/eap/standalone/configuration/application-roles.properties
USER jboss
