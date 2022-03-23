Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607D54E5BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbiCWXdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbiCWXdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:33:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A82E90CCF;
        Wed, 23 Mar 2022 16:31:44 -0700 (PDT)
Date:   Wed, 23 Mar 2022 23:31:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648078301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mb8sRc00s7UweUwt1QoAi01Vq/4TD9UyM7gruvNKweM=;
        b=vJVxTFd/yzIq5owV6d84fhzjPurzls/0HhmMnQea4UKo0RGCd+eBMuH7rtiqlsSCLpD9yb
        wjn5G1PXtHbrAZwQX4u/kcCs8kMUOVR5fn1toPArSuiTAKnhc8fZeCusdGeG+Zwpm0KEBC
        JnkD33kadwecDmgDoha03Q5jIy8QGnF0MAleg6N38NEF/7lmlihpELjpGivCpso56hB8FL
        CjFSe0HAoPxGAt4P87FTEy1jatmuJF1QEeOaWD0BEIkr+8y6VQC2Gm+jfDm3pgYGmjO80j
        Z6frWd/mDnhycQF2o1XW0B7RCf/+ei6r4bGDOKoNktTOCK5vZIn+rYdmEqu3DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648078301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mb8sRc00s7UweUwt1QoAi01Vq/4TD9UyM7gruvNKweM=;
        b=UPr8IfNb1iIeO07lu8i7bbz16cYABb/3nzRpIMdEgrAlhVhEnP+vwNBAzS1d1iDtYU0O1v
        CZB4WUhq4b5TCOAw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220129173647.27981-3-chang.seok.bae@intel.com>
References: <20220129173647.27981-3-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <164807829910.389.4784020527797489400.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     20df737561484cb2d42e537663c03a7311d2b3c1
Gitweb:        https://git.kernel.org/tip/20df737561484cb2d42e537663c03a7311d2b3c1
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sat, 29 Jan 2022 09:36:47 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Mar 2022 21:28:34 +01:00

selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test

Update the arch_prctl test to check the permission bitmap whether the
requested feature is added as expected or not.

Every non-dynamic feature that is enabled is permitted already for use.
TILECFG is not dynamic feature. Ensure the bit is always on from
ARCH_GET_XCOMP_PERM.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220129173647.27981-3-chang.seok.bae@intel.com

---
 tools/testing/selftests/x86/amx.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 3615ef4..2189f03 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -368,9 +368,16 @@ static void req_xtiledata_perm(void)
 
 static void validate_req_xcomp_perm(enum expected_result exp)
 {
-	unsigned long bitmask;
+	unsigned long bitmask, expected_bitmask;
 	long rc;
 
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_PERM, &bitmask);
+	if (rc) {
+		fatal_error("prctl(ARCH_GET_XCOMP_PERM) error: %ld", rc);
+	} else if (!(bitmask & XFEATURE_MASK_XTILECFG)) {
+		fatal_error("ARCH_GET_XCOMP_PERM returns XFEATURE_XTILECFG off.");
+	}
+
 	rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, XFEATURE_XTILEDATA);
 	if (exp == FAIL_EXPECTED) {
 		if (rc) {
@@ -383,10 +390,15 @@ static void validate_req_xcomp_perm(enum expected_result exp)
 		fatal_error("ARCH_REQ_XCOMP_PERM saw unexpected failure.\n");
 	}
 
+	expected_bitmask = bitmask | XFEATURE_MASK_XTILEDATA;
+
 	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_PERM, &bitmask);
 	if (rc) {
 		fatal_error("prctl(ARCH_GET_XCOMP_PERM) error: %ld", rc);
-	} else if (bitmask & XFEATURE_MASK_XTILE) {
+	} else if (bitmask != expected_bitmask) {
+		fatal_error("ARCH_REQ_XCOMP_PERM set a wrong bitmask: %lx, expected: %lx.\n",
+			    bitmask, expected_bitmask);
+	} else {
 		printf("\tARCH_REQ_XCOMP_PERM is successful.\n");
 	}
 }
