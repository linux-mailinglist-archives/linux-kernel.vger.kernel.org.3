Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21804CD37A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbiCDLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbiCDLaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:30:55 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4AD1B1246;
        Fri,  4 Mar 2022 03:30:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so7581816pjb.3;
        Fri, 04 Mar 2022 03:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LBAgln/GTDCgFddRUfBtYbCF94Dwa8Tf8rpkYV3Zu4=;
        b=f2IFFTXBjqENHVE+jMpnpS6onFgxg06DQr1mV2sTlTMhRgbLiXJN+/BV1r/4Yd/au7
         4/0jee32mNK2eFmTKOSUdGTZKW56ApBQwMDyGlF5qNciq4ej3D+WcpDxKoQgIRWSsjMi
         /Ue+5sZ05CuW4+rr8s8FekT2+Kv7I70oXtdLniMmZcQOCoUs+yAbKNJMVxmvtCld96o4
         MXeYgV/6fAWSX6lVHK+X0mC0YSJIokrTvSopLV4qtD/TNimOLys7+4mB51z9kcxFBzLC
         mm/7vs8ryo68hedq9NTu0LuXdLaOGpYErh0EDxxc0irC6hfHnDET85VnlKZfXD6a5QkC
         /cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LBAgln/GTDCgFddRUfBtYbCF94Dwa8Tf8rpkYV3Zu4=;
        b=hofYsQn2G09cHtvGpObBCyXYnrtbLxfSs98E29IHibjzqa3zv/YzspJWQVK7721swm
         hWgKeO+857dX7dpqJzFOvaU4+JrBoS0GIMHeUvmzbNLpRb1ar1kd/mq7UJt7xiEsH+Ll
         9BNWAGUzEnLyX6HLT/w7+5T6WENFFJb2ML1kL7D3HrVdPhGZVUbmzHRfs38jmBpuH3Fq
         G3/VqDON1UB/NV1NcWjTLKasm4cxDzjWAoQIxnuvP3JyIP+neDQORSza29TTy4owbsm9
         kchp4+o2NY95yx/zgPNib6EWC5Ar0wVRdJho9Z4T2bHHdsOw/WAnUgRZSzxNYtaJsGEK
         xB0w==
X-Gm-Message-State: AOAM533n7eLpGfmzKBZf5gqeHvKfzLlCHbKL7B5BUtXxW574LiKgpfWg
        8UiZaKlwiKaPkpu8hiChp1o=
X-Google-Smtp-Source: ABdhPJzbURJna5xflbKpiUyuF0V7e/LYW6LhnViq8N4feeUwjDue3k1I//GQ7Gi/br2sFq+1/ltIqA==
X-Received: by 2002:a17:903:40c3:b0:151:c8a2:1c46 with SMTP id t3-20020a17090340c300b00151c8a21c46mr3500pld.141.1646393407609;
        Fri, 04 Mar 2022 03:30:07 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id h3-20020a056a00170300b004f104c635e4sm5718237pfc.99.2022.03.04.03.30.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Mar 2022 03:30:07 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     kishon@ti.com, vkoul@kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 2/2] dt-bindings: phy: Add bindings doc for Sunplus USB2 PHY driver
Date:   Fri,  4 Mar 2022 19:30:18 +0800
Message-Id: <1646393418-26421-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
References: <1646393418-26421-1-git-send-email-vincent.sunplus@gmail.com>
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
index a3bb35e..ec6beb3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17951,6 +17951,7 @@ SUNPLUS USB2 PHY DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
 F:	drivers/phy/sunplus/Kconfig
 F:	drivers/phy/sunplus/Makefile
 F:	drivers/phy/sunplus/phy-sunplus-usb2.c
-- 
2.7.4

