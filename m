Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC158FC14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiHKMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiHKMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:20:58 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D08983BF2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:20:56 -0700 (PDT)
X-QQ-mid: bizesmtp86t1660220438tdmfl1qy
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:20:36 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000000
X-QQ-FEAT: k0mQ4ihyJQP2Bpmbn/1SZC8/THmmEo80BPJqBWLE3wvy9Nrej8PJId7DSZhBF
        Dg2Tw3KjpN4N4czRwo7G91yGEgrbZ8LV6u2N8bm4qktlq7PWkTaN3X28EbNM7HVZikcIC1w
        FMhgXgJE51VgDF70SdMHrujxL+EnBXlCGyK9Piksq7+r7QsN83STdcHAoGmAQreuCj/wrxY
        pNtg7Gq9Ax/HShjhaYUjPFl8+gqpp6nQwbfthuo6lVyZeROIoXKzpqOudz13Um8v7h+nsJk
        N01Ama53mftLdHIMSKP/ZVXoQK/QgGD9cCwNhKCVx0ruwRn1+3ACaqm0xF4dwnIS3AA+Sfd
        fmMl2N55UEnkw3pZvQVV7gmMzrKG0Z9hd7F+BwmdXcZRijBZpq09XbyIc4AHsptfIh4tDXY
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     catalin.marinas@arm.com
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] KVM: arm64: Fix comment typo
Date:   Thu, 11 Aug 2022 20:20:29 +0800
Message-Id: <20220811122029.28978-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `to' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm64/kvm/inject_fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index f32f4a2a347f..92de0f817be4 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -155,7 +155,7 @@ void kvm_inject_size_fault(struct kvm_vcpu *vcpu)
 	 * Size Fault at level 0, as if exceeding PARange.
 	 *
 	 * Non-LPAE guests will only get the external abort, as there
-	 * is no way to to describe the ASF.
+	 * is no way to describe the ASF.
 	 */
 	if (vcpu_el1_is_32bit(vcpu) &&
 	    !(vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE))
-- 
2.36.1

