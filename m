Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B31472DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbhLMNuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:50:51 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48912 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLMNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403447; x=1670939447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mr8OraDWlXzhhixF2aIaP6ECNIESLZAMBR788P3PA+8=;
  b=nCU00w3SDr3Lwn2aukyrTANmUylH+ajxrEYmxsfldagJXKVhFmx9sn5S
   cVJOX3JJ1wJ2JQtCse58m+VThbwzc+x+ndexSmLhxnQCYiS+TIIYsw49R
   ZUfCdPYi5lNedr6BsKEkSv0dTj89k1JkvA3O8naCUzZAsVVH3FTfdFDPU
   WUMtRA3n+sOW9x/Ibm1e9TIwyi0RNuckJlGO4cSWM75bj7KZtyRy8v77W
   tfNy0hz/jOR3MXzT2cF0jpx5xbtM+uM4Z7lw6Iqkp0ecy8IVZ4lRBwMhi
   zJxqDEg4woXEVjluigrOpuT/9ZokDM9dsOke8b2T/4r18JqC5gTI3cKWD
   Q==;
IronPort-SDR: ilnTfrLGjdTpHvNT/2oVQFqecg6n0aSf2fM37PP6p0zBCoD8xSEJ2UFSF2JadzxuMvPsfKURVn
 dhMY1NF363c+U9rdjJpnCohUhB8xOI5PdxKcTlTCPTFgxbausMyF5OQDIqDFCF6mCgFMNuix7r
 D9jrIUj3zv63gZQ58DygX51LsMiHeG5cMd0jhWyWiMoDH537vmfkPEi2MxBRJscKXGZCr6/mi5
 ZOg+4r5VpMVe+M04/t3mtgzn6Q2chGvSZghs8gPxZPdIFMlscfEtX7bsF1tWmgHCx60/NgzbJi
 3kWcL2gCSZKFNj6PL/zJgH+n
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="79361383"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:50:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:50:46 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:50:22 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 02/23] dt-bindings: media: atmel: csi2dc: add bindings for microchip csi2dc
Date:   Mon, 13 Dec 2021 15:49:19 +0200
Message-ID: <20211213134940.324266-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for Microchip CSI2 Demultiplexer controller.

CSI2DC is a demultiplexer from Synopsys IDI interface specification to
parallel interface connection or direct memory access.
CSI2DC can also act as a parallel bypass from a parallel sensor to the
image sensor controller/interface.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v3:
- Changed to port base as suggested by Rob
- Added properties from video-interfaces which are being used by the csi2dc
- added mention to the parallel port type as input
- did some rephrasing and rewording

Changes in v2:
- changed the endpoint/port references as suggested by Rob

Changes in this version :
- fixed 'sink' name to be actually source.
- added dma properties and example with dma

Previous change log:
Changes in v5:
- modified bindings as per Rob Herring review

Changes in v4:
- Removed property for inter-line-delay and for clock continuous/non-continuous
- Removed virtual channel by reg for second endpoint

Changes in v3:
- Removed some text from description, as it was explained in the schema
- fixed other things as per Rob's review
- moved some text inside the schema, like the clock description

Changes in v2:
- fixed warnings reported by dt_binding_check


 .../bindings/media/microchip,csi2dc.yaml      | 197 ++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/microchip,csi2dc.yaml

