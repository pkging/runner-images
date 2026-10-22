# Runner Image Operations

The publish workflow runs daily, on relevant pushes and on manual dispatch.
It selects the latest stable actions/runner release, builds and tests the image,
then publishes to ghcr.io/pkging/runner-images/actions-runner-pkging.
The workflow summary records the runner version, immutable image digest and date.

Publication failures create or update a GitHub issue. Subscribe to repository
issues and Actions failure notifications. The package must be readable by the
cluster, either publicly or through an appropriate imagePullSecret.

Runner Health runs every ten minutes. Its self-hosted sentinel verifies the
current runner version and Docker connectivity without using Pulp. An independent
GitHub-hosted watchdog checks previous runs for queue delays over five minutes,
failed sentinels and missing successes over 45 minutes, and creates an issue.
Detection occurs on subsequent scheduled runs; GitHub schedules can be delayed
or disabled. This does not replace external monitoring of GitHub Actions itself.
The runner group must permit this repository to use the pkging scale set.

Publishing does not automatically deploy the image. Review the verified digest,
update the ARC Helm values in the infrastructure repository and roll out only
when builds are idle. Remove the temporary official-binary init-container overlay
when switching to the verified complete image. Verify a Runner Health run after
deployment. Keep the previous digest as a rollback option only while GitHub
still accepts its embedded runner version.

Validate workflows with actionlint; the configuration explicitly allows the
custom pkging label. No workflow deletes or restarts runner resources.