Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3FE46E87D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhLIMd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:33:26 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52831 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhLIMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639052990; x=1670588990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IF3u07Cvca1snD/fcDu2THtejBBY9GEcAPFTH0zMSI4=;
  b=AJog9hB26nnZZ+c+jxV7ZO9zZmXnASLrOgK4goIfKnpy322V83XIwlrW
   00NLRAlGJHkVWwsadJnfQC5Rgc+cw0zc6sG8YoP+nAh1XMUW6ANfY2rOX
   r5W6Q86jpMQNpUBGcGBIKluH7Or8AHAMJULm67u5+9k1eKEfy+TgnQVD+
   pZ1xwWAOacY+S2exVjnJBbF7JEE5Sg+g7qgxLDsqiQiCanbu/P+iuRmnw
   YhAvkK8iWISI1QxgASJGOuRrGQ+LpcgSr96Vrtakm0s0tSvy/eAENyWMX
   3mBD9RJkiQpVDF8o8tjUbugs8DmntojZArOZ661ShYB5YHKgWgFda4vs+
   w==;
IronPort-SDR: zpfq2qXK0NpfqfnHXH2olt3AIp44j/AFJp7QER9hBQdU6K+FjrGvHZ5GuxT8m0r/Orm64PiMiD
 MVz+DGcKCvFzZHNaKc2n6m4iho3RQvKMcmu/t2rOL8N/1ruJyM0mDC/zNHhY3luVnOJ53c/H4g
 /BPzFMBlwuP60/WFNEybttKAQ+vHSOW3rpAGxee4+JKubuna+h1E9u4Q3CL6bccRbqnqenNHk8
 BDNKPXIxAeGj46qY1bA6PGF9xCbBFlZs7slv7fbeWJ5wdtzguTraBhQXpS8cYLajX7worBgcqX
 RGLGyuiG57HXEKV0zrSvEDXh
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="141843400"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 05:29:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 05:29:49 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 05:29:46 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] dt-bindings: spi: atmel,quadspi: Define sama7g5 QSPI
Date:   Thu, 9 Dec 2021 14:29:39 +0200
Message-ID: <20211209122939.339810-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211209122939.339810-1-tudor.ambarus@microchip.com>
References: <20211209122939.339810-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sama7g5 embedds 2 instances of the QSPI controller:
1/ One Octal Serial Peripheral Interface (QSPI0) Supporting up to
   200 MHz DDR. Octal, TwinQuad, HyperFlash and OctaFlash Protocols
   Supported
2/ One Quad Serial Peripheral Interface (QSPI1) Supporting Up to
   90 MHz DDR/133 MHz SDR

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../devicetree/bindings/spi/atmel,quadspi.yaml   | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
index 7d0408f53c5f..1d493add4053 100644
--- a/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
@@ -17,6 +17,8 @@ properties:
     enum:
       - atmel,sama5d2-qspi
       - microchip,sam9x60-qspi
+      - microchip,sama7g5-qspi
+      - microchip,sama7g5-ospi
 
   reg:
     items:
@@ -32,17 +34,27 @@ properties:
     minItems: 1
     items:
       - description: peripheral clock
-      - description: system clock, if available
+      - description: system clock or generic clock, if available
 
   clock-names:
     minItems: 1
     items:
       - const: pclk
-      - const: qspick
+      - enum: [ qspick, gclk ]
 
   interrupts:
     maxItems: 1
 
+  dmas:
+    items:
+      - description: tx DMA channel
+      - description: rx DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   '#address-cells':
     const: 1
 
-- 
2.25.1

