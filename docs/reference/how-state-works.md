# How State Works
A Capsule has the capability to write to a local file system, but those files will not persist after the Capsule is restarted. 

A Capsule can be thought of as a computational process which can be started and restarted. When a Capsule is started it receives a fresh copy of the code from a GitHub repository. A Capsule is able to be written to locally in a local file system, but that file system will also start afresh when the code restarts and pulls from the GitHub repository again. Thus, any files written to that file system will not persist when the Capsule is restarted automatically.

Instead, to have the data persist, the use of an external database is recommended. 
Code Capsules has an article on setting up file persistence with a Data Capsule [here.](https://codecapsules.io/docs/reference/set-up-file-data-capsule/)
