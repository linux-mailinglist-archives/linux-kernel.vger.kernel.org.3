Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACA657C453
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiGUGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGUGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:24:26 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C4DF57203
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JU89J
        36GF9qGZOl7Xq6oLoAVJwT8cghcIvZdxBIak1s=; b=W1jRFAtMf3CjJAPBmsTSy
        LE7ICAEABQ+mW5cdyN5BXA65dNFY2i3hR5czcehMXvX9JZS4FNZ0e0KzXhCSaIcN
        ApQbXUsKUd5sHE21BznGS/Jpt0YpH5grFc8BTDC5c6FIisoL0ZBGHTNU+drD/ur3
        O8xKTRM89mn4nBrhkMADeE=
Received: from localhost.localdomain (unknown [112.97.57.47])
        by smtp3 (Coremail) with SMTP id G9xpCgBnYpvz8Nhi5euzQQ--.1300S2;
        Thu, 21 Jul 2022 14:23:52 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     airlied@linux.ie, daniel@ffwll.ch, linus.walleij@linaro.org,
        thierry.reding@gmail.com, sam@ravnborg.org, imre.deak@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] drm: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 14:23:45 +0800
Message-Id: <20220721062345.46842-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBnYpvz8Nhi5euzQQ--.1300S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyDCryrJrWDJF15Ary3twb_yoW8tFyDpF
        47GFy2vrZ8AF1jqay7A3Wjka43CanFqFyfKFWkCwsxZr45AF1jy34rGFWUJFyDJr4xAw12
        yr9xKrWI9a4jyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_c_TAUUUUU=
X-Originating-IP: [112.97.57.47]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivxhFZFWB0i3GQgAAsp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c       | 2 +-
 drivers/gpu/drm/i915/i915_irq.c               | 2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e5bab236b3ae..32b295003f49 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -1597,7 +1597,7 @@ static int drm_dp_aux_reply_duration(const struct drm_dp_aux_msg *msg)
 
 /*
  * Calculate the length of the i2c transfer in usec, assuming
- * the i2c bus speed is as specified. Gives the the "worst"
+ * the i2c bus speed is as specified. Gives the "worst"
  * case estimate, ie. successful while as long as possible.
  * Doesn't account the "MOT" bit, and instead assumes each
  * message includes a START, ADDRESS and STOP. Neither does it
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
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 40ea41b0a5dd..4085822f619a 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -231,7 +231,7 @@ struct nt35510_config {
 	 * bits 0..2 in the lower nibble controls HCK, the booster clock
 	 * frequency, the values are the same as for PCK in @bt1ctr.
 	 * bits 4..5 in the upper nibble controls BTH, the boosting
-	 * amplification for the the step-up circuit.
+	 * amplification for the step-up circuit.
 	 * 0 = AVDD + VDDB
 	 * 1 = AVDD - AVEE
 	 * 2 = AVDD - AVEE + VDDB
-- 
2.25.1

