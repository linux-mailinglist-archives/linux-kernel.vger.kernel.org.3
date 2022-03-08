Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448904D18BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbiCHNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242752AbiCHNH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:07:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDECB48316;
        Tue,  8 Mar 2022 05:07:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j17so28531780wrc.0;
        Tue, 08 Mar 2022 05:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oUsYE5vCqqM379ucx1WaZIZjicJ83WEckesSTynIV2A=;
        b=qiRyr34qJ6m+4Yy3vZMQExJWg/MRLN16JXTN3fqxV8Lx8l1YEfqDpdcyrXdbzdtcoG
         2oToyyqPloznqkgNw3Og8cDFXdYwwrC9EHk59DHCYFku+nzMEZzFY9nVWKYxT+dlJ3zl
         q9V6gsLr+WcawSRT/dSq/u2TM1kACKQ94hQLmxNNTmI01ojX4zou7OL69Qq6pWGcy1Ho
         afSFdx5+huHS5kDlwYgN/k5pGySPsOLsjRfXi2HxGBWij9y8UuNvBigDTjTchtOUSvGg
         oN2EGjKVfe9zDFpErahU3KFbmBptLyp8ssO61enVZDw+VTKsFWTOooroHDyqkC7ETbhV
         KxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oUsYE5vCqqM379ucx1WaZIZjicJ83WEckesSTynIV2A=;
        b=ifyUa/23MyUifkZrfKCET57NBQMdHqdgNa//KhoN0mlX0iRJN5LzrFL8qmKKjJZaaH
         lBKvwK57r3xAO+i3DGRef/1CCxhmAKnrHysKfvqu7hAXoHiSkzXRtgWlrr0osLYqxsKE
         2TukrP+zlLs0cbVa/P3wJ1/95acN/cHL6HOEEqKcfGoSv32ZXiVF0y3Xm2RGMzH6vcdm
         DdGvljPgn70nj9Cj0/8N4hAjw6J8Ary1XJKgZJuVwtwmG7MYWN/fYOkUaot1yj3m7eOe
         HQvboqtmsnER+bakXY9deRmDixFortJX4UxCvY4wHbs6tLu7Of5V0QHj+EVEVFfFnLCx
         fewA==
X-Gm-Message-State: AOAM5320FkjshJvxDIRwmoC17QC0xPH6PSG++jz6NGFs28aGLlY3eDPg
        +oKUbYc0TUwg6fEvdg2S0q4=
X-Google-Smtp-Source: ABdhPJytf6G5YVGNcujtGVSueQv0J+ZS4ATCYKKO0s2bnfxvp/0LDu0ZRMkZKecWr+wmyLkV14b7Pg==
X-Received: by 2002:adf:f006:0:b0:203:723d:a2e5 with SMTP id j6-20020adff006000000b00203723da2e5mr1353663wro.188.1646744820378;
        Tue, 08 Mar 2022 05:07:00 -0800 (PST)
Received: from monk.home ([2a01:cb10:430:ec00:4737:d56e:186b:af1])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b003899d50f01csm2129159wms.6.2022.03.08.05.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 05:06:59 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: display/panel: Add Leadtek ltk035c5444t
Date:   Tue,  8 Mar 2022 14:06:43 +0100
Message-Id: <20220308130643.260683-5-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308130643.260683-1-cbranchereau@gmail.com>
References: <20220308130643.260683-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the leadtek ltk035c5444t, which is a 640x480
mipi-dbi over spi / 24-bit RGB panel based on the newvision
NV03052C chipset.

It is found in the Anbernic RG350M mips handheld.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../panel/leadtek,ltk035c5444t-spi.yaml       | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml
new file mode 100644
index 000000000000..9b6f1810adab
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk035c5444t-spi.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/leadtek,ltk035c5444t-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Leadtek ltk035c5444t 3.5" (640x480 pixels) 24-bit IPS LCD panel
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+  - Christophe Branchereau <cbranchereau@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: leadtek,ltk035c5444t-spi
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "leadtek,ltk035c5444t-spi";
+            reg = <0>;
+
+            spi-3wire;
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&vcc>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
-- 
2.34.1

