Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF8465E37
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355738AbhLBGbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:31:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41996 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239178AbhLBGbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:31:03 -0500
X-UUID: 1c5d5d82a5bc41beae5f692df0281756-20211202
X-UUID: 1c5d5d82a5bc41beae5f692df0281756-20211202
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1981536858; Thu, 02 Dec 2021 14:27:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 2 Dec 2021 14:27:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 14:27:34 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <moudy.ho@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v10 2/3] dts: arm64: mt8183: add Mediatek MDP3 nodes
Date:   Thu, 2 Dec 2021 14:27:32 +0800
Message-ID: <20211202062733.20338-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211202062733.20338-1-moudy.ho@mediatek.com>
References: <20211202062733.20338-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device nodes for Media Data Path 3 (MDP3) modules.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 115 ++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index ba4584faca5a..e4dc76b04438 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1325,6 +1325,85 @@
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
 		};
 
+		mdp3_rdma0: mdp3_rdma0@14001000 {
+			compatible = "mediatek,mt8183-mdp3",
+				     "mediatek,mt8183-mdp3-rdma";
+			mediatek,scp = <&scp>;
+			mediatek,mdp3-id = <0>;
+			mediatek,mdp3-comps = "mediatek,mt8183-mdp3-dl1",
+					      "mediatek,mt8183-mdp3-dl2",
+					      "mediatek,mt8183-mdp3-path1",
+					      "mediatek,mt8183-mdp3-path2",
+					      "mediatek,mt8183-mdp3-imgi",
+					      "mediatek,mt8183-mdp3-exto";
+			mediatek,mdp3-comp-ids = <0 1 0 1 0 1>;
+			reg = <0 0x14001000 0 0x1000>,
+			      <0 0x14000000 0 0x1000>,
+			      <0 0x14005000 0 0x1000>,
+			      <0 0x14006000 0 0x1000>,
+			      <0 0x15020000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>,
+						  <&gce SUBSYS_1400XXXX 0 0x1000>,
+						  <&gce SUBSYS_1400XXXX 0x5000 0x1000>,
+						  <&gce SUBSYS_1400XXXX 0x6000 0x1000>,
+						  <&gce SUBSYS_1502XXXX 0 0x1000>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
+				 <&mmsys CLK_MM_MDP_RSZ1>,
+				 <&mmsys CLK_MM_MDP_DL_TXCK>,
+				 <&mmsys CLK_MM_MDP_DL_RX>,
+				 <&mmsys CLK_MM_IPU_DL_TXCK>,
+				 <&mmsys CLK_MM_IPU_DL_RX>;
+			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
+			mediatek,mmsys = <&mmsys>;
+			mediatek,mm-mutex = <&mutex>;
+			mediatek,mailbox-gce = <&gce>;
+			mboxes = <&gce 20 CMDQ_THR_PRIO_LOWEST 0>,
+				 <&gce 21 CMDQ_THR_PRIO_LOWEST 0>,
+				 <&gce 22 CMDQ_THR_PRIO_LOWEST 0>,
+				 <&gce 23 CMDQ_THR_PRIO_LOWEST 0>;
+			gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
+				     <&gce 0x14010000 SUBSYS_1401XXXX>,
+				     <&gce 0x14020000 SUBSYS_1402XXXX>,
+				     <&gce 0x15020000 SUBSYS_1502XXXX>;
+		};
+
+		mdp3_rsz0: mdp3_rsz0@14003000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			mediatek,mdp3-id = <0>;
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x3000 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ0>;
+		};
+
+		mdp3_rsz1: mdp3_rsz1@14004000 {
+			compatible = "mediatek,mt8183-mdp3-rsz";
+			mediatek,mdp3-id = <1>;
+			reg = <0 0x14004000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x4000 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
+		};
+
+		mdp3_wrot0: mdp3_wrot0@14005000 {
+			compatible = "mediatek,mt8183-mdp3-wrot";
+			mediatek,mdp3-id = <0>;
+			reg = <0 0x14005000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x5000 0x1000>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_MDP_WROT0>;
+			iommus = <&iommu M4U_PORT_MDP_WROT0>;
+		};
+
+		mdp3_wdma: mdp3_wdma@14006000 {
+			compatible = "mediatek,mt8183-mdp3-wdma";
+			mediatek,mdp3-id = <0>;
+			reg = <0 0x14006000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x6000 0x1000>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			clocks = <&mmsys CLK_MM_MDP_WDMA0>;
+			iommus = <&iommu M4U_PORT_MDP_WDMA0>;
+		};
+
 		ovl0: ovl@14008000 {
 			compatible = "mediatek,mt8183-disp-ovl";
 			reg = <0 0x14008000 0 0x1000>;
@@ -1449,7 +1528,33 @@
 			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			mediatek,gce-events = <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
-					      <CMDQ_EVENT_MUTEX_STREAM_DONE1>;
+					      <CMDQ_EVENT_MUTEX_STREAM_DONE1>,
+					      <CMDQ_EVENT_MDP_RDMA0_SOF>,
+					      <CMDQ_EVENT_MDP_RDMA0_EOF>,
+					      <CMDQ_EVENT_MDP_RSZ0_SOF>,
+					      <CMDQ_EVENT_MDP_RSZ1_SOF>,
+					      <CMDQ_EVENT_MDP_TDSHP_SOF>,
+					      <CMDQ_EVENT_MDP_WROT0_SOF>,
+					      <CMDQ_EVENT_MDP_WROT0_EOF>,
+					      <CMDQ_EVENT_MDP_WDMA0_SOF>,
+					      <CMDQ_EVENT_MDP_WDMA0_EOF>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_0>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_1>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_2>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_3>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_4>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_5>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_6>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_7>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_8>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_9>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_10>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_11>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_12>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_13>,
+					      <CMDQ_EVENT_ISP_FRAME_DONE_P2_14>,
+					      <CMDQ_EVENT_WPE_A_DONE>,
+					      <CMDQ_EVENT_SPE_B_DONE>;
 		};
 
 		larb0: larb@14017000 {
@@ -1473,6 +1578,14 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 		};
 
+		mdp3_ccorr: mdp3_ccorr@1401c000 {
+			compatible = "mediatek,mt8183-mdp3-ccorr";
+			mediatek,mdp3-id = <0>;
+			reg = <0 0x1401c000 0 0x1000>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0xc000 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_CCORR>;
+		};
+
 		imgsys: syscon@15020000 {
 			compatible = "mediatek,mt8183-imgsys", "syscon";
 			reg = <0 0x15020000 0 0x1000>;
-- 
2.18.0

