Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62DA580DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiGZHcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbiGZHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:31:34 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D212BB15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:27:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUPgin_1658820416;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUPgin_1658820416)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:26:58 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 09/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:44 +0800
Message-Id: <20220726072555.91323-9-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp.c:724 dpp3_get_blndgam_current() warn: inconsistent indenting.
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_dpp.c:823 dpp3_get_shaper_current() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 77 +++++++++----------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 787b852eeaf2..77b00f86c216 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -716,28 +716,27 @@ static enum dc_lut_mode dpp3_get_blndgam_current(struct dpp *dpp_base)
 
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
-	REG_GET(CM_BLNDGAM_CONTROL,
-			CM_BLNDGAM_MODE_CURRENT, &mode_current);
-	REG_GET(CM_BLNDGAM_CONTROL,
-			CM_BLNDGAM_SELECT_CURRENT, &in_use);
-
-		switch (mode_current) {
-		case 0:
-		case 1:
-			mode = LUT_BYPASS;
-			break;
-
-		case 2:
-			if (in_use == 0)
-				mode = LUT_RAM_A;
-			else
-				mode = LUT_RAM_B;
-			break;
-		default:
-			mode = LUT_BYPASS;
-			break;
-		}
-		return mode;
+	REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_MODE_CURRENT, &mode_current);
+	REG_GET(CM_BLNDGAM_CONTROL, CM_BLNDGAM_SELECT_CURRENT, &in_use);
+
+	switch (mode_current) {
+	case 0:
+	case 1:
+		mode = LUT_BYPASS;
+		break;
+
+	case 2:
+		if (in_use == 0)
+			mode = LUT_RAM_A;
+		else
+			mode = LUT_RAM_B;
+		break;
+	default:
+		mode = LUT_BYPASS;
+		break;
+	}
+
+	return mode;
 }
 
 static bool dpp3_program_blnd_lut(struct dpp *dpp_base,
@@ -817,24 +816,24 @@ static enum dc_lut_mode dpp3_get_shaper_current(struct dpp *dpp_base)
 	uint32_t state_mode;
 	struct dcn3_dpp *dpp = TO_DCN30_DPP(dpp_base);
 
-	REG_GET(CM_SHAPER_CONTROL,
-			CM_SHAPER_MODE_CURRENT, &state_mode);
+	REG_GET(CM_SHAPER_CONTROL, CM_SHAPER_MODE_CURRENT, &state_mode);
 
-		switch (state_mode) {
-		case 0:
-			mode = LUT_BYPASS;
-			break;
-		case 1:
-			mode = LUT_RAM_A;
-			break;
-		case 2:
-			mode = LUT_RAM_B;
-			break;
-		default:
-			mode = LUT_BYPASS;
-			break;
-		}
-		return mode;
+	switch (state_mode) {
+	case 0:
+		mode = LUT_BYPASS;
+		break;
+	case 1:
+		mode = LUT_RAM_A;
+		break;
+	case 2:
+		mode = LUT_RAM_B;
+		break;
+	default:
+		mode = LUT_BYPASS;
+		break;
+	}
+
+	return mode;
 }
 
 static void dpp3_configure_shaper_lut(
-- 
2.20.1.7.g153144c

