#!/usr/bin/with-buildenv bash

if [ ${PUID} -eq 0 ]; then
  exit 0
fi

groupadd -g ${PGID} ${GROUP_NAME}
useradd -md ${USER_HOME} -s /usr/bin/userbash -g ${GROUP_NAME} -u ${PUID} ${USER_NAME}
usermod -a -G sudo ${USER_NAME}

# When not copied skel, manually copy
if [ -d "${USER_HOME}" ] && [ "$(stat -c "%U" "${USER_HOME}")" != "${USER_NAME}" ]; then
  chown ${PUID}:${PGID} ${USER_HOME}

  tmp=/tmp/devcontainer
  mkdir -p ${tmp}/skel
  cp -r -T /etc/skel ${tmp}/skel
  chown -R ${PUID}:${PGID} ${tmp}/skel
  cp -r -T ${tmp}/skel ${USER_HOME}
  rm -rf ${tmp}
fi

# Set default password (= username)
echo "${USER_NAME}:${USER_NAME}" | chpasswd
