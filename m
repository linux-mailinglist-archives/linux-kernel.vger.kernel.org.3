Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3665533C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351733AbiFUNgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351706AbiFUNgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:36:09 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D811A2AE31
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:35:05 -0700 (PDT)
X-QQ-mid: bizesmtp82t1655818482t4lelr4u
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:34:37 +0800 (CST)
X-QQ-SSF: 0100000000700050B000D00A0000000
X-QQ-FEAT: xoS364mEyr1O7d4xyo1etuat7DIRMKm12/lCtpnC6qIif68t8nBxJY9ZY0STk
        aCyrhNuGMgYXDparfZoJuQ8uDc1fRY/EfzT/bF1r+YwjyQ3a2uB8NaB05pVwtNaxYlvfv//
        7dvJk1QTs0S1HUe/b4a35ZsfECag7K0z5MaNcrgykUjt1BrvA1qpMh0Ah56LlZZSBenHPRC
        bjKuzCJl1sZpG0o4wDlIK3ryt54M7HbVAZPyYJxtt4UESyhWT+mTnQQQHbTR9+6tWIk9rzE
        nUsJfM/qnjuFYHX2rDtvcJWkt6GE6IR04hq+FB8b5x3HnegcrA1rXb1obNyp1SIO6E2QvSk
        /BzCRf1lNt7q/sT7Nbrs2XjoA/7Sw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm/i915: i915_irq - drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:34:35 +0800
Message-Id: <20220621133435.5924-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/i915/i915_irq.c
line 68
 * interrupt originated from the the GPU so interrupts from a device which
changed to
 * interrupt originated from the GPU so interrupts from a device which

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/i915/i915_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 73cebc6aa650..783a6ca41a61 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -65,7 +65,7 @@
 
 /*
  * Interrupt statistic for PMU. Increments the counter only if the
- * interrupt originated from the the GPU so interrupts from a device which
+ * interrupt originated from the GPU so interrupts from a device which
  * shares the interrupt line are not accounted.
  */
 static inline void pmu_irq_stats(struct drm_i915_private *i915,
-- 
2.17.1

