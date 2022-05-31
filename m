Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D1538C05
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiEaHf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244516AbiEaHfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:35:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831185EF2;
        Tue, 31 May 2022 00:34:53 -0700 (PDT)
Date:   Tue, 31 May 2022 07:34:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653982491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSX9PuBMAshW58B3hNBClnnwEmHeNYQRsjR5UbWLhPI=;
        b=ebJjmXHW5FydZ1Z3ds9OngR/4bdYBAximI6aLVDzk1ezmjJ5e3MEqYLMY1KTJf8nVS5Ecl
        wDww4bayFCIa/nE3GjzwEWLK88fEGfarjpaIY4fy5vmC3oxWYG5NgEVJ2AIPBqw5Wy5bjt
        msseCl7+BE8FOYaUyc4vv2vro2sZiCeQpA4Fbt8jt5KOQGLYgw5lb9VjBrjXSUHuIBdirA
        Iq0kbHp+9Xq9vt1wFxoAwjmhpzQdspsjMszkub471vXUBJ4p3OeRuT+fbJVx8qh1vZ7G+e
        /HbzoEuxN/wQ9ROWLYGJy/VDl48fKvdudy762tPLToau6yebLUEw06j+ZpXfpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653982491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wSX9PuBMAshW58B3hNBClnnwEmHeNYQRsjR5UbWLhPI=;
        b=HvTlQ9vBewHnc5aizs5LskmS4V67NWx6rNi6GrNlYgBlIJWcLAS0VX91QZOrd9tstabKot
        OT5f5+TgTjIlKeCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Rip out the OLD_INTERFACE
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220525161232.14924-2-bp@alien8.de>
References: <20220525161232.14924-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <165398249057.4207.3408104855886446576.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     181b6f40e9ea80c76756d4d0cdeed396016c487e
Gitweb:        https://git.kernel.org/tip/181b6f40e9ea80c76756d4d0cdeed396016c487e
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 25 May 2022 18:12:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 31 May 2022 09:31:19 +02:00

x86/microcode: Rip out the OLD_INTERFACE

Everything should be using the early initrd loading by now.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220525161232.14924-2-bp@alien8.de

---
 arch/x86/Kconfig                     |  12 +---
 arch/x86/kernel/cpu/microcode/core.c | 100 +--------------------------
 2 files changed, 112 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 762a0b6..f423a2d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1350,18 +1350,6 @@ config MICROCODE_AMD
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
 
-config MICROCODE_OLD_INTERFACE
-	bool "Ancient loading interface (DEPRECATED)"
-	default n
-	depends on MICROCODE
-	help
-	  DO NOT USE THIS! This is the ancient /dev/cpu/microcode interface
-	  which was used by userspace tools like iucode_tool and microcode.ctl.
-	  It is inadequate because it runs too late to be able to properly
-	  load microcode on a machine and it needs special tools. Instead, you
-	  should've switched to the early loading method with the initrd or
-	  builtin microcode by now: Documentation/x86/microcode.rst
-
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
 	help
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 239ff5f..b72c413 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -373,98 +373,6 @@ static int apply_microcode_on_target(int cpu)
 	return ret;
 }
 
-#ifdef CONFIG_MICROCODE_OLD_INTERFACE
-static int do_microcode_update(const void __user *buf, size_t size)
-{
-	int error = 0;
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-		enum ucode_state ustate;
-
-		if (!uci->valid)
-			continue;
-
-		ustate = microcode_ops->request_microcode_user(cpu, buf, size);
-		if (ustate == UCODE_ERROR) {
-			error = -1;
-			break;
-		} else if (ustate == UCODE_NEW) {
-			apply_microcode_on_target(cpu);
-		}
-	}
-
-	return error;
-}
-
-static int microcode_open(struct inode *inode, struct file *file)
-{
-	return capable(CAP_SYS_RAWIO) ? stream_open(inode, file) : -EPERM;
-}
-
-static ssize_t microcode_write(struct file *file, const char __user *buf,
-			       size_t len, loff_t *ppos)
-{
-	ssize_t ret = -EINVAL;
-	unsigned long nr_pages = totalram_pages();
-
-	if ((len >> PAGE_SHIFT) > nr_pages) {
-		pr_err("too much data (max %ld pages)\n", nr_pages);
-		return ret;
-	}
-
-	cpus_read_lock();
-	mutex_lock(&microcode_mutex);
-
-	if (do_microcode_update(buf, len) == 0)
-		ret = (ssize_t)len;
-
-	if (ret > 0)
-		perf_check_microcode();
-
-	mutex_unlock(&microcode_mutex);
-	cpus_read_unlock();
-
-	return ret;
-}
-
-static const struct file_operations microcode_fops = {
-	.owner			= THIS_MODULE,
-	.write			= microcode_write,
-	.open			= microcode_open,
-	.llseek		= no_llseek,
-};
-
-static struct miscdevice microcode_dev = {
-	.minor			= MICROCODE_MINOR,
-	.name			= "microcode",
-	.nodename		= "cpu/microcode",
-	.fops			= &microcode_fops,
-};
-
-static int __init microcode_dev_init(void)
-{
-	int error;
-
-	error = misc_register(&microcode_dev);
-	if (error) {
-		pr_err("can't misc_register on minor=%d\n", MICROCODE_MINOR);
-		return error;
-	}
-
-	return 0;
-}
-
-static void __exit microcode_dev_exit(void)
-{
-	misc_deregister(&microcode_dev);
-}
-#else
-#define microcode_dev_init()	0
-#define microcode_dev_exit()	do { } while (0)
-#endif
-
 /* fake device for request_firmware */
 static struct platform_device	*microcode_pdev;
 
@@ -856,10 +764,6 @@ static int __init microcode_init(void)
 		goto out_driver;
 	}
 
-	error = microcode_dev_init();
-	if (error)
-		goto out_ucode_group;
-
 	register_syscore_ops(&mc_syscore_ops);
 	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
 				  mc_cpu_starting, NULL);
@@ -870,10 +774,6 @@ static int __init microcode_init(void)
 
 	return 0;
 
- out_ucode_group:
-	sysfs_remove_group(&cpu_subsys.dev_root->kobj,
-			   &cpu_root_microcode_group);
-
  out_driver:
 	cpus_read_lock();
 	mutex_lock(&microcode_mutex);
