Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580EB57F363
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 07:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbiGXFmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 01:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXFmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 01:42:03 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D170120AB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 22:41:55 -0700 (PDT)
X-QQ-mid: bizesmtp81t1658641306twz9vf55
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 13:41:44 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: cHidGA2rQwyAyU3ofjyHh1llcWAxjWPyQbM9Hva8mIGipCcfclJB8jIqu/Hc+
        VBmhw+ioVNQ2yKrwvJsNXFj7lD9A13xTP/vX48qYF+pb6SL3cW2N+faGhPXPzG2FpYTweMm
        1yrRR2cPiTJdYyv5P7ar/NuaA7JctpI/NumVana7EwQu98raXnzezDP7foQquvECaIfROde
        7+SegYhfZ8k1oj2e0WDF0teDJjT2NzpeoFydb1rQFmrtZkcCzQotEZyLHzszco6QWF0WvHI
        sf9S65yxxMWLGWbGhHgxxMY++Wq/k4vXf9DMg8sMOaa88Xo+5JqAct5cxzZaVnp/rLfR4Cy
        qdZVxoAmXkL1CDKiRw=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jianli Wang <wangjianli@cdjrlc.com>
Subject: [PATCH] KVM: PPC: Book3S HV:fix repeated words in comments
Date:   Sun, 24 Jul 2022 13:41:37 +0800
Message-Id: <20220724054137.58504-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianli Wang <wangjianli@cdjrlc.com>

Delete the redundant word 'do'.

Signed-off-by: Jianli Wang <wangjianli@cdjrlc.com>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e08fb3124dca..17d79be6077d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5643,7 +5643,7 @@ static int kvmppc_clr_passthru_irq(struct kvm *kvm, int host_irq, int guest_gsi)
 	else
 		kvmppc_xics_clr_mapped(kvm, guest_gsi, pimap->mapped[i].r_hwirq);
 
-	/* invalidate the entry (what do do on error from the above ?) */
+	/* invalidate the entry (what do on error from the above ?) */
 	pimap->mapped[i].r_hwirq = 0;
 
 	/*
-- 
2.25.1

