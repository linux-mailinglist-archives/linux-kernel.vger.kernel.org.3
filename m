Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAAE57F856
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiGYCop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiGYCoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:44:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D58ABF5B;
        Sun, 24 Jul 2022 19:44:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g12so9236055pfb.3;
        Sun, 24 Jul 2022 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OJDKOROYoXVDH++yfrosV7/5WWokwSxr5idK1N46DJk=;
        b=V8/pIYxZALstImC7gmvlecpqn4G1a1EVGfZocH8m0s/Lu1HoElas4l4V5K0QsuOUlp
         s3sbCLfHXyT7JJlA4/nmMzVNe8y7eS2scBvB85kzWwJli2G6yuHgS3jw3cSy06cExjyd
         b7/U8YgaJ1D3Kjjx4M23/IEUdWY99mLcuz/NEgKwCcLz6svJWRavJr2mrfZlRCGmf4WC
         uL7RBlwJIpEiY37qKJVmQCGHx9bH8gIr06uzzUFRj4eTufKi+7XFpcghsUCidDe6XCo5
         wd4IVpI7iKjzdLE+4KjjtSEsZh6oOss/GRMiJz2BhdTt32PCpNh7erA0/pNP0HkPqaC7
         yowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OJDKOROYoXVDH++yfrosV7/5WWokwSxr5idK1N46DJk=;
        b=UM4LU7QIHaL7JToFOJjZXLjux9X0psX/DVTln22YksbIsml7ANAPPvt765sa1YkFWC
         1uaAPMGOYQq5IR7tWpGo/5Wxs9B/dR4BYFbsXy8QE3IWXBdXTQi53cqYIXIENQBUH9h/
         MuLIh+xBJlIyRFEUR+3TzH81ojUW5hMON60EiVTFUUZwWDxoUJ0bps2L0DBe2HVs/i3o
         97UkTPTZdETCMSIlfw/k8WpDTBALxjyPJbiDDtKRIAH2ZccA431C8AevivsWDyoEwT2h
         5ZIFqB0ktkeuSsk0cMc8Sp4Oq8iYKypwuD4/YdYu9D5tMUdZ8ePlNU96vEUZbH9FYMLa
         exjw==
X-Gm-Message-State: AJIora+lOi/ET32Aeq72Dgr/WauMwnRWzILdo7+g/eOHdYwe9l12osBE
        OH7D/6RWFm66W5p+ft8Ywuk=
X-Google-Smtp-Source: AGRyM1sD3gsJBJpYhA79iMNgjkkV2YhwAMccugHvOKL6zG4wvHg8IroydzlzodE6ZtPPM+b1l8IBwg==
X-Received: by 2002:a05:6a00:148d:b0:52b:946:67d2 with SMTP id v13-20020a056a00148d00b0052b094667d2mr10504546pfu.31.1658717074658;
        Sun, 24 Jul 2022 19:44:34 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id u13-20020a170903124d00b0016d1b197914sm7983304plh.90.2022.07.24.19.44.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2022 19:44:34 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v5 2/2] dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver
Date:   Mon, 25 Jul 2022 10:44:12 +0800
Message-Id: <1658717052-26142-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658717052-26142-1-git-send-email-vincent.sunplus@gmail.com>
References: <1658717052-26142-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus USB2 PHY driver

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v5
 - No change

 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
new file mode 100644
index 0000000..069d422
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/sunplus,sp7021-usb2-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Sunplus SP7021 USB 2.0 PHY Controller
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-usb2-phy
+
+  reg:
+    items:
+      - description: UPHY register region
+      - description: MOON4 register region
+
+  reg-names:
+    items:
+      - const: phy
+      - const: moon4
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  nvmem-cell-names:
+    description: names corresponding to the nvmem cells of disconnect voltage
+    const: disc_vol
+
+  nvmem-cells:
+    description: nvmem cell address of disconnect voltage
+    maxItems: 1
+
+  sunplus,disc-vol-addr-off:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the otp address offset of disconnect voltage
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - resets
+  - "#phy-cells"
+  - nvmem-cell-names
+  - nvmem-cells
+  - sunplus,disc-vol-addr-off
+
+additionalProperties: false
+
+examples:
+  - |
+    sp_uphy0: usb-phy@9c004a80 {
+      compatible = "sunplus,sp7021-usb2-phy";
+      reg = <0x9c004a80 0x80>, <0x9c000248 0x10>;
+      reg-names = "phy", "moon4";
+      clocks = <&clkc 0x3d>;
+      resets = <&rstc 0x2d>;
+      #phy-cells = <0>;
+      nvmem-cell-names = "disc_vol";
+      nvmem-cells = <&disc_vol>;
+      sunplus,disc-vol-addr-off = <0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 31d2ba0..989e5ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19227,6 +19227,7 @@ SUNPLUS USB2 PHY DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 F:	drivers/phy/sunplus/Kconfig
 F:	drivers/phy/sunplus/Makefile
 F:	drivers/phy/sunplus/phy-sunplus-usb2.c
-- 
2.7.4

