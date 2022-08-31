Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE55A72E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiHaAqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbiHaAq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:46:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005254E842
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:45:07 -0700 (PDT)
X-QQ-mid: bizesmtp89t1661906702tacmp2wv
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 08:45:01 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: ILHsT53NKPgLPSHQc+3alBEDo3E+b66UsNeloFQYZyjTsUQP+GBcWJ8GsC2+T
        3uoK1s805FksAjqgfvKZEXtbX+6opyFPYfV69z/8hI0gfMbV4U7+vpUSaUBRWrmeGdfgaJW
        0xWPnsEl+EDQ6M551sw0XhWBok3eDSAne2LBrrlSA+mrOOnPwr2pQnbKRIITbwIXErk/PxC
        UFCpg9RAZlTrilqS39yQVgTkXBGRWIB4C4DAu93UYPIeEBHNwoUXXNSNaYygrzPGxyGd2at
        rDzMQfXO6Hp41IsXd/kxasNcKnFdRIwLcR/PXC7M1OOiWjka6kC5hNOZ9uyc5OvCGJ6K+1g
        rpVt5c/GpSO+mP5HtI=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] KVM: fix repeated words in comments
Date:   Wed, 31 Aug 2022 08:44:54 +0800
Message-Id: <20220831004454.33921-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'that'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index e9744b41a226..8e4b42b5f37f 100644
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

