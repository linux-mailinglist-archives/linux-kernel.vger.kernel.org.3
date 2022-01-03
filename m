Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2620482DC5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiACEch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:32:37 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:40318 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229515AbiACEcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:32:36 -0500
X-UUID: 3d3d97554d14437abfc570b8cd0cce48-20220103
X-UUID: 3d3d97554d14437abfc570b8cd0cce48-20220103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1907919793; Mon, 03 Jan 2022 12:32:30 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 3 Jan 2022 12:32:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 Jan
 2022 12:32:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 12:32:29 +0800
From:   YC Hung <yc.hung@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <yc.hung@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <daniel.baluta@nxp.com>, <trevor.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <cezary.rojewski@intel.com>
Subject: [PATCH v3] dt-bindings: dsp: mediatek: add mt8195 dsp document
Date:   Mon, 3 Jan 2022 12:32:03 +0800
Message-ID: <20220103043202.6524-1-yc.hung@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "YC Hung" <yc.hung@mediatek.com>

This patch adds mt8195 dsp document. The dsp is used for Sound Open
Firmware driver node. It includes registers,  clocks, memory regions,
and mailbox for dsp.

Signed-off-by: yc.hung <yc.hung@mediatek.com>
---
Changes since v2:
  Remove useless watchdog interrupt.
  Add commit message more detail description.

Changes since v1:
  Rename yaml file name as mediatek,mt8195-dsp.yaml
  Refine descriptions for mailbox, memory-region and drop unused labels
  in examples.
---
---
 .../devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
index bde763191d86..779daa786739 100644
--- a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
@@ -27,14 +27,6 @@ properties:
       - const: cfg
       - const: sram
 
-  interrupts:
-    items:
-      - description: watchdog interrupt
-
-  interrupt-names:
-    items:
-      - const: wdt
-
   clocks:
     items:
       - description: mux for audio dsp clock
@@ -75,8 +67,6 @@ required:
   - compatible
   - reg
   - reg-names
-  - interrupts
-  - interrupt-names
   - clocks
   - clock-names
   - memory-region
@@ -95,8 +85,6 @@ examples:
        reg = <0x10803000  0x1000>,
              <0x10840000  0x40000>;
        reg-names = "cfg", "sram";
-       interrupts = <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH 0>;
-       interrupt-names = "wdt";
        clocks = <&topckgen 10>, //CLK_TOP_ADSP
                 <&clk26m>,
                 <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS
-- 
2.18.0

