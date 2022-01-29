Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914644A31E0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353152AbiA2UkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 15:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347096AbiA2UkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 15:40:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617FAC061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:40:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e8so17685816wrc.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5j4Lp15SmJkfLirC7e9ctVB85SgWzCUrNRsur35kQU=;
        b=10WWbFMO2KEv2ncnmd2fiaHXIr0qTwt2AAfgWqeJk2VbJWhFLIKnJmA9jLaok3vljq
         vt+SpZLfl7WFQZVntYIudgKm6/CXmnkojj2aIEZWZThGJJlWifbUYJY7oJosCkYiEHGY
         CrBvaFJOzCIP85lBJLWpputV2VKiYvfx14HIeQVdOrNEJ1kRMaou0FuDJqSuaXpVct50
         uXB94c+psLI8cVS+FcKBSItgadTa07RFtwoKzo7GJmDsfZtgluzPZX9xk6GyqCxb+VmU
         n/PzugPgwz68HIHINBZvWjIT+qs/ROO49w5FSGmcLU4J65n5+QgUtE/QEUwEzBW1jRxM
         XZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U5j4Lp15SmJkfLirC7e9ctVB85SgWzCUrNRsur35kQU=;
        b=Y/B4cQ00HXfz24pJqd5mB8LDyixTaCoowE48CD2ydcFZV3RJ6o8csT5/xaBuFROsGu
         /PruSF4AmtFBbHiQEZjmk5BYcKF/mEenegO/gcyJOh+SMvyBtHvF6ny5ZxaNoqd23O42
         8J6KtF6LAko7dDkgo2Xzcf9UTQQAVWRE6OvVs9k5a6V02ouJ9FzbdrnFxBMgRvtDwHeF
         GxpZZoKrN33KhZ6zhkNHusUfasWvRXF54MVKH3AnQrliZA/nyuiQjA25eSKeF68LdyWs
         eDMqUzVqMw01EHrrAmrfJikHjMESaLY1SaNdMsDYV8GSGvF4ySVGJf2HC3n50znj2Xrw
         H29w==
X-Gm-Message-State: AOAM532G0XhBrbwDqCSY4SXUNosO8exi6r/j5EniZhvFLggSu5crMzTk
        IOo/H3N25/k6hUvH3sqqOkuTQQ==
X-Google-Smtp-Source: ABdhPJzxGPN4HvMYawcxI0HhDUqZbvOgoIMexR49vt8JzCPMfBawIPqjLopQtnAmfSjNhvYiiBGvQA==
X-Received: by 2002:a05:6000:178b:: with SMTP id e11mr11491365wrg.634.1643488809950;
        Sat, 29 Jan 2022 12:40:09 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 1sm9227248wry.52.2022.01.29.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 12:40:09 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     damien.lemoal@opensource.wdc.com, linus.walleij@linaro.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: ata: convert ata/cortina,gemini-sata-bridge to yaml
Date:   Sat, 29 Jan 2022 20:40:04 +0000
Message-Id: <20220129204004.1009571-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts ata/cortina,gemini-sata-bridge binding to yaml

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../ata/cortina,gemini-sata-bridge.txt        |  55 ----------
 .../ata/cortina,gemini-sata-bridge.yaml       | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 55 deletions(-)
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
index 000000000000..ff27e4884e21
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/cortina,gemini-sata-bridge.yaml
@@ -0,0 +1,100 @@
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
+    const: "cortina,gemini-sata-bridge"
+  reg:
+    minItems: 1
+  resets:
+    minItems: 2
+    description: phandles to the reset lines for both SATA bridges
+  reset-names:
+    items:
+      - const: "sata0"
+      - const: "sata1"
+  clocks:
+    minItems: 2
+    description: phandles to the compulsory peripheral clocks
+  clock-names:
+    items:
+      - const: "SATA0_PCLK"
+      - const: "SATA1_PCLK"
+  syscon:
+    minItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle to the global Gemini system controller
+  cortina,gemini-ata-muxmode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 0
+      - 1
+      - 2
+      - 3
+    description: |
+      tell the desired multiplexing mode for the ATA controller and SATA bridges. Values 0..3:
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
+    description: enables the PATA to IDE connection.
+                 The muxmode setting decides whether ATA0 or ATA1 is brought out,
+                 and whether master, slave or both interfaces get brought out.
+  cortina,gemini-enable-sata-bridge:
+    type: boolean
+    description: enables the PATA to SATA bridge
+                 inside the Gemnini SoC. The Muxmode decides what PATA blocks will
+                 be muxed out and how.
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
+    sata: sata@46000000 {
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

