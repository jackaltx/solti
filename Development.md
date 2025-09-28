# SOLTI Development log

## Overview

The README is a good overview of what I am doing, this is more of a "History" of how I amn
using an AI to help me create a framework for harnessing my local and remote development clusters

This document will grow over time.  Later work added.  I don't know what will work best.

## Claude as my pair programmer

I started with Claude v 3.5 with a $200/yr pro plan.  It was a chat format and my initial observations was that Claude writes a lot of code quickly
and was very helpful.  It pointed out my limit. My communication skills needed improving. Claude is tool, if you know what you want you can likley get it.  

Learning is a journey.  Often that journey will be rocky and hard.  I went down concepts that I normally do not considered viable.  Sometimes that is a good thing. There were many blind alleys and what you learn is that debugging with Claude in that "chat" form can go far afield. However, when I keep to my north star and focus on the goal the product looks good.

Claude wrote the first draft of this, and helped come up with tool ideas. Claude's writing is better than mine. The ability to review all the code and come up with a good readme has been fantastic.

### Why Claude?

Serendipity really. A smart young fellow showed me ChatGPT and it was cool.  A year later he showed me how he was using Claude.  After a couple of hours of exploration I signed up with a plan to do a years worth of coding ideas.  

That bright young fellow has moved onward. One of his reasons was how claude is sandboxed. It can't access the code directly.  I see changed in that staring.   I like the MCP concept, but I have not gotten it to work outside of my Mac. I am sure it will all come togther when time is right.

### Working in a chat environment

Claude only see's the "artifacts" that I have uploaded to it.  Version 3.5 could not it of the code it generates.  But the code generated
sure looks pretty.  Yet, the debugging sessions were(/are still) infuriating.  Often that is because I am using the AI to teach me the
programming language and sometimes it is some service/application that I am using. Debugging is often a two steps forward and many steps back.

There are times the AI looks at the artifacts (aka uploads) and other times not at all. There are moments of brilliance punctuated by moments of "you are wrong and this is why". The amount of energy it has to put forth is variable, and the results show it.

My main caution is "don't let it take you too far from your vision". You will need to pull in the reigns from time to time and focus on the "why". I have notices two distinct patterns emerge when debuging with the AI: the oak and willow.  

The oak path is on where it has decided the path to solving the problem is just a tweak away.
Claude had no concept that the changes were gong to create a maintenance issue.  After all this is the job, deliver it and move on.
It is logical and given the speed it can deliver a possible solution when things change, that may be good enough.

The willow path bends to a strong will. More than once we have gone in circles where core issue was deeper in the . An example of that kind of issue is the Proxmox-ve LXC interface via command line interface, pct exec, does not create a shell which does not allow you to pipe over files.  This breaks ansible interface module for configuration. I got to learn several techniques for building and delivering commands to be executed, but none them can ever work due to how the cli interface parses and executes.

Finding balance requires me to learn how to work with this tool. The results are impressive and I am generally pleased with results.

### How I worked in this chat environment

The  biggest lesson was how to organize my work. I move towards feature testing (i.e., logging, metrics) focus
over three primary linux distros (i.e., rocky93, Debian12, Ubuntu24) with three computes (i.e., promox-ve, podman, github).
Thos allows some orthogonality in this 3D matrix of capability.  This allowd me to test molecule concept (TODO add links) for both unit and system testing.

I wanted to learn how gitub's CI environent works. I needed a way to communicate back to Clauce the results.  To create that feedback loop; each test run on github it create a short version for GIST output and Wiki Detailed report for all tagged versions and last three for the main branch. On github it will continue to put the files in verify_output/ in the saved output.

The concept worked, but the limits on github were low for my application.  So I have elected to move from GIST to mattermost. It is cool to use github's computer to run tests, but is SLOW to develop with and they are limited.  So I will do my regression testing locally.  Mattermost for notications and Elasticsearch for results is my current direction.

To support that I decided to create solti-containers. This is a patter for creates localhost services that have configured with some rigor and security in mind.  So, I took the ansible work and had the AI use that patter to create a few services.  These will be refined in attempt to create a reusable framework for adding the "next" one.  Which will be minio to support S3 buckets.

### Model Context Protocol (MCP) now available

MCP allows claude access to local data. That is an oversimplification, but for my purposes it does. My development
environment spans many different security boundaries. What mastering that brings us is a way to close the loop which
allows AI to "converge" on a solution.  Exciting stuff in some ways.

The first reference example will be  working on Grafana Alloy Configurtion to explore different "label" processing techniques.
Alloy feeds logs into Loki, which provides a search engine to pull those logs. My Web/Email server is noisy. So reducing
the transfer volume seems prudent. The goal is to get "actionable" logs that I can use to protect the server.  One cheap
way is leverage fail2ban.  Use the logs to craft "fail2ban" rules. If I were running something bigger, Wazuh might be the direction I would go to provice a more efficient system.
