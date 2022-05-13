Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C572A5265C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381091AbiEMPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381173AbiEMPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:14:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946F53A78;
        Fri, 13 May 2022 08:14:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3193C1F46200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652454858;
        bh=w5+v1hRbvV67FHXm0mORluaymSCpHYJAJrO3B5ByyXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIB7kFf4PSBzxdz4S3pU8Nbn4DISL5dfsZXlbq1fmIIuH2y/Srg6c71ZDmILEkL/Q
         Otkd3HWT6qTbOyX54hbn/wSMi7T5AjdIWKUzjVYMIuiFVQA0/ibQCRX+FLaKctoJoh
         KoFaA5rNv5ZFZhz4ZDQs4KAl2sRYXpWpT791cOkqxakS0W8ZZL5QcK9Cnu/mdRNwMV
         tlRb7jLmeJ32buirzY+X3zQSvBbUj1uAECmcwZzrPednvnHyzT4AUK1kZWH/FAhBaW
         9ou+HK5RxX0yUwcW6Rgn2+ZJNoAfPJZCYD7feOkPhSzx7VyLmumOoQlHzD2riIjv7q
         eT6AQC3ynEF8w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Date:   Fri, 13 May 2022 17:14:10 +0200
Message-Id: <20220513151411.395744-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/iommu/mediatek,iommu.yaml        |  3 +
 include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 2ae3bbad7f1a..59c5fb122061 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -73,6 +73,7 @@ properties:
           - mediatek,mt2701-m4u  # generation one
           - mediatek,mt2712-m4u  # generation two
           - mediatek,mt6779-m4u  # generation two
+          - mediatek,mt6795-m4u  # generation two
           - mediatek,mt8167-m4u  # generation two
           - mediatek,mt8173-m4u  # generation two
           - mediatek,mt8183-m4u  # generation two
@@ -120,6 +121,7 @@ properties:
       dt-binding/memory/mt2701-larb-port.h for mt2701 and mt7623,
       dt-binding/memory/mt2712-larb-port.h for mt2712,
       dt-binding/memory/mt6779-larb-port.h for mt6779,
+      dt-binding/memory/mt6795-larb-port.h for mt6795,
       dt-binding/memory/mt8167-larb-port.h for mt8167,
       dt-binding/memory/mt8173-larb-port.h for mt8173,
       dt-binding/memory/mt8183-larb-port.h for mt8183,
@@ -144,6 +146,7 @@ allOf:
             enum:
               - mediatek,mt2701-m4u
               - mediatek,mt2712-m4u
+              - mediatek,mt6795-m4u
               - mediatek,mt8173-m4u
               - mediatek,mt8186-iommu-mm
               - mediatek,mt8192-m4u
diff --git a/include/dt-bindings/memory/mt6795-larb-port.h b/include/dt-bindings/memory/mt6795-larb-port.h
new file mode 100644
index 000000000000..2243bb6414f3
--- /dev/null
+++ b/include/dt-bindings/memory/mt6795-larb-port.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_MEMORY_MT6795_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT6795_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+#define M4U_LARB4_ID			4
+#define M4U_LARB5_ID			5
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_OVL1		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_DISP_RDMA2		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_DISP_WDMA1		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_OD_R		MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define M4U_PORT_DISP_OD_W		MTK_M4U_ID(M4U_LARB0_ID, 8)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 9)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 10)
+#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 11)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 12)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB0_ID, 13)
+
+/* larb1 */
+#define M4U_PORT_VDEC_MC		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_VDEC_PP		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_VDEC_UFO		MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_VDEC_VLD		MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_VDEC_VLD2		MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_VDEC_AVC_MV		MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_VDEC_PRED_RD		MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_VDEC_PRED_WR		MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_VDEC_PPWRAP		MTK_M4U_ID(M4U_LARB1_ID, 8)
+
+/* larb2 */
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_CAM_RRZO		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_CAM_LCSO		MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_CAM_IMGO_S		MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_CAM_LSCI_D		MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_CAM_BPCI		MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_CAM_BPCI_D		MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_CAM_UFDI		MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB2_ID, 11)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB2_ID, 12)
+#define M4U_PORT_CAM_IMG3O		MTK_M4U_ID(M4U_LARB2_ID, 13)
+#define M4U_PORT_CAM_VIPI		MTK_M4U_ID(M4U_LARB2_ID, 14)
+#define M4U_PORT_CAM_VIP2I		MTK_M4U_ID(M4U_LARB2_ID, 15)
+#define M4U_PORT_CAM_VIP3I		MTK_M4U_ID(M4U_LARB2_ID, 16)
+#define M4U_PORT_CAM_LCEI		MTK_M4U_ID(M4U_LARB2_ID, 17)
+#define M4U_PORT_CAM_RB			MTK_M4U_ID(M4U_LARB2_ID, 18)
+#define M4U_PORT_CAM_RP			MTK_M4U_ID(M4U_LARB2_ID, 19)
+#define M4U_PORT_CAM_WR			MTK_M4U_ID(M4U_LARB2_ID, 20)
+
+/* larb3 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_REMDC_SDMA		MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_REMDC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_JPGENC_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_JPGENC_SDMA		MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 10)
+#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 11)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 12)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 13)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 14)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 15)
+#define M4U_PORT_REMDC_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 16)
+#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 17)
+#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 18)
+
+/* larb4 */
+#define M4U_PORT_MJC_MV_RD		MTK_M4U_ID(M4U_LARB4_ID, 0)
+#define M4U_PORT_MJC_MV_WR		MTK_M4U_ID(M4U_LARB4_ID, 1)
+#define M4U_PORT_MJC_DMA_RD		MTK_M4U_ID(M4U_LARB4_ID, 2)
+#define M4U_PORT_MJC_DMA_WR		MTK_M4U_ID(M4U_LARB4_ID, 3)
+
+#endif
-- 
2.35.1

