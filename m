Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3149B51FC61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiEIMR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiEIMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:17:26 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF991EF0A4;
        Mon,  9 May 2022 05:13:32 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 97F7083B32;
        Mon,  9 May 2022 14:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652098410;
        bh=42Zy28pg37OAk1vRPr/3wZvq3TQDaK06uRqMNZn/Ujw=;
        h=From:To:Cc:Subject:Date:From;
        b=sAUQQOYBMJG1CYDfYTpVColDkqwimfIxjAyr+eXrgiMK2/Aw99hTu/nZWGYRJy/GK
         byHBj1aNhVdPmJGq6Tszs4uF5WuDA1CyPyh2nUJ1yhx1z2X1ebpKPJhdXMhbATRvm3
         5cd4vlVOLY76iWLmix4TUNPi3AR7YfYA0eTXOtoX0AgL6l/IW9MVlR3JLXpF0FWtkL
         LeKHOHX8A/PhfdGxttFnunjrUGMjrxQcinpkGwVBo8bTdQkOO4g3dO/SAoflJDBgjL
         piCdKfM/c4eOtElJhsHQfAd5hwm7XD3vCHXtB89Ou53HyEoWS/UWcHDQHaN28mtnoT
         o2lCYw3yyPl0Q==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 2/2] doc: dts: Add device tree information regarding wm8940 codec
Date:   Mon,  9 May 2022 14:13:13 +0200
Message-Id: <20220509121313.31216-1-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit provides documentation entry for wm8940 codec.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 .../devicetree/bindings/sound/wlf,wm8940.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8940.yaml

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8940.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8940.yaml
new file mode 100644
index 000000000000..8aadcbeed502
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8940.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8940.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wolfson WM8940 Codec Device Tree Bindings
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+properties:
+  '#sound-dai-cells':
+    const: 0
+
+  compatible:
+    const: wlf,wm8940
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 526000
+
+required:
+  - '#sound-dai-cells'
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@0 {
+            #sound-dai-cells = <0>;
+            compatible = "wlf,wm8940";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            #sound-dai-cells = <0>;
+            compatible = "wlf,wm8940";
+            reg = <0x1a>;
+        };
+    };
+
+...
-- 
2.35.1

