Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE4B520D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiEJGJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiEJGJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:09:04 -0400
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2635C2A375D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:05:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VCpD4Yc_1652162694;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCpD4Yc_1652162694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 14:05:03 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     alexander.deucher@amd.com
Cc:     christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amdgpu: clean up some inconsistent indenting
Date:   Tue, 10 May 2022 14:04:40 +0800
Message-Id: <20220510060440.67178-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c:35 nbio_v7_7_get_rev_id() warn:
inconsistent indenting.

drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c:214 nbio_v7_7_init_registers()
warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index e32c874b42b5..cdc0c9779848 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -32,8 +32,7 @@ static u32 nbio_v7_7_get_rev_id(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
-
+	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
 
@@ -211,14 +210,14 @@ static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
 
-		def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3);
-		data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
-			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
-		data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
-			CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+	def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3);
+	data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
+			     CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+	data = REG_SET_FIELD(data, BIF0_PCIE_MST_CTRL_3,
+			     CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
 
-		if (def != data)
-			WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
 
 }
 
-- 
2.20.1.7.g153144c

