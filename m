Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6ED46963A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbhLFNID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbhLFNIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:08:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9AEC061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 05:04:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id o14so7013820plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 05:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+Fgu1qSx2f0dhJDqHDpiwW73ReZkuYvOU6/ErlqIf8=;
        b=lwnUredu6XU1WNNsQk8jSMi3DqVgqmVWIU7332HtwNzniM5GqOGZuKAAKk3+39JuGw
         LJivOmQE0ivr5esLy45HvpitVlJ8C8QbqTvDTA8um4Im7pfuiqAPRbevpZjHfkX6zRuH
         txEhmCUCJimLhPfeFJKZIDBxRJGKxSkic19TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+Fgu1qSx2f0dhJDqHDpiwW73ReZkuYvOU6/ErlqIf8=;
        b=O7Gob82rPl1uyP0G48HOHXwtRzE7zdP4WOJXd3fY0dCfwQ2hWLEmTsqlTC5PiFk7SX
         PA1K7BCvVDO1HQQalgeBpMhYmkijx5Yvn6U2eDKTck1VH/gCoJ/KPiCw/mHMrel5ynOp
         cNmKJ1BDMm1gjBFLyHh85KkQS7rZhcd1qIuy1oGSQwhISTD/okVO3F4wja0ORoQR6OA9
         LepcqX1F5qfSKzx3SEiBCBovZ5f0+jhEW64vja8NWpA2ixosfWfG8d7hbU7UrFHOdGEJ
         nmv5FhdXhYCw3GP6weBZiohepCz0r++Y7YY6tciSc7J90jGZo+Wm4sGw8J6zofyX3uup
         LxMQ==
X-Gm-Message-State: AOAM5316FHB6IlYBdFy7vxGlpnjapRWrIOiO9lFGcwspdTMT+TH/KL68
        UeYz6DufbPt6d9iW682NQBL/wGIpslkSbQ==
X-Google-Smtp-Source: ABdhPJwn+JSoGJxO3LQdN4rECBaaqpu+CLStVqXpY1egQDkXXAzG9sz300CI3VPUd4OLhabP1VVbqw==
X-Received: by 2002:a17:90b:314d:: with SMTP id ip13mr37113106pjb.228.1638795873332;
        Mon, 06 Dec 2021 05:04:33 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5044:6464:4ad7:572c])
        by smtp.gmail.com with ESMTPSA id v25sm12402292pfg.175.2021.12.06.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 05:04:32 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
Subject: [v6 1/3] dt-bindings: mediatek: convert mtk jpeg decoder/encoder to yaml
Date:   Mon,  6 Dec 2021 21:04:23 +0800
Message-Id: <20211206130425.184420-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mediatek jpeg decoder and encoder bindings to yaml.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v5->v6: no change, rebase to latest linux-next
---
 .../bindings/media/mediatek-jpeg-decoder.txt  | 38 --------
 .../bindings/media/mediatek-jpeg-decoder.yaml | 89 +++++++++++++++++++
 .../bindings/media/mediatek-jpeg-encoder.txt  | 35 --------
 .../bindings/media/mediatek-jpeg-encoder.yaml | 80 +++++++++++++++++
 4 files changed, 169 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
