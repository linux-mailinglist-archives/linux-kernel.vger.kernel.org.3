Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16457F520
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiGXMzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiGXMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:54:00 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115412AD5;
        Sun, 24 Jul 2022 05:53:54 -0700 (PDT)
X-QQ-mid: bizesmtp86t1658667219tiqqdwip
Received: from localhost.localdomain ( [171.223.97.251])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 20:53:37 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: RrZlkntZBflKcuY8rrgOtE6VDI+adS2tmGpOUI5TaU9rC6YaVQCXtBpTxBiDD
        w/Tu1RgqOoKHEX2qqZGRqWAw0LKbxyzhsG9oW+KkLDWgYINr33l572bzy+wU7mdQdzHeY8U
        qQe4xOhQ9A8iGRjzbufEFp01vo8aCb9pXyyviQfM79ZfpyvxGyNG+9w96D8SLtu6wicASts
        phknQuDRPu5AyKs7BrJvKlKvpasIkXiyYpo0b3Ve+SqxJ3/upzksCZkAb+moGdJIRti4aLD
        ROfi2F5VcHDiz71+BpqVkQwjZI/vzDr/JypXAVwQ9MWNE8+bRNSU2j/dYzTtXsVYOPMZhpH
        f5bGHj8orl0TIOEMOxBGANgMBDw8X5vsd6fwzkJmzFOHEpZs216OoB9gFI17Gy/vDtl7AOi
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     quic_abhinavk@quicinc.com
Cc:     robdclark@gmail.com, dmitry.baryshkov@linaro.org, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, bjorn.andersson@linaro.org,
        quic_kalyant@quicinc.com, quic_vpolimer@quicinc.com,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/msm/dpu: Fix comment typo
Date:   Mon, 25 Jul 2022 04:42:42 +0800
Message-Id: <20220724204242.4107-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `be' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 71fe4c505f5b..38aa38ab1568 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -76,7 +76,7 @@ enum {
 
 /**
  * MDP TOP BLOCK features
- * @DPU_MDP_PANIC_PER_PIPE Panic configuration needs to be be done per pipe
+ * @DPU_MDP_PANIC_PER_PIPE Panic configuration needs to be done per pipe
  * @DPU_MDP_10BIT_SUPPORT, Chipset supports 10 bit pixel formats
  * @DPU_MDP_BWC,           MDSS HW supports Bandwidth compression.
  * @DPU_MDP_UBWC_1_0,      This chipsets supports Universal Bandwidth
-- 
2.35.1


