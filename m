Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E995673AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiGEQAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiGEQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:00:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87F13DCD;
        Tue,  5 Jul 2022 09:00:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35E8361B91;
        Tue,  5 Jul 2022 16:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4A4C341C7;
        Tue,  5 Jul 2022 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036807;
        bh=iNFu+DCH3hapeUc3T/tivUxYXOlzMBlW6gIg/mWtii8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gOPLhrbOO+fFuKTsxaoTB2TA6IUw0fPCOAYRWdnPC2QRQLkWaUQTpzWuTAzp0Gz0l
         fxCu/kSIFRluRp6z/2snPVwgBYjWddbrv+VPY9+Om7nZIWrkU3D6NkLnBan1szM4Qy
         KtP0+zsj2sNU/OM0BfxquL50JZD66nGVPwCVvGSXjZzNvTHQpTzLG9fw7nL6686PF+
         Q3dmARH9e7mcRonE6HehLqTizR8UAfhuyCdv7L50v72IDbIFn0UukEgEMpUeJttcWL
         lHHYlhPRN8kCLHtkmtFMRXCGRmuo53116NkNz/629rA6FZ8e9TX28OGywxfjCsrRIw
         59AmdL6iNxAXw==
Received: by pali.im (Postfix)
        id D5003CBF; Tue,  5 Jul 2022 18:00:03 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add cznic,turris1x-leds.yaml binding
Date:   Tue,  5 Jul 2022 17:59:28 +0200
Message-Id: <20220705155929.25565-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220705000448.14337-1-pali@kernel.org>
References: <20220705000448.14337-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree bindings documentation for Turris 1.x RGB LEDs.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v2:
* Fix schema errors
---
 .../bindings/leds/cznic,turris1x-leds.yaml    | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml

diff --git a/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
new file mode 100644
index 000000000000..bcaab5b03128
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/cznic,turris1x-leds.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/cznic,turris1x-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CZ.NIC's Turris 1.x LEDs driver
+
+maintainers:
+  - Pali Rohár <pali@kernel.org>
+
+description:
+  This module adds support for the RGB LEDs found on the front panel of the
+  Turris 1.x routers. There are 8 RGB LEDs that are controlled by CZ.NIC CPLD
+  firmware running on Lattice FPGA. Firmware is open source and available at
+  https://gitlab.nic.cz/turris/hw/turris_cpld/-/blob/master/CZ_NIC_Router_CPLD.v
+
+properties:
+  compatible:
+    const: cznic,turris1x-leds
+
+  reg:
+    description: CPLD address range where LED registers are mapped
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^multi-led@[0-7]$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    cpld@3,0 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x3 0x0 0x00020000>;
+
+        led-controller@13 {
+            compatible = "cznic,turris1x-leds";
+            reg = <0x13 0x1d>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            multi-led@0 {
+                    reg = <0x0>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_WAN;
+            };
+
+            multi-led@1 {
+                    reg = <0x1>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <5>;
+            };
+
+            multi-led@2 {
+                    reg = <0x2>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <4>;
+            };
+
+            multi-led@3 {
+                    reg = <0x3>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <3>;
+            };
+
+            multi-led@4 {
+                    reg = <0x4>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <2>;
+            };
+
+            multi-led@5 {
+                    reg = <0x5>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+            };
+
+            multi-led@6 {
+                    reg = <0x6>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_WLAN;
+            };
+
+            multi-led@7 {
+                    reg = <0x7>;
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_POWER;
+            };
+        };
+    };
+
+...
-- 
2.20.1

