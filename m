Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC702470781
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbhLJRlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:41:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56128 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241809AbhLJRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:41:35 -0500
X-UUID: 9952b82b904e4ac3a34e11f688d58810-20211211
X-UUID: 9952b82b904e4ac3a34e11f688d58810-20211211
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1240690002; Sat, 11 Dec 2021 01:37:56 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:37:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:37:55 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Flora Fu <flora.fu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH 5/6] arm64: dts: mt8195: Add APU power domain node
Date:   Sat, 11 Dec 2021 01:37:42 +0800
Message-ID: <20211210173743.30906-6-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210173743.30906-1-flora.fu@mediatek.com>
References: <20211210173743.30906-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APU power domain node to MT8195.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 828ac8a6b95f..6e60c4a38495 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1375,6 +1375,22 @@
 			reg = <0 0x19029000 0 0x1000>;
 		};
 
+		apuspm: power-domain@190f0000 {
+			compatible = "mediatek,mt8195-apu-pm", "syscon";
+			reg = <0 0x190f0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#power-domain-cells = <1>;
+			mediatek,scpsys = <&scpsys>;
+			mediatek,apu-conn = <&apu_conn>;
+			mediatek,apu-conn1 = <&apu_conn1>;
+			mediatek,apu-vcore = <&apu_vcore>;
+			apu_top: power-domain@0 {
+				reg = <0>;
+				#power-domain-cells = <0>;
+			};
+		};
+
 		apusys_pll: clock-controller@190f3000 {
 			compatible = "mediatek,mt8195-apusys_pll";
 			reg = <0 0x190f3000 0 0x1000>;
-- 
2.18.0

