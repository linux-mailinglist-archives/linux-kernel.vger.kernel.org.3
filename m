Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2558D4D2EFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiCIMXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCIMXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:23:15 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F6175842;
        Wed,  9 Mar 2022 04:22:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s8so2098958pfk.12;
        Wed, 09 Mar 2022 04:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtP3MmHlfM0UWRqX9xS0r9OrfmBJefLXJOynKbTEDFc=;
        b=XvN9rWv6kISbzWBgCwDBrVb3Lh+T8mEgY95OJ2wgPPqPuqf0uBZ6fyirAD5MIrmvpr
         CNRM6czOQnKQo3JqNmItkTuaPjP/wKGikLK8qA1no3AozxOPu/ZitGEuVGO7OOS7X8qL
         ReVgxYEbA0IKEQtSNzrRgz556QJm+5nJgAodqUb+sTwisikUme3RwYL8VBD8D6jP+tsu
         USf5J0ImxHNdSJg41k6J6XkUcDi7UbUs4zlFsrdDcg7QlSf/brdjMA6daDmbgr4k7RRC
         ascN49puEvnbw5bxUx6fzrtlqIOmjJ2GcsVu8J+nYrWycp+cnln/mRf5w7rhN/xDpcDH
         u/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JtP3MmHlfM0UWRqX9xS0r9OrfmBJefLXJOynKbTEDFc=;
        b=XksN8Jdc5BndAi31UNIIrhEvvUFYJLkeV4LszTq3tYliO4lfYUOLmGCcVykkSlcBm3
         omSPixAogA3UtqgB8jhFlTQLSGTo1BdKi1+U0dLi3NDJvTJLEWSvAEaGSALaP1v7x8uh
         ruugyzGJwY/5bM13Wnq80sVgX5zNXcCj/KVugkmIVJlgF9r2JlTf1unPBFnuFw69YMVF
         CGFFUXbjeUsuKTrtjeZH4pEqr+6axacbwAeaLexYknDsZ+guUus40q3mjSXTjIAyh64Q
         c/P9RP0BfiejNwt39U0/DTem1jg9uh/nUHxBxbBrGJvUSLJXhXfeeE33Nhj+izUdONWQ
         ytmQ==
X-Gm-Message-State: AOAM530BTbal84AhVUc5wjXM+DbVL9MkPwZVEbio4md5JdWW9VPjNr0P
        JM9rh2o9YF2+Jn8MX8bWkpQ=
X-Google-Smtp-Source: ABdhPJzlNd1LIscOYrhwZDPrzIKRSe1wkRn37tBJsX+6jGpwYe3nLpIuIPmg2KbPIwG2y/qhjQ7pNQ==
X-Received: by 2002:a63:1060:0:b0:374:6edc:7cfc with SMTP id 32-20020a631060000000b003746edc7cfcmr17949406pgq.500.1646828533574;
        Wed, 09 Mar 2022 04:22:13 -0800 (PST)
Received: from localhost.localdomain ([2001:288:7001:2708:32a7:e3ac:97bc:3aee])
        by smtp.gmail.com with ESMTPSA id f7-20020a056a0022c700b004e11d3d0459sm3035968pfj.65.2022.03.09.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:22:13 -0800 (PST)
From:   Jui-Tse Huang <juitse.huang@gmail.com>
To:     corbet@lwn.net, peterz@infradead.org, valentin.schneider@arm.com,
        daniel.m.jordan@oracle.com, siyanteng01@gmail.com,
        song.bao.hua@hisilicon.com, henrybear327@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jserv@ccns.ncku.edu.tw, Jui-Tse Huang <juitse.huang@gmail.com>
Subject: [PATCH 1/1] Rewrite mathematical expressions
Date:   Wed,  9 Mar 2022 20:22:06 +0800
Message-Id: <20220309122206.37497-1-juitse.huang@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  There are lots of mathematical expressions in the documentation
which are written in plain text format, which costs reader more time to
recognize the expressions. If those expressions are written in LaTeX
format which is supported as an extension of Sphinx, the expressions
might become prettier as well as more straight forward to reader.

  The mathematical expressions in the documentations under
Documentation/scheduler directory are all modified to take the benifits
of LaTeX format. The change remains the context of documentations
unchanged, but provides a more clear rendering results to reader.

Signed-off-by: Jui-Tse Huang <juitse.huang@gmail.com>
---
 Documentation/scheduler/sched-bwc.rst      |  51 ++--
 Documentation/scheduler/sched-capacity.rst |  80 +++---
 Documentation/scheduler/sched-deadline.rst | 318 +++++++++++----------
 Documentation/scheduler/sched-energy.rst   |  34 +--
 Documentation/scheduler/sched-rt-group.rst |  18 +-
 5 files changed, 274 insertions(+), 227 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index f166b182ff95..3866ddce6661 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -29,35 +29,36 @@ increased interference against the other system users. All nicely bounded.
 
 Traditional (UP-EDF) bandwidth control is something like:
 
-  (U = \Sum u_i) <= 1
+.. math::
+  (U = \sum_{i} u_i) \leq 1
 
 This guaranteeds both that every deadline is met and that the system is
-stable. After all, if U were > 1, then for every second of walltime,
+stable. After all, if :math:`U > 1`, then for every second of walltime,
 we'd have to run more than a second of program time, and obviously miss
 our deadline, but the next deadline will be further out still, there is
 never time to catch up, unbounded fail.
 
 The burst feature observes that a workload doesn't always executes the full
