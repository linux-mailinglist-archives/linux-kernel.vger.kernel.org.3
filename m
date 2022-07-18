Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28739577BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbiGRGxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiGRGxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:53:08 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DBAE0C8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:53:01 -0700 (PDT)
X-QQ-mid: bizesmtp77t1658127135tqg7psaz
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 14:52:13 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000000
X-QQ-FEAT: 7jw2iSiCazrpAmasGQ+fEzHMqngiHAVkye+mDbco5m3HTtQMnqfHCd56zl2xI
        /sN7EoYT1AQvGFKDxpt1+xLBdRjibneM+QjRAJCepCekBAQ2uHURgYc8jwyxnqlmdnEu8Y6
        Lc/YIW9SF9PTyOr8pEh2HcNkB/RRxyqAni+p6j+jfjyGnyoEofzaBWe7NUPpQwnkc0LW5k2
        GATyvZ833lYJf/CV8WpOKkLw7bj9x3iTZZ3iAq1F0xv0TUcx1fmt4Ac0g30yp6qYqR4rH5G
        7rWEFNTO+y3fzWlZCacpkl6PNIj0/IYQHiecil+h3RNgd1VL5siZYBRcrRPJ3YcohlM9EL2
        Qbh3oTiYXnmMV2bi0SDQfdI9lq8POKkq6pmygeKERYpKD91ZdUk8247dc3J25fr+yMrqgm6
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, farosas@linux.ibm.com,
        npiggin@gmail.com, clg@kaod.org, aik@ozlabs.ru,
        maciej.szmigiero@oracle.com, Julia.Lawall@inria.fr,
        liubo03@inspur.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] KVM: PPC: Fix comment typo
Date:   Mon, 18 Jul 2022 14:51:42 +0800
Message-Id: <20220718065142.24640-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' in line 1604 is duplicated, removed one.

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

