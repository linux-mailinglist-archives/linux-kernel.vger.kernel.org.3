Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94B357F375
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 08:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiGXG3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 02:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGXG3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 02:29:44 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E42115801
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 23:29:38 -0700 (PDT)
X-QQ-mid: bizesmtp86t1658644169t732hzsm
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 14:29:27 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: jTyhoG5kVjE+IMviPcyFbe8k8mPtdLra19VGuyaVGwYwIg9vuV5EXT6TvFo37
        MTgs92cNK4oES9V3yo35SOT5nmwPwEFMvqSrKEpPfFO9XZPg4kEM0SBftNl5BeE/K+kkocR
        gy094Nsxet9LYgRhvVJDqjQV0jTxUNqJnpFw30IEk6Ka25tKExZp3DpP0aqMx/Dm+zUZ3+X
        pcWXnRuSXzjZUCNZJLNHKzbCHZRFZNd0y5VwEtzVEaZhBSyYVpD5YeLsby9QtLIQ4YxU2P3
        u5E/F5FZ1XTRCZCcoGGRIKRvGtBSt667gyWfavwAq1c6XjgzspsxPmQxuylpcytVBeoIpek
        dv7rNduC27jQkLtABwq4LfP3/FAQA4aIrn01MQw
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Julia.Lawall@inria.fr, liubo03@inspur.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] powerpc/kvm: fix repeated words in comments Delete the redundant word 'that'.
Date:   Sun, 24 Jul 2022 14:29:20 +0800
Message-Id: <20220724062920.1551-1-wangjianli@cdjrlc.com>
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

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 514fd45c1994..73c6db20cd8a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1601,7 +1601,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
  * is valid, it is written to the HPT as if an H_ENTER with the
  * exact flag set was done.  When the invalid count is non-zero
  * in the header written to the stream, the kernel will make
- * sure that that many HPTEs are invalid, and invalidate them
+ * sure that many HPTEs are invalid, and invalidate them
  * if not.
  */
 
-- 
2.36.1

