Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4AB47071D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhLJRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:30:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49128 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244478AbhLJRab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:30:31 -0500
X-UUID: 417f696fcbfa4e52ab9fbc41278941d0-20211211
X-UUID: 417f696fcbfa4e52ab9fbc41278941d0-20211211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1392086464; Sat, 11 Dec 2021 01:26:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:26:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:26:52 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, Flora Fu <flora.fu@mediatek.com>,
        JB Tsai <jb.tsai@mediatek.com>
Subject: [PATCH 16/17] arm64: dts: mt8192: Add apu-sw-logger node
Date:   Sat, 11 Dec 2021 01:26:04 +0800
Message-ID: <20211210172605.30618-17-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210172605.30618-1-flora.fu@mediatek.com>
References: <20211210172605.30618-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apu-sw-logger node to enable debug into tinysys.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index f95d381ff1cc..c8cc58e74f3c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -914,6 +914,12 @@
 			#mbox-cells = <1>;
 		};
 
+		apusys_sw_logger@19000040 {
+			compatible = "mediatek,apu-sw-logger";
+			reg = <0 0x19000040 0 0x10>;
+			iommus = <&iommu_apu IOMMU_PORT_APU_DATA>;
+		};
+
 		apusys_rv@19001000 {
 			compatible = "mediatek,mt8192-apusys-rv", "simple-mfd";
 			reg = <0 0x19000000 0 0x1000>,
-- 
2.18.0

