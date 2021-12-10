Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95A54707BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244895AbhLJR4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50148 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244833AbhLJR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:17 -0500
X-UUID: 8815f233d66e41d9b0548b8310c6bd78-20211211
X-UUID: 8815f233d66e41d9b0548b8310c6bd78-20211211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2007635512; Sat, 11 Dec 2021 01:52:38 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:52:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:52:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:36 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "JB Tsai" <jb.tsai@mediatek.com>
Subject: [PATCH 08/12] arm64: dts: mt8195: Add APU-IOMMU nodes
Date:   Sat, 11 Dec 2021 01:52:19 +0800
Message-ID: <20211210175223.31131-9-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APU-IOMMI nodes.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 7e31e64e6b39..2f14e3326a2c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8195-memory-port.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
 #include <dt-bindings/reset/ti-syscon.h>
@@ -1367,6 +1368,22 @@
 			#mbox-cells = <1>;
 		};
 
+		iommu_apu0: iommu@19010000 {
+			compatible = "mediatek,mt8195-iommu-apu";
+			reg = <0 0x19010000 0 0x1000>;
+			interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
+			#iommu-cells = <1>;
+			power-domains = <&apuspm 0>;
+		};
+
+		iommu_apu1: iommu@19015000 {
+			compatible = "mediatek,mt8195-iommu-apu";
+			reg = <0 0x19015000 0 0x1000>;
+			interrupts = <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH 0>;
+			#iommu-cells = <1>;
+			power-domains = <&apuspm 0>;
+		};
+
 		apu_conn: syscon@19020000 {
 			compatible = "mediatek,mt8195-apu-conn", "syscon";
 			reg = <0 0x19020000 0 0x1000>;
-- 
2.18.0