-quota; this enables one to describe u_i as a statistical distribution.
-
-For example, have u_i = {x,e}_i, where x is the p(95) and x+e p(100)
-(the traditional WCET). This effectively allows u to be smaller,
-increasing the efficiency (we can pack more tasks in the system), but at
-the cost of missing deadlines when all the odds line up. However, it
-does maintain stability, since every overrun must be paired with an
-underrun as long as our x is above the average.
-
-That is, suppose we have 2 tasks, both specify a p(95) value, then we
-have a p(95)*p(95) = 90.25% chance both tasks are within their quota and
-everything is good. At the same time we have a p(5)p(5) = 0.25% chance
-both tasks will exceed their quota at the same time (guaranteed deadline
-fail). Somewhere in between there's a threshold where one exceeds and
-the other doesn't underrun enough to compensate; this depends on the
-specific CDFs.
+quota; this enables one to describe :math:`u_i` as a statistical distribution.
+
+For example, have :math:`u_i = \{x,e\}_i`, where :math:`x` is the :math:`p(95)`
+and :math:`x+e` is :math:`p(100)` (the traditional WCET). This effectively
+allows :math:`u` to be smaller, increasing the efficiency (we can pack more
+tasks in the system), but at the cost of missing deadlines when all the odds
+line up. However, it does maintain stability, since every overrun must be paired
+with an underrun as long as our :math:`x` is above the average.
+
+That is, suppose we have 2 tasks, both specify a :math:`p(95)` value, then we
+have a :math:`p(95) \times p(95) = 90.25\%` chance both tasks are within their
+quota and everything is good. At the same time we have a
+:math:`p(5) \times p(5) = 0.25\%` chance both tasks will exceed their quota at
+the same time (guaranteed deadline fail). Somewhere in between there's a
+threshold where one exceeds and the other doesn't underrun enough to compensate;
+this depends on the specific CDFs.
 
 At the same time, we can say that the worst case deadline miss, will be
-\Sum e_i; that is, there is a bounded tardiness (under the assumption
-that x+e is indeed WCET).
+:math:`\sum_{i} e_i`; that is, there is a bounded tardiness (under the
+assumption that :math:`x+e` is indeed WCET).
 
 The interferenece when using burst is valued by the possibilities for
 missing the deadline and the average WCET. Test results showed that when
@@ -141,13 +142,13 @@ This interface is read-only.
 Hierarchical considerations
 ---------------------------
 The interface enforces that an individual entity's bandwidth is always
-attainable, that is: max(c_i) <= C. However, over-subscription in the
-aggregate case is explicitly allowed to enable work-conserving semantics
-within a hierarchy:
+attainable, that is: :math:`max(c_i) \leq C`. However, over-subscription in the
+aggregate case is explicitly allowed to enable work-conserving semantics within
+a hierarchy:
 
-  e.g. \Sum (c_i) may exceed C
+  e.g. :math:`\sum_{i} c_i` may exceed :math:`C`
 
