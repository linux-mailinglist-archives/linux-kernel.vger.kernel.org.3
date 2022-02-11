Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9B4B2524
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349816AbiBKMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiBKMCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:02:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2F5F50
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:02:06 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i14so14797171wrc.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKg5fgaSRnMfSUuR5qSVwQe2umofrKLlYtM6bnZW0nM=;
        b=INTwi1N5tH0s4u9PMfQwQ3Yf+GzW5by2wfp+2ny8x/OOnJaeugXwYoCiXTcxHoSanf
         wJ+BEzQv2Uzugz8U5r0b7ey/Yzd0kGrLIEiuozg5FIpD8YgXdVs+doS98xhJWo0Mba8Q
         FYHVj/ZkjVAlt/wFto0stFJNRFIgwAw1MX69IQ36xuc4pFVXgzH31TlotcuwnNiXyYDe
         onDRKXfOMFgNftjCDnj2764DPwCyFmAtig+DyPsAk0V4FoOPofQ6XXrKxDsv4TpIPxA+
         CxT05NboeOk/3GZvh5nGKubPEzNayXlXoAIPWR3xn+2SuIlIrP7hiF73cfv91UQ/7guX
         a3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKg5fgaSRnMfSUuR5qSVwQe2umofrKLlYtM6bnZW0nM=;
        b=SXpSOeokdnWJCppjmxfHrUnEZuvRipQLSeEdd+/u5cx5fCwrCW0XF7F0AZvFckZGUK
         nCLYnglDXUbJoY9MENgVBLvbLD+KFSZ2t5flfFFjPVI9EZ0wAeTKrKNahkPiFUTnzZeb
         +9qXIQa7HUqb7T+ExsT23mlSdLtO2yUBGUn1/6o/bXotpihILqRIKNDFRpVkx+KMQi9W
         4sMnC0il/N3p0w5l7jIh5qCJUmvNMnnW1sI+YUCwdwtqmM5B2jGNucgueZyPSaICJnmu
         6NOJWIrdhyiJyBrObhk1znJfYfcpcYsk5ttggS6twfU2VBQctZi0Kija603i8yIt/ton
         I8/A==
X-Gm-Message-State: AOAM531jMmLtHdAr23rBatCkkv6vR26szsDCxC2usIR314Ytyp5xUfEG
        8J+urHXHaBHJ3s+cKEmzAIqLEA==
X-Google-Smtp-Source: ABdhPJxOk8Ft1kaaLr9QNpJwth1RnYfwy/lDSjmAiJXSSNiflQ9niPakqGD4UkyB8S4sPm/so3B1/Q==
X-Received: by 2002:adf:bbc8:: with SMTP id z8mr1134991wrg.476.1644580924528;
        Fri, 11 Feb 2022 04:02:04 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h10sm14695606wrt.57.2022.02.11.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 04:02:04 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     damien.lemoal@opensource.wdc.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4] dt-bindings: convert ata/cortina,gemini-sata-bridge to yaml
Date:   Fri, 11 Feb 2022 12:01:57 +0000
Message-Id: <20220211120157.3385145-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ata/cortina,gemini-sata-bridge binding to yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
Change since v1:
- fixed cosmetic nits reported by Damien Le Moal
Changes since v2:
- Added blank lines between properties
- Removed useless quotes and label
- Re-indented description
Change since v3:
- removed MaxItems from syscon

 .../ata/cortina,gemini-sata-bridge.txt        |  55 ---------
 .../ata/cortina,gemini-sata-bridge.yaml       | 109 ++++++++++++++++++
 2 files changed, 109 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml

diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
deleted file mode 100644
index 1c3d3cc70051..000000000000
--- a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Cortina Systems Gemini SATA Bridge
-
-The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
-takes two Faraday Technology FTIDE010 PATA controllers and bridges
-them in different configurations to two SATA ports.
-
-Required properties:
-- compatible: should be
-  "cortina,gemini-sata-bridge"
-- reg: registers and size for the block
-- resets: phandles to the reset lines for both SATA bridges
-- reset-names: must be "sata0", "sata1"
-- clocks: phandles to the compulsory peripheral clocks
-- clock-names: must be "SATA0_PCLK", "SATA1_PCLK"
-- syscon: a phandle to the global Gemini system controller
-- cortina,gemini-ata-muxmode: tell the desired multiplexing mode for
-  the ATA controller and SATA bridges. Values 0..3:
-  Mode 0: ata0 master <-> sata0
-          ata1 master <-> sata1
-          ata0 slave interface brought out on IDE pads
-  Mode 1: ata0 master <-> sata0
-          ata1 master <-> sata1
-          ata1 slave interface brought out on IDE pads
-  Mode 2: ata1 master <-> sata1
-          ata1 slave  <-> sata0
-          ata0 master and slave interfaces brought out
-               on IDE pads
-  Mode 3: ata0 master <-> sata0
-          ata0 slave  <-> sata1
-          ata1 master and slave interfaces brought out
-               on IDE pads
-
-Optional boolean properties:
-- cortina,gemini-enable-ide-pins: enables the PATA to IDE connection.
-  The muxmode setting decides whether ATA0 or ATA1 is brought out,
-  and whether master, slave or both interfaces get brought out.
-- cortina,gemini-enable-sata-bridge: enables the PATA to SATA bridge
-  inside the Gemnini SoC. The Muxmode decides what PATA blocks will
-  be muxed out and how.
-
-Example:
-
-sata: sata@46000000 {
-	compatible = "cortina,gemini-sata-bridge";
-	reg = <0x46000000 0x100>;
-	resets = <&rcon 26>, <&rcon 27>;
-	reset-names = "sata0", "sata1";
-	clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
-		 <&gcc GEMINI_CLK_GATE_SATA1>;
-	clock-names = "SATA0_PCLK", "SATA1_PCLK";
-	syscon = <&syscon>;
-	cortina,gemini-ata-muxmode = <3>;
-	cortina,gemini-enable-ide-pins;
-	cortina,gemini-enable-sata-bridge;
-};
diff --git a/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
new file mode 100644
index 000000000000..21a90975593b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/cortina,gemini-sata-bridge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems Gemini SATA Bridge
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+    The Gemini SATA bridge in a SoC-internal PATA to SATA bridge that
+    takes two Faraday Technology FTIDE010 PATA controllers and bridges
+    them in different configurations to two SATA ports.
+
+properties:
+  compatible:
+    const: cortina,gemini-sata-bridge
+
+  reg:
+    maxItems: 1
+
+  resets:
+    minItems: 2
+    maxItems: 2
+    description: phandles to the reset lines for both SATA bridges
+
+  reset-names:
+    items:
+      - const: sata0
+      - const: sata1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+    description: phandles to the compulsory peripheral clocks
+
+  clock-names:
+    items:
+      - const: SATA0_PCLK
+      - const: SATA1_PCLK
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the global Gemini system controller
+
+  cortina,gemini-ata-muxmode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0
+      - 1
+      - 2
+      - 3
+    description: |
+      Tell the desired multiplexing mode for the ATA controller and SATA
+      bridges.
+      Mode 0: ata0 master <-> sata0
+              ata1 master <-> sata1
+              ata0 slave interface brought out on IDE pads
+      Mode 1: ata0 master <-> sata0
+              ata1 master <-> sata1
+              ata1 slave interface brought out on IDE pads
+      Mode 2: ata1 master <-> sata1
+              ata1 slave  <-> sata0
+              ata0 master and slave interfaces brought out on IDE pads
+      Mode 3: ata0 master <-> sata0
+              ata0 slave  <-> sata1
+              ata1 master and slave interfaces brought out on IDE pads
+
+  cortina,gemini-enable-ide-pins:
+    type: boolean
+    description: Enables the PATA to IDE connection.
+      The muxmode setting decides whether ATA0 or ATA1 is brought out,
+      and whether master, slave or both interfaces get brought out.
+
+  cortina,gemini-enable-sata-bridge:
+    type: boolean
+    description: Enables the PATA to SATA bridge inside the Gemnini SoC.
+      The Muxmode decides what PATA blocks will be muxed out and how.
+
+required:
+  - clocks
+  - clock-names
+  - cortina,gemini-ata-muxmode
+  - resets
+  - reset-names
+  - compatible
+  - reg
+  - syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cortina,gemini-clock.h>
+    sata@46000000 {
+      compatible = "cortina,gemini-sata-bridge";
+      reg = <0x46000000 0x100>;
+      resets = <&rcon 26>, <&rcon 27>;
+      reset-names = "sata0", "sata1";
+      clocks = <&gcc GEMINI_CLK_GATE_SATA0>,
+               <&gcc GEMINI_CLK_GATE_SATA1>;
+      clock-names = "SATA0_PCLK", "SATA1_PCLK";
+      syscon = <&syscon>;
+      cortina,gemini-ata-muxmode = <3>;
+      cortina,gemini-enable-ide-pins;
+      cortina,gemini-enable-sata-bridge;
+    };
-- 
2.34.1

