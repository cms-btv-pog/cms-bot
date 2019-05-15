THISDIR=$(dirname $BASH_SOURCE)
SELECTED_VERSION=${1-current}
if [ ! -e ${THISDIR}/${SELECTED_VERSION}/bin/rucio ] ; then
  echo "Error: Unable to find rucio version '${SELECTED_VERSION}'" >&2
  return
fi
PYTHON_DIR=$(grep '#!/' ${THISDIR}/${SELECTED_VERSION}/bin/rucio | sed 's|^#!||;s|/bin/python[^/]*$||')
if [ ! -e ${PYTHON_DIR}/etc/profile.d/init.sh ] ; then
  echo "Error: Unable to find python '${PYTHON_DIR}'" >&2
  return
fi
PY_PATH=$(ls -d ${THISDIR}/${SELECTED_VERSION}/lib/python*/site-packages)
source ${PYTHON_DIR}/etc/profile.d/init.sh
export PATH=${THISDIR}/${SELECTED_VERSION}/bin${PATH:+:$PATH}
export PYTHONPATH=${PY_PATH}${PYTHONPATH:+:$PYTHONPATH}
export RUCIO_HOME=${THISDIR}/${SELECTED_VERSION}
rucio --version
