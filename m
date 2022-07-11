Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7156D8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiGKIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiGKIvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:51:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40A222A9;
        Mon, 11 Jul 2022 01:50:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4298661pjf.2;
        Mon, 11 Jul 2022 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=THtgz4CPWcfotwmT2jvI1fJyl908rsJpPPW0qYVE7M8=;
        b=frCz1U9EuM9c2StWiDcf+Gn8xspE645xF1IzRj9mxTqOaumq3SHHrfMfgjljdY0vVv
         Bff5DSTun7NDCKYPCr99MezfFq7/LFcc35bLXp61+/ZFuhOOo1tBaPGY66Qzp6rVVNPu
         Reb1VHdq0ZgZGm/0VutRcLwX/1XvuZmMbn3I30XocHa8nK8LoyMJ8/qCNKeRWe5iLhuO
         u3LZfx56r/zmWF5ychScURaIa7x3pbu/RdDAY89BCzokeBkIiOeITkc1GkSQWG3ViuyD
         wVI/dHa+trEplDqm0aTHe3w9dUZ5iCu7s8dTrzTGQTZnJp32fn2181aOB3pmgT/RcTfR
         GZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=THtgz4CPWcfotwmT2jvI1fJyl908rsJpPPW0qYVE7M8=;
        b=CRUnJm7FTNRINfNtH4S7S4CEW7y0PE8NqwwcMJkwdDrB2Zjh3gwDuyY64an2DtjbMS
         Rx5SDKGqjihy2JZ4tGPZm4QywTnhNdO9OzrET9NI6OTV5Ag7cY+X0lCpqlD4x7hyyb8O
         wMQT7vfeQocZjTXKF0qWoIBfosKhjEr3oK/xDJ/M/VLmz+rmnOcNu/iWfReoLJZZDnhi
         nxhkoVxVNZgXD3RikPVW58pAfCU212yt+zBdc28XN2eW1kDW5GK74hTab+FuyRkE6cty
         BU3VHL7GoZK9mekLRS8H0oGV7LvnAkSvycqRhgpIN0hd7wR881kggVVi2L51DAktyqIn
         HVKA==
X-Gm-Message-State: AJIora9FiFEZ2P1CIqjohxjKRdRPALbrtuktgMlW8Y1lhxJ+ecLuQJm4
        sJF0zj8sCP/fOFWUUOvPZBA=
X-Google-Smtp-Source: AGRyM1soZL+JyvcBMiRUE0Mgh7AM4O1mmbHVaekJlu0pt5SxTJjEw5HeNxVt5mmQSlFD0voqqvWCDw==
X-Received: by 2002:a17:902:7e8f:b0:16c:eb4:a52a with SMTP id z15-20020a1709027e8f00b0016c0eb4a52amr17695258pla.19.1657529432880;
        Mon, 11 Jul 2022 01:50:32 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id b21-20020aa79515000000b0052ac5e304ccsm2489388pfp.194.2022.07.11.01.50.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 01:50:32 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v3 2/2] dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver
Date:   Mon, 11 Jul 2022 16:50:03 +0800
Message-Id: <1657529403-18084-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657529403-18084-1-git-send-email-vincent.sunplus@gmail.com>
References: <1657529403-18084-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus USB2 PHY driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v3:
 - Addressed the comments from Mr. Krzysztof Kozlowski

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

