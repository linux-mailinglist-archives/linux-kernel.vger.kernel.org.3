Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C7F465E43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355791AbhLBGbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355811AbhLBGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:31:32 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED70C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 22:28:10 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id p19so26527416qtw.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 22:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tEGocQ62hfwK6Gu+tfXjRHtRf5LF3zuLTHi8XMt04nI=;
        b=egTpWtfp0SlDeNQfYXNIF/sz/hm9yIgvOq3ak4DqC9hQjt2e0KVpzWOumLM64pgFkb
         ynToEFexId5xQ+YbHls1LlszRALQxnpntAM2Chs1J9PGx8mtJtWtQpIx+qI933VdtjFu
         c3AUkr75E+ZunYLd4DJhfI87LiIMBwO33L/BiWjaN0IYdRJfMjpD+LRfu5R6qCounkBr
         waUsZ14ac6RFO0dChtHu4r64IVglwygEJDv96gH+YK11OUpqVEi8dpKnJEKZrlDZkxMm
         YKfkasjp0I+6goy/tyBNV9PaVflu21JIN4Tc3CNL1j4Il3con+iu6M/7vZV58O5qt4/V
         Dh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tEGocQ62hfwK6Gu+tfXjRHtRf5LF3zuLTHi8XMt04nI=;
        b=024Mo2HoqFlsZo4Xg06p3EYkDKm/ADCK21id47yWmLbmNnGQemjWbBW0ZVYonJMT40
         MJ/63i2ZKtfQjSFuD9fEUiKrUYYHi0uCqYDmHjhEzh4+uoZGds2GjRMrYbTkj9x6/1/g
         /h5xbT6ZGKHQoRLKDuDD9S+gEcfjBSu54YIaErgvzaUFRMYt12IFEO7wf63wO28UOfIF
         aCcy+jueO5gBZxJQdB4g9WdnVbBnRsQ8QPGQL7C1XZLGXzlT6INeCIZDTUrDU/pQ7Our
         hqo8acMspkg4vX1WiGvGD1AQhhteI7hGHQJktPu4UjhcssnnMA1Ryy4xqaJfVOGP5fl2
         u3oA==
X-Gm-Message-State: AOAM5314Cw8my3n/XVRCw/S26pdOTHhU4E7YV4/R+puYSYNqAJOsHePu
        KO7Bo97oblGo/MDrjCKOZoIuMw==
X-Google-Smtp-Source: ABdhPJzkHOvKxuieF3eK/80llO2ki9JIw/SCWjKwybaECkUsS1OnWMfBcN2OeB78J7LDJKkQLTNW3w==
X-Received: by 2002:a05:622a:388:: with SMTP id j8mr11965266qtx.366.1638426489474;
        Wed, 01 Dec 2021 22:28:09 -0800 (PST)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id 15sm1102145qtp.55.2021.12.01.22.28.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 22:28:09 -0800 (PST)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v5 00/10] Multigenerational LRU Framework
Date:   Wed,  1 Dec 2021 22:28:06 -0800
Message-Id: <20211202062806.80365-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
References: <20211111041510.402534-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / Apache Cassandra benchmark with MGLRU

TLDR
====
With the MGLRU, Apache Cassandra achieved 95% CIs [1.06, 4.10]%,
[1.94, 5.43]% and [4.11, 7.50]% more operations per second (OPS),
respectively, for exponential (distribution) access, random access
and Zipfian access, when swap was off; 95% CIs [0.50, 2.60]%, [6.51,
8.77]% and [3.29, 6.75]% more OPS, respectively, for exponential
access, random access and Zipfian access, when swap was set to
minimum (vm.swappiness=1).

Background
==========
Memory overcommit can increase utilization and, if carried out
properly, can also increase throughput. The challenges are to improve
working set estimation and to optimize page reclaim. The risks are
performance degradation and OOM kills. Short of overcoming the
challenges, the only way to reduce the risks is to underutilize
memory.

Apache Cassandra is one of the most popular open-source NoSQL
databases. YCSB is the leading open-source NoSQL database
benchmarking software that supports multiple access distributions.
Swap can have a negative effect, as Apache Cassandra cautions "Do
never allow your system to swap" [1].

