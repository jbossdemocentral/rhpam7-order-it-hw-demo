# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Red Hat

#Arguments
ARG PAM_VERSION
ARG PAM_BUSINESS_CENTRAL
ARG PAM_KIE_SERVER
ARG EAP
ARG PROJECT_GIT_REPO
ARG NIOGIT_PROJECT_GIT_REPO
#ARG EAP_PATCH

# Environment Variables
ENV HOME /opt/jboss
ENV JBOSS_HOME $HOME/jboss-eap-7.1

# ADD Installation Files
COPY installs/$PAM_BUSINESS_CENTRAL installs/$PAM_KIE_SERVER installs/$EAP /opt/jboss/

# Update Permissions on Installers
USER root
RUN chown jboss:jboss /opt/jboss/$EAP /opt/jboss/$PAM_BUSINESS_CENTRAL /opt/jboss/$PAM_KIE_SERVER
USER jboss

# Prepare and run installer and cleanup installation components
RUN unzip -qo /opt/jboss/$EAP -d $HOME && \
    unzip -qo /opt/jboss/$PAM_BUSINESS_CENTRAL -d $HOME && \
		unzip -qo /opt/jboss/$PAM_KIE_SERVER -d $JBOSS_HOME/standalone/deployments && touch $JBOSS_HOME/standalone/deployments/kie-server.war.dodeploy && \
    rm -rf /opt/jboss/$PAM_BUSINESS_CENTRAL /opt/jboss/$PAM_KIE_SERVER /opt/jboss/$EAP $JBOSS_HOME/standalone/configuration/standalone_xml_history/

# Add support files
RUN $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u pamAdmin -p redhatpam1! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent  && \
  $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u adminUser -p test1234! -ro analyst,admin,manager,user,kie-server,kiemgmt,rest-all --silent  && \
  $JBOSS_HOME/bin/add-user.sh -a -r ApplicationRealm -u kieserver -p kieserver1! -ro kie-server --silent

COPY support/standalone-full.xml $JBOSS_HOME/standalone/configuration/
COPY support/userinfo.properties $JBOSS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/

# Copy demo and support files
COPY support/rhpam7-demo-niogit $JBOSS_HOME/bin/.niogit
# Clone the Demo repository.
USER root
RUN rm -rf $JBOSS_HOME/bin/.niogit/$NIOGIT_PROJECT_GIT_REPO && git clone --bare $PROJECT_GIT_REPO $JBOSS_HOME/bin/.niogit/$NIOGIT_PROJECT_GIT_REPO && chown -R jboss:jboss $JBOSS_HOME/bin/.niogit
USER 1000

# Switch back to root user to perform cleanup
USER root

# Fix permissions on support files
RUN chown -R jboss:jboss $JBOSS_HOME/standalone/configuration/standalone-full.xml $JBOSS_HOME/standalone/deployments/business-central.war/WEB-INF/classes/userinfo.properties

# Run as JBoss
USER jboss

# Expose Ports
EXPOSE 9990 9999 8080

# Run BRMS
ENTRYPOINT ["/opt/jboss/jboss-eap-7.1/bin/standalone.sh"]
CMD ["-c","standalone-full.xml","-b", "0.0.0.0","-bmanagement","0.0.0.0"]