-[ Where C is the parent's bandwidth, and c_i its children ]
+[ Where :math:`C` is the parent's bandwidth, and :math:`c_i` its children ]
 
 
 There are two ways in which a group may become throttled:
diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 805f85f330b5..c5bffebc5c1c 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -31,9 +31,10 @@ can.
 
 CPU performance is usually expressed in Millions of Instructions Per Second
 (MIPS), which can also be expressed as a given amount of instructions attainable
-per Hz, leading to::
+per Hz, leading to:
 
-  capacity(cpu) = work_per_hz(cpu) * max_freq(cpu)
+.. math::
+  \text{capacity(cpu)} = \text{work\_per\_hz(cpu)} \times \text{max\_freq(cpu)}
 
 1.2 Scheduler terms
 -------------------
@@ -57,14 +58,14 @@ brevity.
 
 Consider an hypothetical dual-core asymmetric CPU capacity system where
 
-- work_per_hz(CPU0) = W
-- work_per_hz(CPU1) = W/2
+- work_per_hz(CPU0) = :math:`W`
+- work_per_hz(CPU1) = :math:`\frac{W}{2}`
 - all CPUs are running at the same fixed frequency
 
 By the above definition of capacity:
 
-- capacity(CPU0) = C
-- capacity(CPU1) = C/2
+- capacity(CPU0) = :math:`C`
+- capacity(CPU1) = :math:`\frac{C}{2}`
 
 To draw the parallel with Arm big.LITTLE, CPU0 would be a big while CPU1 would
 be a LITTLE.
@@ -84,7 +85,7 @@ execution trace like so::
 
 CPU0 has the highest capacity in the system (C), and completes a fixed amount of
 work W in T units of time. On the other hand, CPU1 has half the capacity of
-CPU0, and thus only completes W/2 in T.
+CPU0, and thus only completes :math:`\frac{W}{2}` in :math:`T`.
 
 1.3.2 Different max OPPs
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -92,13 +93,13 @@ CPU0, and thus only completes W/2 in T.
 Usually, CPUs of different capacity values also have different maximum
 OPPs. Consider the same CPUs as above (i.e. same work_per_hz()) with:
 
-- max_freq(CPU0) = F
-- max_freq(CPU1) = 2/3 * F
+- max_freq(CPU0) = :math:`F`
+- max_freq(CPU1) = :math:`\frac{2}{3} \times F`
 
 This yields:
 
-- capacity(CPU0) = C
-- capacity(CPU1) = C/3
+- capacity(CPU0) = :math:`C`
+- capacity(CPU1) = :math:`\frac{C}{3}`
 
 Executing the same workload as described in 1.3.1, which each CPU running at its
 maximum frequency results in::
@@ -135,9 +136,10 @@ while task utilization is specific to CFS, it is convenient to describe it here
 in order to introduce more generic concepts.
 
 Task utilization is a percentage meant to represent the throughput requirements
-of a task. A simple approximation of it is the task's duty cycle, i.e.::
+of a task. A simple approximation of it is the task's duty cycle, i.e.:
 
-  task_util(p) = duty_cycle(p)
+.. math::
+  \text{task\_util(p)} = \text{duty\_cycle(p)}
 
 On an SMP system with fixed frequencies, 100% utilization suggests the task is a
 busy loop. Conversely, 10% utilization hints it is a small periodic task that
@@ -150,7 +152,7 @@ expand on these.
 
 One issue that needs to be taken into account is that a workload's duty cycle is
 directly impacted by the current OPP the CPU is running at. Consider running a
-periodic workload at a given frequency F::
+periodic workload at a given frequency :math:`F`::
 
   CPU work ^
            |     ____                ____                ____
@@ -159,7 +161,7 @@ periodic workload at a given frequency F::
 
 This yields duty_cycle(p) == 25%.
 
-Now, consider running the *same* workload at frequency F/2::
+Now, consider running the *same* workload at frequency :math:`\frac{F}{2}`::
 
   CPU work ^
            |     _________           _________           ____
@@ -170,9 +172,12 @@ This yields duty_cycle(p) == 50%, despite the task having the exact same
 behaviour (i.e. executing the same amount of work) in both executions.
 
 The task utilization signal can be made frequency invariant using the following
-formula::
+formula:
 
-  task_util_freq_inv(p) = duty_cycle(p) * (curr_frequency(cpu) / max_frequency(cpu))
+.. math::
+  \text{task\_util\_freq\_inv(p)} =
+  \text{duty\_cycle(p)} \times
+  \frac{\text{curr\_frequency(cpu)}}{\text{max\_frequency(cpu)}}
 
 Applying this formula to the two examples above yields a frequency invariant
 task utilization of 25%.
@@ -208,9 +213,12 @@ IOW,
 - duty_cycle(p) == 75% if p runs on CPU1 at its maximum frequency
 
 The task utilization signal can be made CPU invariant using the following
-formula::
+formula:
 
-  task_util_cpu_inv(p) = duty_cycle(p) * (capacity(cpu) / max_capacity)
+.. math::
+  \text{task\_util\_cpu\_inv(p)} =
+  \text{duty\_cycle(p)} \times
+  \frac{\text{capacity(cpu)}}{\text{max\_capacity}}
 
 with ``max_capacity`` being the highest CPU capacity value in the
 system. Applying this formula to the above example above yields a CPU
@@ -222,11 +230,13 @@ invariant task utilization of 25%.
 Both frequency and CPU invariance need to be applied to task utilization in
 order to obtain a truly invariant signal. The pseudo-formula for a task
 utilization that is both CPU and frequency invariant is thus, for a given
-task p::
+task p:
 
-                                     curr_frequency(cpu)   capacity(cpu)
-  task_util_inv(p) = duty_cycle(p) * ------------------- * -------------
-                                     max_frequency(cpu)    max_capacity
+.. math::
+  \text{task\_util\_inv(p)} =
+  \text{duty\_cycle(p)} \times
+  \frac{\text{curr\_frequency(cpu)}}{\text{max\_frequency(cpu)}} \times
+  \frac{\text{capacity(cpu)}}{\text{max\_capacity}}
 
 In other words, invariant task utilization describes the behaviour of a task as
 if it were running on the highest-capacity CPU in the system, running at its
@@ -336,9 +346,10 @@ asymmetric CPU capacities is to:
 5.1.1 Capacity fitness
 ~~~~~~~~~~~~~~~~~~~~~~
 
-The main capacity scheduling criterion of CFS is::
+The main capacity scheduling criterion of CFS is:
 
-  task_util(p) < capacity(task_cpu(p))
+.. math::
+  \text{task\_util(p)} < \text{capacity(task\_cpu(p))}
 
 This is commonly called the capacity fitness criterion, i.e. CFS must ensure a
 task "fits" on its CPU. If it is violated, the task will need to achieve more
@@ -355,9 +366,11 @@ clamp task_util() in the previous criterion.
 CFS task wakeup CPU selection follows the capacity fitness criterion described
 above. On top of that, uclamp is used to clamp the task utilization values,
 which lets userspace have more leverage over the CPU selection of CFS
-tasks. IOW, CFS wakeup CPU selection searches for a CPU that satisfies::
+tasks. IOW, CFS wakeup CPU selection searches for a CPU that satisfies:
 
-  clamp(task_util(p), task_uclamp_min(p), task_uclamp_max(p)) < capacity(cpu)
+.. math::
+  \text{clamp(task\_util(p), task\_uclamp\_min(p), task\_uclamp\_max(p))} <
+  \text{capacity(cpu)}
 
 By using uclamp, userspace can e.g. allow a busy loop (100% utilization) to run
 on any CPU by giving it a low uclamp.max value. Conversely, it can force a small
@@ -401,7 +414,8 @@ This workload should run on CPU0, but if the task either:
 - was properly scheduled from the start, but suddenly needs more
   processing power
 
-then it might become CPU-bound, IOW ``task_util(p) > capacity(task_cpu(p))``;
+then it might become CPU-bound, IOW
+:math:`\text{task\_util(p)} > \text{capacity(task\_cpu(p))}`;
 the CPU capacity scheduling criterion is violated, and there may not be any more
 wakeup event to fix this up via wakeup CPU selection.
 
@@ -418,9 +432,10 @@ to a CPU with more capacity than its current one.
 5.2.1 Wakeup CPU selection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-RT task wakeup CPU selection searches for a CPU that satisfies::
+RT task wakeup CPU selection searches for a CPU that satisfies:
 
-  task_uclamp_min(p) <= capacity(task_cpu(cpu))
+.. math::
+  \text{task\_uclamp\_min(p)} \leq \text{capacity(task\_cpu(cpu))}
 
 while still following the usual priority constraints. If none of the candidate
 CPUs can satisfy this capacity criterion, then strict priority based scheduling
@@ -432,9 +447,10 @@ is followed and CPU capacities are ignored.
 5.3.1 Wakeup CPU selection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-DL task wakeup CPU selection searches for a CPU that satisfies::
+DL task wakeup CPU selection searches for a CPU that satisfies:
 
-  task_bandwidth(p) < capacity(task_cpu(p))
+.. math::
+  \text{task\_bandwidth(p)} < \text{capacity(task\_cpu(p))}
 
 while still respecting the usual bandwidth and deadline constraints. If
 none of the candidate CPUs can satisfy this capacity criterion, then the
diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9d9be52f221a..3cc1d6a7cfcd 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -80,11 +80,12 @@ Deadline Task Scheduling
     a "remaining runtime". These two parameters are initially set to 0;
 
   - When a SCHED_DEADLINE task wakes up (becomes ready for execution),
-    the scheduler checks if::
+    the scheduler checks if:
 
-                 remaining runtime                  runtime
-        ----------------------------------    >    ---------
-        scheduling deadline - current time           period
+    .. math::
+      \frac{\text{remaining runtime}}
+           {\text{scheduleing deadline} - \text{current time}} >
+      \frac{\text{runtime}}{\text{period}}
 
     then, if the scheduling deadline is smaller than the current time, or
     this condition is verified, the scheduling deadline and the
@@ -168,11 +169,11 @@ Deadline Task Scheduling
       breaking the real-time guarantees.
 
       The 0-lag time for a task entering the ActiveNonContending state is
-      computed as::
+      computed as:
 
-                        (runtime * dl_period)
-             deadline - ---------------------
-                             dl_runtime
+      .. math::
+        \text{deadline} -
+        \frac{\text{runtime} \times \text{dl\_period}}{\text{dl\_runtime}}
 
       where runtime is the remaining runtime, while dl_runtime and dl_period
       are the reservation parameters.
@@ -208,21 +209,24 @@ Deadline Task Scheduling
  It does so by decrementing the runtime of the executing task Ti at a pace equal
  to
 
-           dq = -max{ Ui / Umax, (1 - Uinact - Uextra) } dt
+ .. math::
+   \Delta q =
+   -max(\frac{U_i}{U_{max}}, (1 - U_{inact} - U{extra})) \cdot
+   \Delta t
 
  where:
 
-  - Ui is the bandwidth of task Ti;
-  - Umax is the maximum reclaimable utilization (subjected to RT throttling
-    limits);
-  - Uinact is the (per runqueue) inactive utilization, computed as
+  - :math:`U_i` is the bandwidth of task :math:`T_i`;
+  - :math:`U_{max}` is the maximum reclaimable utilization (subjected to RT
+    throttling limits);
+  - :math:`U_{inact}` is the (per runqueue) inactive utilization, computed as
     (this_bq - running_bw);
-  - Uextra is the (per runqueue) extra reclaimable utilization
+  - :math:`U_{extra}` is the (per runqueue) extra reclaimable utilization
     (subjected to RT throttling limits).
 
 
- Let's now see a trivial example of two deadline tasks with runtime equal
- to 4 and period equal to 8 (i.e., bandwidth equal to 0.5)::
+  Let's now see a trivial example of two deadline tasks with runtime equal
+  to 4 and period equal to 8 (i.e., bandwidth equal to 0.5)::
 
          A            Task T1
          |
@@ -254,33 +258,35 @@ Deadline Task Scheduling
          0   1   2   3   4   5   6   7   8
 
 
-  - Time t = 0:
+  - Time :math:`t = 0`:
 
     Both tasks are ready for execution and therefore in ActiveContending state.
-    Suppose Task T1 is the first task to start execution.
-    Since there are no inactive tasks, its runtime is decreased as dq = -1 dt.
+    Suppose Task :math:`T_1` is the first task to start execution.
+    Since there are no inactive tasks, its runtime is decreased as
+    :math:`\Delta q = -1 \cdot \Delta t`.
 
-  - Time t = 2:
+  - Time :math:`t = 2`:
 
-    Suppose that task T1 blocks
-    Task T1 therefore enters the ActiveNonContending state. Since its remaining
-    runtime is equal to 2, its 0-lag time is equal to t = 4.
-    Task T2 start execution, with runtime still decreased as dq = -1 dt since
-    there are no inactive tasks.
+    Suppose that task :math:`T_1` blocks
+    Task :math:`T_1` therefore enters the ActiveNonContending state. Since its
+    remaining runtime is equal to 2, its 0-lag time is equal to :math:`t = 4`.
+    Task :math:`T_2` start execution, with runtime still decreased as
+    :math:`\Delta q = -1 \cdot \Delta t` since there are no inactive tasks.
 
-  - Time t = 4:
+  - Time :math:`t = 4`:
 
-    This is the 0-lag time for Task T1. Since it didn't woken up in the
+    This is the 0-lag time for Task :math:`T_1`. Since it didn't woken up in the
     meantime, it enters the Inactive state. Its bandwidth is removed from
     running_bw.
-    Task T2 continues its execution. However, its runtime is now decreased as
-    dq = - 0.5 dt because Uinact = 0.5.
-    Task T2 therefore reclaims the bandwidth unused by Task T1.
+    Task :math:`T_2` continues its execution. However, its runtime is now
+    decreased as :math:`\Delta q = -0.5 \cdot \Delta t` because
+    :math:`U_{inact} = 0.5`. Task :math:`T_2` therefore reclaims the bandwidth
+    unused by Task :math:`T_1`.
 
-  - Time t = 8:
+  - Time :math:`t = 8`:
 
-    Task T1 wakes up. It enters the ActiveContending state again, and the
-    running_bw is incremented.
+    Task :math:`T_1` wakes up. It enters the ActiveContending state again, and
+    the running_bw is incremented.
 
 
 2.3 Energy-aware scheduling
@@ -325,140 +331,157 @@ Deadline Task Scheduling
  A typical real-time task is composed of a repetition of computation phases
  (task instances, or jobs) which are activated on a periodic or sporadic
  fashion.
- Each job J_j (where J_j is the j^th job of the task) is characterized by an
- arrival time r_j (the time when the job starts), an amount of computation
- time c_j needed to finish the job, and a job absolute deadline d_j, which
- is the time within which the job should be finished. The maximum execution
- time max{c_j} is called "Worst Case Execution Time" (WCET) for the task.
- A real-time task can be periodic with period P if r_{j+1} = r_j + P, or
- sporadic with minimum inter-arrival time P is r_{j+1} >= r_j + P. Finally,
- d_j = r_j + D, where D is the task's relative deadline.
+ Each job :math:`J_j` (where :math:`J_j` is the :math:`j^{th}` job of the task)
+ is characterized by an arrival time :math:`r_j` (the time when the job starts),
+ an amount of computation time :math:`c_j` needed to finish the job, and a job
+ absolute deadline :math:`d_j`, which is the time within which the job should be
+ finished. The maximum execution time :math:`max(c_j)` is called "Worst Case
+ Execution Time" (WCET) for the task. A real-time task can be periodic with
+ period :math:`P` if :math:`r_{j+1} = r_j + P`, or sporadic with minimum
+ inter-arrival time :math:`P` is :math:`r_{j+1} \geq r_j + P`. Finally,
+ :math:`d_j = r_j + D`, where :math:`D` is the task's relative deadline.
  Summing up, a real-time task can be described as
 
-	Task = (WCET, D, P)
+ .. math::
+   \text{Task} = (\text{WCET}, D, P)
 
  The utilization of a real-time task is defined as the ratio between its
  WCET and its period (or minimum inter-arrival time), and represents
  the fraction of CPU time needed to execute the task.
 
- If the total utilization U=sum(WCET_i/P_i) is larger than M (with M equal
- to the number of CPUs), then the scheduler is unable to respect all the
- deadlines.
+ If the total utilization :math:`U = \sum_{i} (\text{WCET}_i / P_i)` is
+ larger than :math:`M` (with :math:`M` equal to the number of CPUs), then the
+ scheduler is unable to respect all the deadlines.
  Note that total utilization is defined as the sum of the utilizations
- WCET_i/P_i over all the real-time tasks in the system. When considering
- multiple real-time tasks, the parameters of the i-th task are indicated
- with the "_i" suffix.
- Moreover, if the total utilization is larger than M, then we risk starving
- non- real-time tasks by real-time tasks.
- If, instead, the total utilization is smaller than M, then non real-time
- tasks will not be starved and the system might be able to respect all the
- deadlines.
+ :math:`(\text{WCET}_i / P_i)` over all the real-time tasks in the system.
+ When considering multiple real-time tasks, the parameters of the :math:`i^{th}`
+ task are indicated with the :math:`i` suffix.
+ Moreover, if the total utilization is larger than :math:`M`, then we risk
+ starving non-real-time tasks by real-time tasks.
+ If, instead, the total utilization is smaller than :math:`M`, then non
+ real-time tasks will not be starved and the system might be able to respect
+ all the deadlines.
  As a matter of fact, in this case it is possible to provide an upper bound
  for tardiness (defined as the maximum between 0 and the difference
  between the finishing time of a job and its absolute deadline).
  More precisely, it can be proven that using a global EDF scheduler the
  maximum tardiness of each task is smaller or equal than
 
-	((M − 1) · WCET_max − WCET_min)/(M − (M − 2) · U_max) + WCET_max
+ .. math::
+   \frac{(M - 1) \cdot \text{WCET}_{max} - \text{WCET}_{min}}
+        {M - (M - 2) \cdot U_{max}} +
+   \text{WCET}_{max}
 
- where WCET_max = max{WCET_i} is the maximum WCET, WCET_min=min{WCET_i}
- is the minimum WCET, and U_max = max{WCET_i/P_i} is the maximum
+ where :math:`\text{WCET}_{max} = max(\text{WCET}_i)` is the maximum WCET,
+ :math:`\text{WCET}_{min} = min(\text{WCET}_i)` is the minimum WCET, and
+ :math:`U_{max} = max(\text{WCET}_i / P_i)` is the maximum
  utilization[12].
 
 3.2 Schedulability Analysis for Uniprocessor Systems
 ----------------------------------------------------
 
- If M=1 (uniprocessor system), or in case of partitioned scheduling (each
- real-time task is statically assigned to one and only one CPU), it is
- possible to formally check if all the deadlines are respected.
- If D_i = P_i for all tasks, then EDF is able to respect all the deadlines
+ If :math:`M = 1` (uniprocessor system), or in case of partitioned scheduling
+ (each real-time task is statically assigned to one and only one CPU), it is
+ possible to formally check if all the deadlines are respected. If
+ :math:`D_i = P_i` for all tasks, then EDF is able to respect all the deadlines
  of all the tasks executing on a CPU if and only if the total utilization
  of the tasks running on such a CPU is smaller or equal than 1.
- If D_i != P_i for some task, then it is possible to define the density of
- a task as WCET_i/min{D_i,P_i}, and EDF is able to respect all the deadlines
- of all the tasks running on a CPU if the sum of the densities of the tasks
- running on such a CPU is smaller or equal than 1:
+ If :math:`D_i \neq P_i` for some task, then it is possible to define the
+ density of a task as :math:`(\text{WCET}_i / min(D_i,P_i))`, and EDF is
+ able to respect all the deadlines of all the tasks running on a CPU if the sum
+ of the densities of the tasks running on such a CPU is smaller or equal than 1:
 
-	sum(WCET_i / min{D_i, P_i}) <= 1
+ .. math::
+   \sum_{i} \frac{\text{WCET}_i}{min(D_i, P_i)} \leq 1
 
  It is important to notice that this condition is only sufficient, and not
  necessary: there are task sets that are schedulable, but do not respect the
- condition. For example, consider the task set {Task_1,Task_2} composed by
- Task_1=(50ms,50ms,100ms) and Task_2=(10ms,100ms,100ms).
- EDF is clearly able to schedule the two tasks without missing any deadline
- (Task_1 is scheduled as soon as it is released, and finishes just in time
- to respect its deadline; Task_2 is scheduled immediately after Task_1, hence
- its response time cannot be larger than 50ms + 10ms = 60ms) even if
-
-	50 / min{50,100} + 10 / min{100, 100} = 50 / 50 + 10 / 100 = 1.1
+ condition. For example, consider the task set
+ :math:`\{\text{Task}_1, \text{Task}_2\}` composed by
+ :math:`\text{Task}_1 = (50ms, 50ms, 100ms)` and
+ :math:`\text{Task}_2 = (10ms, 100ms, 100ms)`. EDF is clearly able to schedule
+ the two tasks without missing any deadline (:math:`\text{Task}_1` is scheduled
+ as soon as it is released, and finishes just in time to respect its deadline;
+ :math:`\text{Task}_2` is scheduled immediately after :math:`\text{Task}_1`,
+ hence its response time cannot be larger than :math:`50ms + 10ms = 60ms`) even
+ if
+
+ .. math::
+   \frac{50}{min(50, 100)} + \frac{10}{min(100, 100)} =
+   \frac{50}{50} + \frac{10}{100} = 1.1
 
  Of course it is possible to test the exact schedulability of tasks with
- D_i != P_i (checking a condition that is both sufficient and necessary),
- but this cannot be done by comparing the total utilization or density with
- a constant. Instead, the so called "processor demand" approach can be used,
- computing the total amount of CPU time h(t) needed by all the tasks to
- respect all of their deadlines in a time interval of size t, and comparing
- such a time with the interval size t. If h(t) is smaller than t (that is,
- the amount of time needed by the tasks in a time interval of size t is
- smaller than the size of the interval) for all the possible values of t, then
- EDF is able to schedule the tasks respecting all of their deadlines. Since
- performing this check for all possible values of t is impossible, it has been
- proven[4,5,6] that it is sufficient to perform the test for values of t
- between 0 and a maximum value L. The cited papers contain all of the
- mathematical details and explain how to compute h(t) and L.
- In any case, this kind of analysis is too complex as well as too
- time-consuming to be performed on-line. Hence, as explained in Section
- 4 Linux uses an admission test based on the tasks' utilizations.
+ :math:`D_i \neq P_i` (checking a condition that is both sufficient and
+ necessary), but this cannot be done by comparing the total utilization or
+ density with a constant. Instead, the so called "processor demand" approach can
+ be used, computing the total amount of CPU time :math:`h(t)` needed by all the
+ tasks to respect all of their deadlines in a time interval of size :math:`t`,
+ and comparing such a time with the interval size :math:`t`. If :math:`h(t)` is
+ smaller than :math:`t` (that is, the amount of time needed by the tasks in a
+ time interval of size :math:`t` is smaller than the size of the interval) for
+ all the possible values of :math:`t`, then EDF is able to schedule the tasks
+ respecting all of their deadlines. Since performing this check for all possible
+ values of t is impossible, it has been proven[4,5,6] that it is sufficient to
+ perform the test for values of :math:`t` between 0 and a maximum value
+ :math:`L`. The cited papers contain all of the mathematical details and explain
+ how to compute :math:`h(t)` and :math:`L`. In any case, this kind of analysis
+ is too complex as well as too time-consuming to be performed on-line. Hence, as
+ explained in Section 4 Linux uses an admission test based on the tasks'
+ utilizations.
 
 3.3 Schedulability Analysis for Multiprocessor Systems
 ------------------------------------------------------
 
- On multiprocessor systems with global EDF scheduling (non partitioned
- systems), a sufficient test for schedulability can not be based on the
- utilizations or densities: it can be shown that even if D_i = P_i task
- sets with utilizations slightly larger than 1 can miss deadlines regardless
- of the number of CPUs.
-
- Consider a set {Task_1,...Task_{M+1}} of M+1 tasks on a system with M
- CPUs, with the first task Task_1=(P,P,P) having period, relative deadline
- and WCET equal to P. The remaining M tasks Task_i=(e,P-1,P-1) have an
- arbitrarily small worst case execution time (indicated as "e" here) and a
- period smaller than the one of the first task. Hence, if all the tasks
- activate at the same time t, global EDF schedules these M tasks first
- (because their absolute deadlines are equal to t + P - 1, hence they are
- smaller than the absolute deadline of Task_1, which is t + P). As a
- result, Task_1 can be scheduled only at time t + e, and will finish at
- time t + e + P, after its absolute deadline. The total utilization of the
- task set is U = M · e / (P - 1) + P / P = M · e / (P - 1) + 1, and for small
- values of e this can become very close to 1. This is known as "Dhall's
- effect"[7]. Note: the example in the original paper by Dhall has been
+ On multiprocessor systems with global EDF scheduling (non partitioned systems),
+ a sufficient test for schedulability can not be based on the utilizations or
+ densities: it can be shown that even if :math:`D_i = P_i` task sets with
+ utilizations slightly larger than 1 can miss deadlines regardless of the number
+ of CPUs.
+
+ Consider a set :math:`\{\text{Task}_1, ...\text{Task}_{M+1}\}` of :math:`M + 1`
+ tasks on a system with :math:`M` CPUs, with the first task
+ :math:`\text{Task}_1 = (P, P, P)` having period, relative deadline and
+ :math:`\text{WCET}` equal to :math:`P`. The remaining :math:`M` tasks
+ :math:`\text{Task}_i = (e, P - 1, P - 1)` have an arbitrarily small worst case
+ execution time (indicated as "e" here) and a period smaller than the one of the
+ first task. Hence, if all the tasks activate at the same time :math:`t`, global
+ EDF schedules these :math:`M` tasks first (because their absolute deadlines are
+ equal to :math:`t + P - 1`, hence they are smaller than the absolute deadline
+ of :math:`\text{Task}_1`, which is :math:`t + P`). As a result,
+ :math:`\text{Task}_1` can be scheduled only at time :math:`t + e`, and will
+ finish at time :math:`t + e + P`, after its absolute deadline. The total
+ utilization of the task set is
+ :math:`U = M \times \frac{e}{P - 1} + \frac{P}{P} = M \times \frac{e}{P - 1} + 1`,
+ and for small values of e this can become very close to 1. This is known as
+ "Dhall's effect"[7]. Note: the example in the original paper by Dhall has been
  slightly simplified here (for example, Dhall more correctly computed
- lim_{e->0}U).
+ :math:`\lim_{e\to0} U`).
 
  More complex schedulability tests for global EDF have been developed in
  real-time literature[8,9], but they are not based on a simple comparison
  between total utilization (or density) and a fixed constant. If all tasks
- have D_i = P_i, a sufficient schedulability condition can be expressed in
- a simple way:
+ have :math:`D_i = P_i`, a sufficient schedulability condition can be expressed
+ in a simple way:
 
-	sum(WCET_i / P_i) <= M - (M - 1) · U_max
+ .. math::
+	\sum_{i} \frac{\text{WCET}_i}{P_i} \leq M - (M - 1) \times U_{max}
 
- where U_max = max{WCET_i / P_i}[10]. Notice that for U_max = 1,
- M - (M - 1) · U_max becomes M - M + 1 = 1 and this schedulability condition
- just confirms the Dhall's effect. A more complete survey of the literature
- about schedulability tests for multi-processor real-time scheduling can be
- found in [11].
+ where :math:`U_{max} = max(\text{WCET}_i / P_i)`[10]. Notice that for
+ :math:`U_{max} = 1`, :math:`M - (M - 1) \times U_{max}` becomes
+ :math:`M - M + 1 = 1` and this schedulability condition just confirms the
+ Dhall's effect. A more complete survey of the literature about schedulability
+ tests for multi-processor real-time scheduling can be found in [11].
 
- As seen, enforcing that the total utilization is smaller than M does not
- guarantee that global EDF schedules the tasks without missing any deadline
+ As seen, enforcing that the total utilization is smaller than :math:`M` does
+ not guarantee that global EDF schedules the tasks without missing any deadline
  (in other words, global EDF is not an optimal scheduling algorithm). However,
- a total utilization smaller than M is enough to guarantee that non real-time
- tasks are not starved and that the tardiness of real-time tasks has an upper
- bound[12] (as previously noted). Different bounds on the maximum tardiness
- experienced by real-time tasks have been developed in various papers[13,14],
- but the theoretical result that is important for SCHED_DEADLINE is that if
- the total utilization is smaller or equal than M then the response times of
- the tasks are limited.
+ a total utilization smaller than :math:`M` is enough to guarantee that non
+ real-time tasks are not starved and that the tardiness of real-time tasks has
+ an upper bound[12] (as previously noted). Different bounds on the maximum
+ tardiness experienced by real-time tasks have been developed in various
+ papers[13,14], but the theoretical result that is important for SCHED_DEADLINE
+ is that if the total utilization is smaller or equal than :math:`M` then the
+ response times of the tasks are limited.
 
 3.4 Relationship with SCHED_DEADLINE Parameters
 -----------------------------------------------
@@ -467,24 +490,26 @@ Deadline Task Scheduling
  SCHED_DEADLINE scheduling parameters described in Section 2 (runtime,
  deadline and period) and the real-time task parameters (WCET, D, P)
  described in this section. Note that the tasks' temporal constraints are
- represented by its absolute deadlines d_j = r_j + D described above, while
- SCHED_DEADLINE schedules the tasks according to scheduling deadlines (see
+ represented by its absolute deadlines :math:`d_j = r_j + D` described above,
+ while SCHED_DEADLINE schedules the tasks according to scheduling deadlines (see
  Section 2).
  If an admission test is used to guarantee that the scheduling deadlines
  are respected, then SCHED_DEADLINE can be used to schedule real-time tasks
  guaranteeing that all the jobs' deadlines of a task are respected.
  In order to do this, a task must be scheduled by setting:
 
-  - runtime >= WCET
-  - deadline = D
-  - period <= P
+  - :math:`\text{runtime} \geq \text{WCET}`
+  - :math:`\text{deadline} = D`
+  - :math:`\text{period} \leq P`
 
- IOW, if runtime >= WCET and if period is <= P, then the scheduling deadlines
- and the absolute deadlines (d_j) coincide, so a proper admission control
- allows to respect the jobs' absolute deadlines for this task (this is what is
- called "hard schedulability property" and is an extension of Lemma 1 of [2]).
- Notice that if runtime > deadline the admission control will surely reject
- this task, as it is not possible to respect its temporal constraints.
+ IOW, if :math:`\text{runtime} \geq \text{WCET}` and if
+ :math:`\text{period} \leq P`, then the scheduling deadlines and the absolute
+ deadlines (:math:`d_j`) coincide, so a proper admission control allows to
+ respect the jobs' absolute deadlines for this task (this is what is called
+ "hard schedulability property" and is an extension of Lemma 1 of [2]).
+ Notice that if :math:`\text{runtime} > \text{deadline}` the admission control
+ will surely reject this task, as it is not possible to respect its temporal
+ constraints.
 
  References:
 
