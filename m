Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED895AC2C8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiIDErX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiIDErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:47:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F34D4D5;
        Sat,  3 Sep 2022 21:47:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q15so5690346pfn.11;
        Sat, 03 Sep 2022 21:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=nEa7rEbxxWV7/pqimd1itO387lK223KVqe5+0HctdzQ=;
        b=Ac5B+8OnJEOn8t3Hqh1RvlzvGCwHxDTcmMfujXCyTG3TevMr+r+nsCHPLB6Z62y4r0
         RD/ZHXRFC3JVmW50Qe4z4muEzN6pWaNPTuhz0gzPs7fHZcjltQiIzjS3FFcPNW5bnqG/
         qloj2Wzc5IAQlhVQ33sFGgcfMcm7IfyJ6aTrZyFfTDp9NpKNXWuDnNAkeAt6lK6kAGin
         aJdlGVx+YywYIdVcZBHd2kl59u8JIBbWZ7/D1IPuGL3f7ruIL9WXww47f5lCUdjzmnre
         W2eHAkT/GhjOpq3R4O8Sk1lRGxBzdZmPwUSTch6gVP4Ispa2cmG9n01lp5ZFjriP+1Mx
         iIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nEa7rEbxxWV7/pqimd1itO387lK223KVqe5+0HctdzQ=;
        b=0Tj7htpyvMd+UBb8J51iig8r1/sq9adWhiero51SaM3Lu7ks+q5LWAvsBhu4OvUz93
         +pZSXmr8Bfmjz/OBxMgUUW1ZekvUmsgpd2YeM1tu7XL9y9/jz9ivqLBpI7MyTDr8+LRL
         AZ/poN4sbhnT6+FTwuf3qmxHqRctPiMc1tIcLki9hlXKIDhCkZwRb8EI1w0XILbgGpTo
         0nZPv8v/zL7i80UWK44rK0NeTYBb/LkRHBhFrectFHcBJ5c5scr0PCa4kXo5wKb5CuPZ
         eURSMj0YSf8IxosE7CJ/U2DQb7JxZL5qZaRQGa46m2Nypz09SYTrtJkQPW1tBMLxC3C6
         534Q==
X-Gm-Message-State: ACgBeo3OcZ6/IYDw9p0rmN+jAE3L3fhCMfveWGj2oxvZA0g/zXMAK5wJ
        PySQNA6D8fSeGhraL7vnIYk=
X-Google-Smtp-Source: AA6agR6fy1BCLbzWw8d9mBRxpco8+3v0DLovwFo2MWvsfgDHEvmbi9YAgRm3rVDYGzi0J3fabjfyCA==
X-Received: by 2002:a63:1921:0:b0:42b:6eb3:bce5 with SMTP id z33-20020a631921000000b0042b6eb3bce5mr37687326pgl.231.1662266837137;
        Sat, 03 Sep 2022 21:47:17 -0700 (PDT)
Received: from localhost.localdomain ([115.99.107.255])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001641b2d61d4sm4572617plf.30.2022.09.03.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:47:16 -0700 (PDT)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jagathjog1996@gmail.com
Subject: [PATCH v1 1/2] dt-bindings: rtc: add Maxim max31329 rtc device tree bindings
Date:   Sun,  4 Sep 2022 10:17:07 +0530
Message-Id: <20220904044708.7062-2-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220904044708.7062-1-jagathjog1996@gmail.com>
References: <20220904044708.7062-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for the Maxim max31329 Real Time Clock.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 .../bindings/rtc/maxim,max31329.yaml          | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/maxim,max31329.yaml

diff --git a/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml b/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
new file mode 100644
index 000000000000..757f1ac4fdc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/maxim,max31329.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/maxim,max31329.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX31329 Real Time Clock
+
+allOf:
+  - $ref: rtc.yaml#
+
+maintainers:
+  - Jagath Jog J <jagathjog1996@gmail.com>
+
+properties:
+  compatible:
+    const: maxim,max31329
+
+  reg:
+    maxItems: 1
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  trickle-resistor-ohms:
+    enum:
+      - 3000
+      - 6000
+      - 11000
+
+  start-year: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@68 {
+            compatible = "maxim,max31329";
+            reg = <0x68>;
+            trickle-resistor-ohms = <6000>;
+            #clock-cells = <0>;
+        };
+    };
+...
-- 
2.17.1

