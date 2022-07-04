Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7647564F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiGDIKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGDIJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:09:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C793FB1EB;
        Mon,  4 Jul 2022 01:09:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b2so7907193plx.7;
        Mon, 04 Jul 2022 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7FkKV37PzJJDhOyAhrZ3wfJVwVbk2smwW6Ops/1fLk=;
        b=JlNFp22fP1+C3UMkGoScMLE/g6uIN6Y9MBR6P+QOR6l9ifVQOX2WTADLed8OOh62sb
         VJTBnKpuH0h4RDVKjEyhSanPwstd37eiI7aRqw9gUZmFpDi3TLVMX5b1lHisk7PP0IRS
         y9eUv31y+iCTG9MbanHgmOs4JdYpI374Fe2IYWl3WdTOpbv25dw32kV2WIXiiL+42cvX
         Piax1Hvr9FyWb8C1AOvveYWzOJRQ30tWBwqXqJZQz8yIP3J0+Wc65Aen8JMZgXDqH7gz
         LjOkt+SsshPnb8RDRyrDHUJBJwVsdsjMxSHuJQNO30zmWpJ7DuUA2qzZBSb2cICQoRcg
         MiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7FkKV37PzJJDhOyAhrZ3wfJVwVbk2smwW6Ops/1fLk=;
        b=YR5eRhVfMFyqaPFzzMVXP0uO4LDEl+ZbxU8t6wzfhKQzSOqHj/n1bbfeg6ORXu64dV
         agBFHmQ7EJb7R+hA87XEHHt+YA7W8I2W/Q+fx1UmDYZDWeQ8gFxJCc2sK3HGE+uxSrEe
         ig0S3If9pc41vHkTkXiqO5G5V5uFQCUJasK2BcdD6LNzE+Y0/vrVJJZ8XwTCK8e2468c
         /Yof3socm+1Js17lob6FyVVRmgNPOyqzgddapRk0k6TgyXTQusN9WEI8jxl+uMwKW9hQ
         S2D30z0IS11kuzKvVu0svd1xWc4AnVctJrvvQ/fTrXMI34Tn/3/wz5eEhcQSogk+jEUz
         Tdwg==
X-Gm-Message-State: AJIora8+2iuorin+681OEM1vNOQ400W7ertvoDt+8Jl+lAG+0zV8/JFH
        KOrIQRc53W3JCswaDBXR2KZA6Kyibjo=
X-Google-Smtp-Source: AGRyM1uoWIObRXy5D/EkwgELN8cV/1qDDJD4NAdW1VOKYJfB1lZWq5tsSAQ8hAnAPorF77WgieksQQ==
X-Received: by 2002:a17:90a:b789:b0:1ef:845a:237a with SMTP id m9-20020a17090ab78900b001ef845a237amr6714654pjr.222.1656922189200;
        Mon, 04 Jul 2022 01:09:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:489:5fa0:f4ca:b72:ee4c:412c])
        by smtp.gmail.com with ESMTPSA id bg14-20020a056a001f8e00b0051853e6617fsm17596248pfb.89.2022.07.04.01.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2022 01:09:48 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Mon,  4 Jul 2022 16:09:38 +0800
Message-Id: <1656922179-21829-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656922179-21829-1-git-send-email-u0084500@gmail.com>
References: <1656922179-21829-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the documentation for Richtek rtq6056.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
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

