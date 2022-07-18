Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D627577F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiGRKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiGRKAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:00:25 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A511A3A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:00:19 -0700 (PDT)
X-QQ-mid: bizesmtp86t1658138355tjhkudby
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 17:59:14 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000000
X-QQ-FEAT: lO87fmWkX3E5qms+Os8ereri50t437h26GU7cDy3ex2Skf9XW9+uSBUipAcSm
        qMEYHbNj41fDVsieOjodvTtxJFu/K7JA+Qstq5KpnNqsMmElR9CNJrLezLBh9E98jc/fGza
        xHKcW4P2RNMEuFd/NxVK9ZZvIfTWD3WzGnr0HaEfMCAKxB7+uGw9cChv5stMEqqgNlAiokc
        POgY/m3NqqWgVV8yyJYeTCSYlk+p+7a+x5PZQMgD8t9ods/GVX94/3p+t38dV0O75Ss7HNg
        Z7QSmpF/NyxBQwnmNRdstTfckgW69Bxc8+LPKCd3pyy+hZXclmPnHyxR2uMsgeXvNAPysVJ
        J5BaKcViLkbKVKsg10OrhPGt4KOleSl20zHHp7hdyN7QcVDXiLnmY5+WX/1YpzaL8rPmnMX
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     paulus@samba.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        farosas@linux.ibm.com, npiggin@gmail.com, aik@ozlabs.ru,
        maciej.szmigiero@oracle.com, Julia.Lawall@inria.fr,
        liubo03@inspur.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] Merge: Fix comment typo
Date:   Mon, 18 Jul 2022 17:59:10 +0800
Message-Id: <20220718095910.188312-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' is duplicated in line 1604, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