@@ -557,11 +582,11 @@ Deadline Task Scheduling
 
  As already stated in Section 3, a necessary condition to be respected to
  correctly schedule a set of real-time tasks is that the total utilization
- is smaller than M. When talking about -deadline tasks, this requires that
- the sum of the ratio between runtime and period for all tasks is smaller
- than M. Notice that the ratio runtime/period is equivalent to the utilization
- of a "traditional" real-time task, and is also often referred to as
- "bandwidth".
+ is smaller than :math:`M`. When talking about -deadline tasks, this requires
+ that the sum of the ratio between runtime and period for all tasks is smaller
+ than :math:`M`. Notice that the ratio runtime/period is equivalent to the
+ utilization of a "traditional" real-time task, and is also often referred to
+ as "bandwidth".
  The interface used to control the CPU bandwidth that can be allocated
  to -deadline tasks is similar to the one already used for -rt
  tasks with real-time group scheduling (a.k.a. RT-throttling - see
@@ -581,7 +606,7 @@ Deadline Task Scheduling
  parameters, so that CPU bandwidth is allocated to SCHED_DEADLINE tasks
  respecting their needs in terms of granularity. Therefore, using this simple
  interface we can put a cap on total utilization of -deadline tasks (i.e.,
- \Sum (runtime_i / period_i) < global_dl_utilization_cap).
+ :math:`\sum_{i} (\text{runtime}_i / \text{period}_i) < \text{global\_dl\_utilization\_cap}`).
 
 4.1 System wide settings
 ------------------------
