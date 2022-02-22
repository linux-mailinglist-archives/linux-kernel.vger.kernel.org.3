Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3A64BEF08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiBVBQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:16:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiBVBQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:16:26 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D19225587;
        Mon, 21 Feb 2022 17:15:53 -0800 (PST)
Received: from localhost.localdomain (abxh33.neoplus.adsl.tpnet.pl [83.9.1.33])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id BF6EF3F5D8;
        Tue, 22 Feb 2022 02:15:50 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: clock: add SM6350 QCOM Graphics clock bindings
Date:   Tue, 22 Feb 2022 02:15:30 +0100
Message-Id: <20220222011534.3502-3-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222011534.3502-1-konrad.dybcio@somainline.org>
References: <20220222011534.3502-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SM6350 SoCs.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
 include/dt-bindings/clock/qcom,gpucc-sm6350.h | 37 +++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm6350.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 46dff46d5760..9ebcb1943b0a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -17,6 +17,7 @@ description: |
     dt-bindings/clock/qcom,gpucc-sdm845.h
     dt-bindings/clock/qcom,gpucc-sc7180.h
     dt-bindings/clock/qcom,gpucc-sc7280.h
+    dt-bindings/clock/qcom,gpucc-sm6350.h
     dt-bindings/clock/qcom,gpucc-sm8150.h
     dt-bindings/clock/qcom,gpucc-sm8250.h
 
@@ -27,6 +28,7 @@ properties:
       - qcom,sc7180-gpucc
       - qcom,sc7280-gpucc
       - qcom,sc8180x-gpucc
+      - qcom,sm6350-gpucc
       - qcom,sm8150-gpucc
       - qcom,sm8250-gpucc
 
diff --git a/include/dt-bindings/clock/qcom,gpucc-sm6350.h b/include/dt-bindings/clock/qcom,gpucc-sm6350.h
new file mode 100644
index 000000000000..68e814fc8acd
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm6350.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM6350_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM6350_H
+
+/* GPU_CC clocks */
+#define GPU_CC_PLL0						0
+#define GPU_CC_PLL1						1
+#define GPU_CC_ACD_AHB_CLK					2
+#define GPU_CC_ACD_CXO_CLK					3
+#define GPU_CC_AHB_CLK						4
+#define GPU_CC_CRC_AHB_CLK					5
+#define GPU_CC_CX_GFX3D_CLK					6
+#define GPU_CC_CX_GFX3D_SLV_CLK					7
+#define GPU_CC_CX_GMU_CLK					8
+#define GPU_CC_CX_SNOC_DVM_CLK					9
+#define GPU_CC_CXO_AON_CLK					10
+#define GPU_CC_CXO_CLK						11
+#define GPU_CC_GMU_CLK_SRC					12
+#define GPU_CC_GX_CXO_CLK					13
+#define GPU_CC_GX_GFX3D_CLK					14
+#define GPU_CC_GX_GFX3D_CLK_SRC					15
+#define GPU_CC_GX_GMU_CLK					16
+#define GPU_CC_GX_VSENSE_CLK					17
+
+/* CLK_HW */
+#define GPU_CC_CRC_DIV						0
+
+/* GDSCs */
+#define GPU_CX_GDSC						0
+#define GPU_GX_GDSC						1
+
+#endif
-- 
2.35.1

