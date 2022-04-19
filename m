Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751E1507278
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354253AbiDSQEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354210AbiDSQEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:04:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6BE329B9;
        Tue, 19 Apr 2022 09:01:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x17so30195439lfa.10;
        Tue, 19 Apr 2022 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehqNT/5oR3HuyIGR5JQZQmSZyCh8KRJVy0SP+2tgcek=;
        b=ktv9S+AC1qbbzGaNa/H0W3WNyE1ztLbef1s9HRlW/ZOei6J9xYTUCF5OYnZ3JPD9Q3
         8lfQbwlLe4QkLTzjZgQ0b6zzRpgBupUKA5y8uQocF2Vi5bp3k350CD2TuUDCVa4rlxdP
         tYVHe/xtzvC5hRYOXdqBa+K8igOJaRdV5YuIbbyCZjDmOsZ8zAwan8ogd1pSjKhmrTPS
         Q+yvq04qgWvl6W2q6l5ctjcUu631ZeKxQYAUYRk7mH425MiNOsZnxUFCuTlurpSA+mQo
         vfvfZ38L9SJ/OH1X+HV/e8AzM0E6yIx7jNIbs19X0AHonlMrmjv66Bs6SwzIYHpfOq3z
         GqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehqNT/5oR3HuyIGR5JQZQmSZyCh8KRJVy0SP+2tgcek=;
        b=LcZaY24dv2bm2K3LizeSNV98lwkkrT40idI8Y9YuxHEdp0+UsmB4iRwXsaOTgWhjyq
         GfFchyAy4rnclcALkU3Wv+Yxi+4qlCNt9c/6ZVzPAjelqZsmL+D7KhwXW4tbPhWOc1UN
         Z5CsBJ0zbFZ6c3sw3x8ayWRjrA7IshtHXBtTlR0FoXhq7n4IHL87FBvT5R2sTo89bntX
         J8YCUT8fM5/ALSWwtqLjATT9hxIUACcls9MxR0eHVSjOFtrOPsK52kgPkmB0i/2AxUin
         ZvehMcdMfbEr6lyWKXPso1Pceu7yyxCkZ8V/qj5VBNz5ry73uszWe5EPBPtRLP4J74sb
         /KSg==
X-Gm-Message-State: AOAM532FPUGXyOrG0qLLCcRuAtugL1VrCfHX9oyUxLbPpTiGyWOdIXHS
        +inlz/B2lDDmIJ4iMrIKfXfMYNxJx4U=
X-Google-Smtp-Source: ABdhPJzwBapTROi0PkpUXr3uI4pW+2BLxbg8H5YAgnpuZZ7d0BpkyONRn5EkA7yGf9dMoUDVdJj4uA==
X-Received: by 2002:ac2:4107:0:b0:44a:3084:39f8 with SMTP id b7-20020ac24107000000b0044a308439f8mr11380730lfi.209.1650384075957;
        Tue, 19 Apr 2022 09:01:15 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id m5-20020a194345000000b0046e951e34b3sm1506663lfj.24.2022.04.19.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:01:15 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Tue, 19 Apr 2022 19:00:55 +0300
Message-Id: <20220419160058.9998-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419160058.9998-1-markuss.broks@gmail.com>
References: <20220419160058.9998-1-markuss.broks@gmail.com>
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
 .../bindings/mfd/siliconmitus,sm5703.yaml     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml

diff --git a/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
new file mode 100644
index 000000000000..0d9de057a63b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
@@ -0,0 +1,96 @@
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
+    const: siliconmitus,sm5703
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  regulators:
+    $ref: /schemas/regulator/siliconmitus,sm5703-regulator.yaml
+    description:
+      List of child nodes that specify the regulators.
+
+  reset-gpios:
+    description:
+      GPIO which is connected to the MRSTB pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - regulators
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@49 {
+        compatible = "siliconmitus,sm5703";
+        reg = <0x49>;
+
+        reset-gpios = <&msmgpio 24 GPIO_ACTIVE_HIGH>;
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

