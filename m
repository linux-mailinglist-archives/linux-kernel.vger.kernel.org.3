Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF494D56E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiCKAnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiCKAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:43:46 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FEDB1095
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:42:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V6qUi.A_1646959359;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V6qUi.A_1646959359)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Mar 2022 08:42:40 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     christian.koenig@amd.com
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/amd/pm: clean up some inconsistent indenting
Date:   Fri, 11 Mar 2022 08:42:38 +0800
Message-Id: <20220311004238.112196-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:174
__smu_cmn_reg_print_error() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index ae64d1980f10..5ed11624f144 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -164,17 +164,17 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 
 	switch (reg_c2pmsg_90) {
 	case SMU_RESP_NONE: {
-	if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
-		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
-		prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
-	} else {
-		msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
-		prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	}
-		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
-				    msg_idx, prm);
-	}
+		if (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 5)) {
+			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
+			prm     = RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
+		} else {
+			msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
+			prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+		}
+			dev_err_ratelimited(adev->dev,
+				"SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
+				msg_idx, prm);
+		}
 		break;
 	case SMU_RESP_OK:
 		/* The SMU executed the command. It completed with a
-- 
2.20.1.7.g153144c

