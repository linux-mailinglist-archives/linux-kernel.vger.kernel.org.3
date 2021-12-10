Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E564707B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhLJR40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:26 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44636 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244798AbhLJR4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:13 -0500
X-UUID: 5a36e2d2beb145a09bcd5d3fa98ed22a-20211211
X-UUID: 5a36e2d2beb145a09bcd5d3fa98ed22a-20211211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1555568712; Sat, 11 Dec 2021 01:52:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Dec 2021 01:52:36 +0800
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
Subject: [PATCH 07/12] arm64: dts: mt8195: Add APU mtk-apu-mailbox node
Date:   Sat, 11 Dec 2021 01:52:18 +0800
Message-ID: <20211210175223.31131-8-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mtk-apu-mailbox for mt8195 SOC.

Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 6e60c4a38495..7e31e64e6b39 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1360,6 +1360,13 @@
 			#clock-cells = <1>;
 		};
 
+		apu_mailbox: apu_mailbox@19000000 {
+			compatible = "mediatek,mtk-apu-mailbox";
+			reg = <0 0x19000000 0 0x100>;
+			interrupts = <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>;
+			#mbox-cells = <1>;
+		};
+
 		apu_conn: syscon@19020000 {
 			compatible = "mediatek,mt8195-apu-conn", "syscon";
 			reg = <0 0x19020000 0 0x1000>;
-- 
2.18.0

