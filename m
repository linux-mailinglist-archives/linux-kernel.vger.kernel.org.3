Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9006D501DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbiDNVsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiDNVsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:48:08 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE55939C5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:45:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id c15so7639445ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6S9KRqkX7A9YoKgU2PmWjCc953BNXu29WrskqsElFU=;
        b=BYSt7/9CMe6e1cOZOoavQDCxmhu1x78HdprHlMXMk1ysdygv7tLT2SflcRXutu3rLu
         hRE3Doq7jUXTsKnTmS7BenvXMDIbceuHBh18m/k6KMy/KGSryz5BaxeKvlh/uaZxy5JL
         hqHvJ0A5TGC7XCcJCXnwQK9qtOqz8ClbchKQU8L1Fzrw2XD9n8YhQ6zWLgYZhnOnOcFR
         EdB4bf36VfA/J7m5aIzTDpB/P9Jwcg+70XcWCKdAk1Myt6+COEmQC/7pedRK6axH0O2p
         wRnJG/w91gYmqwZZxjXObg16Cufuo/sSoGf3xBoxxrqzlgFVtcw8JAdm9m58+I53GrMw
         /zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6S9KRqkX7A9YoKgU2PmWjCc953BNXu29WrskqsElFU=;
        b=68ZCBA2COT4y3JzaxYZHIiOt2So3X2I9jUap83nMvtdv+TTlJCe/MIBIBtEJUigF66
         n7feCkxXL6rCfIlzRyrynJcl48rLr0LgEpactscw5XpMlLBuq6LkiANCTFm/nSToeeuA
         IR97A3TrNHkPkz4aGC42sfUJousCISYBGteZrrZC8lMJu7N49rb+RbYZ6mgRic1eF3Rz
         9jszT2YTbGjywlYvL//jKzvRDQ3dHnFmKAPRmm9ZJUqchJ86uwzmf4kaDdyP+uMOcmFw
         7JObdZdivAmy6rB2bt/oH3EuL16VJSDOny9TeAMpgygPzrzKigZkGsh/XDqoU3YDvLjY
         UquQ==
X-Gm-Message-State: AOAM530D4sGRtZN4Iu+mSCY4ksSLMqcHeCiVtQnw3HsCM70GD0BWBjvX
        M0oFaIOaO8GXZf0XFXtaztSGiQ==
X-Google-Smtp-Source: ABdhPJzW86vujFH03PxD99Oeby+xWsKew7UCfjWbhtO6O52/RZMhu/hElz9UH1L8JcIPVmipfKkBdw==
X-Received: by 2002:a2e:6a08:0:b0:24d:14af:4be4 with SMTP id f8-20020a2e6a08000000b0024d14af4be4mr2754201ljc.24.1649972740518;
        Thu, 14 Apr 2022 14:45:40 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u3-20020a196003000000b0046d02774aa4sm119327lfb.37.2022.04.14.14.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:45:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: gnss: Add Broacom BCM4751 family bindings
Date:   Thu, 14 Apr 2022 23:43:37 +0200
Message-Id: <20220414214337.311880-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom BCM4751 family of (A-)GPS chips have been around for
some years. The latest iteration BCM4753 is for example mounted
on the Huawei HiKey970.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/gnss/brcm,bcm4751.yaml           | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml

diff --git a/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml b/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
new file mode 100644
index 000000000000..f06a4acf21cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/gnss/brcm,bcm4751.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
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

