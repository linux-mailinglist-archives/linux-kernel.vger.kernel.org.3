Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C154E525F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378990AbiEMJZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378785AbiEMJZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:25:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A22A28CB;
        Fri, 13 May 2022 02:25:34 -0700 (PDT)
X-UUID: ae0bf1c4f3844786a839cccb77ca2e0f-20220513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f7a445aa-ab51-446f-a571-bd9fb33e59a0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:413332a7-eab7-4b74-a74d-5359964535a9,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: ae0bf1c4f3844786a839cccb77ca2e0f-20220513
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1099558783; Fri, 13 May 2022 17:25:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 13 May 2022 17:25:30 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 May 2022 17:25:28 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6, 1/7] dt-bindings: media: mediatek: vcodec: Adds decoder dt-bindings for lat soc
Date:   Fri, 13 May 2022 17:25:20 +0800
Message-ID: <20220513092526.9670-2-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513092526.9670-1-yunfei.dong@mediatek.com>
References: <20220513092526.9670-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds decoder dt-bindings for compatible "mediatek,mtk-vcodec-lat-soc".

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../media/mediatek,vcodec-subdev-decoder.yaml | 51 +++++++++++++------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index 6415c9f29130..6854e7f2ce9f 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -17,20 +17,20 @@ description: |
 
   About the Decoder Hardware Block Diagram, please check below:
 
-    +---------------------------------+------------------------------------+
-    |                                 |                                    |
-    | input -> lat HW -> lat buffer --|--> lat buffer -> core HW -> output |
-    |            ||                   |                     ||             |
-    +------------||-------------------+---------------------||-------------+
-              lat workqueue           |              core workqueue     <parent>
-    -------------||-----------------------------------------||------------------
-                 ||                                         ||          <child>
-                 \/ <----------------HW index-------------->\/
-           +------------------------------------------------------+
-           |                    enable/disable                    |
-           |           clk     power    irq    iommu              |
-           |                 (lat/lat soc/core0/core1)            |
-           +------------------------------------------------------+
+    +------------------------------------------------+-------------------------------------+
+    |                                                |                                     |
+    |  input -> lat soc HW -> lat HW -> lat buffer --|--> lat buffer -> core HW -> output  |
+    |            ||             ||                   |                     ||              |
+    +------------||-------------||-------------------+---------------------||--------------+
+                 ||     lat     ||                   |               core workqueue  <parent>
+    -------------||-------------||-------------------|---------------------||---------------
+                 ||<------------||----------------HW index---------------->||        <child>
+                 \/             \/                                         \/
+               +-------------------------------------------------------------+
+               |                          enable/disable                     |
+               |                 clk     power    irq    iommu               |
+               |                   (lat/lat soc/core0/core1)                 |
+               +-------------------------------------------------------------+
 
   As above, there are parent and child devices, child mean each hardware. The child device
   controls the information of each hardware independent which include clk/power/irq.
@@ -45,6 +45,13 @@ description: |
   For the smi common may not the same for each hardware, can't combine all hardware in one node,
   or leading to iommu fault when access dram data.
 
+  Lat soc is a hardware which is related with some larb(local arbiter) ports. For mt8195
+  platform, there are some ports like RDMA, UFO in lat soc larb, need to enable its power and
+  clock when lat start to work, don't have interrupt.
+
+  mt8195: lat soc HW + lat HW + core HW
+  mt8192: lat HW + core HW
+
 properties:
   compatible:
     enum:
@@ -88,7 +95,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: mediatek,mtk-vcodec-lat
+        enum:
+          - mediatek,mtk-vcodec-lat
+          - mediatek,mtk-vcodec-lat-soc
 
       reg:
         maxItems: 1
@@ -126,7 +135,6 @@ patternProperties:
     required:
       - compatible
       - reg
-      - interrupts
       - iommus
       - clocks
       - clock-names
@@ -197,6 +205,17 @@ required:
   - dma-ranges
   - ranges
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - mediatek,mtk-vcodec-lat
+
+then:
+  required:
+    - interrupts
+
 additionalProperties: false
 
 examples:
-- 
2.18.0

