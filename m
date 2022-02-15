Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069604B69D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiBOKyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:54:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiBOKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD42C6220;
        Tue, 15 Feb 2022 02:54:28 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gq8JkGp7txklDWvEWlo9O1PgemKRDCD3AFK4Be8fUDU=;
        b=zEByKY6nS3XXm6LTHvcMVlReoFpuigW47wjkpjjMfvsvehIlDtNDd57S3TpByMkWX9282u
        uPKku3w2HzVt0xgDWT0A4SE2eTQmxGDe8WL7dozlD7gr7qv6EjDzkBiqP1tOXQK+5TEPag
        t56nlrbriXQmKgHsO6p8s+PzfaiExdqwVCzQwB5D0fDwIKiiSgGNFpkvuT2cAB4dGXpvm9
        D+DoYmwjke/Avwan72NNiR8FvyAhTF2TV/MoXP+3Gln5w91fu3Yg8OrbGo/9Vt14Jcax0Z
        AUDwl2L4+2o+D8AUByedtSPdSYZO0lDNp04aO6r42XpNQy1O4sKpE68S66n4zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gq8JkGp7txklDWvEWlo9O1PgemKRDCD3AFK4Be8fUDU=;
        b=C4D+GLTgsQIqoy5nuB7I3KHx4MiI5Jlk1BUAes1XXd76zZXFU8l829xKs7t+BX1TFp5Odt
        19WzDsuTcn0cQfBA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] Documentation/x86: Update documentation for SVA
 (Shared Virtual Addressing)
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-12-fenghua.yu@intel.com>
References: <20220207230254.3342514-12-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492246461.16921.16965885697297666355.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     83aa52ffed5d35a08e24452d0471e1684075cdf8
Gitweb:        https://git.kernel.org/tip/83aa52ffed5d35a08e24452d0471e1684075cdf8
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:54 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Feb 2022 11:31:43 +01:00

Documentation/x86: Update documentation for SVA (Shared Virtual Addressing)

Adjust the documentation to the new way how a PASID is being allocated,
freed and fixed up.

Based on a patch by Ashok Raj <ashok.raj@intel.com>

  [ bp: Massage commit message, fix htmldocs build warning ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220207230254.3342514-12-fenghua.yu@intel.com
---
 Documentation/x86/sva.rst | 53 +++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
index 076efd5..2e9b8b0 100644
--- a/Documentation/x86/sva.rst
+++ b/Documentation/x86/sva.rst
@@ -104,18 +104,47 @@ The MSR must be configured on each logical CPU before any application
 thread can interact with a device. Threads that belong to the same
 process share the same page tables, thus the same MSR value.
 
-PASID is cleared when a process is created. The PASID allocation and MSR
-programming may occur long after a process and its threads have been created.
-One thread must call iommu_sva_bind_device() to allocate the PASID for the
-process. If a thread uses ENQCMD without the MSR first being populated, a #GP
-will be raised. The kernel will update the PASID MSR with the PASID for all
-threads in the process. A single process PASID can be used simultaneously
-with multiple devices since they all share the same address space.
-
-One thread can call iommu_sva_unbind_device() to free the allocated PASID.
-The kernel will clear the PASID MSR for all threads belonging to the process.
-
-New threads inherit the MSR value from the parent.
+PASID Life Cycle Management
+===========================
+
+PASID is initialized as INVALID_IOASID (-1) when a process is created.
+
+Only processes that access SVA-capable devices need to have a PASID
+allocated. This allocation happens when a process opens/binds an SVA-capable
+device but finds no PASID for this process. Subsequent binds of the same, or
+other devices will share the same PASID.
+
+Although the PASID is allocated to the process by opening a device,
+it is not active in any of the threads of that process. It's loaded to the
+IA32_PASID MSR lazily when a thread tries to submit a work descriptor
+to a device using the ENQCMD.
+
+That first access will trigger a #GP fault because the IA32_PASID MSR
+has not been initialized with the PASID value assigned to the process
+when the device was opened. The Linux #GP handler notes that a PASID has
+been allocated for the process, and so initializes the IA32_PASID MSR
+and returns so that the ENQCMD instruction is re-executed.
+
+On fork(2) or exec(2) the PASID is removed from the process as it no
+longer has the same address space that it had when the device was opened.
+
+On clone(2) the new task shares the same address space, so will be
+able to use the PASID allocated to the process. The IA32_PASID is not
+preemptively initialized as the PASID value might not be allocated yet or
+the kernel does not know whether this thread is going to access the device
+and the cleared IA32_PASID MSR reduces context switch overhead by xstate
+init optimization. Since #GP faults have to be handled on any threads that
+were created before the PASID was assigned to the mm of the process, newly
+created threads might as well be treated in a consistent way.
+
+Due to complexity of freeing the PASID and clearing all IA32_PASID MSRs in
+all threads in unbind, free the PASID lazily only on mm exit.
+
+If a process does a close(2) of the device file descriptor and munmap(2)
+of the device MMIO portal, then the driver will unbind the device. The
+PASID is still marked VALID in the PASID_MSR for any threads in the
+process that accessed the device. But this is harmless as without the
+MMIO portal they cannot submit new work to the device.
 
 Relationships
 =============
