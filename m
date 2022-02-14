Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A14B4E16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350622AbiBNLWD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:22:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352084AbiBNLVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:21:38 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67F66469
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:57:22 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-09a1hDNTONuupyNsMr2KKw-1; Mon, 14 Feb 2022 05:47:01 -0500
X-MC-Unique: 09a1hDNTONuupyNsMr2KKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB97D801B1C;
        Mon, 14 Feb 2022 10:46:58 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2188226E74;
        Mon, 14 Feb 2022 10:46:49 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [RFC V2 09/21] rv/monitor: wip instrumentation and Makefile/Kconfig entries
Date:   Mon, 14 Feb 2022 11:45:00 +0100
Message-Id: <87e86ddb840f7c69a5a9348974936de918ca3036.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the instrumentation to the previously created wip monitor, as an
example of the developer work. It also adds a Makefile and Kconfig
entries.

This is a good example of the manual work that is left for the
developer to do.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/rv/Kconfig           |  7 +++++++
 kernel/trace/rv/Makefile          |  1 +
 kernel/trace/rv/monitor_wip/wip.c | 16 ++++++++--------
 kernel/trace/rv/monitor_wip/wip.h |  2 +-
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 560408fec0c8..7338e661d78f 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -13,6 +13,13 @@ menuconfig RV
 
 if RV
 
+config RV_MON_WIP
+	depends on PREEMPTIRQ_TRACEPOINTS
+	tristate "WIP monitor"
+	help
+	  Enable WIP sample monitor, this is a sample monitor that
+	  illustrates the usage of per-cpu monitors.
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y if RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 8944274d9b41..20f30741b933 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
+obj-$(CONFIG_RV_MON_WIP) += monitor_wip/wip.o
diff --git a/kernel/trace/rv/monitor_wip/wip.c b/kernel/trace/rv/monitor_wip/wip.c
index 1aec75e683d2..dd35a042e727 100644
--- a/kernel/trace/rv/monitor_wip/wip.c
+++ b/kernel/trace/rv/monitor_wip/wip.c
@@ -33,36 +33,36 @@ DECLARE_DA_MON_PER_CPU(wip, char);
  *
  */
 
-void handle_preempt_disable(void *data, /* XXX: fill header */)
+void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
 	da_handle_event_wip(preempt_disable);
 }
 
-void handle_preempt_enable(void *data, /* XXX: fill header */)
+void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_wip(preempt_enable);
+	da_handle_init_event_wip(preempt_enable);
 }
 
-void handle_sched_waking(void *data, /* XXX: fill header */)
+void handle_sched_waking(void *data, struct task_struct *task)
 {
 	da_handle_event_wip(sched_waking);
 }
 
-#define NR_TP   3
+#define NR_TP	3
 static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
 	{
 		.probe = handle_preempt_disable,
-		.name = /* XXX: tracepoint name here */,
+		.name = "preempt_disable",
 		.registered = 0
 	},
 	{
 		.probe = handle_preempt_enable,
-		.name = /* XXX: tracepoint name here */,
+		.name = "preempt_enable",
 		.registered = 0
 	},
 	{
 		.probe = handle_sched_waking,
-		.name = /* XXX: tracepoint name here */,
+		.name = "sched_wakeup",
 		.registered = 0
 	},
 };
diff --git a/kernel/trace/rv/monitor_wip/wip.h b/kernel/trace/rv/monitor_wip/wip.h
index 7a751a8896e9..1ba58a5781ff 100644
--- a/kernel/trace/rv/monitor_wip/wip.h
+++ b/kernel/trace/rv/monitor_wip/wip.h
@@ -59,6 +59,6 @@ TRACE_EVENT(error_wip,
 
 /* This part ust be outside protection */
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../kernel/trace/rv/monitor_wip/
 #define TRACE_INCLUDE_FILE wip
 #include <trace/define_trace.h>
-- 
2.33.1

