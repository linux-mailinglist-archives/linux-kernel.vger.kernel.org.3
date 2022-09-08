Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0A5B25EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiIHSg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiIHSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:35:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C2FE902E;
        Thu,  8 Sep 2022 11:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662662150; x=1694198150;
  h=from:to:subject:date:message-id:mime-version;
  bh=h9p/+uX2RAB3V9XaOftI0A9VkAF/FC15sxqN67WuOvI=;
  b=RkWlrffHwa7BKTs4OPQf2c8gacLb6cuAERU7g1Vw1mefmUNT7KU3LbMS
   Nszz8Z3gcFUuK/Dd0nzUyzXquGix0EskPYEG7ZzSFu1UOEtAuYdDev0eV
   FQ1NH2QVkk7LlQ8e5V1XEqCJg0d80Uc1ali9XO1PFKdpXlge+/mZcA0Dy
   O9Ni0qFqvNt3FML7871Wrx+SuOJ51YhOoZhqjOtWobhEjIATDfIjXm1fh
   TLFkuXHB/LK8y5uDqKE69PfNRMY95mPJSwXjQ+bhnjHZGcpMyOZSZb4M+
   OA6O0YvKnZbfg318t+6ZgRkTnPLubfmODQqNxyviZU4T4aLzfwhrwL3sI
   w==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="173015060"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 11:35:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 11:35:38 -0700
Received: from AUS-LT-C33025.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 11:35:37 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jerry Ray" <jerry.ray@microchip.com>
Subject: [linux][PATCH v7 1/2] ARM: dts: at91: Add info on SAMA5D3-EDS
Date:   Thu, 8 Sep 2022 13:35:36 -0500
Message-ID: <20220908183537.8004-1-jerry.ray@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board
description yaml file.

Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
---
v6->v7:
 - Moved the placement of the Microchip SAMA5D3-EDS entry within the file.
v5->v6:
 - No code change - patch prefix naming modified to match with others.
v4->v5:
 - No change
v3->v4:
 - No change
v2->v3:
 - No change
v1->v2:
 - Added Device Tree documentation for Microchip SAMA5D3-EDS board
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 2b7848bb7769..9e2e66a7566d 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -127,6 +127,13 @@ properties:
           - const: atmel,sama5d3
           - const: atmel,sama5
 
+      - description: Microchip SAMA5D3 Ethernet Development System Board
+        items:
+          - const: microchip,sama5d3-eds
+          - const: atmel,sama5d36
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
       - description: CalAmp LMU5000 board
         items:
           - const: calamp,lmu5000
-- 
2.17.1

