Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F059E5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbiHWPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242894AbiHWPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:06:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FA99A691
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:31:03 -0700 (PDT)
X-QQ-mid: bizesmtp76t1661257851toe4j5vo
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 20:30:50 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: CR3LFp2JE4nuRAt3y5hdzUXJ8PhfvhAvvgiJTnr3AKnjupX57tUKbnJ0nioxQ
        INW5jBmZbXBroGHF0+FEYjm+Rk6YHbz4FrAU5YpFmbpuSpYKZS6ApwnmGlzMOARuF0j/UOw
        nRLvkO3uiRovj6Ws064ydTtHc8tAqJ9tsBRASqSkdbO6fAlFlHcbFKOp3tBkmSwwJLJ5a0H
        D2sstLjSXAlo1ELaaTBRDnUQzEseU+sL7y6zDpjARhdyvUOZFg5l08+IbGsaFOBTeh9TXN+
        MEeH8ltMBfZ5lRHkjNjzfgWdQgf3+HvrUqLJ1eAEr3zrdlOe8P3vtARqZ9NDivOhdHUaG8z
        zHJi9D14E+JuUFc2R4HErlF7e0mSLpaLYMXBWUpzZoaqiVvGm+4zb586u+LgjdG7HzOkLd8
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/i915: fix repeated words in comments
Date:   Tue, 23 Aug 2022 20:30:44 +0800
Message-Id: <20220823123044.24593-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'other'.
 Delete the redundant word 'the'.
 Delete the redundant word 'will'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/i915/i915_gem_evict.c | 2 +-
 drivers/gpu/drm/i915/i915_irq.c       | 4 ++--
 drivers/gpu/drm/i915/i915_memcpy.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_evict.c b/drivers/gpu/drm/i915/i915_gem_evict.c
index f025ee4fa526..028e509e1628 100644
--- a/drivers/gpu/drm/i915/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/i915_gem_evict.c
@@ -256,7 +256,7 @@ i915_gem_evict_something(struct i915_address_space *vm,
 	goto search_again;
 
 found:
-	/* drm_mm doesn't allow any other other operations while
+	/* drm_mm doesn't allow any other operations while
 	 * scanning, therefore store to-be-evicted objects on a
 	 * temporary list and take a reference for all before
 	 * calling unbind (which may remove the active reference
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 73cebc6aa650..1e4a705bc5cc 100644
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
@@ -2175,7 +2175,7 @@ static irqreturn_t ilk_irq_handler(int irq, void *arg)
 	raw_reg_write(regs, DEIER, de_ier & ~DE_MASTER_IRQ_CONTROL);
 
 	/* Disable south interrupts. We'll only write to SDEIIR once, so further
-	 * interrupts will will be stored on its back queue, and then we'll be
+	 * interrupts will be stored on its back queue, and then we'll be
 	 * able to process them after we restore SDEIER (as soon as we restore
 	 * it, we'll get an interrupt if SDEIIR still has something to process
 	 * due to its back queue). */
diff --git a/drivers/gpu/drm/i915/i915_memcpy.h b/drivers/gpu/drm/i915/i915_memcpy.h
index 3df063a3293b..126dfb4352f0 100644
--- a/drivers/gpu/drm/i915/i915_memcpy.h
+++ b/drivers/gpu/drm/i915/i915_memcpy.h
@@ -18,7 +18,7 @@ void i915_unaligned_memcpy_from_wc(void *dst, const void *src, unsigned long len
 /* The movntdqa instructions used for memcpy-from-wc require 16-byte alignment,
  * as well as SSE4.1 support. i915_memcpy_from_wc() will report if it cannot
  * perform the operation. To check beforehand, pass in the parameters to
- * to i915_can_memcpy_from_wc() - since we only care about the low 4 bits,
+ * i915_can_memcpy_from_wc() - since we only care about the low 4 bits,
  * you only need to pass in the minor offsets, page-aligned pointers are
  * always valid.
  *
-- 
2.36.1

