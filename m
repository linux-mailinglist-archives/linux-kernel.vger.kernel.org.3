Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187F14FEF82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiDMGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiDMGLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:11:11 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865BA35DCC;
        Tue, 12 Apr 2022 23:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649830117; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BiUbEUIHXIRrZXDGJfUo+W4AjUSABlHdBC7OBng3VUCiSKZKDU6D3TBYmK8fqDSvJrvfnps5ofUkU9TaeGrksgD7v/eO4s+fz7FpK2v8w4OKJc1vl+HXL3qDajtZ7DhmNf5xI+OgVun7wYbhHjfIBB9XQA0sy55nNqmXgIjiDwE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649830117; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Z9OI2iyoJdnz5EmsHXut+vIwbquSFmvba6kvk2HobWI=; 
        b=XTAzbS+8EZ8Bu6v0dMvLdTZquGM/yeCJD8xPa1T13ihP2I5MjcU0D9IWlc8mjroyOfkL3TKEFwrx04FtVEGLsWGCyHOpXsRSD83gIukhLzyGnF21+OzYgDmuvVeOz9Mc+abZ3aogZI2PZteuDgIXFHQBJM+Khe+KZBdNw2yhscI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649830117;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=Z9OI2iyoJdnz5EmsHXut+vIwbquSFmvba6kvk2HobWI=;
        b=W+1HVaE9dKQqi+fuU/u3fF9/R9Php3FUcYw1ol2/wyrno4+bIZuccws0yocO+Avr
        w/2b8LTjVgDim9Zfa3KWx9IboSBD2zXDmpqcFptQ56ebepqpAl47173EUjomnjsEsoV
        ZxiLT78Vkv1zvawFFrMCkcHkutUVAFMnWJ5nQAQA=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649830115843597.8661474284708; Tue, 12 Apr 2022 23:08:35 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 10/14] dt-bindings: pinctrl: rt2880: fix binding name, pin groups and functions
Date:   Wed, 13 Apr 2022 09:07:25 +0300
Message-Id: <20220413060729.27639-11-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413060729.27639-1-arinc.unal@arinc9.com>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change binding name from ralink,rt2880-pinmux to ralink,rt2880-pinctrl.
This is the binding for the Ralink RT2880 pinctrl subdriver.

Current pin group and function bindings are for MT7621. Put bindings for
RT2880 instead.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 ...pinmux.yaml => ralink,rt2880-pinctrl.yaml} | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{ralink,rt2880-pinmux.yaml => ralink,rt2880-pinctrl.yaml} (56%)

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
similarity index 56%
rename from Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
rename to Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
index 9de8b0c075e2..c657bbf9fdda 100644
--- a/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml
@@ -1,21 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinmux.yaml#
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt2880-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ralink rt2880 pinmux controller
+title: Ralink RT2880 Pin Controller
 
 maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
   - Sergio Paracuellos <sergio.paracuellos@gmail.com>
 
 description:
-  The rt2880 pinmux can only set the muxing of pin groups. Muxing indiviual pins
+  Ralink RT2880 pin controller for RT2880 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing indiviual pins
   is not supported. There is no pinconf support.
 
 properties:
   compatible:
-    const: ralink,rt2880-pinmux
+    const: ralink,rt2880-pinctrl
 
 patternProperties:
   '-pins$':
@@ -28,14 +30,12 @@ patternProperties:
 
         properties:
           groups:
-            description: Name of the pin group to use for the functions.
-            enum: [i2c, jtag, mdio, pcie, rgmii1, rgmii2, sdhci, spi,
-                   uart1, uart2, uart3, wdt]
+            description: The pin group to select.
+            enum: [i2c, spi, uartlite, jtag, mdio, sdram, pci]
+
           function:
-            description: The mux function to select
-            enum: [gpio, i2c, i2s, jtag, mdio, nand1, nand2, pcie refclk,
-                   pcie rst, pcm, rgmii1, rgmii2, sdhci, spdif2, spdif3,
-                   spi, uart1, uart2, uart3, wdt refclk, wdt rst]
+            description: The mux function to select.
+            enum: [gpio, i2c, spi, uartlite, jtag, mdio, sdram, pci]
 
         required:
           - groups
@@ -57,7 +57,7 @@ examples:
   # Pinmux controller node
   - |
     pinctrl {
-      compatible = "ralink,rt2880-pinmux";
+      compatible = "ralink,rt2880-pinctrl";
 
       i2c_pins: i2c0-pins {
         pinmux {
-- 
2.25.1

