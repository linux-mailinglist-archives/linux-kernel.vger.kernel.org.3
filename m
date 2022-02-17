Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DA4BA5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243216AbiBQQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:28:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243151AbiBQQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B79D049;
        Thu, 17 Feb 2022 08:27:34 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u18so10610195edt.6;
        Thu, 17 Feb 2022 08:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TN6KDpHU/fcJsRDPYzJSQRkuj2gxgVh7KPbfIBfiw8=;
        b=p+Dn1m1iWFHZLCfxSfqbw37qW3cs7g0tWJzQzYwUE48iHIcrr9qbEWPpmKq7uMY80k
         3DfUtdJuo9vgbNz0r+b9g4Gy1lmjhX8+4y++U7/dxGVBUp8hf5FqDHJHmr875Mi1M+Ck
         IqGJQXz/97eNDbHfdTWTgHY/G5hEXDMpPLrSR2BltNqzUVP2G/U2MyWjGz+j3vVCZt72
         kxhfsosCnPYjrbxZ4VryMQKyMZpX+qJfLf3NQeseY/yYL/Y7haiF6IarVeA5NuKfyYtl
         TU9fAhNkTMTn1JtwKg0QCrI2D6sjV9Kk1/46n9BwERFUG9CyUu9ulWpQQWmkrutJr++S
         IfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TN6KDpHU/fcJsRDPYzJSQRkuj2gxgVh7KPbfIBfiw8=;
        b=Vuc/vPvNzqkenmMDhm6OIAFiUlI0bTzGrYchyoPE8lngxYyq5jbNe7+Ai707mqpCNy
         ekg86yR9T4vrU+L2P76kMyrUDL4+8Z6hBsEiFB6RtmCvpXwRTkNCEaf1b+wruG15C3kV
         feDGn+okF1W1pQN1REX1I1QW1jHnLBGPQ2CpDPYbMU8Z2rf95Ncx76MHe4JAQgRrmAdW
         osw7Oi+a6PKeNq25PhblcHZi6shsZOVZKjp3Rb2mYmYnJEKNFv7KNSN/9+qAoYBc71QI
         3WsWPt2LSjNQe6ZPSt7xZrNI7sA7PBuzingBU6hAzecH0c2LAafErQFpL+B2ljueuS1s
         VENA==
X-Gm-Message-State: AOAM533B/XEa0ZErLmkQwgYB6X1xbj4B1hks34oHhfPspe6yoqooiITy
        v92xfnIr1v48LJWJW3qiOcY=
X-Google-Smtp-Source: ABdhPJxR/7Pw26cq0b01F99RPvWseXTpwnZBkO1Hq58klzU0u/bho0hS6nOLnBPDSRBkOuRKgV9L4A==
X-Received: by 2002:a50:8713:0:b0:410:db7a:4b2a with SMTP id i19-20020a508713000000b00410db7a4b2amr3443451edb.140.1645115252663;
        Thu, 17 Feb 2022 08:27:32 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:32 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 10/13] dt-bindings: iio: imu: add documentation for Bosch BNO055 bindings
Date:   Thu, 17 Feb 2022 17:27:07 +0100
Message-Id: <20220217162710.33615-11-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
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

Introduce new documentation file for the Bosch BNO055 IMU

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 .../bindings/iio/imu/bosch,bno055.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
new file mode 100644
index 000000000000..e0d06db161a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bno055.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BNO055
+
+maintainers:
+  - Andrea Merello <andrea.merello@iit.it>
+
+description: |
+  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
+  internal MCU for sensor fusion
+  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
+
+properties:
+  compatible:
+    enum:
+      - bosch,bno055
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+      imu {
+        compatible = "bosch,bno055";
+        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+        clocks = <&imu_clk>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      imu@28 {
+        compatible = "bosch,bno055";
+        reg = <0x28>;
+        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+        clocks = <&imu_clk>;
+      };
+    };
-- 
2.17.1

