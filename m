Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872024C38F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiBXWqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiBXWqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:46:15 -0500
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE5AD17F6A7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:45:43 -0800 (PST)
Received: from [128.177.79.46] (helo=[10.118.101.22])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1nNMTD-000HIG-7O; Thu, 24 Feb 2022 17:20:19 -0500
Subject: [PATCH v5 1/3] MAINTAINERS: Update maintainers for paravirt ops and
 VMware hypervisor interface
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     jgross@suse.com, x86@kernel.org, pv-drivers@vmware.com,
        tglx@linutronix.de, bp@alien8.de
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Deep Shah <sdeep@vmware.com>, sdeep@vmware.com,
        vithampi@vmware.com, amakhalov@vmware.com, keerthanak@vmware.com,
        srivatsab@vmware.com, anishs@vmware.com,
        linux-kernel@vger.kernel.org, namit@vmware.com, joe@perches.com,
        kuba@kernel.org, rostedt@goodmis.org, srivatsa@csail.mit.edu
Date:   Thu, 24 Feb 2022 14:24:22 -0800
Message-ID: <164574143710.654750.17342470717937593195.stgit@csail.mit.edu>
In-Reply-To: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
References: <164574138686.654750.10250173565414769119.stgit@csail.mit.edu>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

Deep has decided to transfer the joint-maintainership of paravirt ops
to Srivatsa, and the maintainership of the VMware hypervisor interface
to Srivatsa and Alexey. Update the MAINTAINERS file to reflect this
change, and also add Alexey as a reviewer for paravirt ops.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Acked-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Deep Shah <sdeep@vmware.com>
Cc: Juergen Gross <jgross@suse.com>
---

 MAINTAINERS |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d492bb6a9c66..9325debf5365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14609,7 +14609,8 @@ F:	include/uapi/linux/ppdev.h
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Deep Shah <sdeep@vmware.com>
+M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
+R:	Alexey Makhalov <amakhalov@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
@@ -20647,10 +20648,13 @@ S:	Maintained
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
 


