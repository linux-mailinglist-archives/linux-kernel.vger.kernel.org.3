Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399FC48778F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347141AbiAGMWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiAGMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:22:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC3C061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 04:22:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso6303296pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 04:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j2hVMlNtYj5VEZ4Y0Jxi4coXu71w03xKJ5OC/uICxbM=;
        b=NmATg7It3Il/fTwBYVReR2qL0539xNHXqwhaC0Io36c1Hse/4RmuJk8p3V1iAoEAHz
         Id310GNdgnitLhaWeAwpIxqQ8Ama2awsWR2hUiMGlGzHeNrgWx1VCzgQg7aWjweGPpaz
         hhmcdLVcHmdpxgOnIkNAAQNNE75nHl7Jxo0WPKuySplURCkS5PG3f3qM757JjNtUPezY
         61YiywVtRFfCcCREn5xMi8kKQID6rH3ngw4+WcW4QOXG169tGnQ2vXGEzA9hcqnutGn3
         tVxOuucpCztEO18Skvsnulo0/WBkM1lVzfxAFkqszmGcO/0v260EcPG7RZpHYTIXOczv
         nDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j2hVMlNtYj5VEZ4Y0Jxi4coXu71w03xKJ5OC/uICxbM=;
        b=o/s4XDaKQeQiT2+KZqJRSSHe0556Zjs+ObNZPV/BJHKNOcnAvhUUTPwsCM3zdrxtUe
         GwRqAU2Anve3i5MaULxzH1drGh3Qe41gKN++GALrRZzvx1fE4BQJndNbMN9ydYn/xdZ1
         FeJtntCsbApNXgur9/T0icqhDwZZjIZZ2g3eEfAUpgEkTOjtsQiD8qkqajt8mENiBkgY
         V6CAl3xzeSMeEVCuvwQhBle7z4qacxijfnPrZswfKB47J2dg0tpMvRT5YFtBOjdkpxJu
         4HUv/yFsqMRliuqyLF0Htgs8x09oT1072mJ1EEWWkSLz5jp8bBm8FSHQfiOzTlZ9wMa5
         cCbg==
X-Gm-Message-State: AOAM531ecroBC1bsmS1+KPDYafLz/+05K+yBpa37aoZSb7Or+1KD0q4B
        i0Ri/4gMLyD4mMnm0I22/8b2SQ==
X-Google-Smtp-Source: ABdhPJxYPhYn/uXSncnYHL8SnUZXPEHJiyYRnFKZgWswA7zlt3cluhf9z1TPTccC6ncbn0MdMB9u5w==
X-Received: by 2002:a17:90b:3848:: with SMTP id nl8mr15322592pjb.167.1641558140626;
        Fri, 07 Jan 2022 04:22:20 -0800 (PST)
Received: from ubuntu.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id o11sm6013071pfu.150.2022.01.07.04.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 04:22:20 -0800 (PST)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hsinyi@chromium.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v2 2/2] dt-bindings: display: Add STARRY 2081101QFH032011-53G
Date:   Fri,  7 Jan 2022 20:22:08 +0800
Message-Id: <20220107122208.3893-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220107122208.3893-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20220107122208.3893-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for 10.1" TFT LCD module called STARRY 2081101
QFH032011-53G.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
---
 .../display/panel/innolux,himax8279d.yaml     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml b/Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml
new file mode 100644
index 000000000000..fdcea3870dfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,himax8279d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: INNOLUX HIMAX8279D DSI Display Panel
+
+maintainers:
+  - xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+        # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
+      - starry,2081101qfh032011-53g
+
+  reg:
+    description: the virtual channel number of a DSI peripheral
+
+  enable-gpios:
+    description: a GPIO spec for the enable pin
+
+  pp1800-supply:
+    description: core voltage supply
+
+  avdd-supply:
+    description: phandle of the regulator that provides positive voltage
+
+  avee-supply:
+    description: phandle of the regulator that provides negative voltage
+
+  backlight:
+    description: phandle of the backlight device attached to the panel
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - pp1800-supply
+  - avdd-supply
+  - avee-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "starry,2081101qfh032011-53g";
+            reg = <0>;
+            enable-gpios = <&pio 45 0>;
+            avdd-supply = <&ppvarn_lcd>;
+            avee-supply = <&ppvarp_lcd>;
+            pp1800-supply = <&pp1800_lcd>;
+            backlight = <&backlight_lcd0>;
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.17.1