@@ -595,10 +620,13 @@ Deadline Task Scheduling
  run -rt tasks from a -deadline server; in which case the -rt bandwidth is a
  direct subset of dl_bw.
 
- This means that, for a root_domain comprising M CPUs, -deadline tasks
+ This means that, for a root_domain comprising :math:`M` CPUs, -deadline tasks
  can be created while the sum of their bandwidths stays below:
 
-   M * (sched_rt_runtime_us / sched_rt_period_us)
+ .. math::
+   M \times
+   \frac{\text{sched\_rt\_runtime\_us}}
+        {\text{sched\_rt\_period\_us}}
 
  It is also possible to disable this bandwidth management logic, and
  be thus free of oversubscribing the system up to any arbitrary level.
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 8fbce5e767d9..8bc8bd258aae 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -33,17 +33,15 @@ To make it clear from the start:
  - power = energy/time = [joule/second] = [watt]
 
 The goal of EAS is to minimize energy, while still getting the job done. That
-is, we want to maximize::
+is, we want to maximize:
 
-	performance [inst/s]
-	--------------------
-	    power [W]
+.. math::
+   \frac{\text{performance (inst/s)}}{\text{power (W)}}
 
-which is equivalent to minimizing::
+which is equivalent to minimizing:
 
-	energy [J]
-	-----------
-	instruction
+.. math::
+   \frac{\text{energy (J)}}{\text{instruction}}
 
 while still getting 'good' performance. It is essentially an alternative
 optimization objective to the current performance-only objective for the
