Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8D24B442C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiBNIct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:32:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiBNIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:32:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B571A25C72;
        Mon, 14 Feb 2022 00:32:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y9so13853123pjf.1;
        Mon, 14 Feb 2022 00:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hqjdi+LXQoBDys1NbSqDIQiBrEAsmBFRhOAjluSnqEg=;
        b=QRtlg6ti9if8VfG2x74AXO5RWbE0DLT+aDHqwaGajr4GQ5jX8oyGtzIEDIKLDHTUul
         UTwsSxigT39S+brI0T8t8A1jnQ+HFntEii8gtyQb/qBSuF0gMHd98Kwul23h1C9ARc6V
         dtX3du8FQtHa/AzqHaRXBaKFf0u0NQp3vgbCfpVfPUe8jCphRXfoUyGAetSCA3mxa6la
         Hb/dOHD6tvUaLo7lT08gMnKXdKHsi10pS/4w9bT18ol/5gcjImZSGjKZFFiEfpb+7EWK
         A4rPBBDpfDPKvBex8ZyAtOXtydcp/QHqZdD08Fr1ZnlPU4KeaQBhKeRBd/Tnt0c+z1QA
         p+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hqjdi+LXQoBDys1NbSqDIQiBrEAsmBFRhOAjluSnqEg=;
        b=SKG/CAp/rGg58xQfJQll4dYwtBlY2YAwJFu0GST5wFwOK4kaM18pkAKNWGHcOxSnDe
         uZXVSpmidR23axW+hmoMeV2xmEwG+cEXoFAxczs391zkD8z/qarFYGTciIPeuieiSiSE
         alR2Ee7OqWan/qcxLJS+DkGJEiRohC/1/L1Mm8M/KURcBfWp/V6yxMuRIEBoJyqoEhyM
         xy3WP5d1KEe55ahKRMUaOH0qg1qpLP6Cp/2fRlb6R/UNJYQaVmBBHRDqIHvkx4l+umR4
         1IfqZKbd0iIippNo8pex28DFtWzYcnbuSdz+Z4OaViOSOCeX68ZBo0GhtJGe8Y1jXzhS
         wZeA==
X-Gm-Message-State: AOAM530usXo6MJCn1DV7unvYWNw34pSM3jSDOpxJoTjBS+DAZru7gTPX
        C/4gJZmW54B5ckfioSVHCr0Z132l08ImqA==
X-Google-Smtp-Source: ABdhPJyk9tjg1qMy9s0CHX6mjUCLQPitqsR6q6RqwRDMuS01pHck6ITKvIWZWk6Qd9Va0/qezKVdww==
X-Received: by 2002:a17:903:2307:: with SMTP id d7mr13664527plh.8.1644827558298;
        Mon, 14 Feb 2022 00:32:38 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id 84sm6583420pfx.181.2022.02.14.00.32.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Feb 2022 00:32:37 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v1 2/2] dt-bindings: usb: Add bindings doc for Sunplus EHCI driver
Date:   Mon, 14 Feb 2022 16:32:42 +0800
Message-Id: <1644827562-17244-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
References: <1644827562-17244-1-git-send-email-vincent.sunplus@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus EHCI driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
 .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      | 69 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml

diff --git a/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
new file mode 100644
index 0000000..299f7b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/sunplus,sp7021-usb-ehci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 EHCI Device Tree bindings for ehci0/ehci1
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+allOf:
+  - $ref: usb-hcd.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sunplus,sp7021-usb-ehci0
+      - sunplus,sp7021-usb-ehci1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: USB2_USBC0
+      - const: USB2_UPHY0
+
+  reg:
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  nvmem-cell-names:
+    description: names corresponding to the nvmem cells of disconnect voltage
+    const: disc_vol
+
+  nvmem-cells:
+    description: nvmem cell address of disconnect voltage
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - reg
+  - interrupts
+  - nvmem-cell-names
+  - nvmem-cells
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    sp_ehci0: usb@9c102100 {
+      compatible = "sunplus,sp7021-usb-ehci0";
+      clocks = <&clkc 0x3a>, <&clkc 0x3d>;
+      clock-names = "USB2_USBC0", "USB2_UPHY0";
+      reg = <0x9c102100 0x68>, <0x9c004a80 0x80>,
+               <0x9c000000 0x80>, <0x9c000200 0x80>;
+      interrupt-parent = <&intc>;
+      interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+      nvmem-cell-names = "disc_vol";
+      nvmem-cells = <&disc_vol>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6c2faf3..49702c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17951,6 +17951,7 @@ SUNPLUS USB EHCI DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 F:	drivers/usb/host/ehci-sunplus.c
 
 SUPERH
-- 
2.7.4

