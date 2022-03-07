Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C134CFCC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiCGL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiCGL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:27:16 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199F4A3DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:03:41 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v4so13078759pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 03:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFEOo1tcEco00+Nvk7m320IFPXwMdnmT4rBSqgHwb9U=;
        b=qtjDbzotyaVzeWfh9ZP2lKirFOAUTh9U/lRfK/AmyUHC81BOUQqRWV8uYCpRv45zF/
         JfuELtkYJkfkeBsnkNyb8dSw5o0huILMLDVO1CneisVMVdzYZp/KPIHiPffB7jNk2y7g
         7qyMbiP+ZcgwqY03j2iV6pztEiry52W4y6m3vGeh+ccjyh55cthC36FA9t/+YbMF5ueK
         A2JLckHy3vDz9ECpC+g5tiA3F/I6nZlnFG5BHEUusdCqvxPTit5boDlsMSM0/QLfegx9
         g92RR3KXXqWVJ/Twx7BOxF8eaSreXTIq8xxN1/uSlLTZHQdvtbmc+BKtR2ukBE4PkzPm
         22Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFEOo1tcEco00+Nvk7m320IFPXwMdnmT4rBSqgHwb9U=;
        b=t/aILU1QWwlEDjFdoQM200CfWHpc8lWX9zyXnsseCJKPIbCkYSltAdO2mAb67xuymw
         ywHE9x+ZuY2QDoUiuzM+hkJjwzMpxuibahjiInDc0K+ez6fJPAkRLnoGlYEYobRo9g0c
         w72z1CERM7vfnR3tKAZRwMdHB/DLfjOtNcFZtTM9LnSqcTgEDi5/IAcXypHwArgCrDeL
         yjYN7ZNu8yrZPsEmK/aj3jtruaXa7oDjo0d6GXSiHl6x8lLNDejsdUYmSj5UPZoZHIaG
         hdnPEncaxuazgPEhnjODj/NBBtX7+7Qy5NPvXCLQmCm6vxhqBHQ0yejOQQofg1bd6Zli
         NlIw==
X-Gm-Message-State: AOAM533MstlhwJctwTojQIdT9Nmdl/zXlvQpibBTyXelzXTMPEHPohYb
        wF50oJ864n/oBExlQ/MY83Wzfg==
X-Google-Smtp-Source: ABdhPJzQWuDyPVOZV8+vb7zFRV1bqqY/2Jkp1Y9YhwzRyLVg+CvO8Hap3qvd2yxJOHBDSbBx85jL6Q==
X-Received: by 2002:a17:90b:216:b0:1bc:5d68:e7aa with SMTP id fy22-20020a17090b021600b001bc5d68e7aamr12283884pjb.57.1646651020984;
        Mon, 07 Mar 2022 03:03:40 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c2a:216d:d967:c5a7:5da:6441])
        by smtp.gmail.com with ESMTPSA id mw7-20020a17090b4d0700b001b8baf6b6f5sm12390121pjb.50.2022.03.07.03.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:03:40 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        dianders@chromium.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        arnd@arndb.de, peterz@infradead.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFT v4] tty/sysrq: Make sysrq handler NMI aware
Date:   Mon,  7 Mar 2022 16:33:28 +0530
Message-Id: <20220307110328.2557655-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a magic sysrq to be triggered from an NMI context. This is done
via marking some sysrq actions as NMI safe. Safe actions will be allowed
to run from NMI context whilst that cannot run from an NMI will be queued
as irq_work for later processing.

The major use-case is to add NMI debugging capabilities to the kernel
in order to debug scenarios such as:
- Primary CPU is stuck in deadlock with interrupts disabled and hence
  doesn't honor serial device interrupt. So having magic sysrq triggered
  as an NMI is helpful for debugging.
- Always enabled NMI based magic sysrq irrespective of whether the serial
  TTY port is active or not.
- Apart from UART interrupts, it allows magic sysrq to be triggered from
  a diagnostic NMI interrupt on systems such as A64FX.

A particular sysrq handler is only marked as NMI safe in case the handler
isn't contending for any synchronization primitives as in NMI context
they are expected to cause deadlocks. Note that the debug sysrq do not
contend for any synchronization primitives. It does call kgdb_breakpoint()
to provoke a trap but that trap handler should be NMI safe on
architectures that implement an NMI.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Use atomic operations for sysrq key variable to gracefully handle
  concurrent sysrq entry on multiple CPUs.
- Rename sysrq_nmi_key to sysrq_key as it isn't anymore specific to NMI
  context.
- Addressed other misc. comments from Doug.

Changes in v3:
- Extend commit message to include use-cases.
- Get rid of redundant kfifo stuff.
- Incorporate other misc. feedback from Peter Z.

Changes in v2:
- Rebased to 5.17-rc5.
- Separate this patch from complete patch-set [1] as its relevant for
  other diagnostic NMI interrupts [2] as well apart from uart NMI
  interrupts.
- Incorporated suggestions from Doug.

