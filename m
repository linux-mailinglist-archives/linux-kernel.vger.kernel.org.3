Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256514B4D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbiBNLCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:02:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiBNLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:02:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7516A390;
        Mon, 14 Feb 2022 02:30:22 -0800 (PST)
Date:   Mon, 14 Feb 2022 10:30:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644834620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DelFAPYS08hotY5TMjlHYO1W8U22bXH6IEEThYbb/hg=;
        b=TpUMfS57K6D83ldetsDZoVvHm5TW3nA5laTkvLIJx8yIAOIlXnMHNwklb+J9Klh12KQFcs
        nvYnd43kYa/w7Tmhf9DaBojTvBnQ4e8OIEMRgQcuLHhzqtWBns71z2G6kul5A9Et7oEWGJ
        JEAXOZQ8DT27f/2mmwDl+ji5I1b9TOevHfb6iO0gEDqs+NnlLm5TregkrsJCNkYYb5sAi0
        JZBEraXe60Ab+p5DTnOcW5JYjRIpK2gvI6XDjuGsMuWdXpjB8sreid9lfWjRy52ti6+edX
        LR0uBgsDJSS/JihiKztRBEoluUtthbTNtdFKZPB7GeR9M6A0dXXx/SnT4JMIlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644834620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DelFAPYS08hotY5TMjlHYO1W8U22bXH6IEEThYbb/hg=;
        b=IEqyiLNlHgck0Mji8evFF20Ahhdbc0gCHJHiQJbxO7A/u8dXoVV66GsZx8mJyFtmPhdfgQ
        GXoOs1KwB5Ma3jDw==
From:   "tip-bot2 for Huang Ying" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa-balancing: Move some document to make it
 consistent with the code
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220210052514.3038279-1-ying.huang@intel.com>
References: <20220210052514.3038279-1-ying.huang@intel.com>
MIME-Version: 1.0
Message-ID: <164483461838.16921.3762073853345319823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3624ba7b5e2acc02b01301ea5fd3534971eb9896
Gitweb:        https://git.kernel.org/tip/3624ba7b5e2acc02b01301ea5fd3534971eb9896
Author:        Huang Ying <ying.huang@intel.com>
AuthorDate:    Thu, 10 Feb 2022 13:25:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 23:30:08 +01:00

sched/numa-balancing: Move some document to make it consistent with the code

After commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to
debugfs"), some NUMA balancing sysctls enclosed with SCHED_DEBUG has
been moved to debugfs.  This patch move the document for these
sysctls from

  Documentation/admin-guide/sysctl/kernel.rst

to

  Documentation/scheduler/sched-debug.rst

to make the document consistent with the code.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lkml.kernel.org/r/20220210052514.3038279-1-ying.huang@intel.com
---
 Documentation/admin-guide/sysctl/kernel.rst | 46 +-----------------
 Documentation/scheduler/index.rst           |  1 +-
 Documentation/scheduler/sched-debug.rst     | 54 ++++++++++++++++++++-
 3 files changed, 56 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/scheduler/sched-debug.rst

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index d359bcf..8551aec 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -609,51 +609,7 @@ be migrated to a local memory node.
 The unmapping of pages and trapping faults incur additional overhead that
 ideally is offset by improved memory locality but there is no universal
 guarantee. If the target workload is already bound to NUMA nodes then this
