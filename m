Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFE5B0546
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 15:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIGNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiIGNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 09:37:36 -0400
Received: from es400ra02.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39D89923;
        Wed,  7 Sep 2022 06:37:31 -0700 (PDT)
Received: from es400ra02.iit.it (127.0.0.1) id h32f9i0171sv; Wed, 7 Sep 2022 15:22:32 +0200 (envelope-from <prvs=1249fcc2cf=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:From:To:CC:Subject:Date:
        Message-ID:In-Reply-To:References:MIME-Version:
        Content-Transfer-Encoding:Content-Type; bh=lThD6BA32M/3+1gJOlZ6S
        d+pgka8j0o3qmjB0KTkeU4=; b=GNESkznNWkqHThFJJRtw4G4dooqKNgXWsMrfR
        /l1D1HSnbxQYNLz3LNbSCHvrMuOk+gTOUb1uugzkIvAGVFsiWpI0oCQdS7v1XAVq
        kuRmrMRYjW8DAbg55sU8E7u3gSDve+BBHpHzN9d9npRD4/9KI215377VhjB0tpkK
        KKGAcg=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra02.iit.it ([172.31.0.242]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202209071322320212552-8; Wed, 07 Sep 2022 15:22:32 +0200
Received: from poker.iit.local (10.10.20.64) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Wed, 7 Sep
 2022 15:22:31 +0200
From:   <andrea.merello@iit.it>
To:     <jic23@kernel.org>, <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <lars@metafoo.de>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <matt.ranostay@konsulko.com>,
        <ardeleanalex@gmail.com>, <jacopo@jmondi.org>,
        <andrea.merello@gmail.com>, <bagasdotme@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>,
        Rob Herring <robh@kernel.org>
Subject: [v7 11/14] dt-bindings: iio/imu: Add Bosch BNO055
Date:   Wed, 7 Sep 2022 15:22:02 +0200
Message-ID: <20220907132205.28021-12-andrea.merello@iit.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907132205.28021-1-andrea.merello@iit.it>
References: <20220907132205.28021-1-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.10.20.64]
X-ClientProxiedBy: IITMXWGE021.iit.local (10.255.8.187) To
 iitmxwge020.iit.local (10.255.8.186)
X-Mlf-DSE-Version: 6948
X-Mlf-Rules-Version: s20220810181453; ds20200715013501;
        di20220831211829; ri20160318003319; fs20220901203539
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202209071322320212552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Merello <andrea.merello@iit.it>

Introduce new documentation file for the Bosch BNO055 IMU.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

