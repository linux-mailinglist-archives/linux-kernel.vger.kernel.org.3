Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E9B4707BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbhLJR4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50250 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244660AbhLJR4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:17 -0500
X-UUID: 6681d22034d540ae83d7903cf19a5273-20211211
X-UUID: 6681d22034d540ae83d7903cf19a5273-20211211
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1469939390; Sat, 11 Dec 2021 01:52:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Dec 2021 01:52:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:37 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "JB Tsai" <jb.tsai@mediatek.com>
Subject: [PATCH 10/12] arm64: dts: mt8195: Add APU power nodes
Date:   Sat, 11 Dec 2021 01:52:21 +0800
Message-ID: <20211210175223.31131-11-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APU power node for MT8195.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8f4f56e2f08c..5ab4b2fba0e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1450,6 +1450,25 @@
 			};
 		};
 
+		apusys_power: apusys_power@190f1000 {
+			compatible = "mediatek,mt8195-apu-power";
+			reg = <0 0x190f1000 0 0x1000>,
+			      <0 0x19000600 0 0x100>;
+			reg-names = "apu_pcu",
+				    "apu_spare";
+			power-domains = <&apuspm 0>;
+
+			apu_combo_iommu0 {
+				compatible = "mediatek,apu_combo_iommu0";
+				iommus = <&iommu_apu0 IOMMU_PORT_APU_DATA>;
+			};
+
+			apu_combo_iommu1 {
+				compatible = "mediatek,apu_combo_iommu1";
+				iommus = <&iommu_apu1 IOMMU_PORT_APU_DATA>;
+			};
+		};
+
 		apusys_pll: clock-controller@190f3000 {
 			compatible = "mediatek,mt8195-apusys_pll";
 			reg = <0 0x190f3000 0 0x1000>;
-- 
2.18.0

