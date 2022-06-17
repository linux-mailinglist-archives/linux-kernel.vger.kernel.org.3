Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2929754F45C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380336AbiFQJdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiFQJdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:33:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F98A14D16;
        Fri, 17 Jun 2022 02:33:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q140so3602846pgq.6;
        Fri, 17 Jun 2022 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=91x22Ybf5qix8GQgeWq4HQH4r0RVdU79HIEcKCYEvaM=;
        b=krlKPga5WvNQNCmWXYoYBHW3+c+o78cMZm4mcrpacTHD+XSW+m9lgHH0r95q5s8j+S
         RxDhGNsdGKc+n6Rvniohy6g0bPC/oZr7bGAf0xtlNZ+I3YN0xb/607de6pZwC9viYMm5
         OrS5s2GOPijz4nV+rcuPWGQKmr/XvTjPswMQsnMcuJipUQdnJruVZq9EMa/Pvx+QdnDP
         mcbzGkh93UEjnXNy5FFQy0kBek0nPnzt30k2U+0Y3Tcz78isLXpDeIeev3VWNyWnmDPu
         VjMlzhf2Ju9nHsYrDfmohHCN59Aeucy2oAxt85JasroC/RmfqQkzzlVUzj3M9Km8wUDx
         /p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=91x22Ybf5qix8GQgeWq4HQH4r0RVdU79HIEcKCYEvaM=;
        b=JlSoQIeUncr0KqVIGXW7lvRf3RcEQTqHw6FDy4k18hnwSYj28YjInVzS6fbKMlPExZ
         g1r2JU5W4glfB2cBxjFX8xGBrIbcMvMZHYKH0L5J90kSDLoJr7SNo+d58FdOm0fOlIC6
         0t499DYOef30+NnjPlV6DR2ShMqhje711E+kmVBA7XFG4r8S7tOvlrYJ/6eZA/u7/yYN
         CZLR/o/nN/62Osl5Ju4OvwscW1DoO5gYFN0J58rMjqZG6JK0vMfxSxyuOmBeMAS/Aiml
         t5tnPYkdneqbRYPyjA/INxfYlV+9kAavR+zuij11f+rHCtKy/cxtLuNY4UJPzuevTnI6
         Fx1A==
X-Gm-Message-State: AJIora+B5zjlE0BSVFwwbiAggNSrWwXUwQeEofnzMBvM7TjiQuogGJcF
        nQorshespkY8fvOSX1aVgVE=
X-Google-Smtp-Source: AGRyM1v8rQLNzqrpPoBK4vZComYIsmqYhGT6t4t67zNZQwfK9KWuOeWsG4PQE1fa+PU8nEI2YxdX8Q==
X-Received: by 2002:a05:6a00:1901:b0:4fa:fa9e:42e6 with SMTP id y1-20020a056a00190100b004fafa9e42e6mr9217905pfi.1.1655458384488;
        Fri, 17 Jun 2022 02:33:04 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:e813:14e7:c8c7:4065:3f67])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b0015e8d4eb242sm3103576plg.140.2022.06.17.02.33.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 02:33:04 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Fri, 17 Jun 2022 17:32:54 +0800
Message-Id: <1655458375-30478-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
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

Add the documentation for Richtek RTQ6056.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/iio/adc/richtek,rtq6056-adc.yaml      | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
new file mode 100644
index 00000000..6b4e0e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056-adc.yaml#
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
+  richtek,shunt-resistor-uohm:
+    description: Shunt IN+/IN- sensing node resistor in microohm.
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+      rtq6056@40 {
+        compatible = "richtek,rtq6056";
+        reg = <0x40>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.7.4

