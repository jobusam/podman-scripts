# See https://jupyterhub.readthedocs.io/en/stable/reference/config-user-env.html

# requires notebook >= 5.4

# shutdown the server after no activity for 10 minutes
c.NotebookApp.shutdown_no_activity_timeout = 10 * 60
# shutdown kernels after no activity for 4 minutes
c.MappingKernelManager.cull_idle_timeout = 4 * 60
# check for idle kernels every two minutes
c.MappingKernelManager.cull_interval = 2 * 60