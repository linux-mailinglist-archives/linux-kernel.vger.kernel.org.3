Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAA4B39D9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 07:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiBMGcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:32:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBMGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:32:15 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2899F26101
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:32:11 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i21so22246343pfd.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnIfjUmZdedfi4INaVoGg1BBbTjtjdDq0mhqvofLu/o=;
        b=ayLkrL0jVN0cG0TefQ83qSKycUfY3dJJZFQRvZNkD7dR0yESr0YP5GzNMheLhDUZWA
         5tWk/kUE+RK8efoINPQj40BpkLfBDANJ1LmGtXKTStJpcsMxQoWQTwJhppynRbfjUxim
         1VamoWWTaQlLJg8UiekJpEQzo4G820Tt9Td/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnIfjUmZdedfi4INaVoGg1BBbTjtjdDq0mhqvofLu/o=;
        b=CyasufWdnWzxSs6rGpIrhsSJCGGgGHmx0XD4yvAYYhy5A4tOs2aOZP9dOgA/ptFNX0
         uMFRqtAFCZGuzOp2foiJPoO1rhFl/2Q1OsYOhx5sj0scgTqbI2v97cASttDKCeIC6bMs
         UHx5zMY8noLULIKqkJwKByjB/YuikQTLVWPUU7+KeOM1Pk+C0Zl8EkGeX7M1Sh4XssiL
         gVuWgHHgCgIxl9MimIWnZfAFl2lUUNZ7LRv/zv+URAoYHj4yZrHORKyvYhLChgSFVulH
         ynVPNoFugReRtzo1G+sNcc3Je5+efiXAQjMtNsevKGtfbxvpK5LwMx3S2emA/eG9WK6P
         e+cQ==
X-Gm-Message-State: AOAM532/r8a8nDT+hhTYdgl7y32dLhx/JvpdM8U+LUPoqBLFdikdMDEy
        ig3W7guS6/uvRRa4ufCFHtsjWw==
X-Google-Smtp-Source: ABdhPJzGawVyNFBnKSTS7EoIyQkuKznXDZQHiblP4nZQ75Arj2fe0OXk2XiTMXRtxaLQq6D82ZRsYg==
X-Received: by 2002:a05:6a00:1d9f:: with SMTP id z31mr8990026pfw.38.1644733930515;
        Sat, 12 Feb 2022 22:32:10 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:3653:bf18:8571:5f26])
        by smtp.gmail.com with ESMTPSA id q2sm34170025pfj.94.2022.02.12.22.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 22:32:09 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 2/2] dt-bindings: display: Add STARRY 2081101QFH032011-53G
Date:   Sun, 13 Feb 2022 14:31:51 +0800
Message-Id: <20220213063151.3321331-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220213063151.3321331-1-hsinyi@chromium.org>
References: <20220213063151.3321331-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>

Add dt-bindings for 10.1" TFT LCD module called STARRY 2081101
QFH032011-53G.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2->v3:
rebase to next-20220211
---
 .../display/panel/innolux,himax8279d.yaml     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml b/Documentation/devicetree/bindings/display/panel/innolux,himax8279d.yaml
new file mode 100644
index 00000000000000..fdcea3870dfb80
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
2.35.1.265.g69c8d7142f-goog

