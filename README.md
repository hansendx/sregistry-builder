# sregistry-builder
To build singularity images and push them into an sregistry.

Singularity 2.5.1 is installed.

sregistry is installed from its github repository.
After cloning the commit [cb595c0b3371514c648b1844a914f861fb842d4f](https://github.com/singularityhub/sregistry-cli/commit/cb595c0b3371514c648b1844a914f861fb842d4f) is checked out since an installation from pip (pip install sregistry) or the repository at HEAD installed a version that produced errors on using push.

## Setting credentials

The file `/sregistry_file` contains a template `.sregistry` file, that can be sourced after setting the  variables 
`$SREGISTRY_TOKEN`, `$SREGISTRY_USERNAME` and `$SREGISTRY_HOSTNAME`. The sourced variable `$SREGISTRY_FILE` can than be feed into `~/.sregistry` using `echo`. 

``` bash
export SREGISTRY_TOKEN=alonghash123
export SREGISTRY_USERNAME=pushinguser
export SREGISTRY_HOSTNAME=mysregistry.com
source /sregistry_file
echo $SREGISTRY_FILE > ~/.sregistry
sregistry push ...
```