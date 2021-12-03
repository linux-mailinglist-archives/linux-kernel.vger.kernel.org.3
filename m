Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A906F4672E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351028AbhLCHtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350969AbhLCHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:49:45 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D2C061758;
        Thu,  2 Dec 2021 23:46:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x131so2069759pfc.12;
        Thu, 02 Dec 2021 23:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uO+ywGBRXxL4/QAnvH9WlWkflgr/aXty12RnyNQ/E8o=;
        b=PMyAg5VAHhxbi2EqaGTPY71l5TFAoHhZHR0vDXSS+y93EoSnFBbk6nRnnxvtw0UlNH
         ofjaNjFvE8AVrHnK9Wd3O/3H7bhtAYgxH8MQD1hu5pDw1tMbv1FC/B+L9qfQ3CucZ/X2
         bBXtp9oDcHTSQlu1UohEXzLb+sFiCcIml1mitrXhQCZkPKdkxXEcmz6e9y+ioBCXGc7R
         if60JzwpD/odkoLx40pWq6wy6ceogcv3v7F7jBOpe3bGllSA18p9Rp0ZVr+++iBZ2pOS
         OA9h301py0ngAAHxUP1Dg8/ZcXZ8bJlHjRczO5lDgUuDMU7xlSoanKjfuGewlMvE4nQ5
         Q72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uO+ywGBRXxL4/QAnvH9WlWkflgr/aXty12RnyNQ/E8o=;
        b=t/aL8MIez6jBGMdg0PG2HvOCR2vlg1rS7xVqtJK/U34QU79Q1dCblGupJdCXZzGcih
         Ri99antBq4Ub73pm1pGD+Q6lUQ/QdBMSiPnWpOLFHYhpNdG51cg/khaLfEYFHQk+3MeK
         +QyvgSh+mwjfpRwcf9/S4/tsm/2dsKpnGgO5jFVg/sPe7RRrOxplmZT0XU8xodcbCTOb
         KCx5fPiT4pBIbNVJGKnbMKWOXWnesRznR/Wmb4yJtz0C1DTvb7jQFeeu+L8oZe6RIFcW
         GxgP+h3A5vEwdX5YafAXHQ03xi6sN744ZZQhl/n59p797dgGpXPlMTjSnixtMMEi7fax
         3Z5A==
X-Gm-Message-State: AOAM531pfj56XFts2LANMjx9+EwmLV2rDvp7OE4ae/EQnRcIm7K8MQKx
        tyaExyId1ic7tWK5Q9hMczo=
X-Google-Smtp-Source: ABdhPJyI+SUZljjcfhxI4gwhZqmi9uvUCYIYy2VOb+p3pYpcbXczZs7zVhmyYu9zU6JFFvfUgb8IXQ==
X-Received: by 2002:a65:6790:: with SMTP id e16mr3432395pgr.112.1638517581782;
        Thu, 02 Dec 2021 23:46:21 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id d19sm2162364pfv.199.2021.12.02.23.46.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Dec 2021 23:46:21 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
X-Google-Original-From: Vincent Shih <vincent.sunplus@gamil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gamil.com>
Subject: [PATCH v3 2/2] dt-bindings: rtc: Add Sunplus RTC json-schema
Date:   Fri,  3 Dec 2021 15:46:19 +0800
Message-Id: <1638517579-10316-3-git-send-email-vincent.sunplus@gamil.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
References: <1638517579-10316-1-git-send-email-vincent.sunplus@gamil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sunplus RTC json-schema

Signed-off-by: Vincent Shih <vincent.sunplus@gamil.com>
---
Changes in v3:
 - Addressed the comments from Mr. Rob Herring

 .../bindings/rtc/sunplus,sp7021-rtc.yaml           | 56 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml b/Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
new file mode 100644
index 0000000..fd1b3e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/sunplus,sp7021-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 Real Time Clock controller
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+properties:
+  compatible:
+    const: sunplus,sp7021-rtc
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: rtc
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
+  - reg-names
+  - clocks
+  - resets
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rtc: serial@9c003a00 {
+        compatible = "sunplus,sp7021-rtc";
+        reg = <0x9c003a00 0x80>;
+        reg-names = "rtc";
+        clocks = <&clkc 0x12>;
+        resets = <&rstc 0x02>;
+        interrupt-parent = <&intc>;
+        interrupts = <163 IRQ_TYPE_EDGE_RISING>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8c86f28..c6dd228 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17949,6 +17949,7 @@ SUNPLUS RTC DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 L:	linux-rtc@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/rtc/sunplus,sp7021-rtc.yaml
 F:	drivers/rtc/rtc-sunplus.c
 
 SUPERH
-- 
2.7.4

