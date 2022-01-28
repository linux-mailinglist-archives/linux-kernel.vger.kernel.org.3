Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47B49F3AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbiA1G3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:29:23 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48930 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346494AbiA1G3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:29:12 -0500
X-UUID: 9f534976197b4844866c10c97f07efe4-20220128
X-UUID: 9f534976197b4844866c10c97f07efe4-20220128
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 346881307; Fri, 28 Jan 2022 14:29:08 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 Jan 2022 14:29:06 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 14:29:05 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 4/4] arm64: dts: mediatek: mt8195: enable usb remote wakeup
Date:   Fri, 28 Jan 2022 14:29:02 +0800
Message-ID: <20220128062902.26273-4-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB remote wakeup of all four xHCI controllers

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: based on new mt8195 base dts, no need add usb nodes

Note:

 depend on the reviewing patch:

[v9,3/3] arm64: dts: Add mediatek SoC mt8195 and evaluation board
https://patchwork.kernel.org/patch/12711296

---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 240a21708806..444e5448c9b1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -573,6 +573,8 @@
 				 <&apmixedsys CLK_APMIXED_USB1PLL>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 103>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -636,6 +638,8 @@
 				 <&apmixedsys CLK_APMIXED_USB1PLL>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "mcu_ck","xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 104>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -655,6 +659,8 @@
 				 <&topckgen CLK_TOP_SSUSB_P2_REF>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 105>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -674,6 +680,8 @@
 				 <&topckgen CLK_TOP_SSUSB_P3_REF>,
 				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>;
 			clock-names = "sys_ck", "ref_ck", "xhci_ck";
+			mediatek,syscon-wakeup = <&pericfg 0x400 106>;
+			wakeup-source;
 			/* This controller is connected with a BT device.
 			 * Disable usb2 lpm to prevent konwn issues.
 			 */
-- 
2.18.0

