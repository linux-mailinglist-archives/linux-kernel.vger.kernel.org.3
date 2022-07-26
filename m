Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFAF580DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiGZHbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiGZHa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:30:57 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A92A2D1EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:27:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VKUNX5e_1658820387;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VKUNX5e_1658820387)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 15:26:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 02/20] drm/amd/display: Clean up some inconsistent indenting
Date:   Tue, 26 Jul 2022 15:25:37 +0800
Message-Id: <20220726072555.91323-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
References: <20220726072555.91323-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

smatch warnings:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mpc.c:306 mpc32_get_shaper_current() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 94141f5e6994..357bd2461bc9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -300,24 +300,24 @@ static enum dc_lut_mode mpc32_get_shaper_current(struct mpc *mpc, uint32_t mpcc_
 	uint32_t state_mode;
 	struct dcn30_mpc *mpc30 = TO_DCN30_MPC(mpc);
 
-	REG_GET(MPCC_MCM_SHAPER_CONTROL[mpcc_id],
-			MPCC_MCM_SHAPER_MODE_CURRENT, &state_mode);
-
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
+	REG_GET(MPCC_MCM_SHAPER_CONTROL[mpcc_id], MPCC_MCM_SHAPER_MODE_CURRENT, &state_mode);
+
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
 
 
-- 
2.20.1.7.g153144c

