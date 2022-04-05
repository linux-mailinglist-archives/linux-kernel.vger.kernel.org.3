Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534614F483C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379380AbiDEVcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382392AbiDEMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:15:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324BB0A6F;
        Tue,  5 Apr 2022 04:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157932; x=1680693932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8n2YxQNWVhdkwtjAv52Li27hbMlbmN6l6OeLTPUnnGY=;
  b=rQy1fe6rIbmakySXGVive3IJs0OraO33Hp+VDkVqRTe7O7zKN9QGTdfh
   c3pEAuIiZJqMw9t/5Zo5M6AKDaMByHN9qJMi93gWkccB2OJS0D0Tpur0d
   nHnsdD2uuWFHabcH8iLEN0Fp074O6oVo1ndSOzCOaqYTZhsE3WnBSSNC1
   k4vEMqznnLRUIXWOm/1+AcgN0oIpMOU4kmAeTPhnPJW5aUAf1hDsuJkUG
   aNcorcFza29cbcgIIsxmqHZkc6pZtVjv1v/gUXLTjFNhdIT1vr0RH3U9a
   1H4U1qZSXGQ2rms8UnvHH9VGgqHR7pQlXx54cC1lxE1E7yWGDPRFUdues
   g==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="151544594"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:25:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:25:29 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:25:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/8] dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
Date:   Tue, 5 Apr 2022 14:27:19 +0300
Message-ID: <20220405112724.2760905-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for SAMA7G5 reset controller. Compared with previous
versions of reset controllers this one contains support for resetting
in SoC devices (e.g. USB PHYs).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../reset/atmel,at91sam9260-reset.yaml        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
index 92936c987c9a..a165c10ae474 100644
--- a/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
@@ -10,7 +10,8 @@ maintainers:
   - Claudiu Beznea <claudiu.beznea@gmail.com>
 
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

