Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0464CC2D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbiCCQcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbiCCQcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:32:32 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC119D61E;
        Thu,  3 Mar 2022 08:31:45 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id p20so7562963ljo.0;
        Thu, 03 Mar 2022 08:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GARCkxgiyMRjl3V6/FiJ6/g+bqmKHGIILslZSNmkwfA=;
        b=SSql2ZWfIALEJHdO2HVJs1emFDEUdGXdxXkrsGgirOEQYDgDGQ9baJqHmwppEezB4r
         0LE3ZFISZZOysMHY1i/tJpje4VIe3uIcclOTKchhYtTUnRC5ZB/53CPhtgYFXLIqyXhO
         4BWiP3RabMQt/aIgSwCbqIWRL7tZyP8BkC80Xoq4iZyNEm4Sv897i9IAy2oF+vuUJFsd
         SDt/0Qd62iBY5RJcZx3f0aqij/b7pDl+sw0Z3lbdIRX1Q5zpURVD3q4LIECwm0uCjpZX
         Oei0RHO+gs20jRmcBN0TIkbaDOI7Y6I9q97HMK2UFFtThdLBya85o4jBol9yI5giBDdr
         wOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GARCkxgiyMRjl3V6/FiJ6/g+bqmKHGIILslZSNmkwfA=;
        b=L6kNWMhZGowlzeapKHkjUi9iq6iJJpW9kSt0mYCTpISZ+WQPFEY1U77LmUivmxmTfe
         bPhHPQNbDUnBasmEnsmIwroYZ+/2MIPwCv0lbRCe/dnR0bvV621DroSLgi1MKrAHKBcN
         vt+KIUYFHq7Trd85WFFY9+9pzsVSzN0VLIiHMm6NE9wBIOz+ZWw69D2Q0ffQI4CmGuwg
         IMi/t2lJtxVqUxFI8EdIgcmKfU4JXtzLVB9zdOPOAekY8u6Z5h5BpT8m0N0STckmEZ9K
         zHnLxw8yK57cBXw7nAVR41bKEGdPzDNHferwAlEkVXDhxkyZDqSOK+AA6rh21l6EIm6x
         SjWQ==
X-Gm-Message-State: AOAM532d6FkVFkDLJAgf9M529ce3Gx1TXNF7KgT4zZcJp6Ut7YbIvKwj
        jp9IblJB72pHmGj1Iv4PzAP1wMNdHO0V+ZGW
X-Google-Smtp-Source: ABdhPJyAk6RGKOcJly4APNCxs/FSUkOZrtJlZfZWuEpVMHttnDu0jxRrNhfnd/z3GR4JlGS5LxKi2A==
X-Received: by 2002:a2e:990:0:b0:238:1937:82f9 with SMTP id 138-20020a2e0990000000b00238193782f9mr24383568ljj.84.1646325101436;
        Thu, 03 Mar 2022 08:31:41 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id g18-20020a19ee12000000b00443af3721f2sm510678lfb.237.2022.03.03.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:31:41 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        jeff@labundy.com, markuss.broks@gmail.com,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, rydberg@bitmath.com,
        sfr@canb.auug.org.au, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v9 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Thu,  3 Mar 2022 18:31:32 +0200
Message-Id: <20220303163133.1418-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220303163133.1418-1-markuss.broks@gmail.com>
References: <20220303163133.1418-1-markuss.broks@gmail.com>
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

This patch adds device-tree bindings for the Imagis
IST3038C touch screen IC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../input/touchscreen/imagis,ist3038c.yaml    | 74 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..e3a2b871e50c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis IST30XXC family touchscreen controller bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  $nodename:
+    pattern: "^touchscreen@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - imagis,ist3038c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@50 {
+        compatible = "imagis,ist3038c";
+        reg = <0x50>;
+        interrupt-parent = <&gpio>;
+        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&ldo1_reg>;
+        vddio-supply = <&ldo2_reg>;
+        touchscreen-size-x = <720>;
+        touchscreen-size-y = <1280>;
+        touchscreen-fuzz-x = <10>;
+        touchscreen-fuzz-y = <10>;
+        touchscreen-inverted-x;
+        touchscreen-inverted-y;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 781a5795d8ff..3dca47d6f1d3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -560,6 +560,8 @@ patternProperties:
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
     description: ILI Technology Corporation (ILITEK)
+  "^imagis,.*":
+    description: Imagis Technologies Co., Ltd.
   "^img,.*":
     description: Imagination Technologies Ltd.
   "^imi,.*":
-- 
2.20.1

