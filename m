Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E317B579B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbiGSMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiGSM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:29:40 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A121691E5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:11:18 -0700 (PDT)
X-QQ-mid: bizesmtp71t1658232648tu95v5nq
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:10:46 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: WKaXkSLX6oOMxAmviYlNwWMv0TGdduPbzjHTO13LpUEcMocSaLByA3yu89Ts0
        n+ccWHkn7zegKCtYtTWm5WfhHBFSmYdhZc7sgYjIHla9C5H17pGbCG7xu0sW12+8M/JGNy2
        gCQvXAjwbl+GEXJWWF9AWXe75EwPDyEFq2C8IZSAoZkbCpiwMbFkwryekJndBs7vs6iCEgr
        L02r5aiDNchyx/HpFMJx4Ks8Xsc/7qo7IJsw8k6qjAQr5xrZoCDpaouqH65tPn75su0Wg1u
        5FeeDWlURjKll6ONUT+pbywPeT3mrdTjcxnF5BJKop6vvUqRyO9kRs6jkb3BL962brhPto3
        bsCZZaBE+44mwQWPY20ItApVIWfY3vR/HvmRTtMXL8r1+OcRMIQA7EFCcoWJ32uKHBk8efh
        TfmRjq4Y++Q=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, ramalingam.c@intel.com,
        thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
        dan.carpenter@oracle.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/i915/gt: Remove unneeded semicolon
Date:   Sat, 16 Jul 2022 12:08:45 +0800
Message-Id: <20220716040845.32045-1-wangborong@cdjrlc.com>
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

The semicolon after a code block end symbol `}' is unneeded, remove
it.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/i915/gt/intel_migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_migrate.c b/drivers/gpu/drm/i915/gt/intel_migrate.c
index 2c35324b5f68..a69b244f14d0 100644
--- a/drivers/gpu/drm/i915/gt/intel_migrate.c
+++ b/drivers/gpu/drm/i915/gt/intel_migrate.c
@@ -645,7 +645,7 @@ static int scatter_list_length(struct scatterlist *sg)
 	while (sg && sg_dma_len(sg)) {
 		len += sg_dma_len(sg);
 		sg = sg_next(sg);
-	};
+	}
 
 	return len;
 }
-- 
2.35.1

