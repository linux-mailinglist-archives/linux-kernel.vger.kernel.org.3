Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136EE46E32F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhLIH1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhLIH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:27:54 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC59C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 23:24:21 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id f20so4521189qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 23:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NBh2FtOhN9V4AaYJCGgnULr5RlKifG8K4kl2lNElkqE=;
        b=dIoU0XEyugtg1Fe2bPpH7wzdzKvXTAXc3KL9Z6npueqZiH0qtF/YtLnsyOlTbdZhSu
         F7bt/nVHNrNfB1O5MkYHm0tiquhJAqwe/SGcU8C/kazHaEN2U2llPdmns270QrS7ebBw
         E4VkAqkKJvS6qsVlXjTh20qHdH8zeumBr2/luRpmpzr5BRBKJuVOUPDWa7/jqys2WekI
         R4NdkdeLyhA2DELWgsWRweTv4bAhEcMgC2fqJSxQtS0aDGKJ9V5B9cgcKt0G6b3CLMFd
         zyoexv1850Dn79utmgbFqSwDdD7vZgV39EtphdiB3qAo3pvbk9/eMS9RZQlKsNo35OE7
         wA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NBh2FtOhN9V4AaYJCGgnULr5RlKifG8K4kl2lNElkqE=;
        b=FMNK+tMFeYNyctVSAsyorwwl0ACIDil1hRgZv7jRMxqOGweaqvjQNQJNJq6joJcZep
         b2L76ve6sw8PygsSrb24/N8OzjkIJfGauT8SlRUhT4jRDqRk816Zr9RLl4qkk39IE20g
         noAfr8DzZRRiF/bOTPD/LsJNSaHWjcRZbgTfH15Y1JpXXcYjMJw0XY8gBjyi+YDTsWvI
         O9MdmiyCREC26S184DqfNEG0OCMULiDcVB0D9DHqN8t4W3FRZiskrPLKd3tLk2x8qWDU
         RApANk/20+KDFoXQxVr1qYFT2oPj1eTp6mUdL0eg86DDm5E1kjCobgeOZwdRR+CL0Ppt
         wpuA==
X-Gm-Message-State: AOAM531RSn6GclN7ERZu8z+tcrZ4Rp7qkHaE7O2IbVo2uwuQ+5bqYDhF
        oOUP+pVGQkkS5v8VhsLqLdrlaqmF9HzaAA==
X-Google-Smtp-Source: ABdhPJytuoYkwpk9eT43sFCClb+a55nb+d8+FBlZl6072GJvTh07ntBMbC9woi5lutycMfXsCowCNA==
X-Received: by 2002:ac8:58c9:: with SMTP id u9mr14923345qta.583.1639034660203;
        Wed, 08 Dec 2021 23:24:20 -0800 (PST)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id t11sm3432244qtx.48.2021.12.08.23.24.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 23:24:19 -0800 (PST)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v5 00/10] Multigenerational LRU Framework
Date:   Wed,  8 Dec 2021 23:24:16 -0800
Message-Id: <20211209072416.33606-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
References: <20211111041510.402534-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / Apache Hadoop benchmark with MGLRU

TLDR
====
With the MGLRU, Apache Hadoop took 95% CIs [5.31, 9.69]% and [2.02,
7.86]% less wall time to finish TeraSort, respectively, under the
medium- and the high-concurrency conditions, when swap was on. There
were no statistically significant changes in wall time for the rest
of the test matrix.

Background
==========
Memory overcommit can increase utilization and, if carried out
properly, can also increase throughput. The challenges are to improve
working set estimation and to optimize page reclaim. The risks are
performance degradation and OOM kills. Short of overcoming the
challenges, the only way to reduce the risks is to underutilize
memory.

Apache Hadoop is one of the most popular open-source big-data
frameworks. TeraSort is the most widely used benchmark for Apache
Hadoop.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.15
* Patched: 5.15 + MGLRU

Swap configurations:
* Off
* On

Concurrency conditions: average # of tasks per CPU
* Low: 1/2
* Medium: 1
* High: 2

