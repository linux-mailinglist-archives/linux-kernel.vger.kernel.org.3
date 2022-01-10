Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88733488DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 01:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbiAJA7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 19:59:51 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:51962 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237659AbiAJA7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 19:59:30 -0500
X-UUID: e6de86ec2ea54f95b866fcf10a7a682e-20220110
X-UUID: e6de86ec2ea54f95b866fcf10a7a682e-20220110
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1449463707; Mon, 10 Jan 2022 08:59:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 10 Jan 2022 08:59:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 08:59:24 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v2 2/3] dt-bindings: ARM: Mediatek: Remove vppsys in MT8195 clock document
Date:   Mon, 10 Jan 2022 08:59:01 +0800
Message-ID: <20220110005902.27148-3-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
References: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vppsys0 and vppsys1 sub-system are both integrated with mmsys driver,
should be describe in mediatek,mmsys.yaml

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 .../arm/mediatek/mediatek,mt8195-clock.yaml      | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
index 17fcbb45d121..d62d60181147 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
@@ -28,11 +28,9 @@ properties:
           - mediatek,mt8195-imp_iic_wrap_s
           - mediatek,mt8195-imp_iic_wrap_w
           - mediatek,mt8195-mfgcfg
-          - mediatek,mt8195-vppsys0
           - mediatek,mt8195-wpesys
           - mediatek,mt8195-wpesys_vpp0
           - mediatek,mt8195-wpesys_vpp1
-          - mediatek,mt8195-vppsys1
           - mediatek,mt8195-imgsys
           - mediatek,mt8195-imgsys1_dip_top
           - mediatek,mt8195-imgsys1_dip_nr
@@ -92,13 +90,6 @@ examples:
         #clock-cells = <1>;
     };
 
-  - |
-    vppsys0: clock-controller@14000000 {
-        compatible = "mediatek,mt8195-vppsys0";
-        reg = <0x14000000 0x1000>;
-        #clock-cells = <1>;
-    };
-
   - |
     wpesys: clock-controller@14e00000 {
         compatible = "mediatek,mt8195-wpesys";
@@ -120,13 +111,6 @@ examples:
         #clock-cells = <1>;
     };
 
-  - |
-    vppsys1: clock-controller@14f00000 {
-        compatible = "mediatek,mt8195-vppsys1";
-        reg = <0x14f00000 0x1000>;
-        #clock-cells = <1>;
-    };
-
   - |
     imgsys: clock-controller@15000000 {
         compatible = "mediatek,mt8195-imgsys";
-- 
2.18.0

