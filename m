Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81C5019C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbiDNRPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbiDNRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:14:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E02B4;
        Thu, 14 Apr 2022 10:06:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u7so10198816lfs.8;
        Thu, 14 Apr 2022 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UqP4xfrPo10vTgY/j5s+P5EZr0sl8LLw6TahcYWWquQ=;
        b=aIuOZaL18kpoDTDXW+XpXtRxHjrNQ1EWRCmtzl8P+yeCXCuf7y0GuQY03My+fuzKYp
         D/Yp7zegMF6Ij46yMl+EcSMrKoprf09qOhSXxb3KPVerAxjlCJJasHn49LJ4+A8D3BFv
         CVNIwkta3rzORr6ZIN26KKGcy/qykZ5+AEu12YIjDc2OwFZCi0wchqOaFoL2XjGc/c0R
         QCvxSeD9OSYAuwvw5R2hmYfUJsespFo3vBr+UGwAOQ/kCpfmNfRKKMzPxcK8Wj1Z0Ywx
         qJ9QnGoEa43yOKtY9FZUktMM9HZuF4OzxVQYbAln+Ns0XHEi60YSHd0uZ1qnHPug5tbz
         A2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UqP4xfrPo10vTgY/j5s+P5EZr0sl8LLw6TahcYWWquQ=;
        b=3fSJvr8aHioLWVeZuoJ0Kj6gZQR+lOIOWd7Pcakwzbl1C4LmE8DFAHC9Qgbh9tdRId
         xavTmUDBpVfy2Ctg5wYnSoxDGtRgkot18vzJYj3YNQLnAwdBBP8mpK/MHW5jOpqwl54X
         2kRia+eejrXOFzi79SZPI6E2+fjoLk+vfn+ipV6g0y8NtJzIArbJijujVOLvL87K5JjW
         i8UOmUzZXq5e81neOoqAyR/lF6IUbEFF+5f8f37qZFsd7eBiW8l2iSugjNcqoZSGf8OB
         R9NTzlu0eGab33MwRsX9NL4YCipD/D78MjX1Ysdxo9EhKuFSkY0B0qeo574KLpS6WYvq
         9gng==
X-Gm-Message-State: AOAM532/bpMj4wZsapYciubluaLQkdzn5q5r1OIulErGeAlYT2ODGGA1
        rfrmGGhq+98Hs+B00StWpn7/BZnNEvU=
X-Google-Smtp-Source: ABdhPJznpm7lMO1/Kusi9VhokL4ZNsSDNoOGSIbhniAmsoR8zp63cwGawE7wTq1PhNpPwwG5oXsCig==
X-Received: by 2002:a05:6512:128b:b0:46b:a392:1186 with SMTP id u11-20020a056512128b00b0046ba3921186mr2497713lfs.495.1649956010976;
        Thu, 14 Apr 2022 10:06:50 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x11-20020a056512046b00b0046bbe5d2eabsm52216lfd.75.2022.04.14.10.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:06:50 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: mfd: Add bindings for Silicon Mitus SM5703 MFD
Date:   Thu, 14 Apr 2022 20:06:13 +0300
Message-Id: <20220414170616.23319-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414170616.23319-1-markuss.broks@gmail.com>
References: <20220414170616.23319-1-markuss.broks@gmail.com>
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
index 000000000000..cf72bee7a679
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/siliconmitus,sm5703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Mitus multi-function device bindings
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
+    const:
+      - siliconmitus,sm5703-mfd
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
+  i2c {
+    #address-cells = <1>;
+    #size-cells = <0>;
+
+    mfd@49 {
+      compatible = "siliconmitus,sm5703-mfd";
+      reg = <0x49>;
+
+      reset-gpio = <&msmgpio 24 GPIO_ACTIVE_HIGH>;
+      pinctrl-0 = <&mrstb_default>;
+
+      regulator {
+        compatible = "siliconmitus,sm5703-regulator";
+
+        regulators {
+          sm5703_ldo1: ldo1 {
+            regulator-min-microvolt = <2800000>;
+            regulator-max-microvolt = <2800000>;
+          };
+
+          sm5703_ldo2: ldo2 {
+            regulator-min-microvolt = <1500000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          sm5703_ldo3: ldo3 {
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+          };
+
+          sm5703_usbldo1: usbldo1 {
+            regulator-min-microvolt = <4800000>;
+            regulator-max-microvolt = <4800000>;
+          };
+
+          sm5703_usbldo2: usbldo2 {
+            regulator-min-microvolt = <4800000>;
+            regulator-max-microvolt = <4800000>;
+          };
+
+          sm5703_vbus: vbus {
+            regulator-min-microvolt = <5000000>;
+            regulator-max-microvolt = <5000000>;
+          };
+        };
+      };
+    };
+  };
-- 
2.35.1

