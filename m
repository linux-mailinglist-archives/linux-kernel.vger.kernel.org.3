Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037AD577F54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGRKGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiGRKGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:06:10 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B901BE85
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:06:05 -0700 (PDT)
X-QQ-mid: bizesmtp66t1658138720t60o43yy
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 18:05:19 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000000
X-QQ-FEAT: J5JfekO1WsjnFRCaIrI9KYX73TsBVSpDrxrZytBTXGuBm4FsKT62YRtbKmS2l
        ybcFzHccw/BfsvUGYuYAjnVklOzxREmvfcNDfxMnPzZT3LSEcAC+gxSlvsfjXzFS413OitG
        iQJ14cE+YGQBGiLG8V8XxxcruMDZeY6GVOdT3T4mRGEJxnQI9eNZnlrPri8HZxfDTYO4Itf
        cDtbLjQ032MaZ9QKK0eqYU+xy98zgF4TmVrzpqPJ9cbooyd6Arn8rjcFhxEYdw5LxhnZdaY
        3f9la0Hb2HAYeWOoaaPDEa/ZJUqNAAECW8MtTRXcP48lxYjgc4fJ/cj31Ip+/Y7ztUji8A4
        QYGD1dUK0UaoTqmNkEkI7/ztp4Wv4xW63DLsXFJlnZ9j2iIMyg0vCsorDC02dlie+0/8PJ1
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     paulus@samba.org
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        farosas@linux.ibm.com, npiggin@gmail.com, Julia.Lawall@inria.fr,
        aik@ozlabs.ru, maciej.szmigiero@oracle.com, liubo03@inspur.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] KVM: PPC: Book3S HV: Fix comment typo
Date:   Mon, 18 Jul 2022 18:05:04 +0800
Message-Id: <20220718100504.194167-1-wangborong@cdjrlc.com>
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