Cluster mode: local (12 concurrent jobs)
Dataset size: 100 million records from TeraGen

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~20

Procedure
=========
The latest MGLRU patchset for the 5.15 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
    refs/changes/30/1430/2

Baseline and patched 5.15 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>
teragen 100000000 /mnt/data/raw
e2image <backup /mnt/data>

<for each kernel>
    grub-set-default <baseline, patched>
    <for each swap configuration>
        <swapoff, swapon>
        <update run_terasort.sh>
        <for each concurrency condition>
            <update run_terasort.sh>
            <for each data point>
                e2image <restore /mnt/data>
                reboot
                run_terasort.sh
                <collect wall time>

Hardware
========
Memory (GB): 256
CPU (total #): 48
NVMe SSD (GB): 2048

OS
==
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=21.10
DISTRIB_CODENAME=impish
DISTRIB_DESCRIPTION="Ubuntu 21.10"

$ cat /proc/swaps
Filename          Type          Size          Used     Priority
/swap.img         partition     67108860      0        -2

$ cat /proc/sys/vm/overcommit_memory
1

$ cat /proc/sys/vm/swappiness
1

Apache Hadoop
=============
$ hadoop version
Hadoop 3.3.1
Source code repository https://github.com/apache/hadoop.git -r
a3b9c37a397ad4188041dd80621bdeefc46885f2
Compiled by ubuntu on 2021-06-15T05:13Z
Compiled with protoc 3.7.1
From source with checksum 88a4ddb2299aca054416d6b7f81ca55
This command was run using
/root/hadoop-3.3.1/share/hadoop/common/hadoop-common-3.3.1.jar

$ cat run_terasort.sh
export HADOOP_ROOT_LOGGER="WARN,DRFA"
export HADOOP_HEAPSIZE_MAX=<swapoff: 20G, swapon: 22G>

for ((i = 0; i < 12; i++))
do
    /usr/bin/time -f "%e" hadoop jar \
        hadoop-mapreduce-examples-3.3.1.jar terasort \
        -Dfile.stream-buffer-size=8388608 \
        -Dio.file.buffer.size=8388608 \
        -Dmapreduce.job.heap.memory-mb.ratio=1.0 \
        -Dmapreduce.reduce.input.buffer.percent=1.0 \
        -Dmapreduce.reduce.merge.inmem.threshold=0 \
        -Dmapreduce.task.io.sort.factor=100 \
        -Dmapreduce.task.io.sort.mb=1000 \
        -Dmapreduce.terasort.final.sync=false \
        -Dmapreduce.terasort.num.partitions=100 \
        -Dmapreduce.terasort.partitions.sample=1000000 \
        -Dmapreduce.local.map.tasks.maximum=<2, 4, 8> \
        -Dmapreduce.local.reduce.tasks.maximum=<2, 4, 8> \
        -Dmapreduce.reduce.shuffle.parallelcopies=<2, 4, 8> \
        -Dhadoop.tmp.dir=/mnt/data/tmp$i \
        /mnt/data/raw /mnt/data/sorted$i
done

wait

Results
=======
Comparing the patched with the baseline kernel, Apache Hadoop took
95% CIs [5.31, 9.69]% and [2.02, 7.86]% less wall time to finish
TeraSort, respectively, under the medium- and the high-concurrency
conditions, when swap was on. There were no statistically significant
changes in wall time for the rest of the test matrix.

+--------------------+------------------+------------------+
| Mean wall time (s) | Swap off         | Swap on          |
| [95% CI]           |                  |                  |
+--------------------+------------------+------------------+
| Low concurrency    | 758.43 / 746.83  | 740.78 / 733.42  |
|                    | [-26.80, 3.60]   | [-18.07, 3.35]   |
+--------------------+------------------+------------------+
| Medium concurrency | 911.81 / 910.19  | 911.53 / 843.15  |
|                    | [-26.70, 23.46]  | [-88.35, -48.39] |
+--------------------+------------------+------------------+
| High concurrency   | 921.17 / 929.51  | 1042.85 / 991.33 |
|                    | [-25.50, 42.18]  | [-81.94, -21.08] |
+--------------------+------------------+------------------+
Table 1. Comparison between the baseline and the patched kernels

Comparing swap on with swap off, Apache Hadoop took 95% CIs [-3.39,
-1.27]% and [10.69, 15.73]% more wall time to finish TeraSort,
respectively, under the low- and the high-concurrency conditions,
when using the baseline kernel; 95% CIs [-9.34, -5.39]% and [2.52,
10.78]% more wall time, respectively, under the medium- and the
high-concurrency conditions, when using the patched kernel. There
were no statistically significant changes in wall time for the rest
of the test matrix.

+--------------------+------------------+------------------+
| Mean wall time (s) | Baseline kernel  | Patched kernel   |
| [95% CI]           |                  |                  |
+--------------------+------------------+------------------+
| Low concurrency    | 758.43 / 740.78  | 746.83 / 733.42  |
|                    | [-25.67, -9.64]  | [-29.80, 2.97]   |
+--------------------+------------------+------------------+
| Medium concurrency | 911.81 / 911.53  | 910.19 / 843.15  |
|                    | [-26.62, 26.06]  | [-84.98, -49.09] |
+--------------------+------------------+------------------+
| High concurrency   | 921.17 / 1042.85 | 929.51 / 991.33  |
|                    | [98.51, 144.85]  | [23.43, 100.21]  |
+--------------------+------------------+------------------+
Table 2. Comparison between swap off and on

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/hadoop/5.15

Appendix
========
$ cat raw_data_hadoop.r
v <- c(
    # baseline swapoff 2mr
    742.83, 751.91, 755.75, 757.50, 757.83, 758.16, 758.25, 763.58, 766.58, 772.00,
    # baseline swapoff 4mr
    863.25, 868.08, 886.58, 894.66, 901.16, 918.25, 940.91, 944.08, 949.66, 951.50,
    # baseline swapoff 8mr
    892.16, 895.75, 909.25, 922.58, 922.91, 922.91, 923.16, 926.00, 935.33, 961.66,
    # baseline swapon 2mr
    731.58, 732.08, 736.66, 737.75, 738.00, 738.08, 740.08, 740.33, 752.58, 760.66,
    # baseline swapon 4mr
    878.83, 886.33, 902.75, 904.83, 907.25, 918.50, 921.33, 925.50, 927.58, 942.41,
    # baseline swapon 8mr
    1016.58, 1017.33, 1019.33, 1019.50, 1026.08, 1030.50, 1065.16, 1070.50, 1075.25, 1088.33,
    # patched swapoff 2mr
    720.41, 724.58, 727.41, 732.00, 745.41, 748.00, 754.50, 767.91, 773.16, 775.00,
    # patched swapoff 4mr
    887.16, 887.50, 906.66, 907.41, 915.00, 915.58, 915.66, 916.91, 925.00, 925.08,
    # patched swapoff 8mr
    857.08, 864.41, 910.25, 918.58, 921.91, 933.75, 949.50, 966.75, 984.00, 988.91,
    # patched swapon 2mr
    719.33, 721.91, 724.41, 724.83, 725.75, 728.75, 737.83, 743.91, 749.41, 758.08,
    # patched swapon 4mr
    813.33, 819.00, 821.91, 829.33, 839.50, 846.75, 850.25, 857.00, 875.83, 878.66,
    # patched swapon 8mr
    929.41, 955.83, 961.16, 974.66, 988.75, 1004.00, 1009.08, 1019.91, 1030.58, 1040.00
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (swap in 1:2) {
    for (mr in 1:3) {
        r <- t.test(a[, mr, swap, 1], a[, mr, swap, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("swap%d mr%d: no significance", swap, mr)
        } else {
            s <- sprintf("swap%d mr%d: [%.2f, %.2f]%%", swap, mr, -p[2], -p[1])
        }
        print(s)
    }
}

# swapoff vs swapon
for (kern in 1:2) {
    for (mr in 1:3) {
        r <- t.test(a[, mr, 1, kern], a[, mr, 2, kern])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("kern%d mr%d: no significance", kern, mr)
        } else {
            s <- sprintf("kern%d mr%d: [%.2f, %.2f]%%", kern, mr, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data_hadoop.r

        Welch Two Sample t-test

data:  a[, mr, swap, 1] and a[, mr, swap, 2]
t = 1.6677, df = 11.658, p-value = 0.122
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -3.604753 26.806753
sample estimates:
mean of x mean of y
  758.439   746.838

[1] "swap1 mr1: no significance"

        Welch Two Sample t-test

data:  a[, mr, swap, 1] and a[, mr, swap, 2]
t = 0.14071, df = 11.797, p-value = 0.8905
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -23.4695  26.7035
sample estimates:
mean of x mean of y
  911.813   910.196

[1] "swap1 mr2: no significance"

        Welch Two Sample t-test

data:  a[, mr, swap, 1] and a[, mr, swap, 2]
t = -0.53558, df = 12.32, p-value = 0.6018
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -42.18602  25.50002
sample estimates:
mean of x mean of y
  921.171   929.514

[1] "swap1 mr3: no significance"

        Welch Two Sample t-test

data:  a[, mr, swap, 1] and a[, mr, swap, 2]
t = 1.4568, df = 15.95, p-value = 0.1646
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -3.352318 18.070318
sample estimates:
mean of x mean of y
  740.780   733.421

[1] "swap2 mr1: no significance"

        Welch Two Sample t-test

data:  a[, mr, swap, 1] and a[, mr, swap, 2]
t = 7.204, df = 17.538, p-value = 1.229e-06
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 48.39677 88.35323
sample estimates:
mean of x mean of y
  911.531   843.156

[1] "swap2 mr2: [-9.69, -5.31]%"

        Welch Two Sample t-test

data:  a[, mr, swap, 1] and a[, mr, swap, 2]
t = 3.5698, df = 17.125, p-value = 0.002336
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 21.08655 81.94945
sample estimates:
mean of x mean of y
 1042.856   991.338

[1] "swap2 mr3: [-7.86, -2.02]%"

        Welch Two Sample t-test

data:  a[, mr, 1, kern] and a[, mr, 2, kern]
t = 4.6319, df = 17.718, p-value = 0.0002153
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
  9.640197 25.677803
sample estimates:
mean of x mean of y
  758.439   740.780

[1] "kern1 mr1: [-3.39, -1.27]%"

        Welch Two Sample t-test

data:  a[, mr, 1, kern] and a[, mr, 2, kern]
t = 0.0229, df = 14.372, p-value = 0.982
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -26.06533  26.62933
sample estimates:
mean of x mean of y
  911.813   911.531

[1] "kern1 mr2: no significance"

        Welch Two Sample t-test

data:  a[, mr, 1, kern] and a[, mr, 2, kern]
t = -11.129, df = 16.051, p-value = 5.874e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -144.8574  -98.5126
sample estimates:
mean of x mean of y
  921.171  1042.856

[1] "kern1 mr3: [10.69, 15.73]%"

        Welch Two Sample t-test

data:  a[, mr, 1, kern] and a[, mr, 2, kern]
t = 1.7413, df = 15.343, p-value = 0.1016
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2.974529 29.808529
sample estimates:
mean of x mean of y
  746.838   733.421

[1] "kern2 mr1: no significance"

        Welch Two Sample t-test

data:  a[, mr, 1, kern] and a[, mr, 2, kern]
t = 7.9839, df = 14.571, p-value = 1.073e-06
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 49.09637 84.98363
sample estimates:
mean of x mean of y
  910.196   843.156

[1] "kern2 mr2: [-9.34, -5.39]%"

        Welch Two Sample t-test

data:  a[, mr, 1, kern] and a[, mr, 2, kern]
t = -3.3962, df = 17.1, p-value = 0.003413
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -100.21425  -23.43375
sample estimates:
mean of x mean of y
  929.514   991.338

[1] "kern2 mr3: [2.52, 10.78]%"
