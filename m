Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341B3500828
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbiDNIWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiDNIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:21:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7862F6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:19:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q12so4139460pgj.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SSywtdZUMxkCBI/xEk1bUiLN2t69WD4r/p615M6+ZCA=;
        b=vgBISCRmMtcc6je3mf41/eoFijY/e66ExSqB70Xd8xivGACiHeL4dvR3YDgMVAN/95
         EqijJScDyIkc4ojblWztN+TKdFijp+04CBNy1UAGvMMSH7XV5U/KFvtKMF/DeZOut+D4
         Za3B7xBV7DZDf4EmVmwSCmHORKyflKz0xbd2T6+ViE/X3CbBpaNW5im6B/hnqz4hMDeX
         cxi9ki32zgAMrDhWgLPJPWIW+14YGK2OUJGcNxkhlPnet9sng7CO4U69hOYrIh2F7yMY
         m9LmzUL9qSkNnzaLSdNiiQhx3k331OUon5dGiCI+uf0QWURzmpsBTPHUqv7YKJlNSwUy
         bXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SSywtdZUMxkCBI/xEk1bUiLN2t69WD4r/p615M6+ZCA=;
        b=rY7YQv+5HQpzQLHBUCsTkzbynTEiS1Uks3mxjWM6q6jhOYzoZXlDzCqkcQRbbTtLOa
         GfRNjIuUKrz05UnKPaDQ6Q3smoNn4FzwEnwKpGupY7Sa5zUuICcf/aoMB/2XLh9/KTrO
         XxDFI9MWu3JHp+UWwgOh3aZaqT5wgyffe/vf3GCg/nBKblYKeGcb9l6gp3mjHOBxAws0
         HeieTsECGL+Ol5RO3df9ucD3URGvjWe1VRs/ltLSDle6k6N2LFnBr0anqL7LutBnTyN9
         5M6ZEb/uiG0+foddwHwUi/UbP0UpxARkUzWI678wrgY+19sLC6qq1tyS2gdPBcmRtpF2
         4xeQ==
X-Gm-Message-State: AOAM530Axz081FtfKOHbHtZBN0Fpnuc/Q+oS8iKQqA6RIsSkhqBPN2z8
        QGAlXTP+yDvvV31OHYd5dTTjJg==
X-Google-Smtp-Source: ABdhPJw4fCPHEUNZa/x7vkhc1oMIXUbOOzV3GlqSYTDLhsZ1g28DioXPjDSm4ncis3PlhZ/DHCjRhw==
X-Received: by 2002:a65:5b88:0:b0:39c:c84f:b0a4 with SMTP id i8-20020a655b88000000b0039cc84fb0a4mr1400824pgr.65.1649924369447;
        Thu, 14 Apr 2022 01:19:29 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78009000000b004fde2dd78b0sm1304394pfi.109.2022.04.14.01.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:19:29 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [RESEND v2 2/2] dt-bindings: display: Add STARRY 2081101QFH032011-53G
Date:   Thu, 14 Apr 2022 16:19:16 +0800
Message-Id: <20220414081916.11766-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220414081916.11766-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20220414081916.11766-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for 10.1" TFT LCD module called STARRY 2081101
QFH032011-53G.

Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

