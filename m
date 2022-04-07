Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B208F4F7709
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241730AbiDGHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbiDGHRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65AD141479;
        Thu,  7 Apr 2022 00:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315710; x=1680851710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5AzebHFW+wKVCswo1mni6dGq0V0+Rg/eIh7HzLox4c=;
  b=xp3RkiHRQyOfazdWo/bUdiDYAqcDn5kCuphqNG8khz5X+PNQSyRF695o
   fRiUV8LgwGbII+RbhCv0BGM8Pbljydk2r9+XC5X3CBDjdr+R6iBFuVb+9
   ch1DXganVlKTsJJmzCsd0xHVUuHjcQX9T0y0c5BDMRIt+omCCJnEefr6c
   mBTs0FXKrpO2/krn+k6+tc0PZ9PWsSx8pEMcJXDNSwlvSJL1v2m2vQ/a/
   9V+FU4twGdcjOeOoiFGdaON/LCsY3vSiP3j6pcdFQHBNzkNYuZqvuta4B
   GIe3fJ0mntz/eA33cdD7ZQb64xpl1fk3L3u3C1ZXmrW3T0rk5mUT5YXCs
   A==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159247051"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:09 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 03/10] dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
Date:   Thu, 7 Apr 2022 10:17:01 +0300
Message-ID: <20220407071708.3848812-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for SAMA7G5 reset controller. Compared with previous
versions of reset controllers this one contains support for resetting
in SoC devices (e.g. USB PHYs).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../reset/atmel,at91sam9260-reset.yaml        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 34c40b875e20..98465d26949e 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -10,7 +10,8 @@ maintainers:
   - Claudiu Beznea <claudiu.beznea@microchip.com>
 
 description: |
-  The system reset controller can be used to reset the CPU.
+  The system reset controller can be used to reset the CPU. In case of
+  SAMA7G5 it can also reset some devices (e.g. USB PHYs).
 
 properties:
   compatible:
@@ -21,21 +22,39 @@ properties:
               - atmel,at91sam9g45-rstc
               - atmel,sama5d3-rstc
               - microchip,sam9x60-rstc
+              - microchip,sama7g5-rstc
       - items:
           - const: atmel,sama5d3-rstc
           - const: atmel,at91sam9g45-rstc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: base registers for system reset control
+      - description: registers for device specific reset control
 
   clocks:
     maxItems: 1
 
+  "#reset-cells":
+    const: 1
+
 required:
   - compatible
   - reg
   - clocks
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,sama7g5-rstc
+    then:
+      required:
+        - "#reset-cells"
+
 additionalProperties: false
 
 examples:
-- 
2.32.0