@@ -152,8 +150,8 @@ Example 2.
     composed of two CPUs each. CPU0 and CPU1 are little CPUs; CPU2 and CPU3
     are big.
 
-    The scheduler must decide where to place a task P whose util_avg = 200
-    and prev_cpu = 0.
+    The scheduler must decide where to place a task :math:`P` whose
+    util_avg = 200 and prev_cpu = 0.
 
     The current utilization landscape of the CPUs is depicted on the graph
     below. CPUs 0-3 have a util_avg of 400, 100, 600 and 500 respectively
@@ -183,10 +181,10 @@ Example 2.
 
     find_energy_efficient_cpu() will first look for the CPUs with the
     maximum spare capacity in the two performance domains. In this example,
-    CPU1 and CPU3. Then it will estimate the energy of the system if P was
-    placed on either of them, and check if that would save some energy
-    compared to leaving P on CPU0. EAS assumes that OPPs follow utilization
-    (which is coherent with the behaviour of the schedutil CPUFreq
+    CPU1 and CPU3. Then it will estimate the energy of the system if :math:`P`
+    was placed on either of them, and check if that would save some energy
+    compared to leaving :math:`P` on CPU0. EAS assumes that OPPs follow
+    utilization (which is coherent with the behaviour of the schedutil CPUFreq
     governor, see Section 6. for more details on this topic).
 
     **Case 1. P is migrated to CPU1**::
@@ -364,10 +362,12 @@ too complex (too many CPUs, too many performance domains, too many performance
 states, ...), the cost of using it in the wake-up path can become prohibitive.
 The energy-aware wake-up algorithm has a complexity of:
 
-	C = Nd * (Nc + Ns)
+.. math::
+   C = N_d \cdot (N_c + N_s)
 
-with: Nd the number of performance domains; Nc the number of CPUs; and Ns the
-total number of OPPs (ex: for two perf. domains with 4 OPPs each, Ns = 8).
+with: :math:`N_d` the number of performance domains; :math:`N_c` the number of
+CPUs; and :math:`N_s` the total number of OPPs (ex: for two perf. domains with 4
+OPPs each, :math:`N_s` = 8).
 
 A complexity check is performed at the root domain level, when scheduling
 domains are built. EAS will not start on a root domain if its C happens to be
diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 655a096ec8fb..9fbb2e7a69c9 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -60,14 +60,14 @@ SCHED_OTHER.
 Let's consider an example: a frame fixed realtime renderer must deliver 25
 frames a second, which yields a period of 0.04s per frame. Now say it will also
 have to play some music and respond to input, leaving it with around 80% CPU
-time dedicated for the graphics. We can then give this group a run time of 0.8
-* 0.04s = 0.032s.
+time dedicated for the graphics. We can then give this group a run time of
+:math:`0.8 \times 0.04s = 0.032s`.
 
 This way the graphics group will have a 0.04s period with a 0.032s run time
 limit. Now if the audio thread needs to refill the DMA buffer every 0.005s, but
-needs only about 3% CPU time to do so, it can do with a 0.03 * 0.005s =
-0.00015s. So this group can be scheduled with a period of 0.005s and a run time
-of 0.00015s.
+needs only about 3% CPU time to do so, it can do with a
+:math:`0.03 \times 0.005s = 0.00015s`. So this group can be scheduled with a
+period of 0.005s and a run time of 0.00015s.
 
 The remaining CPU time will be used for user input and other tasks. Because
 realtime tasks have explicitly allocated the CPU time they need to perform
@@ -138,12 +138,14 @@ Documentation/admin-guide/cgroup-v1/cgroups.rst as well.
 Group settings are checked against the following limits in order to keep the
 configuration schedulable:
 
-   \Sum_{i} runtime_{i} / global_period <= global_runtime / global_period
+.. math::
+  \frac{\sum_{i} \text{runtime$_{i}$}}{\text{global\_period}} \leq
+  \frac{\text{global\_runtime}}{\text{global\_period}}
 
 For now, this can be simplified to just the following (but see Future plans):
 
-   \Sum_{i} runtime_{i} <= global_runtime
-
+.. math::
+  \sum_{i} \text{runtime$_{i}$} \leq \text{global\_runtime}
 
 3. Future plans
 ===============
-- 
2.25.1

