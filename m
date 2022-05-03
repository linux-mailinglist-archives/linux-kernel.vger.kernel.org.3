Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05695182CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiECLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiECLAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:00:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C921E26;
        Tue,  3 May 2022 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651575384; x=1683111384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Eup3wdhItPs5S0DzMQ1JST6KjNM8ndKwpGJX5U2PUNk=;
  b=0MSFDJ7PmvBzhLwjt3EsGG1kOZ7MlNoMqKr/Odh3InT3K8FRf1QlGeE1
   Kf02m/TlVAjaSytcrMtfLLdYD8gjXV2aApc7MQC/e6Bv9Hfwa7pQZcYt4
   v+r4MGex3cFKQiGZ+eDs1D/Te9cmh4M9BcdiQ4oizG02TzJG85ynfZOsZ
   DuiJvpsdZAMk58F26w3v13DuY+CzKbyfPmNvQ2R0zj5B9iI2seIzc7A46
   AOzzNH6MGww8YdHrAlV70v788LWLVr1mf5MrtimFMOeiXcMiGznrzNjNf
   eb0IRdM0ToIWe/qqIIsX6bbYxjhIv8GAVjt7Ew6w1kfe2kO/WORA62NfA
   g==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="162535325"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 03:56:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 03:56:23 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 03:56:19 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH 2/4] dt-bindings: mfd: atmel,flexcom: Add lan966 compatible string and mux properties
Date:   Tue, 3 May 2022 16:25:26 +0530
Message-ID: <20220503105528.12824-3-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
References: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lan966 flexcom compatible string and flexcom mux
device tree properties

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 .../devicetree/bindings/mfd/atmel,flexcom.yaml   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
index 62dea9b891d8..3e056857c44a 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - atmel,sama5d2-flexcom
+      - microchip,lan966-flexcom
 
   reg:
     minItems: 1
@@ -45,6 +46,19 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2]
 
+  # The following optional mux properties are only for lan966 flexcoms
+  mux-controls:
+    minItems: 1
+    description: Phandle to the mux controller to map flexcom chip-select
+     to flexcom shared pin.
+
+  mux-control-names:
+    description: String to label the mux controller.
+    minItems: 1
+    items:
+      - const: cs0
+      - const: cs1
+
 required:
   - compatible
   - reg
@@ -64,5 +78,7 @@ examples:
           #size-cells = <1>;
           ranges = <0x0 0xf8034000 0x800>;
           atmel,flexcom-mode = <2>;
+          mux-controls = <&mux 0>;
+          mux-control-names = "cs0";
     };
 ...
-- 
2.17.1

