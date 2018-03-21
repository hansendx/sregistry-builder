# sregistry-builder
To build singularity images and push them into an sregistry.

Singularity 2.4.3 is installed since it is the latest version that enables building singularity images inside a docker container.
Using later versions causes file permission issues.
Version 2.4.3 uses docker-extract code that keeps files away from the actual file system.
The reintroduction of docker-extract functionality is planned for a 2.5 release.
[Here is an issue about this on github.](https://github.com/singularityware/singularity/issues/1291)