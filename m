Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337784D7A64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiCNFdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiCNFdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:33:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F90C3D48B;
        Sun, 13 Mar 2022 22:31:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o23so12760642pgk.13;
        Sun, 13 Mar 2022 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1DPJ7SGMvyfoUwo9X/vu4UVhU1Tx4WkS35X+VF/0EP4=;
        b=cxtaKnregLaKLEDwWc84/IFvfdvNCRhQOdQ8cvcoQ0tXPxGr/jUXgrg2IgCcNZc4FX
         uIli+ny1cThyTt0ySnrFHlkQYXsmvFWKeDHNyp6vW/XqFvmDATYyB4jB2yQD0ybHT9SF
         RVWiAzwSIT/egVxAsfXWDaZ1Lz5XKQj5xSL2daoE+7r8CcvzFqWyaWffeupnz3hiVOCv
         ownT4/Zxdz8yUXeN4uA3HJW2e0SIksfFWkb1RYc9dZTWPNsvX0GwGrjicf6ikBK+Ohc4
         x7LEA3piKgrRpxHblffWw0F9Coe6z/vHgNd6r/FxFimyPcCfkmM3U7DijzOyF4qfuu58
         rEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1DPJ7SGMvyfoUwo9X/vu4UVhU1Tx4WkS35X+VF/0EP4=;
        b=3H6YllHj13TBmYQLULretUBT7mj0zPfvLB5pa9mOtGMzNiZVFJJmPTmrnt3fYX2qoa
         +fc1Ww9Mp976fashEKfZETc30fBRKZCjFPf8b8W2MGaWFnOy9E5AXQ3E5nrnoBVhwyas
         yKTO2X7hJ0FrqxuWZRRTC+C10AQwf35OhEGeHzY798SbkMdlaQbSNuhA9qww4ppH31ru
         SVqvtcBISKCCJ1bZn7+kIjlN7XlmLeA/dosWqYRQMQa8CCf2FjUoLL0vMZ7xcOlQrxGR
         u2HaEGdd+8Aq/IKoW6nzacXnJCCmSXCeqp/6/8a3LB62i0XCl6g05LUyUxnTB6Rw7lfP
         pb6Q==
X-Gm-Message-State: AOAM531Ie7h86Fu5A8i+lI1248/qbbGR8H2Wo9FAY6rEG5I8Bvs83XGx
        R1dotXJohEwDT2oK9t+iPRs=
X-Google-Smtp-Source: ABdhPJx3Q6EI395hKYFkDb0FwvhVKPS9olsiL4DX1R3h+KmPrDlCz6ZwH3PJj7ki9UbGPZr9Ln3Cbw==
X-Received: by 2002:a63:485e:0:b0:380:2ff5:d0c0 with SMTP id x30-20020a63485e000000b003802ff5d0c0mr18929734pgk.493.1647235909751;
        Sun, 13 Mar 2022 22:31:49 -0700 (PDT)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id c7-20020aa78e07000000b004f6e4d8ccc8sm18116376pfr.163.2022.03.13.22.31.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Mar 2022 22:31:49 -0700 (PDT)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 2/2] dt-bindings: usb: Add bindings doc for Sunplus USB HOST OHCI driver
Date:   Mon, 14 Mar 2022 13:32:04 +0800
Message-Id: <1647235924-15572-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
References: <1647235924-15572-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus USB HOST OHCI driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
 .../bindings/usb/sunplus,sp7021-usb-ohci.yaml      | 69 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.yaml

diff --git a/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.yaml b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.yaml
new file mode 100644
index 0000000..7583b68
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/sunplus,sp7021-usb-ohci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 OHCI Controller Device Tree Bindings
+
+allOf:
+  - $ref: usb-hcd.yaml#
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+description:
+  Sunplus SP7021 USB HOST IP is a USB2.0 Host Controller. It supports both
+  Enhanced Host Controller Interface (EHCI) and Open Host Controller Interface
+  (OHCI).
+
+  It supports 32-bits address bus and 64bit data bus interface, compliant
+  to AMBA AXI interface for data transfer.
+
+  It supports 32-bits address and data bus interface, compliant to AMBA
+  AHB interface for register configurations.
+
+  It supports 32-bits address and data bus interface, compliant to AMBA
+  AXI interface for register alternative configurations.
+
+  The UTM Interface block generates PHY control signals, compliant to
+  USB2.0 Transceiver Macrocell Interface Specification Revision 1.0.
+
+properties:
+  compatible:
+    const: sunplus,sp7021-usb-ohci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    sp_ohci0: usb@9c102080 {
+      compatible = "sunplus,sp7021-usb-ohci";
+      reg = <0x9c102080 0x68>;
+      clocks = <&clkc 0x3a>;
+      resets = <&rstc 0x2a>;
+      interrupt-parent = <&intc>;
+      interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f7a9ed7..4c80c39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,7 @@ SUNPLUS USB OHCI DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ohci.yaml
 F:	drivers/usb/host/ohci-sunplus.c
 
 SUPERH
-- 
2.7.4

