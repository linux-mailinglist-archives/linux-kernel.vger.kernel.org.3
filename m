Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD5459E564
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbiHWOxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbiHWOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:53:09 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7411695D9;
        Tue, 23 Aug 2022 05:18:16 -0700 (PDT)
X-QQ-mid: bizesmtp67t1661255821tgysc78a
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 19:57:00 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: ElntjVByhgVQv4+GOszWIo/B50C+UxqZL1+AmKuizmDK1uH7z+g2iiryx0hmA
        1G1WEJ0FlHyuGSgfekId81w8IBsTH6wo69LieT81SqIGNNViyOkOyK5t9kAOamiHOmn2ygY
        7fWy2UyDXHCroky5EP/pOeCQ0RxbKWLoXWssXWY4Clvy+xXfhX4qB3yHNrGuH7KBE+eSvYU
        3n8KuwB5FRrCIGf9QJR+8DzVNDUSVQmhdTzIojoeZULgcuiJ7F9CjRNOUaRx4i+dCAf7cXT
        L7aSWqCYEp/+nTWuD5qpHT/2GVZ/VEqiYycduTsEAx6wFQdRoaOiUKIylh3TTjSx/IDu09J
        YGxTfhfRTACWyMUA2+b8uK9/6sVn2IcftTifnC9d7xGhLud3L7INJeNqISxqQzRpj+rr8r7
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] msm/adreno: fix repeated words in comments
Date:   Tue, 23 Aug 2022 19:56:54 +0800
Message-Id: <20220823115654.58725-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'power'.
 Delete the redundant word 'in'.
 Delete the redundant word 'for'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9f76f5b15759..32ecb783c3c1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -352,7 +352,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state)
 	gmu_write(gmu, REG_A6XX_GMU_HOST2GMU_INTR_SET, 1 << bit);
 }
 
-/* Enable CPU control of SPTP power power collapse */
+/* Enable CPU control of SPTP power collapse */
 static int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
 {
 	int ret;
@@ -374,7 +374,7 @@ static int a6xx_sptprac_enable(struct a6xx_gmu *gmu)
 	return 0;
 }
 
-/* Disable CPU control of SPTP power power collapse */
+/* Disable CPU control of SPTP power collapse */
 static void a6xx_sptprac_disable(struct a6xx_gmu *gmu)
 {
 	u32 val;
@@ -1277,7 +1277,7 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
 		}
 
 		/*
-		 * Look for a level in in the secondary list that matches. If
+		 * Look for a level in the secondary list that matches. If
 		 * nothing fits, use the maximum non zero vote
 		 */
 
@@ -1559,7 +1559,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node)
 			goto err_memory;
 	}
 
-	/* Allocate memory for for the HFI queues */
+	/* Allocate memory for the HFI queues */
 	ret = a6xx_gmu_memory_alloc(gmu, &gmu->hfi, SZ_16K, 0, "hfi");
 	if (ret)
 		goto err_memory;
-- 
2.36.1

