Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CAC544199
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiFICr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFICr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:47:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BEF1A007E;
        Wed,  8 Jun 2022 19:47:23 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LJT3b669lz1K9kr;
        Thu,  9 Jun 2022 10:45:31 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 10:47:20 +0800
From:   Zheng Zengkai <zhengzengkai@huawei.com>
To:     <corbet@lwn.net>
CC:     <chenhuacai@kernel.org>, <kernel@xen0n.name>, <deller@gmx.de>,
        <linux-parisc@vger.kernel.org>, <vincent.whitchurch@axis.com>,
        <richard@nod.at>, <linux-um@lists.infradead.org>,
        <palmer@dabbelt.com>, <linux-riscv@lists.infradead.org>,
        <vgupta@kernel.org>, <sergey.matyukevich@synopsys.com>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>,
        <zhengzengkai@huawei.com>
Subject: [PATCH] Documentation/features: Update the arch support status files
Date:   Thu, 9 Jun 2022 10:56:56 +0800
Message-ID: <20220609025656.143460-1-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arch support status files don't match reality as of v5.19-rc1,
use the features-refresh.sh to refresh all the arch-support.txt files
in place.

Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 Documentation/features/core/cBPF-JIT/arch-support.txt          | 1 +
 Documentation/features/core/eBPF-JIT/arch-support.txt          | 1 +
 .../features/core/generic-idle-thread/arch-support.txt         | 1 +
 Documentation/features/core/jump-labels/arch-support.txt       | 1 +
 .../features/core/thread-info-in-task/arch-support.txt         | 1 +
 Documentation/features/core/tracehook/arch-support.txt         | 1 +
 Documentation/features/debug/KASAN/arch-support.txt            | 1 +
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt | 3 ++-
 Documentation/features/debug/gcov-profile-all/arch-support.txt | 3 ++-
 Documentation/features/debug/kcov/arch-support.txt             | 1 +
 Documentation/features/debug/kgdb/arch-support.txt             | 1 +
 Documentation/features/debug/kmemleak/arch-support.txt         | 1 +
 .../features/debug/kprobes-on-ftrace/arch-support.txt          | 1 +
 Documentation/features/debug/kprobes/arch-support.txt          | 1 +
 Documentation/features/debug/kretprobes/arch-support.txt       | 1 +
 Documentation/features/debug/optprobes/arch-support.txt        | 1 +
 Documentation/features/debug/stackprotector/arch-support.txt   | 1 +
 Documentation/features/debug/uprobes/arch-support.txt          | 1 +
 .../features/debug/user-ret-profiler/arch-support.txt          | 1 +
 Documentation/features/io/dma-contiguous/arch-support.txt      | 1 +
 Documentation/features/locking/cmpxchg-local/arch-support.txt  | 1 +
 Documentation/features/locking/lockdep/arch-support.txt        | 1 +
 Documentation/features/locking/queued-rwlocks/arch-support.txt | 3 ++-
 .../features/locking/queued-spinlocks/arch-support.txt         | 1 +
 Documentation/features/perf/kprobes-event/arch-support.txt     | 3 ++-
 Documentation/features/perf/perf-regs/arch-support.txt         | 1 +
 Documentation/features/perf/perf-stackdump/arch-support.txt    | 1 +
 .../features/sched/membarrier-sync-core/arch-support.txt       | 1 +
 Documentation/features/sched/numa-balancing/arch-support.txt   | 1 +
 Documentation/features/seccomp/seccomp-filter/arch-support.txt | 1 +
 .../features/time/arch-tick-broadcast/arch-support.txt         | 1 +
 Documentation/features/time/clockevents/arch-support.txt       | 1 +
 Documentation/features/time/context-tracking/arch-support.txt  | 1 +
 Documentation/features/time/irq-time-acct/arch-support.txt     | 1 +
 Documentation/features/time/virt-cpuacct/arch-support.txt      | 1 +
 Documentation/features/vm/ELF-ASLR/arch-support.txt            | 1 +
 Documentation/features/vm/PG_uncached/arch-support.txt         | 1 +
 Documentation/features/vm/THP/arch-support.txt                 | 1 +
 Documentation/features/vm/TLB/arch-support.txt                 | 1 +
 Documentation/features/vm/huge-vmap/arch-support.txt           | 1 +
 Documentation/features/vm/ioremap_prot/arch-support.txt        | 1 +
 Documentation/features/vm/pte_special/arch-support.txt         | 3 ++-
 42 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index 10482dee8703..a053667a7a8c 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index bcefb5afc7d6..c0bb9c92937f 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index d80d99449ac1..c9bfff292816 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 53eab154925d..35e2a44b1448 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
