Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483D850E18E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiDYN17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbiDYN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:27:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D2136B65
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:24:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so6980234ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=caM+vLuNWYVORv3rxDBPjphWOSPmMGej9yvUojmZGAw=;
        b=AXeei8U3Y7CuBFSNXZhaxy5IfluR0msbktvlq5Qq3T76ZMWl+akgZKYeuToOL96XZ5
         7EYahLSVcAjRoEoeOAtFBvoWDYMbzFD+QffmVFxa5fiI1QEJq66zG8d3zFul6eYGW/yX
         0TuajuLTlhCtJjS85bdtg1m3g1z6QrhkNirYH9q7GpbD++Nalm52fYFP5wmebmbU00kq
         8LVpPWtF4E/4yNB0x0DQsVCEomNOnMtBxtN6ciFxJS4WwU++agjn6Zt43IWUnpKrxGaX
         7kM/TLiU/qCRtlRTl08ciR+Xr44/Yuejg6T0X42vvXzaToq8a7T8kF/ytn5wB5zN4f0E
         VPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=caM+vLuNWYVORv3rxDBPjphWOSPmMGej9yvUojmZGAw=;
        b=UZJY7oHJSeKU6fPqMyCbDyhXJw8L9MoLNbPYlX6FGBZ/CIDlrhqENAJ7feYF/d+ZA1
         aIJFhBoW8tCvGT4Op9DGtDtXQKEEdW6zglJb77QY3T3zhZ5VQXsbxDvY4puU4EEa3+xo
         oIOs5vioyICfu7xIYA3pTJXO4eFGeYkc2Lib5Fi20ovvTaYhtA9FjYOrZXU+ke+/hE4t
         kARuvSO1Z7rO9NYcwG88FNhGutwM3QaNhT1eL0Zko1yVmkCre+6E4jIEChFu39yUe+2R
         YjhF+iIFI9q2HjNX0dndj2n+g7Hk4sH+5RYpPeymeUpgAB3TlFylqsSpZwq4omaLjQWW
         lkKg==
X-Gm-Message-State: AOAM532R8vXAZMbAN8oJVnaK0orcaII6E0UOsVNJCtTqpLPMpeG0Bs3k
        f156u7jwOcSj2hEXpK9Mbz3bJA==
X-Google-Smtp-Source: ABdhPJyCPaMaWm10rhF+he0H6qsfcgxcaz11xEHicik6Tbl7NLrZGIjTVyUX0+GuKR9YLuHmk/4GpA==
X-Received: by 2002:a2e:5c41:0:b0:24b:156c:7100 with SMTP id q62-20020a2e5c41000000b0024b156c7100mr11466984ljb.80.1650893059670;
        Mon, 25 Apr 2022 06:24:19 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id q21-20020a05651232b500b0046bacf73c9fsm1411752lfe.151.2022.04.25.06.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 06:24:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: gnss: Add Broacom BCM4751 family bindings
Date:   Mon, 25 Apr 2022 15:22:15 +0200
Message-Id: <20220425132215.1309216-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom BCM4751 family of (A-)GPS chips have been around for
some years. The latest iteration BCM4753 is for example mounted
on the Huawei HiKey970.

Cc: devicetree@vger.kernel.org
Cc: phone-devel@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Switch do dual GPL/BSD license.
---
 .../bindings/gnss/brcm,bcm4751.yaml           | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml

diff --git a/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml b/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
new file mode 100644
index 000000000000..e62b30386ac2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gnss/brcm,bcm4751.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4751 family GNSS Receiver Device Tree Bindings
+
+maintainers:
+  - Johan Hovold <johan@kernel.org>
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  Broadcom GPS chips can be used over the UART or I2C bus. The UART
+  bus requires CTS/RTS support. The number of the capsule is more
+  elaborate than the compatibles BCM4751 may be printed
+  BCM4751IFBG for example.
+
+allOf:
+  - $ref: gnss-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm4751
+      - brcm,bcm4752
+      - brcm,bcm4753
+
+  reg:
+    description:
+      The I2C Address, not required on UART buses.
+
+  vdd-auxin-supply:
+    description:
+      Main voltage supply, pin name VDD_AUXIN, typically connected
+      directly to a battery such as LiIon 3.8V battery or a 2.6V supply.
+
+  vddio-supply:
+    description:
+      IO voltage supply, pin name VDDIO, typically 1.8V
+
+  reset-gpios:
+    maxItems: 1
+    description: An optional active low reset line, should be flagged with
+      GPIO_ACTIVE_LOW.
+
+  enable-gpios:
+    description: Enable GPIO line, connected to pins named REGPU or NSTANDBY.
+      If the line is active low such as NSTANDBY, it should be tagged
+      GPIO_ACTIVE_LOW.
+
+required:
+  - compatible
+  - enable-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+        gnss {
+            compatible = "brcm,bcm4751";
+            vdd-auxin-supply = <&vbat>;
+            reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+            enable-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
+            current-speed = <38400>;
+        };
+    };
-- 
2.35.1