-feature should be disabled. Otherwise, if the system overhead from the
-feature is too high then the rate the kernel samples for NUMA hinting
-faults may be controlled by the `numa_balancing_scan_period_min_ms,
-numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
-numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
-
-
-numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms, numa_balancing_scan_size_mb
-===============================================================================================================================
-
-
-Automatic NUMA balancing scans tasks address space and unmaps pages to
-detect if pages are properly placed or if the data should be migrated to a
-memory node local to where the task is running.  Every "scan delay" the task
-scans the next "scan size" number of pages in its address space. When the
-end of the address space is reached the scanner restarts from the beginning.
-
-In combination, the "scan delay" and "scan size" determine the scan rate.
-When "scan delay" decreases, the scan rate increases.  The scan delay and
-hence the scan rate of every task is adaptive and depends on historical
-behaviour. If pages are properly placed then the scan delay increases,
-otherwise the scan delay decreases.  The "scan size" is not adaptive but
-the higher the "scan size", the higher the scan rate.
-
-Higher scan rates incur higher system overhead as page faults must be
-trapped and potentially data must be migrated. However, the higher the scan
-rate, the more quickly a tasks memory is migrated to a local node if the
-workload pattern changes and minimises performance impact due to remote
-memory accesses. These sysctls control the thresholds for scan delays and
-the number of pages scanned.
-
-``numa_balancing_scan_period_min_ms`` is the minimum time in milliseconds to
-scan a tasks virtual memory. It effectively controls the maximum scanning
-rate for each task.
-
-``numa_balancing_scan_delay_ms`` is the starting "scan delay" used for a task
-when it initially forks.
-
-``numa_balancing_scan_period_max_ms`` is the maximum time in milliseconds to
-scan a tasks virtual memory. It effectively controls the minimum scanning
-rate for each task.
-
-``numa_balancing_scan_size_mb`` is how many megabytes worth of pages are
-scanned for a given scan.
-
+feature should be disabled.
 
 oops_all_cpu_backtrace
 ======================
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 88900aa..30cca8a 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -17,6 +17,7 @@ Linux Scheduler
     sched-nice-design
     sched-rt-group
     sched-stats
+    sched-debug
 
     text_files
 
diff --git a/Documentation/scheduler/sched-debug.rst b/Documentation/scheduler/sched-debug.rst
new file mode 100644
index 0000000..4d3d24f
--- /dev/null
+++ b/Documentation/scheduler/sched-debug.rst
@@ -0,0 +1,54 @@
+=================
+Scheduler debugfs
+=================
+
+Booting a kernel with CONFIG_SCHED_DEBUG=y will give access to
+scheduler specific debug files under /sys/kernel/debug/sched. Some of
+those files are described below.
+
+numa_balancing
+==============
+
+`numa_balancing` directory is used to hold files to control NUMA
+balancing feature.  If the system overhead from the feature is too
+high then the rate the kernel samples for NUMA hinting faults may be
+controlled by the `scan_period_min_ms, scan_delay_ms,
+scan_period_max_ms, scan_size_mb` files.
+
+
+scan_period_min_ms, scan_delay_ms, scan_period_max_ms, scan_size_mb
+-------------------------------------------------------------------
+
+Automatic NUMA balancing scans tasks address space and unmaps pages to
+detect if pages are properly placed or if the data should be migrated to a
+memory node local to where the task is running.  Every "scan delay" the task
+scans the next "scan size" number of pages in its address space. When the
+end of the address space is reached the scanner restarts from the beginning.
+
+In combination, the "scan delay" and "scan size" determine the scan rate.
+When "scan delay" decreases, the scan rate increases.  The scan delay and
+hence the scan rate of every task is adaptive and depends on historical
+behaviour. If pages are properly placed then the scan delay increases,
+otherwise the scan delay decreases.  The "scan size" is not adaptive but
+the higher the "scan size", the higher the scan rate.
+
+Higher scan rates incur higher system overhead as page faults must be
+trapped and potentially data must be migrated. However, the higher the scan
+rate, the more quickly a tasks memory is migrated to a local node if the
+workload pattern changes and minimises performance impact due to remote
+memory accesses. These files control the thresholds for scan delays and
+the number of pages scanned.
+
+``scan_period_min_ms`` is the minimum time in milliseconds to scan a
+tasks virtual memory. It effectively controls the maximum scanning
+rate for each task.
+
+``scan_delay_ms`` is the starting "scan delay" used for a task when it
+initially forks.
+
+``scan_period_max_ms`` is the maximum time in milliseconds to scan a
+tasks virtual memory. It effectively controls the minimum scanning
+rate for each task.
+
+``scan_size_mb`` is how many megabytes worth of pages are scanned for
+a given scan.
