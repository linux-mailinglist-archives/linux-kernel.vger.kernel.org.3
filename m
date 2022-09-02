Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173BB5AAA99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiIBIt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiIBIth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:49:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F742C126;
        Fri,  2 Sep 2022 01:49:35 -0700 (PDT)
Date:   Fri, 02 Sep 2022 08:49:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662108573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tHqU9xje3UYKAZiz5EQdq8SX17fpHeWdaNN84FIbl6I=;
        b=AWy7iMjUGRYqeZdzv+fH+DtbdxUSUJN82ZcfndIu5k6qjGqRuWaFzT4PfKEpfyNNa1iQl3
        p5ZaSoF2KRM3u7EIm499OvI/Q/SmbewWR3qmGcOhvJ7skOSn1txau0+hzctLSQrBVjYP1m
        /+NmjS79qr04jIqRntLyYMrGSreg+7p3MREN6Tm/yAeURv2c/VRdYKbkvlCrHGe8P6j1Hk
        Wvre/YDuU/b3G0yWbiHcUzbnAl2I8pvXUk+0EIE38lpKgqWRs9/v4nzb+7DqYxzFZmwGJi
        Cw9cNAMRqoK3m3KqXMD/3DOk6THl7TUBQ150DddZObbp2XL9OTbOPejEptdGYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662108573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tHqU9xje3UYKAZiz5EQdq8SX17fpHeWdaNN84FIbl6I=;
        b=ElZYt6KtukhCPO0J779Iq1L4zwQNAmkSv/+lx/7GrNApFCML+/w153WfxCGLVtKn7uS4Xk
        zusGfJH8oQ7gCxCg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/defconfig: Refresh the defconfigs
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166210857267.401.17949589519631648315.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     81290934eafd19ad1799526ed63ce9d92df6294c
Gitweb:        https://git.kernel.org/tip/81290934eafd19ad1799526ed63ce9d92df6294c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 02 Sep 2022 10:37:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Sep 2022 10:37:53 +02:00

x86/defconfig: Refresh the defconfigs

Just go through a 'make savedefconfig' cycle to pick up fresh Kconfig
details, no change in settings, just reordering of some entries.

( This makes followup changes generated via 'make savedefconfig'
  contain less noise. )

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/configs/i386_defconfig   | 5 +++--
 arch/x86/configs/x86_64_defconfig | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 7207219..a292489 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -27,7 +27,6 @@ CONFIG_CGROUP_MISC=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_SMP=y
 CONFIG_HYPERVISOR_GUEST=y
@@ -44,6 +43,7 @@ CONFIG_EFI_STUB=y
 CONFIG_HZ_1000=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
+# CONFIG_RETHUNK is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
@@ -62,6 +62,7 @@ CONFIG_BLK_CGROUP_IOLATENCY=y
 CONFIG_BLK_CGROUP_IOCOST=y
 CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BINFMT_MISC=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -269,9 +270,9 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_KERNEL=y
 CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 5ce67b7..2a7333b 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -26,7 +26,6 @@ CONFIG_CGROUP_MISC=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
-# CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_SMP=y
 CONFIG_HYPERVISOR_GUEST=y
@@ -62,6 +61,7 @@ CONFIG_BLK_CGROUP_IOLATENCY=y
 CONFIG_BLK_CGROUP_IOCOST=y
 CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BINFMT_MISC=y
+# CONFIG_COMPAT_BRK is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -267,8 +267,8 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_PRINTK_TIME=y
-CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_STACK_USAGE=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
