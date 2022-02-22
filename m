Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5124BEF13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiBVBXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:23:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiBVBXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:23:32 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D2225C40
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 17:23:07 -0800 (PST)
Received: from localhost.localdomain (abxh33.neoplus.adsl.tpnet.pl [83.9.1.33])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 364443F5D2;
        Tue, 22 Feb 2022 02:23:05 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/msm/adreno: Fix up formatting
Date:   Tue, 22 Feb 2022 02:22:48 +0100
Message-Id: <20220222012252.6373-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222012252.6373-1-konrad.dybcio@somainline.org>
References: <20220222012252.6373-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leading spaces are not something checkpatch likes, and it says so when
they are present. Use tabs consistently to indent function body and
unwrap a 83-char-long line, as 100 is cool nowadays.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 9e3b4ea7f9bc..e1f9d7442114 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -198,7 +198,7 @@ static inline int adreno_is_a420(struct adreno_gpu *gpu)
 
 static inline int adreno_is_a430(struct adreno_gpu *gpu)
 {
-       return gpu->revn == 430;
+	return gpu->revn == 430;
 }
 
 static inline int adreno_is_a506(struct adreno_gpu *gpu)
@@ -238,7 +238,7 @@ static inline int adreno_is_a540(struct adreno_gpu *gpu)
 
 static inline int adreno_is_a618(struct adreno_gpu *gpu)
 {
-       return gpu->revn == 618;
+	return gpu->revn == 618;
 }
 
 static inline int adreno_is_a619(struct adreno_gpu *gpu)
@@ -248,7 +248,7 @@ static inline int adreno_is_a619(struct adreno_gpu *gpu)
 
 static inline int adreno_is_a630(struct adreno_gpu *gpu)
 {
-       return gpu->revn == 630;
+	return gpu->revn == 630;
 }
 
 static inline int adreno_is_a640_family(struct adreno_gpu *gpu)
@@ -258,18 +258,18 @@ static inline int adreno_is_a640_family(struct adreno_gpu *gpu)
 
 static inline int adreno_is_a650(struct adreno_gpu *gpu)
 {
-       return gpu->revn == 650;
+	return gpu->revn == 650;
 }
 
 static inline int adreno_is_7c3(struct adreno_gpu *gpu)
 {
 	/* The order of args is important here to handle ANY_ID correctly */
-       return adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), gpu->rev);
+	return adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), gpu->rev);
 }
 
 static inline int adreno_is_a660(struct adreno_gpu *gpu)
 {
-       return gpu->revn == 660;
+	return gpu->revn == 660;
 }
 
 /* check for a615, a616, a618, a619 or any derivatives */
@@ -280,14 +280,13 @@ static inline int adreno_is_a615_family(struct adreno_gpu *gpu)
 
 static inline int adreno_is_a660_family(struct adreno_gpu *gpu)
 {
-       return adreno_is_a660(gpu) || adreno_is_7c3(gpu);
+	return adreno_is_a660(gpu) || adreno_is_7c3(gpu);
 }
 
 /* check for a650, a660, or any derivatives */
 static inline int adreno_is_a650_family(struct adreno_gpu *gpu)
 {
-       return gpu->revn == 650 || gpu->revn == 620 ||
-	       adreno_is_a660_family(gpu);
+	return gpu->revn == 650 || gpu->revn == 620 || adreno_is_a660_family(gpu);
 }
 
 int adreno_get_param(struct msm_gpu *gpu, uint32_t param, uint64_t *value);
-- 
2.35.1

