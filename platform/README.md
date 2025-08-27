# Release notes

### 22 August 2025

***

We’ve rolled out some big updates across logging, storage, monitoring, and scaling.&#x20;

Here’s what’s new:

**Logging Overhaul: Logging just got a whole lot smoother**

* Brand new logging UI with a cleaner experience.
* Filter logs by replica/instance for horizontally scaled workloads.
* Blazing fast querying & searching.
* Real-time logs via websockets (no more delayed polling).
* Date/time filters with improved performance for historical digging.
* Download logs in JSON, text, or CSV.
* Full-screen mode for easier reading.
* Beta: Log retention by time and size.

_For Internal Developer Platform (IDP) customers:_

* Improved backend performance & stability → lowers infra costs while boosting performance.
* Updated dependencies and security patches across the logging stack.

#### Storage Management (IDP only)

* Smarter handling of storage and database workloads.
* Automatic self-healing for horizontally scaled workloads during restarts.
* Helps right-size infrastructure for lower costs and better performance.

#### State Management Foundation

* Laying the groundwork for websocket-based capsule state management.
* Coming soon: real-time capsule status updates (starting, running, scaling, shutting down, OOM, etc).

#### Monitoring (IDP only)

* Enhanced monitoring stack with advanced alerting and integrations.
* Custom dashboards & reporting across infra, platform, and applications.
* Support for custom metrics scraping/importing.

#### &#x20;Database Backup Improvements

* Flexible backup schedules: daily, weekly, or monthly.
* Supported across Storage, MySQL, Postgres, and Mongo.

#### Workload Scaling (IDP only)

*   Scale CPU and RAM independently to fine-tune workload requirements.

    (e.g. high CPU + low RAM or the other way around).

That’s it for now, with these updates, you’ll see faster insights, better reliability, and more flexibility across your workloads.
