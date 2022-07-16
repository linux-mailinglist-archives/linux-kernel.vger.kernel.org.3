Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE9576E16
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiGPNC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPNC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:02:27 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3172B4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 06:02:22 -0700 (PDT)
X-QQ-mid: bizesmtp85t1657976518tiba5dfa
Received: from localhost.localdomain ( [182.132.179.58])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:01:54 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000000
X-QQ-FEAT: ALw5QuVtm4W6g00JOOK8BZrhQ8/YnIxpxoxTCkyqD1twqMvTwDXPkyk/LihOZ
        75YbWFndLq03UAzR2Gt4RP5uSMGPhMjZh0jrRoQ/4Itq6WBv3Wk8ia6H7M36vsWZy4Sprps
        ejmd09KZeNc7USdZubNra1M3WhrHjMB69R0VF/vv5PZC+JUwPFYYo63zg5v4+kPYLzHtHdB
        bWNmKxuNfRmxFezRGvYDIAQI+9KU3Vh8cAYyIZCzkGaVkIvqF9knjMH9EeYpTf2B62rdesx
        lM0fMtEcNt3nIuvgAiKn3jWoIh4OVAKBvpuBStAmp3IYj/Wcbg0kiSQKJjtJWEPn4lNkgAS
        7pQ5Q7ERRICE8xVbnv6L5NtsGFlP3UAQWBxiM+tU0zuJQEAZ69WMAj5yiwYOw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, ramalingam.c@intel.com,
        thomas.hellstrom@linux.intel.com, matthew.auld@intel.com,
        dan.carpenter@oracle.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/i915/gt: Remove unneeded semicolon
Date:   Sun, 17 Jul 2022 02:44:39 +0800
Message-Id: <20220716184439.72056-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon after the `}' in line 648 is unneeded.

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

