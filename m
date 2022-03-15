Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB294DA0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350454AbiCORHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350438AbiCORHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:07:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9EF580FE;
        Tue, 15 Mar 2022 10:05:58 -0700 (PDT)
Date:   Tue, 15 Mar 2022 17:05:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647363956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlXaSeWP66xNpLAMYFGcwVaODehcepISmjpSetFkRFw=;
        b=LUYTAkb5h2Gf0bjvVIr2Tq8GIEScK6aXbFDH9t05gOKSiHeA/4ghUI71oVDVjYbVEklt26
        b73SUpyRXMhWaz25/BcZgRtcwPf5W1k05Z3P132N4naR5E6xosKuSTtV8P6RFaqrb7MTLx
        ndeF1QQHYs/D1sXwlg2M95UYi/QT1wNI6m3tJknuwTrMx2o4xH6TQVwJwcnw7XZriyn42L
        eXgkcWcwc4FEl62ZuxTiXqltE+ZvyxzINHx7XAxtkixM+ejLWCHkQiXeHNwWnMkMTZ7Wn3
        vwOkKLGzAzpRx45RSv2197/5Yjm757UZUpdT5RQd4QfduWK9THrQfNHMR+BNqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647363956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mlXaSeWP66xNpLAMYFGcwVaODehcepISmjpSetFkRFw=;
        b=hLtjPLOkhVOW9xQIX9wCCek7rdBWzONjHpGWbRK4EOItey8fs7akv+wZAzH5T1a2kJLVYz
        5Uv9Utie8HENheAQ==
From:   "tip-bot2 for Srivatsa S. Bhat (VMware)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] MAINTAINERS: Mark VMware mailing list entries as
 email aliases
Cc:     "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        Joe Perches <joe@perches.com>, Zack Rusin <zackr@vmware.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <164574148378.654750.15832494349474144706.stgit@csail.mit.edu>
References: <164574148378.654750.15832494349474144706.stgit@csail.mit.edu>
MIME-Version: 1.0
Message-ID: <164736395458.16921.2762087640279770080.tip-bot2@tip-bot2>
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

Commit-ID:     686016f732420f88dd2e1d67cf4bb5dffdb93c82
Gitweb:        https://git.kernel.org/tip/686016f732420f88dd2e1d67cf4bb5dffdb93c82
Author:        Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
AuthorDate:    Thu, 24 Feb 2022 14:24:49 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Mar 2022 17:46:15 +01:00

MAINTAINERS: Mark VMware mailing list entries as email aliases

VMware mailing lists in the MAINTAINERS file are private lists meant
for VMware-internal review/notification for patches to the respective
subsystems. Anyone can post to these addresses, but there is no public
read access like open mailing lists, which makes them more like email
aliases instead (to reach out to reviewers).

So update all the VMware mailing list references in the MAINTAINERS
file to mark them as such, using "R: email-alias@vmware.com".

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Juergen Gross <jgross@suse.com>
Acked-by: Joe Perches <joe@perches.com>
Acked-by: Zack Rusin <zackr@vmware.com>
Link: https://lore.kernel.org/r/164574148378.654750.15832494349474144706.stgit@csail.mit.edu
---
 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 630ac98..e6e5466 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6301,8 +6301,8 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/vboxvideo/
 
 DRM DRIVER FOR VMWARE VIRTUAL GPU
-M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	Zack Rusin <zackr@vmware.com>
+R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -14578,7 +14578,7 @@ PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
 R:	Alexey Makhalov <amakhalov@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
 S:	Supported
@@ -20580,7 +20580,7 @@ F:	tools/testing/vsock/
 
 VMWARE BALLOON DRIVER
 M:	Nadav Amit <namit@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/vmw_balloon.c
@@ -20588,7 +20588,7 @@ F:	drivers/misc/vmw_balloon.c
 VMWARE HYPERVISOR INTERFACE
 M:	Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
 M:	Alexey Makhalov <amakhalov@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 L:	x86@kernel.org
 S:	Supported
@@ -20599,14 +20599,14 @@ F:	arch/x86/kernel/cpu/vmware.c
 VMWARE PVRDMA DRIVER
 M:	Bryan Tan <bryantan@vmware.com>
 M:	Vishnu Dasa <vdasa@vmware.com>
-M:	VMware PV-Drivers <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/hw/vmw_pvrdma/
 
 VMware PVSCSI driver
 M:	Vishal Bhakta <vbhakta@vmware.com>
-M:	VMware PV-Drivers <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/vmw_pvscsi.c
@@ -20614,7 +20614,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Vivek Thampi <vithampi@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/ptp/ptp_vmw.c
@@ -20622,15 +20622,15 @@ F:	drivers/ptp/ptp_vmw.c
 VMWARE VMCI DRIVER
 M:	Jorgen Hansen <jhansen@vmware.com>
 M:	Vishnu Dasa <vdasa@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-kernel@vger.kernel.org
-L:	pv-drivers@vmware.com (private)
 S:	Maintained
 F:	drivers/misc/vmw_vmci/
 
 VMWARE VMMOUSE SUBDRIVER
 M:	Zack Rusin <zackr@vmware.com>
-M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
-M:	"VMware, Inc." <pv-drivers@vmware.com>
+R:	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/input/mouse/vmmouse.c
@@ -20638,7 +20638,7 @@ F:	drivers/input/mouse/vmmouse.h
 
 VMWARE VMXNET3 ETHERNET DRIVER
 M:	Ronak Doshi <doshir@vmware.com>
-M:	pv-drivers@vmware.com
+R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/vmxnet3/