[1]: https://github.com/apache/cassandra/blob/trunk/conf/cassandra.yaml#L394

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.15
* Patched: 5.15 + MGLRU

Swap configurations:
* Off
* Minimum (vm.swappiness=1)

Concurrency: average # of users per CPU
* Medium: 3

Access distributions (2kB objects, 10% update):
* Exponential
* Uniform random
* Zipfian

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~40

Note that Apache Cassandra reached the peak performance for this
benchmark with 2-3 users per CPU, i.e., its performance started
degrading with fewer or more users.

Procedure
=========
The latest MGLRU patchset for the 5.15 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
    refs/changes/30/1430/2

Baseline and patched 5.15 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>
ycsb_load.sh
systemctl stop cassandra
e2image <backup /mnt/data>

<for each kernel>
    grub-set-default <baseline, patched>
    <for each swap configuration>
        <swapoff, swapon>
        <for each access distribution>
            <update ycsb_run.sh>
            <for each data point>
                systemctl stop cassandra
                e2image <restore /mnt/data>
                reboot
                ycsb_run.sh
                <collect OPS>

Hardware
========
Memory (GB): 256
CPU (total #): 48
NVMe SSD (GB): 1024

OS
==
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=21.10
DISTRIB_CODENAME=impish
DISTRIB_DESCRIPTION="Ubuntu 21.10"

$ cat /proc/swaps
Filename          Type          Size          Used     Priority
/dev/nvme0n1p3    partition     32970748      0        -2

$ cat /sys/fs/cgroup/user.slice/memory.min
4294967296

$ cat /proc/sys/vm/overcommit_memory
1

$ cat /proc/sys/vm/swappiness
1

$ cat /proc/sys/vm/max_map_count
1048575

Apache Cassandra
================
$ nodetool version
ReleaseVersion: 4.0.1

$ cat jvm8-server.options
<existing parameters>

#-XX:+UseParNewGC
#-XX:+UseConcMarkSweepGC
#-XX:+CMSParallelRemarkEnabled
#-XX:SurvivorRatio=8
#-XX:MaxTenuringThreshold=1
#-XX:CMSInitiatingOccupancyFraction=75
#-XX:+UseCMSInitiatingOccupancyOnly
#-XX:CMSWaitDuration=10000
#-XX:+CMSParallelInitialMarkEnabled
#-XX:+CMSEdenChunksRecordAlways
#-XX:+CMSClassUnloadingEnabled

-XX:+UseG1GC
-XX:+ParallelRefProcEnabled
-XX:MaxGCPauseMillis=400

<existing parameters>

$ cat cassandra.yaml
<existing parameters>

data_file_directories: /mnt/data/
key_cache_size_in_mb: 5000
file_cache_enabled: true
file_cache_size_in_mb: 10000
buffer_pool_use_heap_if_exhausted: false
memtable_offheap_space_in_mb: 10000
memtable_allocation_type: offheap_buffers

<existing parameters>

YCSB
====
$ git log
commit ce3eb9ce51c84ee9e236998cdd2cefaeb96798a8 (HEAD -> master,
origin/master, origin/HEAD)
Author: Ivan <john.koepi@gmail.com>
Date:   Tue Feb 16 17:38:00 2021 +0200

    [scylla] enable token aware LB by default, improve the docs (#1507)

$ cat ycsb_load.sh
# load objects
cqlsh -e "create keyspace ycsb WITH REPLICATION = {'class' : \
    'SimpleStrategy', 'replication_factor': 1};"
cqlsh -k ycsb -e "create table usertable (y_id varchar primary key, \
    field0 varchar, field1 varchar, field2 varchar, field3 varchar, \
    field4 varchar, field5 varchar ,field6 varchar, field7 varchar, \
    field8 varchar, field9 varchar);"
ycsb load cassandra-cql -s -threads 24 -p hosts=localhost \
    -p workload=site.ycsb.workloads.CoreWorkload -p fieldlength=200 \
    -p recordcount=130000000

$ cat ycsb_run.sh
# run benchmark
ycsb run cassandra-cql -s -threads 144 -p hosts=localhost \
    -p workload=site.ycsb.workloads.CoreWorkload \
    -p recordcount=130000000 -p operationcount=130000000 \
    -p readproportion=0.9 -p updateproportion=0.1 \
    -p maxexecutiontime=1800 \
    -p requestdistribution=<exponential, uniform, zipfian>

Results
=======
Comparing the patched with the baseline kernel, Apache Cassandra
achieved 95% CIs [1.06, 4.10]%, [1.94, 5.43]% and [4.11, 7.50]% more
OPS, respectively, for exponential access, random access and Zipfian
access, when swap was off; 95% CIs [0.50, 2.60]%, [6.51, 8.77]% and
[3.29, 6.75]% more OPS, respectively, for exponential access, random
access and Zipfian access, when swap was set to minimum
(vm.swappiness=1).

+--------------------+--------------------+---------------------+
| Mean OPS [95% CI]  | No swap            | Minimum swap        |
+--------------------+--------------------+---------------------+
| Exponential access | 71084.9 / 72917.5  | 71499.6 / 72607.9   |
|                    | [751.42, 2913.77]  | [358.40, 1858.19]   |
+--------------------+--------------------+---------------------+
| Random access      | 47127.2 / 48862.8  | 47585.4 / 51220.1   |
|                    | [912.68, 2558.51]  | [3097.39, 4172.00]  |
+--------------------+--------------------+---------------------+
| Zipfian access     | 70271.5 / 74348.8  | 70698.2 / 74248.3   |
|                    | [2887.20, 5267.39] | [2326.69, 4773.50]  |
+--------------------+--------------------+---------------------+
Table 1. Comparison between the baseline and the patched kernels

Comparing minimum swap with no swap, Apache Cassandra achieved 95%
CIs [4.05, 5.60]% more OPS for random access, when using the patched
kernel. There were no statistically significant changes in OPS under
other conditions.

+--------------------+--------------------+---------------------+
| Mean OPS [95% CI]  | Baseline kernel    |  Patched kernel     |
+--------------------+--------------------+---------------------+
| Exponential access | 71084.9 / 71499.6  | 72917.5 / 72607.9   |
|                    | [-358.97, 1188.37] | [-1376.93, 757.73]  |
+--------------------+--------------------+---------------------+
| Random access      | 47127.2 / 47585.4  | 48862.8 / 51220.1   |
|                    | [-424.55, 1340.95] | [1977.09, 2737.50]  |
+--------------------+--------------------+---------------------+
| Zipfian access     | 70271.5 / 70698.2  | 74348.8 / 74248.3   |
|                    | [-749.39, 1602.79] | [-1337.07, 1136.07] |
+--------------------+--------------------+---------------------+
Table 2. Comparison between no swap and minimum swap

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/cassandra/5.15

Appendix
========
$ cat raw_data_cassandra.r
v <- c(
    # baseline swapoff exp
    69952, 70274, 70286, 70818, 70946, 71202, 71244, 71615, 71787, 72725,
    # baseline swapoff uni
    45309, 46056, 46086, 46188, 47275, 47524, 47797, 48243, 48329, 48465,
    # baseline swapoff zip
    69096, 69194, 69386, 69408, 69412, 70795, 70890, 71170, 71232, 72132,
    # baseline swapon exp
    69836, 70783, 70951, 71188, 71521, 71764, 72035, 72166, 72287, 72465,
    # baseline swapon uni
    46089, 46963, 47308, 47599, 47776, 47822, 47952, 48042, 48092, 48211,
    # baseline swapon zip
    68986, 69279, 69290, 69805, 70146, 70913, 71462, 71978, 72370, 72753,
    # patched swapoff exp
    70701, 71328, 71458, 72846, 72885, 73078, 73702, 74077, 74415, 74685,
    # patched swapoff uni
    48275, 48460, 48735, 48813, 48902, 48969, 48996, 49007, 49213, 49258,
    # patched swapoff zip
    71829, 72909, 73259, 73835, 74200, 74544, 75318, 75514, 76031, 76049,
    # patched swapon exp
    71169, 71968, 72208, 72374, 72401, 72755, 72861, 72942, 73469, 73932,
    # patched swapon uni
    50292, 50529, 50981, 51224, 51414, 51420, 51480, 51608, 51625, 51628,
    # patched swapon zip
    72032, 72325, 73834, 74366, 74482, 74573, 74810, 75044, 75371, 75646
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (swap in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, swap, 1], a[, dist, swap, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("swap%d dist%d: no significance", swap, dist)
        } else {
            s <- sprintf("swap%d dist%d: [%.2f, %.2f]%%", swap, dist, -p[2], -p[1])
        }
        print(s)
    }
}

# swapoff vs swapon
for (kern in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, 1, kern], a[, dist, 2, kern])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("kern%d dist%d: no significance", kern, dist)
        } else {
            s <- sprintf("kern%d dist%d: [%.2f, %.2f]%%", kern, dist, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data_cassandra.r

        Welch Two Sample t-test

data:  a[, dist, swap, 1] and a[, dist, swap, 2]
t = -3.6172, df = 14.793, p-value = 0.002585
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2913.7703  -751.4297
sample estimates:
mean of x mean of y
  71084.9   72917.5

[1] "swap1 dist1: [1.06, 4.10]%"

        Welch Two Sample t-test

data:  a[, dist, swap, 1] and a[, dist, swap, 2]
t = -4.679, df = 10.331, p-value = 0.0007961
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2558.5199  -912.6801
sample estimates:
mean of x mean of y
  47127.2   48862.8

[1] "swap1 dist2: [1.94, 5.43]%"

        Welch Two Sample t-test

data:  a[, dist, swap, 1] and a[, dist, swap, 2]
t = -7.2315, df = 16.902, p-value = 1.452e-06
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -5267.396 -2887.204
sample estimates:
mean of x mean of y
  70271.5   74348.8

[1] "swap1 dist3: [4.11, 7.50]%"

        Welch Two Sample t-test

data:  a[, dist, swap, 1] and a[, dist, swap, 2]
t = -3.1057, df = 17.95, p-value = 0.006118
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1858.191  -358.409
sample estimates:
mean of x mean of y
  71499.6   72607.9

[1] "swap2 dist1: [0.50, 2.60]%"

        Welch Two Sample t-test

data:  a[, dist, swap, 1] and a[, dist, swap, 2]
t = -14.307, df = 16.479, p-value = 1.022e-10
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -4172.006 -3097.394
sample estimates:
mean of x mean of y
  47585.4   51220.1

[1] "swap2 dist2: [6.51, 8.77]%"

        Welch Two Sample t-test

data:  a[, dist, swap, 1] and a[, dist, swap, 2]
t = -6.1048, df = 17.664, p-value = 9.877e-06
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -4773.504 -2326.696
sample estimates:
mean of x mean of y
  70698.2   74248.3

[1] "swap2 dist3: [3.29, 6.75]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -1.1261, df = 17.998, p-value = 0.2749
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1188.3785   358.9785
sample estimates:
mean of x mean of y
  71084.9   71499.6

[1] "kern1 dist1: no significance"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -1.1108, df = 14.338, p-value = 0.2849
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1340.9555   424.5555
sample estimates:
mean of x mean of y
  47127.2   47585.4

[1] "kern1 dist2: no significance"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -0.76534, df = 17.035, p-value = 0.4545
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1602.7926   749.3926
sample estimates:
mean of x mean of y
  70271.5   70698.2

[1] "kern1 dist3: no significance"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 0.62117, df = 14.235, p-value = 0.5443
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -757.7355 1376.9355
sample estimates:
mean of x mean of y
  72917.5   72607.9

[1] "kern2 dist1: no significance"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -13.18, df = 15.466, p-value = 8.07e-10
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2737.509 -1977.091
sample estimates:
mean of x mean of y
  48862.8   51220.1

[1] "kern2 dist2: [4.05, 5.60]%"

        Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 0.17104, df = 17.575, p-value = 0.8661
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1136.076  1337.076
sample estimates:
mean of x mean of y
  74348.8   74248.3

[1] "kern2 dist3: no significance"
