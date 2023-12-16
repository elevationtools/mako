
This demonstrates a pattern for using Mako that provides the following benefits:

- A project will always use the same version of dependencies.
- Automates setup of developer workstations, reducing onboarding effort.
- Uses a unified approach for production building, CI/CD, and workstations.
- Allows downloading only the dependencies needed for building any given
	subcomponent of a project.  This is particularly beneficial when building
	Docker images to keep build times down and images smaller.

