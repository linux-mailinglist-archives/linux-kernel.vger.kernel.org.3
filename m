Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FEE578040
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiGRKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiGRKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:51:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCB20182;
        Mon, 18 Jul 2022 03:51:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f11so10201612pgj.7;
        Mon, 18 Jul 2022 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pzx0LTAEG3plavLsKEb5O1+0H3QSoplqHlDrOAmJwM0=;
        b=pjHLQ1tU+9Z/jw03Et5aIahbF/Qm2nLM2GoP+sewQYwZoxFZuKCXaynTjv4K1YzH/e
         POLpKKxGFLNydnDB1V8Fw3dBYLodL8EZ/FCkN3Qf9d2wJyXf9lFMV7AXjX1UZMZSq7IP
         2XuVfIYuyRTi/b/XM4QxkAwd/Vvf3AxCb5pVxgzEuffw2QYAFhGGyeqZgJSwJcyuwRHs
         0nJ8s7u3fkmgquf2Jk8tE3RokRx43voshbnitAAuQbOI+ITg2F93o6wAx5+PvYY1a2j3
         AlvFGbLNO0Yis6+7MtmghrqFArpZTW2v/dQ5/704EXYekCYNXWnb2GX+LYfq9dSRPzkW
         iLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pzx0LTAEG3plavLsKEb5O1+0H3QSoplqHlDrOAmJwM0=;
        b=7Y22rIZfeay0FshSF16JgMKX1428HPuFwTl5avQhTYf02ynE9hThbcI9/++EyCg9OW
         e8H56GQGrXzjakXgTd5Ww/UkMhlVRF1soebEkKDuJuakuFkw8u0m8Mduyq4x2W89Zmiv
         zKtwp0DotH5pXWjvZWg4pmlyskcpn7G7nhT0IAsM7aHKvze+dqzFIZzjld/JJiN6s9s3
         qCQLUvaUO059bcpERcZXLW7gEa8dX8pZW98GRHYEDT//coXHisY4iB5HwYRm0TGe5dWl
         20edmPsM8G0JUiyDrFwlNC1TcvqEd130Se7llFMjVJF17Ljr2J0lA/pp557EENyaH8If
         +Qpw==
X-Gm-Message-State: AJIora8ve1Nks/kGYc+069bWblUkKyrN2CVkV58eZZm4406s6E9ziGfo
        NbpOQDFyQRH1RviqQKamq9o=
X-Google-Smtp-Source: AGRyM1sM2aRIyOja2E9k7LGH0ZcvsU9FUgU7Z7TYOhcgHRZQYqonOKjMd4pT27VlfZsvZ1ABsValtg==
X-Received: by 2002:a05:6a00:124c:b0:52b:26b6:2ab4 with SMTP id u12-20020a056a00124c00b0052b26b62ab4mr20907079pfi.85.1658141504318;
        Mon, 18 Jul 2022 03:51:44 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s2-20020aa78bc2000000b0052ac1af926fsm8914641pfd.20.2022.07.18.03.51.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 03:51:44 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: phy: Add bindings doc for Sunplus USB2
Date:   Mon, 18 Jul 2022 18:51:20 +0800
Message-Id: <1658141480-9291-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658141480-9291-1-git-send-email-vincent.sunplus@gmail.com>
References: <1658141480-9291-1-git-send-email-vincent.sunplus@gmail.com>
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

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v4:
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