[1] https://lore.kernel.org/linux-arm-kernel/CAFA6WYOWHgmYYt=KGXDh2hKiuy_rQbJfi279ev0+s-Qh7L21kA@mail.gmail.com/t/#m2b5006f08581448020eb24566927a104d0b95c44
[2] https://lore.kernel.org/all/Yhi0rrkSR63ZhjX1@kroah.com/T/

 drivers/tty/sysrq.c       | 50 ++++++++++++++++++++++++++++++++++++++-
 include/linux/sysrq.h     |  1 +
 kernel/debug/debug_core.c |  1 +
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index bbfd004449b5..005c9f9e0004 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -51,6 +51,7 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/irq_work.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -112,6 +113,7 @@ static const struct sysrq_key_op sysrq_loglevel_op = {
 	.help_msg	= "loglevel(0-9)",
 	.action_msg	= "Changing Loglevel",
 	.enable_mask	= SYSRQ_ENABLE_LOG,
+	.nmi_safe	= true,
 };
 
 #ifdef CONFIG_VT
@@ -159,6 +161,7 @@ static const struct sysrq_key_op sysrq_crash_op = {
 	.help_msg	= "crash(c)",
 	.action_msg	= "Trigger a crash",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_reboot(int key)
@@ -172,6 +175,7 @@ static const struct sysrq_key_op sysrq_reboot_op = {
 	.help_msg	= "reboot(b)",
 	.action_msg	= "Resetting",
 	.enable_mask	= SYSRQ_ENABLE_BOOT,
+	.nmi_safe	= true,
 };
 
 const struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
@@ -219,6 +223,7 @@ static const struct sysrq_key_op sysrq_showlocks_op = {
 	.handler	= sysrq_handle_showlocks,
 	.help_msg	= "show-all-locks(d)",
 	.action_msg	= "Show Locks Held",
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_showlocks_op (*(const struct sysrq_key_op *)NULL)
@@ -291,6 +296,7 @@ static const struct sysrq_key_op sysrq_showregs_op = {
 	.help_msg	= "show-registers(p)",
 	.action_msg	= "Show Regs",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 
 static void sysrq_handle_showstate(int key)
@@ -328,6 +334,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
 	.help_msg	= "dump-ftrace-buffer(z)",
 	.action_msg	= "Dump ftrace buffer",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
+	.nmi_safe	= true,
 };
 #else
 #define sysrq_ftrace_dump_op (*(const struct sysrq_key_op *)NULL)
@@ -566,12 +573,46 @@ static void __sysrq_put_key_op(int key, const struct sysrq_key_op *op_p)
 		sysrq_key_table[i] = op_p;
 }
 
+static atomic_t sysrq_key = ATOMIC_INIT(-1);
+
+static void sysrq_do_irq_work(struct irq_work *work)
+{
+	const struct sysrq_key_op *op_p;
+	int orig_suppress_printk;
+	int key = atomic_read(&sysrq_key);
+
+	orig_suppress_printk = suppress_printk;
+	suppress_printk = 0;
+
+	rcu_sysrq_start();
+	rcu_read_lock();
+
+	op_p = __sysrq_get_key_op(key);
+	if (op_p)
+		op_p->handler(key);
+
+	rcu_read_unlock();
+	rcu_sysrq_end();
+
+	suppress_printk = orig_suppress_printk;
+	atomic_set(&sysrq_key, -1);
+}
+
+static DEFINE_IRQ_WORK(sysrq_irq_work, sysrq_do_irq_work);
+
 void __handle_sysrq(int key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
 	int orig_log_level;
 	int orig_suppress_printk;
 	int i;
+	bool irq_work = false;
+
+	/* Skip sysrq handling if one already in progress */
+	if (atomic_cmpxchg(&sysrq_key, -1, key) != -1) {
+		pr_warn("Skip sysrq key: %i as one already in progress\n", key);
+		return;
+	}
 
 	orig_suppress_printk = suppress_printk;
 	suppress_printk = 0;
@@ -596,7 +637,11 @@ void __handle_sysrq(int key, bool check_mask)
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
-			op_p->handler(key);
+
+			if (in_nmi() && !op_p->nmi_safe)
+				irq_work = irq_work_queue(&sysrq_irq_work);
+			else
+				op_p->handler(key);
 		} else {
 			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
@@ -623,6 +668,9 @@ void __handle_sysrq(int key, bool check_mask)
 	rcu_sysrq_end();
 
 	suppress_printk = orig_suppress_printk;
+
+	if (!irq_work)
+		atomic_set(&sysrq_key, -1);
 }
 
 void handle_sysrq(int key)
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 3a582ec7a2f1..630b5b9dc225 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -34,6 +34,7 @@ struct sysrq_key_op {
 	const char * const help_msg;
 	const char * const action_msg;
 	const int enable_mask;
+	const bool nmi_safe;
 };
 
 #ifdef CONFIG_MAGIC_SYSRQ
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index da06a5553835..53b56114f59b 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -978,6 +978,7 @@ static const struct sysrq_key_op sysrq_dbg_op = {
 	.handler	= sysrq_handle_dbg,
 	.help_msg	= "debug(g)",
 	.action_msg	= "DEBUG",
+	.nmi_safe	= true,
 };
 #endif
 
-- 
2.25.1

