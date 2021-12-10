Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8674E470837
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245247AbhLJSRq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 13:17:46 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:44815 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245238AbhLJSRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:17:44 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-pHky0U-BNH-jzwQnk5oBlA-1; Fri, 10 Dec 2021 13:14:03 -0500
X-MC-Unique: pHky0U-BNH-jzwQnk5oBlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C11A41926DA3;
        Fri, 10 Dec 2021 18:14:01 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25AF160C04;
        Fri, 10 Dec 2021 18:13:57 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: [PATCH V9 10/14] rtla: Add rtla osnoise top documentation
Date:   Fri, 10 Dec 2021 19:11:29 +0100
Message-Id: <445aa2173ca152fc2e68719e3c1a2547dd01efd3.1639158831.git.bristot@kernel.org>
In-Reply-To: <cover.1639158831.git.bristot@kernel.org>
References: <cover.1639158831.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Man page for rtla osnoise top mode.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_options.rst   | 28 +++++++++
 .../tools/rtla/common_osnoise_options.rst     | 17 ++++++
 .../tools/rtla/common_top_options.rst         |  3 +
 Documentation/tools/rtla/rtla-osnoise-top.rst | 61 +++++++++++++++++++
 4 files changed, 109 insertions(+)
 create mode 100644 Documentation/tools/rtla/common_options.rst
 create mode 100644 Documentation/tools/rtla/common_osnoise_options.rst
 create mode 100644 Documentation/tools/rtla/common_top_options.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-top.rst

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
new file mode 100644
index 000000000000..721790ad984e
--- /dev/null
+++ b/Documentation/tools/rtla/common_options.rst
@@ -0,0 +1,28 @@
+**-c**, **--cpus** *cpu-list*
+
+        Set the osnoise tracer to run the sample threads in the cpu-list.
+
+**-d**, **--duration** *time[s|m|h|d]*
+
+        Set the duration of the session.
+
+**-D**, **--debug**
+
+        Print debug info.
+
+**-t**, **--trace**\[*=file*]
+
+        Save the stopped trace to [*file|osnoise_trace.txt*].
+
+**-P**, **--priority** *o:prio|r:prio|f:prio|d:runtime:period*
+
+        Set scheduling parameters to the osnoise tracer threads, the format to set the priority are:
+
+        - *o:prio* - use SCHED_OTHER with *prio*;
+        - *r:prio* - use SCHED_RR with *prio*;
+        - *f:prio* - use SCHED_FIFO with *prio*;
+        - *d:runtime[us|ms|s]:period[us|ms|s]* - use SCHED_DEADLINE with *runtime* and *period* in nanoseconds.
+
+**-h**, **--help**
+
+        Print help menu.
diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.rst
new file mode 100644
index 000000000000..d556883e4e26
--- /dev/null
+++ b/Documentation/tools/rtla/common_osnoise_options.rst
@@ -0,0 +1,17 @@
+**-p**, **--period** *us*
+
+        Set the *osnoise* tracer period in microseconds.
+
+**-r**, **--runtime** *us*
+
+        Set the *osnoise* tracer runtime in microseconds.
+
+**-s**, **--stop** *us*
+
+        Stop the trace if a single sample is higher than the argument in microseconds.
+        If **-T** is set, it will also save the trace to the output.
+
+**-S**, **--stop-total** *us*
+
+        Stop the trace if the total sample is higher than the argument in microseconds.
+        If **-T** is set, it will also save the trace to the output.
diff --git a/Documentation/tools/rtla/common_top_options.rst b/Documentation/tools/rtla/common_top_options.rst
new file mode 100644
index 000000000000..f48878938f84
--- /dev/null
+++ b/Documentation/tools/rtla/common_top_options.rst
@@ -0,0 +1,3 @@
+**-q**, **--quiet**
+
+        Print only a summary at the end of the session.
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
new file mode 100644
index 000000000000..5d75d1394516
--- /dev/null
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -0,0 +1,61 @@
+===================
+rtla-osnoise-top
+===================
+-----------------------------------------------
+Display a summary of the operating system noise
+-----------------------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rtla osnoise top** [*OPTIONS*]
+
+DESCRIPTION
+===========
+.. include:: common_osnoise_description.rst
+
+**rtla osnoise top** collects the periodic summary from the *osnoise* tracer,
+including the counters of the occurrence of the interference source,
+displaying the results in a user-friendly format.
+
+The tool also allows many configurations of the *osnoise* tracer and the
+collection of the tracer output.
+
+OPTIONS
+=======
+.. include:: common_osnoise_options.rst
+
+.. include:: common_top_options.rst
+
+.. include:: common_options.rst
+
+EXAMPLE
+=======
+In the example below, the **rtla osnoise top** tool is set to run with a
+real-time priority *FIFO:1*, on CPUs *0-3*, for *900ms* at each period
+(*1s* by default). The reason for reducing the runtime is to avoid starving
+the rtla tool. The tool is also set to run for *one minute* and to display
+a summary of the report at the end of the session::
+
+  [root@f34 ~]# rtla osnoise top -P F:1 -c 0-3 -r 900000 -d 1M -q
+                                          Operating System Noise
+  duration:   0 00:01:00 | time is in us
+  CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
+    0 #59         53100000       304896    99.42580        6978           56         549            0        53111         1590           13
+    1 #59         53100000       338339    99.36282        8092           24         399            0        53130         1448           31
+    2 #59         53100000       290842    99.45227        6582           39         855            0        53110         1406           12
+    3 #59         53100000       204935    99.61405        6251           33         290            0        53156         1460           12
+
+SEE ALSO
+========
+
+**rtla-osnoise**\(1), **rtla-osnoise-hist**\(1)
+
+Osnoise tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
-- 
2.31.1