diff --git a/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
new file mode 100644
index 000000000000..e8544fb2d034
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/microchip,csi2dc.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/microchip,csi2dc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip CSI2 Demux Controller (CSI2DC)
+
+maintainers:
+  - Eugen Hristev <eugen.hristev@microchip.com>
+
+description:
+  CSI2DC - Camera Serial Interface 2 Demux Controller
+
+  CSI2DC is a hardware block that receives incoming data from either from an
+  IDI interface or from a parallel bus interface.
+  It filters IDI packets based on their data type and virtual channel
+  identifier, then converts the byte stream to a pixel stream into a cross
+  clock domain towards a parallel interface that can be read by a sensor
+  controller.
+  IDI interface is Synopsys proprietary.
+  CSI2DC can act a simple bypass bridge if the incoming data is coming from
+  a parallel interface.
+
+  CSI2DC provides two pipes, one video pipe and one data pipe. Video pipe
+  is connected at the output to a sensor controller and the data pipe is
+  accessible as a DMA slave port to a DMA controller.
+
+  CSI2DC supports a single 'port' node as a sink port with either Synopsys
+  32-bit IDI interface or a parallel interface.
+
+  CSI2DC supports one 'port' node as source port with parallel interface.
+  This is called video pipe.
+  This port has an 'endpoint' that can be connected to a sink port of another
+  controller (next in pipeline).
+
+  CSI2DC also supports direct access to the data through AHB, via DMA channel,
+  called data pipe.
+  For data pipe to be available, a dma controller and a dma channel must be
+  referenced.
+
+properties:
+  compatible:
+    const: microchip,sama7g5-csi2dc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    description:
+      CSI2DC must have two clocks to function correctly. One clock is the
+      peripheral clock for the inside functionality of the hardware block.
+      This is named 'pclk'. The second clock must be the cross domain clock,
+      in which CSI2DC will perform clock crossing. This clock must be fed
+      by the next controller in pipeline, which usually is a sensor controller.
+      Normally this clock should be given by this sensor controller who
+      is also a clock source. This clock is named 'scck', sensor controller clock.
+    items:
+      - const: pclk
+      - const: scck
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description:
+          Input port node, single endpoint describing the input port.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+            description: Endpoint connected to input device
+
+            properties:
+              bus-type:
+                enum: [4, 5, 6]
+                default: 4
+
+              bus-width:
+                enum: [8, 9, 10, 11, 12, 13, 14]
+                default: 14
+
+              clock-noncontinuous:
+                type: boolean
+                description:
+                  Presence of this boolean property decides whether clock is
+                  continuous or noncontinuous.
+
+              remote-endpoint: true
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description:
+          Output port node, single endpoint describing the output port.
+
+        properties:
+          endpoint:
+            unevaluatedProperties: false
+            $ref: video-interfaces.yaml#
+            description: Endpoint connected to output device
+
+            properties:
+              bus-type:
+                enum: [5, 6]
+                default: 5
+
+              bus-width:
+                enum: [8, 9, 10, 11, 12, 13, 14]
+                default: 14
+
+              remote-endpoint: true
+
+    required:
+      - port@0
+      - port@1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ports
+
+examples:
+  # Example for connecting to a parallel sensor controller block (video pipe)
+  # and the input is received from Synopsys IDI interface
+  - |
+    csi2dc@e1404000 {
+        compatible = "microchip,sama7g5-csi2dc";
+        reg = <0xe1404000 0x500>;
+        clocks = <&pclk>, <&scck>;
+        clock-names = "pclk", "scck";
+
+        ports {
+               #address-cells = <1>;
+               #size-cells = <0>;
+               port@0 {
+                       reg = <0>; /* must be 0, first child port */
+                       csi2dc_in: endpoint { /* input from IDI interface */
+                               bus-type = <4>; /* MIPI CSI2 D-PHY */
+                               remote-endpoint = <&csi2host_out>;
+                       };
+               };
+
+               port@1 {
+                       reg = <1>; /* must be 1, second child port */
+                       csi2dc_out: endpoint {
+                               remote-endpoint = <&xisc_in>; /* output to sensor controller */
+                       };
+               };
+        };
+    };
+
+  # Example for connecting to a DMA master as an AHB slave
+  # and the input is received from Synopsys IDI interface
+  - |
+    #include <dt-bindings/dma/at91.h>
+    csi2dc@e1404000 {
+        compatible = "microchip,sama7g5-csi2dc";
+        reg = <0xe1404000 0x500>;
+        clocks = <&pclk>, <&scck>;
+        clock-names = "pclk", "scck";
+        dmas = <&dma0 AT91_XDMAC_DT_PERID(34)>;
+        dma-names = "rx";
+
+        ports {
+               #address-cells = <1>;
+               #size-cells = <0>;
+               port@0 {
+                       reg = <0>; /* must be 0, first child port */
+                       csi2dc_input: endpoint { /* input from IDI interface */
+                               remote-endpoint = <&csi2host_out>;
+                       };
+               };
+
+               port@1 {
+                       reg = <1>;
+               };
+        };
+    };
+
+...
-- 
2.25.1

