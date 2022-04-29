Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998935142C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354901AbiD2HFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354884AbiD2HE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:04:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFF8B822D;
        Fri, 29 Apr 2022 00:01:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t13so6218839pfg.2;
        Fri, 29 Apr 2022 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sPglW94tnj8XZLFLi8TD5DyZuTLeLJOzEQaitrD47Rk=;
        b=UWmiesA9J6CPk3EH2Rwr/isQLTArC8YOhw1jnhhf3WMHhNhx9x9tqBPHV3PRqDJHBG
         0+v9RrtZvlYN+Fu+pEv7ZkPlE/iYt4CeCwOgZ0q6GL44YFbXu8jILacoU/8zVoJeduM1
         PobrlU4x/QfSDNQnByx3rdIGByv58ynZN6q9G3K45Xc45GJU2+cyQVCDWYM2YdfvZp7N
         ZMRLd/J3GZja3dyNuiE1wZqcuhI65qcoLSV0Km8OaW1f6tifqcJ7JI3R10cUd39b0cpd
         jD9vsyGkDsNFaJs29ZjSlFJ+gP0+OITHN2GrGfN6gRZlweVUsBCVh76SPCv61yq78RSL
         pA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sPglW94tnj8XZLFLi8TD5DyZuTLeLJOzEQaitrD47Rk=;
        b=wbNF/YLJTMpaQ4O4sV0dnCidos9T0td6qYhsu7zlbjCDBGfmADs8UAU8aDsGncCWQF
         ziSvfJBpKKd8XXPkOycFzxAFwD0HxytA2FoQJO3998ohnGchDMrUcuMDY4amcywhCVfo
         W1WyPJT6tWB3oLTbfoLzvHoHUlrIIPuPx+ALwcpDMEWYqGI/6Ja5CxE7QfMIwgO3CycB
         n/TQ/6BuPQ6GLXY3fDae2tfFYGEzOti6F6K7Jn3oprYw+bWfarwEr7/mV+QoF09QhkLo
         oftrfEnMvvXvPKTiLUeRACt8PX5CDhB6dTVhLQ/y4Lm2BJM7lu85bcnaINNLvLAsBU43
         2jNw==
X-Gm-Message-State: AOAM530smXFrknoCLeJFsvgbyzqqQ+G6CidYZo1JPB0FktIMns7X2UId
        0qSeBOsPmuF2MuHL4U8SQEs=
X-Google-Smtp-Source: ABdhPJxHO/t1cCtZO8hv2a8P7Ok20cXuZ2lrAN2/4UXIlDNv+BJ53aXaRe17sCGSdg6u0RA042r5Hw==
X-Received: by 2002:a63:e80a:0:b0:3c1:6c84:de53 with SMTP id s10-20020a63e80a000000b003c16c84de53mr7076534pgh.224.1651215701291;
        Fri, 29 Apr 2022 00:01:41 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id iy19-20020a17090b16d300b001cd4989fee6sm13148106pjb.50.2022.04.29.00.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Apr 2022 00:01:40 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver
Date:   Fri, 29 Apr 2022 15:00:56 +0800
Message-Id: <1651215656-19024-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651215656-19024-1-git-send-email-vincent.sunplus@gmail.com>
References: <1651215656-19024-1-git-send-email-vincent.sunplus@gmail.com>
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
Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v2
 - No change

 .../bindings/phy/sunplus,sp7021-usb2-phy.yaml      | 73 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
new file mode 100644
index 0000000..52cf20e
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
+title: Sunplus SP7021 USB 2.0 PHY Controller Device Tree bindings
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
+    sp_uphy0: uphy@9c004a80 {
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
index 6b88a7b..bddf6c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18918,6 +18918,7 @@ SUNPLUS USB2 PHY DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 F:	drivers/phy/sunplus/Kconfig
 F:	drivers/phy/sunplus/Makefile
 F:	drivers/phy/sunplus/phy-sunplus-usb2.c
-- 
2.7.4

