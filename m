Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F05577B9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiFWKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiFWKUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:20:39 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8C3FE1A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:20:38 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5F23D1E80C7D;
        Thu, 23 Jun 2022 18:20:19 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id It6xpm0snNTk; Thu, 23 Jun 2022 18:20:16 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.33])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C822F1E80CCC;
        Thu, 23 Jun 2022 18:20:15 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] KVM: Fix spelling mistake
Date:   Thu, 23 Jun 2022 18:20:31 +0800
Message-Id: <20220623102031.15359-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'subsquent' to 'subsequent'.
Change 'accross' to 'across'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/powerpc/kvm/book3s_xive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 4ca23644f752..b4b680f2d853 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -539,7 +539,7 @@ static int xive_vm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 	if (irq == XICS_IPI || irq == 0) {
 		/*
 		 * This barrier orders the setting of xc->cppr vs.
-		 * subsquent test of xc->mfrr done inside
+		 * subsequent test of xc->mfrr done inside
 		 * scan_interrupts and push_pending_to_hw
 		 */
 		smp_mb();
@@ -563,7 +563,7 @@ static int xive_vm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 	/*
 	 * This barrier orders both setting of in_eoi above vs,
 	 * subsequent test of guest_priority, and the setting
-	 * of xc->cppr vs. subsquent test of xc->mfrr done inside
+	 * of xc->cppr vs. subsequent test of xc->mfrr done inside
 	 * scan_interrupts and push_pending_to_hw
 	 */
 	smp_mb();
@@ -2392,7 +2392,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	/*
 	 * Now, we select a target if we have one. If we don't we
 	 * leave the interrupt untargetted. It means that an interrupt
-	 * can become "untargetted" accross migration if it was masked
+	 * can become "untargetted" across migration if it was masked
 	 * by set_xive() but there is little we can do about it.
 	 */
 
-- 
2.25.1

