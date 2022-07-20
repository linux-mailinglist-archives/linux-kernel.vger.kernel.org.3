Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360FC57BED5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiGTTqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGTTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:45:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF9E1145B;
        Wed, 20 Jul 2022 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658346354; x=1689882354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bszvKFIgFMZrjUZ+SOyrgfU7M2ShoWC/rXL9ffjC6xc=;
  b=wKRXnFq/nH8WjtxH9MxdYcErFZfXH6poldwXEXTpZoQ00yp74HMmiSCR
   49Crd15TS+OUrZEF80ZAKu2f0mWxB0dKyda2/iv82KYghddoJa2E0Q/Gv
   Qh0XNcvERVWmDmJrNd02iaXGZ/rERdzibMWcUqkmw8VJNbusMoxaTXP/H
   9N1kw3n5pFOp+9A7jpFmRM1VUYX5Epqsth9iS1kOkjiTQOpEFpd088nHb
   A+fIhfRkTLEbkIs6D+w9Pd3qH+AyfNtyqymJig5Uqw2MNvd0wF7aFFNZB
   KRH/E2SZtSAZy/9pQfsrSEvE7zkg3zAYCDorgUyZlXq0z09WzWQYAWoDi
   w==;
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="173158928"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 12:45:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 12:45:53 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 12:45:50 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <UNGLinuxDriver@microchip.com>,
        <maxime.chevallier@bootlin.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 1/2] dt-bindings: arm: at91: add lan966 pcb8309 board
Date:   Wed, 20 Jul 2022 21:49:03 +0200
Message-ID: <20220720194904.2025384-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
References: <20220720194904.2025384-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Microchip LAN9662 PCB8309.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 4e495e03264b..9dc9ad81193a 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -169,6 +169,12 @@ properties:
           - const: microchip,lan9662
           - const: microchip,lan966
 
+      - description: Microchip LAN9662 PCB8309 Evaluation Board.
+        items:
+          - const: microchip,lan9662-pcb8309
+          - const: microchip,lan9662
+          - const: microchip,lan966
+
       - description: Microchip LAN9668 PCB8290 Evaluation Board.
         items:
           - const: microchip,lan9668-pcb8290
-- 
2.33.0

