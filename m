Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2448DA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiAMPE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbiAMPEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:04:52 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F29EC061749;
        Thu, 13 Jan 2022 07:04:52 -0800 (PST)
Received: from localhost.localdomain (89-166-24-184.bb.dnainternet.fi [89.166.24.184])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id ECBE63F43A;
        Thu, 13 Jan 2022 15:55:31 +0100 (CET)
From:   Jami Kettunen <jami.kettunen@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/msm/dpu1: Add DMA2, DMA3 clock control to enum
Date:   Thu, 13 Jan 2022 16:51:09 +0200
Message-Id: <20220113145111.29984-2-jami.kettunen@somainline.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113145111.29984-1-jami.kettunen@somainline.org>
References: <20220113145111.29984-1-jami.kettunen@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

The enum dpu_clk_ctrl_type misses DPU_CLK_CTRL_DMA{2,3} even though
this driver does actually handle both, if present: add the two in
preparation for adding support for SoCs having them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index 31af04afda7d..736f52c742fb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -435,6 +435,8 @@ enum dpu_clk_ctrl_type {
 	DPU_CLK_CTRL_RGB3,
 	DPU_CLK_CTRL_DMA0,
 	DPU_CLK_CTRL_DMA1,
+	DPU_CLK_CTRL_DMA2,
+	DPU_CLK_CTRL_DMA3,
 	DPU_CLK_CTRL_CURSOR0,
 	DPU_CLK_CTRL_CURSOR1,
 	DPU_CLK_CTRL_INLINE_ROT0_SSPP,
-- 
2.34.1