index 94926451afb9..9b3e2ce12b44 100644
--- a/Documentation/features/core/thread-info-in-task/arch-support.txt
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index b4274b8141b6..9c7ffec5d51d 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index c15bb4b21b6f..2fd5fb6f5f23 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 4c31fc92a312..c45711e55c7b 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -13,12 +13,13 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index d7a5ac4bc1fe..502c1d409648 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
@@ -24,7 +25,7 @@
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: | TODO |
-    |          um: | TODO |
+    |          um: |  ok  |
     |         x86: |  ok  |
     |      xtensa: | TODO |
     -----------------------
diff --git a/Documentation/features/debug/kcov/arch-support.txt b/Documentation/features/debug/kcov/arch-support.txt
index 136e14c2b603..afb90bebded2 100644
--- a/Documentation/features/debug/kcov/arch-support.txt
+++ b/Documentation/features/debug/kcov/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 5b3f3d8ae462..04120d278c22 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/kmemleak/arch-support.txt b/Documentation/features/debug/kmemleak/arch-support.txt
index 7a2eab4fdf9d..e487c356ab20 100644
--- a/Documentation/features/debug/kmemleak/arch-support.txt
+++ b/Documentation/features/debug/kmemleak/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index db02ab194138..b3697f4c806e 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index ec186e7deebc..452385ac9e06 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 4b7865e693f6..daecf046e72b 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 5d9befa041c7..adb1bd055bfd 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index d97fd38460e6..ddcd7161d14c 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index d30e3475904e..25121200f9f9 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 9ae1fa2eb27c..f2fcff8e77b7 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 9e09988eb654..95e485c87e36 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 5c4ec316dbac..8b1a8d9e1c79 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index 65007c1ac44f..ab69e8f56a37 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 20056670fb09..0bfb72a08d82 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -20,7 +21,7 @@
     |    openrisc: |  ok  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 707514faac7b..d2f2201febc8 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 9f31ce9b9f2a..0d0647b06762 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -7,12 +7,13 @@
     |         arch |status|
     -----------------------
     |       alpha: | TODO |
-    |         arc: | TODO |
+    |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index f148c4329c7a..13c297bbf05c 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 32c88b6a910c..931687eec671 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index d82a1f0cdc91..336d728b8a45 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -36,6 +36,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 2687564e5fa8..76d012118372 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index 1b4109199e9d..a86b8b1f3d10 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 27327256bd05..364169f00ee2 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index b9a4bda2c8f5..6ea274790e47 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 4aa51c9fa32b..c9e0a16290e6 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 0306ece41faa..fd17d8de5ef1 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ..  |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 5d64e40c0092..1a859ac05e9e 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 92c9db24a6a3..b1229953391b 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 7424fea37614..02f325fbfcd0 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 60985067626b..9bfff977ef55 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: |  ok  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index f2dcbec6020e..039e4e91ada3 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 680090df03e1..13b4940e0c3a 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 205a90e82050..b01bf7bca3e6 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -13,6 +13,7 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 9f16d6e4e11e..fc3687b5e89b 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -13,12 +13,13 @@
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
+    |       loong: |  ok  |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: |  ok  |
     |        s390: |  ok  |
-- 
2.20.1

