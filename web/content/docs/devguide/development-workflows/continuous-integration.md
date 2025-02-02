+++
date = "2018-02-26T11:00:13+01:00"
title = "Continuous Integration"
author = "Lars Bilke"
weight = 1016

[menu]
  [menu.devguide]
    parent = "development-workflows"
+++

## Introduction

> [Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration) (short **CI**) is the practice of merging all developer working copies to a shared mainline several times a day.

So for every proposed change to the source code the following is done automatically:

- Compilation of the changed code merged with the official source code is tested on a variety of platforms (Windows, Linux, Mac OS, different compilers)
- A comprehensive [test suite]({{< ref "unit-testing.md" >}}) checks validity of the proposed changes
- Additional checks regarding code formatting and documentation help in maintaining a good software quality and structure

After the system is done with all these tasks the developer can view build reports highlighting occurred errors and problems. We are using [GitLab CI]({{< ref "gitlab-ci.md" >}}) as our CI system.

## CI on OGS

All of this automatically kicks in when you open a [Merge Request](../code-reviews) on GitLab. You will notice a pipeline block at the merge request page:
![GitLab CI screenshot](../GL_CI_screenshot.png)

Click on the pipeline link or the individual pipeline stage icons (circles) to find out the reason for a failed check. If you add more commits to this merge request all checks are run again.

See the [GitLab CI page]({{< ref "gitlab-ci.md" >}}) for more info.
