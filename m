Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECC751EB14
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 04:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiEHCq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 22:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447189AbiEHCqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 22:46:50 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678ACF6
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 19:42:53 -0700 (PDT)
X-QQ-mid: bizesmtp66t1651977607t5j9ik6z
Received: from localhost.localdomain ( [125.69.42.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 08 May 2022 10:40:05 +0800 (CST)
X-QQ-SSF: 01000000002000E0S000B00A0000000
X-QQ-FEAT: 7zplUpjHcnrMz5odkXxNlKjMgcSI34LHNMTkXMtsnZiYvjPMp7kMA2oWwDw6c
        TJyqM+/RXHIZFYX5eTrjQQHe29VhIljOLYmqMC65lODj/J8h8b1vB/Tdj/cyfGkT5a+naGH
        x3CDh4PFGVHmsntgVIZUDEiJ8H0Sg5eVrdyBFKqacPp9yvROmNQOLDU9FxwIWd3nttOU6an
        xMk9Hl0yHlvIIb9Ea4Qd0fwXotq1mh+dS/Yk18cPN4798PyaRkUPc2LQ2iyatA+/tJX+uLw
        0x6A4vbvOgh/u3CtsFfSnlomhG+y8q5NAqvtx7G+U00VxZSxNFHFtqM7J2u/beLyGKjEPQI
        8Ah9UwFL28vcqts8A8=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, clg@kaod.org,
        maz@kernel.org, npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        kernel.noureddine@gmail.com, aik@ozlabs.ru,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Fix typo in a comment
Date:   Sun,  8 May 2022 10:40:01 +0800
Message-Id: <20220508024001.107483-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in the comment in line 212 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/powerpc/kvm/book3s_xive_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index f81ba6f84e72..5271c33fe79e 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -209,7 +209,7 @@ static int kvmppc_xive_native_reset_mapped(struct kvm *kvm, unsigned long irq)
 
 	/*
 	 * Clear the ESB pages of the IRQ number being mapped (or
-	 * unmapped) into the guest and let the the VM fault handler
+	 * unmapped) into the guest and let the VM fault handler
 	 * repopulate with the appropriate ESB pages (device or IC)
 	 */
 	pr_debug("clearing esb pages for girq 0x%lx\n", irq);
-- 
2.35.1

