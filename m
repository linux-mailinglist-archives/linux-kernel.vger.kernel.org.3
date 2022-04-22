Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6950B240
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445212AbiDVH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445094AbiDVHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:55:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9BE51E54;
        Fri, 22 Apr 2022 00:52:56 -0700 (PDT)
X-UUID: cec03ad551e845bfb3b612cc533bedcb-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f2db3952-60de-4aca-889d-b533f97df9cb,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:c34097f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: cec03ad551e845bfb3b612cc533bedcb-20220422
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 98230225; Fri, 22 Apr 2022 15:52:51 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 15:52:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 15:52:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 15:52:48 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V4 14/14] arm64: dts: mediatek: Add mediatek,cci property for MT8183 cpufreq
Date:   Fri, 22 Apr 2022 15:52:39 +0800
Message-ID: <20220422075239.16437-15-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mediatek,cci property to support MediaTek CCI feature.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c95eec5fb704..c34d4733e4ea 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -336,6 +336,7 @@
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu1: cpu@1 {
@@ -351,6 +352,7 @@
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu2: cpu@2 {
@@ -366,6 +368,7 @@
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu3: cpu@3 {
@@ -381,6 +384,7 @@
 			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu4: cpu@100 {
@@ -396,6 +400,7 @@
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu5: cpu@101 {
@@ -411,6 +416,7 @@
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu6: cpu@102 {
@@ -426,6 +432,7 @@
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		cpu7: cpu@103 {
@@ -441,6 +448,7 @@
 			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
+			mediatek,cci = <&cci>;
 		};
 
 		idle-states {
-- 
2.18.0

