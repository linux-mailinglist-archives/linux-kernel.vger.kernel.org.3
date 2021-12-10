Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70394707B3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244785AbhLJR4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:11 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44502 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244769AbhLJR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:07 -0500
X-UUID: 8a704a79d9994999820373d7523642ca-20211211
X-UUID: 8a704a79d9994999820373d7523642ca-20211211
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 257280221; Sat, 11 Dec 2021 01:52:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 11 Dec 2021 01:52:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:52:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:28 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "JB Tsai" <jb.tsai@mediatek.com>
Subject: [PATCH 01/12] dt-bindings: memory: mediatek: Add MT8195 apu iommu bindings
Date:   Sat, 11 Dec 2021 01:52:12 +0800
Message-ID: <20211210175223.31131-2-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two apu iommu hardwares in MT8195.
Add MT8195 apu iommu bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 +++
 include/dt-bindings/memory/mt8195-memory-port.h             | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 14fae9642ec9..ba1b3ce6cf99 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -81,6 +81,7 @@ properties:
           - mediatek,mt8195-iommu-vdo        # generation two
           - mediatek,mt8195-iommu-vpp        # generation two
           - mediatek,mt8195-iommu-infra      # generation two
+          - mediatek,mt8195-iommu-apu        # generation two
 
       - description: mt7623 generation one
         items:
@@ -158,6 +159,7 @@ allOf:
             - mediatek,mt8192-iommu-apu
             - mediatek,mt8195-iommu-vdo
             - mediatek,mt8195-iommu-vpp
+            - mediatek,mt8195-iommu-apu
 
     then:
       required:
@@ -170,6 +172,7 @@ allOf:
             enum:
               - mediatek,mt8192-iommu-apu
               - mediatek,mt8195-iommu-infra
+              - mediatek,mt8195-iommu-apu
 
     then:
       required:
diff --git a/include/dt-bindings/memory/mt8195-memory-port.h b/include/dt-bindings/memory/mt8195-memory-port.h
index 9882877cda9d..438e75140717 100644
--- a/include/dt-bindings/memory/mt8195-memory-port.h
+++ b/include/dt-bindings/memory/mt8195-memory-port.h
@@ -405,4 +405,8 @@
 #define IOMMU_PORT_INFRA_SSUSB_R		MTK_IFAIOMMU_PERI_ID(30)
 #define IOMMU_PORT_INFRA_SSUSB_W		MTK_IFAIOMMU_PERI_ID(31)
 
+#define IOMMU_PORT_APU_DATA			MTK_M4U_ID(0, 0)
+#define IOMMU_PORT_APU_VLM			MTK_M4U_ID(0, 1)
+#define IOMMU_PORT_APU_VPU			MTK_M4U_ID(0, 2)
+
 #endif
-- 
2.18.0

