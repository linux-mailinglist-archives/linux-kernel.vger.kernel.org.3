Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB062501A52
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbiDNRo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343870AbiDNRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:43:41 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D47E6C77;
        Thu, 14 Apr 2022 10:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649958033; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HmBlFh49I5d+3fOI1GKxvLytOXmNgP1fBtydOZs8BNrN8me3t1ryRdFPFHLrLVmfb5iQxqKRXGpUJf1Ct/2/5nsknrW9AxoHKJXcIc3UBaKPF6I0OyQZ26yWhSpuS5ipKmJpM11IyWest+q5bg9ycX6RlsGNI5gtnq48Z9RwnII=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649958033; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6WorpwNzRGvitFn8B8dTme9JwnssgeQFz9v0cURTiC8=; 
        b=C6fADviAfg4UclzJnIwrrgchvrT1Rn2gzuUzcE8WdZUzWVlvJ7cwEyu36FxDtJ9T22pPG+y+vkloBNxzvV4YNBDQ+1sycRhE2SXPw+TLKcHmzzhpOkaYB0y3UkpTLabYEe7sZCN3giSQOpYSnIZ8LXkB5A3wrG0dvQSPqMTNDPE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649958033;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=6WorpwNzRGvitFn8B8dTme9JwnssgeQFz9v0cURTiC8=;
        b=Bh6yL6OHatcspOpXw2TZiHB0ITqcWhOFQoqPzeb4fixH1Abz+48ChkV15yQVbhR0
        Ubt2hMWV2bPDrY854+YQrXqDx+2N91LEBtlTjOVXrLCUnHSNKSVcCr/02RiHTKrljNi
        epawh+Ch135EdrAAdWxEV7iYCB5roms9sUd5FZzg=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649958032683220.010621040307; Thu, 14 Apr 2022 10:40:32 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 13/14] dt-bindings: pinctrl: add binding for Ralink RT305X pinctrl
Date:   Thu, 14 Apr 2022 20:39:15 +0300
Message-Id: <20220414173916.5552-14-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
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

Add binding for the Ralink RT305X pin controller for RT3050, RT3052,
RT3350, RT3352 and RT5350 SoCs.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../pinctrl/ralink,rt305x-pinctrl.yaml        | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
new file mode 100644
index 000000000000..425401c54269
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt305x-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT305X Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description:
+  Ralink RT305X pin controller for RT3050, RT3052, RT3350, RT3352 and RT5350
+  SoCs.
+  The pin controller can only set the muxing of pin groups. Muxing individual
+  pins is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,rt305x-pinctrl
+
+patternProperties:
+  '-pins$':
+    type: object
+    patternProperties:
+      '^(.*-)?pinmux$':
+        type: object
+        description: node for pinctrl.
+        $ref: pinmux-node.yaml#
+
+        properties:
+          groups:
+            description: The pin group to select.
+            enum: [
+              # For RT3050, RT3052 and RT3350 SoCs
+              i2c, jtag, mdio, rgmii, sdram, spi, uartf, uartlite,
+
+              # For RT3352 SoC
+              i2c, jtag, led, lna, mdio, pa, rgmii, spi, spi_cs1, uartf,
+              uartlite,
+
+              # For RT5350 SoC
+              i2c, jtag, led, spi, spi_cs1, uartf, uartlite,
+            ]
+
+          function:
+            description: The mux function to select.
+            enum: [
+              # For RT3050, RT3052 and RT3350 SoCs
+              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, mdio, pcm gpio,
+              pcm i2s, pcm uartf, rgmii, sdram, spi, uartf, uartlite,
+
+              # For RT3352 SoC
+              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, lna, mdio,
+              pa, pcm gpio, pcm i2s, pcm uartf, rgmii, spi, spi_cs1, uartf,
+              uartlite, wdg_cs1,
+
+              # For RT5350 SoC
+              gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, led, pcm gpio,
+              pcm i2s, pcm uartf, spi, spi_cs1, uartf, uartlite, wdg_cs1,
+            ]
+
+        required:
+          - groups
+          - function
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  # Pinmux controller node
+  - |
+    pinctrl {
+      compatible = "ralink,rt305x-pinctrl";
+
+      i2c_pins: i2c0-pins {
+        pinmux {
+          groups = "i2c";
+          function = "i2c";
+        };
+      };
+    };
-- 
2.25.1