deleted file mode 100644
index 39c1028b2dfb49..00000000000000
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Mediatek JPEG Decoder
-
-Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
-
-Required properties:
-- compatible : must be one of the following string:
-	"mediatek,mt8173-jpgdec"
-	"mediatek,mt7623-jpgdec", "mediatek,mt2701-jpgdec"
-	"mediatek,mt2701-jpgdec"
-- reg : physical base address of the jpeg decoder registers and length of
-  memory mapped region.
-- interrupts : interrupt number to the interrupt controller.
-- clocks: device clocks, see
-  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- clock-names: must contain "jpgdec-smi" and "jpgdec".
-- power-domains: a phandle to the power domain, see
-  Documentation/devicetree/bindings/power/power_domain.txt for details.
-- mediatek,larb: must contain the local arbiters in the current Socs, see
-  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
-  for details.
-- iommus: should point to the respective IOMMU block with master port as
-  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
-  for details.
-
-Example:
-	jpegdec: jpegdec@15004000 {
-		compatible = "mediatek,mt2701-jpgdec";
-		reg = <0 0x15004000 0 0x1000>;
-		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
-			  <&imgsys CLK_IMG_JPGDEC>;
-		clock-names = "jpgdec-smi",
-			      "jpgdec";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
-		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
-			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
-	};
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
new file mode 100644
index 00000000000000..9b87f036f1785b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek JPEG Decoder Device Tree Bindings
+
+maintainers:
+  - Xia Jiang <xia.jiang@mediatek.com>
+
+description: |-
+  Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt8173-jpgdec
+              - mediatek,mt2701-jpgdec
+      - items:
+          - enum:
+              - mediatek,mt7623-jpgdec
+          - const: mediatek,mt2701-jpgdec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: jpgdec-smi
+      - const: jpgdec
+
+  power-domains:
+    maxItems: 1
+
+  mediatek,larb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Must contain the local arbiters in the current Socs, see
+      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+      for details.
+
+  iommus:
+    maxItems: 2
+    description: |
+      Points to the respective IOMMU block with master port as argument, see
+      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+      Ports are according to the HW.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - mediatek,larb
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt2701-larb-port.h>
+    #include <dt-bindings/power/mt2701-power.h>
+    jpegdec: jpegdec@15004000 {
+      compatible = "mediatek,mt2701-jpgdec";
+      reg = <0x15004000 0x1000>;
+      interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+      clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+                <&imgsys CLK_IMG_JPGDEC>;
+      clock-names = "jpgdec-smi",
+                    "jpgdec";
+      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+      mediatek,larb = <&larb2>;
+      iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
+               <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
+    };
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
deleted file mode 100644
index 5e53c6ab52d011..00000000000000
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* MediaTek JPEG Encoder
-
-MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
-
-Required properties:
-- compatible : "mediatek,mt2701-jpgenc"
-  followed by "mediatek,mtk-jpgenc"
-- reg : physical base address of the JPEG encoder registers and length of
-  memory mapped region.
-- interrupts : interrupt number to the interrupt controller.
-- clocks: device clocks, see
-  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
-- clock-names: must contain "jpgenc". It is the clock of JPEG encoder.
-- power-domains: a phandle to the power domain, see
-  Documentation/devicetree/bindings/power/power_domain.txt for details.
-- mediatek,larb: must contain the local arbiters in the current SoCs, see
-  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
-  for details.
-- iommus: should point to the respective IOMMU block with master port as
-  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
-  for details.
-
-Example:
-	jpegenc: jpegenc@1500a000 {
-		compatible = "mediatek,mt2701-jpgenc",
-			     "mediatek,mtk-jpgenc";
-		reg = <0 0x1500a000 0 0x1000>;
-		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
-		clocks =  <&imgsys CLK_IMG_VENC>;
-		clock-names = "jpgenc";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
-		iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
-			 <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
-	};
diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
new file mode 100644
index 00000000000000..5e35ecfd21f1b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/mediatek-jpeg-encoder.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek JPEG Encoder Device Tree Bindings
+
+maintainers:
+  - Xia Jiang <xia.jiang@mediatek.com>
+
+description: |-
+  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt2701-jpgenc
+      - const: mediatek,mtk-jpgenc
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: jpgenc
+
+  power-domains:
+    maxItems: 1
+
+  mediatek,larb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Must contain the local arbiters in the current Socs, see
+      Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+      for details.
+
+  iommus:
+    maxItems: 2
+    description: |
+      Points to the respective IOMMU block with master port as argument, see
+      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.
+      Ports are according to the HW.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - mediatek,larb
+  - iommus
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt2701-clk.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/memory/mt2701-larb-port.h>
+    #include <dt-bindings/power/mt2701-power.h>
+    jpegenc: jpegenc@1500a000 {
+      compatible = "mediatek,mt2701-jpgenc",
+                   "mediatek,mtk-jpgenc";
+      reg = <0x1500a000 0x1000>;
+      interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_LOW>;
+      clocks =  <&imgsys CLK_IMG_VENC>;
+      clock-names = "jpgenc";
+      power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+      mediatek,larb = <&larb2>;
+      iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
+               <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
+    };
-- 
2.34.1.400.ga245620fadb-goog

