Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC4A56C9D8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGIOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGIOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:11:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085113F57;
        Sat,  9 Jul 2022 07:11:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1110066pjo.0;
        Sat, 09 Jul 2022 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KllOWvu7e5SrcZMDE7g9T24hEywTIkk+v5p3DscJSVk=;
        b=URNmP3umu2PBlR0Jiq2x+70Gh+/snbyMaDhjDqYXTKpUbuT+iZ7a8v0Pr87jT5ljya
         mqGLESW71MJTMggzoFhVtAoSqiRB9CXcSxCalKUDDBQiTZiOG+kp+HJH+30PKfIXJ4P1
         rgPRmSMUxKYKgoQlLBJwEF0X0m5tDuU0J51tXReFYssdd+9DkCZPulPaaKmq9yU4fniC
         UVldYMoBotVX1vPCVSVySqpkaeWjybRfrdQh1m7gu/OWozZzrWH0zF6UqhVvKnljHidX
         FLOAT0j+rk+03varPvOLd+QWaXdGZ79R+LqA0JTY4jcYgPtLkTY6Px20CDGrSRHAoIh2
         mVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KllOWvu7e5SrcZMDE7g9T24hEywTIkk+v5p3DscJSVk=;
        b=0MMh2IRpxUB8m+hsU+YHnflJ5V5RTUUu/qc+7X8kVs42r7t7i9iGHeTQv3Ohm69yDL
         9pHdh4RMmZaOTMyMRKg+JuFsffAVn95LNZmIg1Oxr3xd4Y6y8aepKpFm/zHD40EdfX1x
         2EVs9bN7MFGqRR0h20s6Pi1bFKIjqvn8S48FrBHlpUnZk5YHapfGUOSOrMNGRvGKiNGN
         SclS6L+vhCYTl7YbUorsBN7BJLQVIfMiRTEZweEu9Y4f7AgcNwKE5DJyjv2I8jnPrs2d
         IKmTtBsZ6Sp0eJB26loT0rFIwEhGL89qFpqdoiBwM20FYIogzoOj57OkATMoebCGYO3j
         wsPA==
X-Gm-Message-State: AJIora+Eg49WHKrUIM+LyyGi0VoGe0VdLtI4W66MSmFbfh95kyGA4dGK
        T5MbQObfh0Hh2uV5cxktqt4=
X-Google-Smtp-Source: AGRyM1veZswxyk5NCV2BlLrQOLUfYkf8tbPH2lK9NsCBmTlbFuxvkQULsL+YlEPBy6MIgc1Yp8h5/g==
X-Received: by 2002:a17:902:c64b:b0:16b:d51a:dc24 with SMTP id s11-20020a170902c64b00b0016bd51adc24mr8822796pls.48.1657375908291;
        Sat, 09 Jul 2022 07:11:48 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id e11-20020a056a0000cb00b0052974b651b9sm1529828pfj.38.2022.07.09.07.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 07:11:47 -0700 (PDT)
From:   MollySophia <mollysophia379@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT35596S panel bindings
Date:   Sat,  9 Jul 2022 22:11:35 +0800
Message-Id: <20220709141136.58298-1-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for "novatek,nt35596s" panel.

Signed-off-by: MollySophia <mollysophia379@gmail.com>
---
 .../display/panel/novatek,nt35596s.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
new file mode 100644
index 000000000000..f724f101a6fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35596s.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt35596s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT35596S based DSI display Panels
+
+maintainers:
+  - Molly Sophia <mollysophia379@gmail.com>
+
+description: |
+  The nt35596s IC from Novatek is a generic DSI Panel IC used to drive dsi
+  panels.
+  Right now, support is added only for a JDI FHD+ LCD display panel with a
+  resolution of 1080x2160. It is a video mode DSI panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - jdi,fhd-nt35596s
+      - const: novatek,nt35596s
+    description: This indicates the panel manufacturer of the panel that is
+      in turn using the NT35596S panel driver. This compatible string
+      determines how the NT35596S panel driver is configured for the indicated
+      panel. The novatek,nt35596s compatible shall always be provided as a fallback.
+
+  vddi0-supply:
+    description: regulator that provides the supply voltage
+      Power IC supply
+
+  vddpos-supply:
+    description: positive boost supply regulator
+
+  vddneg-supply:
+    description: negative boost supply regulator
+
+  reg: true
+  port: true
+  backlight: true
+
+required:
+  - compatible
+  - reg
+  - vddi0-supply
+  - vddpos-supply
+  - vddneg-supply
+  - reset-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "jdi,fhd-nt35596s", "novatek,nt35596s";
+            reg = <0>;
+            vddi0-supply = <&vreg_l14a_1p88>;
+            vddpos-supply = <&lab>;
+            vddneg-supply = <&ibb>;
+
+            backlight = <&pmi8998_wled>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+            port {
+                jdi_nt35596s_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.37.0

