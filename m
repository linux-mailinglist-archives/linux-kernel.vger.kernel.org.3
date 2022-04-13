Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C54FEF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiDMGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiDMGLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:11:32 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD651E67;
        Tue, 12 Apr 2022 23:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649830134; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=avtSYMatMQJTrvfdxH9tcMztEPmn8u2zb4O7F+3j+jyn7fN+YJ+hUKHj62tjFqaBwVG9RBXaSBPETmVn8m++fw5RabDjKwAzIXW/cHJ7Aemgj1Bwc79/uKU8Dq9MokCsK7DAgL69YYudAc8n1b24ISEiNAUFeoyHWNguyd4iOfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649830134; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vTUK5pF/zz+MqI8xc+MhrlHhkZm8+zGbv4qzWp+bAOE=; 
        b=NhDgpIiMVBktiDlGV/krs0IHM+bqOylp/Al5kOTSrW0I8AbVInNxMNnwjziWm/4PcdUSjFnxZ9Nk0ipfowPLsMBmELrrqdZdSl57zL8INo4GYcpmXNOEowOj4ei21DYJBith5K0Y7dlbeuc/x53A5sl5JeZrx2Xgf8mwPCrdKFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649830134;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=vTUK5pF/zz+MqI8xc+MhrlHhkZm8+zGbv4qzWp+bAOE=;
        b=ejk/5EvrqsknZXlaLdvQGYU93zbCdTKVMlIZ4j8DpZkISNRrzojLACKDOitPIi5c
        L06j4w4zK9iwD3VF03Y9CMTmMWY97rHnxPpV43b+Szwce/LmhbrZ66u+L+AD9lhl7NO
        X9NGzPIuZvHT1HFCCnt0/Ftsm6RSh4wzqFg9DJZU=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649830132114573.9252729984381; Tue, 12 Apr 2022 23:08:52 -0700 (PDT)
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
Subject: [PATCH 14/14] dt-bindings: pinctrl: add binding for Ralink RT3883 pinctrl
Date:   Wed, 13 Apr 2022 09:07:29 +0300
Message-Id: <20220413060729.27639-15-arinc.unal@arinc9.com>
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

Add binding for the Ralink RT3883 pin controller for RT3883 SoC.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../pinctrl/ralink,rt3883-pinctrl.yaml        | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
new file mode 100644
index 000000000000..583efc0ad51c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/ralink,rt3883-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ralink RT3883 Pin Controller
+
+maintainers:
+  - Arınç ÜNAL <arinc.unal@arinc9.com>
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description:
+  Ralink RT3883 pin controller for RT3883 SoC.
+  The pin controller can only set the muxing of pin groups. Muxing indiviual pins
+  is not supported. There is no pinconf support.
+
+properties:
+  compatible:
+    const: ralink,rt3883-pinctrl
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
+            enum: [ge1, ge2, i2c, jtag, lna a, lna g, mdio, pci, spi, uartf, uartlite]
+
+          function:
+            description: The mux function to select.
+            enum: [ge1, ge2, gpio, gpio i2s, gpio uartf, i2c, i2s uartf, jtag, lna a, lna g, mdio, pci-dev,
+                   pci-fnc, pci-host1, pci-host2, pcm gpio, pcm i2s, pcm uartf, spi, uartf, uartlite]
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
+      compatible = "ralink,rt3883-pinctrl";
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

