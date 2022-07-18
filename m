Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5983F577A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiGRFqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiGRFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:46:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7339E13E95;
        Sun, 17 Jul 2022 22:46:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b9so9709928pfp.10;
        Sun, 17 Jul 2022 22:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=qSohyQgZWNj5S4idc0/JGpMQD4sS7/yNRT2duzbMxdEfHeXKykEFllaiH3k1xWdx1W
         4SVkB4yVhv/Lz3hBBXBuLm3R1b04mVMf2egZCw5pfTTxBRgyn1ZPpqEWGYWOsoAArBc9
         zRq5ITMNWpawbg4wlGUoeWbs2GdGzq0lExzutYLVwXrdt5dz+fVUjbXbBTId9XEdXmYA
         rJhN7TCWUDmHD2rGt0tTrT3WEfN8kzM2USg9oev2P9Zn6M9wcr8qa2a1XBu3pOC+COR6
         qpLT9G6neMxhLBtJ/l69ug05mknGqFb8NjnVlijo66iDhZcsmzPksVo4dzd0E+E/VYvX
         Kl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=4/kpSNWURDOlt6O4qq+jKi2okZ/lG9+gmOsC+pceiSzx34ypHviqal03/7BA0LVBiO
         JsYbauLki2POfUgfvNkC3xLc57mOhDr7pfn0eJ0O1Yp4CPBOOI2mrbCT9DgDJggq0g0T
         1rAr4PAB0gQ1WX1tDJ1m9Y9B6+hShzbusr+d2T7e9eKyUQUCD5wjy4M5OHZau6CnZXgL
         qVv2iLDApuTsrON3Qn05N7eUq4+5mtjHziLGLgRydViKquFQg8TRt57VgrENre86Yq8m
         sv0YLNHwcsmKonIwD7zEKoXUcFtqO4NXuyGX5cyZct3MmoeNElr6Luo7MFRNoPIa6E3F
         hBEA==
X-Gm-Message-State: AJIora97PwsMSfMlr7lKWU94t+k6fdPa+/ocjxUREg0oHz4My5IIuCWm
        ykcXUYVVOvmf5gCNyX25/BnjCHvfPQ4=
X-Google-Smtp-Source: AGRyM1uRqEBLpxCphEiYVF0D2xg/zbzhig7tO2y/1QXm32SKZoF7iPNVMxuBTOM8omasI8yBoh/3Jw==
X-Received: by 2002:a05:6a00:a06:b0:51e:47f5:79ad with SMTP id p6-20020a056a000a0600b0051e47f579admr26691399pfh.53.1658123173815;
        Sun, 17 Jul 2022 22:46:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:e7ad:4982:5f13:5219:614d])
        by smtp.gmail.com with ESMTPSA id c66-20020a621c45000000b00528ce53a4a6sm8147951pfc.196.2022.07.17.22.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 22:46:13 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 1/3] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Mon, 18 Jul 2022 13:46:01 +0800
Message-Id: <1658123163-10039-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
References: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the documentation for Richtek rtq6056.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v3
- change the node name to be generic 'adc' in binding example.

Since v2
- Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.

---
 .../bindings/iio/adc/richtek,rtq6056.yaml          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
new file mode 100644
index 00000000..88e0086
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
+  interface, and the device provides full information for system by reading
+  out the loading current and power.
+
+  The device monitors both of the drops across sense resistor and the BUS
+  voltage, converts into the current in amperes, and power in watts through
+  internal analog-to-digital converter ADC. The programmable calibration,
+  adjustable conversion time, and averaging function are also built in for
+  more design flexibility.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+
+properties:
+  compatible:
+    const: richtek,rtq6056
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description: Shunt IN+/IN- sensing node resistor
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adc@40 {
+        compatible = "richtek,rtq6056";
+        reg = <0x40>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.7.4

