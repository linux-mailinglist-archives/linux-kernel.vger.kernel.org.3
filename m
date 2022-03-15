Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2484DA0DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350457AbiCORHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350439AbiCORHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:07:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4125838F;
        Tue, 15 Mar 2022 10:05:59 -0700 (PDT)
Date:   Tue, 15 Mar 2022 17:05:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647363957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPbLF8wqrQxOrPBpwWkm500pyBsDWh/pxVvbE9yQs2o=;
        b=FNkfEEXSZtWhxMsmccig9GVkb87TWZLXZciEnvpzV63/9Vi33WxB6oh2aQbbWa6a+LPcwM
        kU4lBhWqY0Ekfs6nVrlPaL3AlSHuhEnfsN5Tn4Zp6Rq/sRvYXPfPSvZRiMeR//iikD6zlV
        fRtgyc6ocmgq0jcWMloveTbr5WlsTBARCvJgdoYb6XhW/dIgoW1kQlaw2iwN4Pll8N5noK
        SYS3YlO9fWXm/9TmJYn5quPJ/dTAzYCAqCVpgjXP7ezwCPOWAjnA2yZXKJGvI5eDGXbKCk
        cYCueWQufR0/PLR/0EFPrcn3YTYOFLrjc+CJdTT4ymyq8lXsPq0X/sgHlwMhaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647363957;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPbLF8wqrQxOrPBpwWkm500pyBsDWh/pxVvbE9yQs2o=;
        b=klkOeP0g45J64IvkX7y3BG64cR0fFKDIin8TBAkNMAWH7GR8i9QdhsnleBhb38jtQ2TqT6
        yry31iORe/58cGDw==
From:   "tip-bot2 for Srivatsa S. Bhat (VMware)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] MAINTAINERS: Update maintainers for paravirt ops and
 VMware hypervisor interface
Cc:     "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Deep Shah <sdeep@vmware.com>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <164574143710.654750.17342470717937593195.stgit@csail.mit.edu>
References: <164574143710.654750.17342470717937593195.stgit@csail.mit.edu>
MIME-Version: 1.0
Message-ID: <164736395665.16921.16724160880437600840.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     01683580c65ffe0ce72d52cfb5225b80b477c598
Gitweb:        https://git.kernel.org/tip/01683580c65ffe0ce72d52cfb5225b80b477c598
Author:        Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
AuthorDate:    Thu, 24 Feb 2022 14:24:22 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Mar 2022 17:44:16 +01:00

MAINTAINERS: Update maintainers for paravirt ops and VMware hypervisor interface

Deep has decided to transfer the joint-maintainership of paravirt ops
to Srivatsa, and the maintainership of the VMware hypervisor interface
to Srivatsa and Alexey. Update the MAINTAINERS file to reflect this
change, and also add Alexey as a reviewer for paravirt ops.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Deep Shah <sdeep@vmware.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/164574143710.654750.17342470717937593195.stgit@csail.mit.edu
---
 MAINTAINERS | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c9..4f81c3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14576,7 +14576,8 @@ F:	include/uapi/linux/ppdev.h
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Deep Shah <sdeep@vmware.com>
+M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+R:	Alexey Makhalov <amakhalov@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
@@ -20585,10 +20586,13 @@ S:	Maintained
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Deep Shah <sdeep@vmware.com>
+M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+M:	Alexey Makhalov <amakhalov@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
+L:	x86@kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware
 F:	arch/x86/include/asm/vmware.h
 F:	arch/x86/kernel/cpu/vmware.c
 
