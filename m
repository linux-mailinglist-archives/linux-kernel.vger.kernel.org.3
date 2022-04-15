Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526F0502DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355950AbiDOQqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355931AbiDOQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:46:40 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D4CDCE23;
        Fri, 15 Apr 2022 09:44:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x17so14785369lfa.10;
        Fri, 15 Apr 2022 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDxdr1g9vgY1LaIET7bIK/Kc0z0gmbx0UAjEc4ycukM=;
        b=fOb2Pt+NwhMNomeRTgosyQMA4QrO9ZOh33yzwVTnnPFQkiVz3C4AjST2Tpzv+CAFFn
         ao2xHBn141iOBzEOHzgMdCb+Pn04v8+eDNy5kvudS+9w7HCHpwVgOT9XBWf9iRVTWATf
         DdV/wXOfMdJDsTtQBjKjoNBJs+E7m6t0NtF3mAbXldnojZoY7880xCRZ8p5hlCa2q9de
         B3ecJUR2oUyt8+5QyLzzswhdXv8Oaz/OKmeqqUxP5qC4zjV60+cRPqYOYyPtsejeHAXa
         QDrl9TdKMBjUk9cCXeGE7jd38Q9f1yisp++Tz3i3XqC9Vl7+SOHjvJBe8ns53UCcRUoX
         ntyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDxdr1g9vgY1LaIET7bIK/Kc0z0gmbx0UAjEc4ycukM=;
        b=CNyHWHXnwoVZqAPaYdJUUhzFzSeWJhhSCzXL5KRKGl4AKDuiHqKnFiFjmBqvR24RCA
         Df4s96ygMkDuhrwgQdjkoNWxgiImuf8YNFxVAf+Oa4yBm2opI4rs/KxIrZn2UI4aV8+N
         i+dwiPm/0Ov4QwAosgjK8W0usPeXe3lrBhw4ZkGXRKYhqHY22SjU0rBdAzYgq+rhZ/7C
         fcWsomv/uoKzvXGh4YFSeP5d8xNMQS3e44FY6j1U7SmtZTn4PIK6Nkuk++89ClAjsvip
         Camf55DyU0pWMmN/CI3vhcDKDv6BtTv2QbK49Sv57lzY7XzexazhK0M8e/n61sWffJ8r
         vDvw==
X-Gm-Message-State: AOAM533m19aHkMLNSBUJPQt8jB/LDOsfRRegHG3mDUNmDcnqdq/ax/Pq
        L8jU8EvLMaFXUC6IMzFUbHasbSbNGfA=
X-Google-Smtp-Source: ABdhPJw5/m/REE+h/gPyO7nLb5/M1uL8qKIqhdAmjY8nvJDqPRTLKOwJAVavS0L5c6Di2cpx5nEXBg==
X-Received: by 2002:a05:6512:31c3:b0:46d:31b:e059 with SMTP id j3-20020a05651231c300b0046d031be059mr5865720lfe.364.1650041049532;
        Fri, 15 Apr 2022 09:44:09 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h22-20020a056512339600b0046bc4ceaeb6sm383787lfg.27.2022.04.15.09.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:44:09 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Fri, 15 Apr 2022 19:43:53 +0300
Message-Id: <20220415164356.25165-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415164356.25165-1-markuss.broks@gmail.com>
References: <20220415164356.25165-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device-tree bindings for the Silicon Mitus
SM5703 MFD.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../bindings/mfd/siliconmitus,sm5703.yaml     | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml

diff --git a/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
new file mode 100644
index 000000000000..aa676967593d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/siliconmitus,sm5703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Mitus SM5703 multi-function device bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+description: |
+  Silicon Mitus SM5703 is a multi-function device, that consists of several
+  modules, designed for a mobile phone use. It consists of
+  LDO, Buck, USBLDO and VBUS regulators, a flash LED driver, a MUIC unit,
+  a fuel gauge and a battery charger circuit. The MUIC and Fuel-Gauge units
+  are separate from the main MFD, having their own i2c lines, while the
+  LED driver, regulators and charger are sharing the main i2c bus of the MFD.
+
+properties:
+  compatible:
+    const: siliconmitus,sm5703-mfd
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  regulators:
+    $ref: ../regulator/siliconmitus,sm5703-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+  reset-gpio:
+    description:
+      GPIO which is connected to the MRSTB pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      mfd@49 {
+        compatible = "siliconmitus,sm5703-mfd";
+        reg = <0x49>;
+
+        reset-gpio = <&msmgpio 24 GPIO_ACTIVE_HIGH>;
+        pinctrl-0 = <&mrstb_default>;
+
+        regulator {
+          compatible = "siliconmitus,sm5703-regulator";
+
+          regulators {
+            sm5703_ldo1: ldo1 {
+              regulator-min-microvolt = <2800000>;
+              regulator-max-microvolt = <2800000>;
+            };
+
+            sm5703_ldo2: ldo2 {
+              regulator-min-microvolt = <1500000>;
+              regulator-max-microvolt = <3300000>;
+            };
+
+            sm5703_ldo3: ldo3 {
+              regulator-min-microvolt = <3300000>;
+              regulator-max-microvolt = <3300000>;
+            };
+
+            sm5703_usbldo1: usbldo1 {
+              regulator-min-microvolt = <4800000>;
+              regulator-max-microvolt = <4800000>;
+            };
+
+            sm5703_usbldo2: usbldo2 {
+              regulator-min-microvolt = <4800000>;
+              regulator-max-microvolt = <4800000>;
+            };
+
+            sm5703_vbus: vbus {
+              regulator-min-microvolt = <5000000>;
+              regulator-max-microvolt = <5000000>;
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.35.1

