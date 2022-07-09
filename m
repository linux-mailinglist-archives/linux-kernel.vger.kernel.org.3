Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F1856C9C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiGIOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGIOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:05:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774E11A16;
        Sat,  9 Jul 2022 07:05:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m14so1023541plg.5;
        Sat, 09 Jul 2022 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KllOWvu7e5SrcZMDE7g9T24hEywTIkk+v5p3DscJSVk=;
        b=JsA5x/iG8WfSdh0tZ4dxUU7FBSlqz7y9N+fyrUGvUx1PBpFtSnrEp4ERs6Jaoa66S/
         hUIz8pj5tFx8yO/37gDbwdggYTyQ5tFV9Do27iGNssX/cH4aTnns1acqDloV30TZmVJL
         6QaeC6PvgTvfBCO4YCi0Cqt/rF0TVlUkoM9w/+dwgKMTLQrbEbI5sI85CwZbJbvFVFRn
         TbsnCoizLml9geh0H2VCtLar2IYNEID6BdEZTQCxb/0mMRIJfaiRxsfG480bCaN2iMBm
         W4HvAAR/r3yv+FsCX1IIoCqTgDUYtvHs9/4+p8GqI43OtkyEeaVDs5Bkrza/zL6Ag0VL
         HMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KllOWvu7e5SrcZMDE7g9T24hEywTIkk+v5p3DscJSVk=;
        b=FAWMVObRkfOso9Nf7ChFtL0YSvAr6rxpqKg8zBoiOJcfmLWtbpSf0ZdT/4tGOYXU2D
         geL5vf0dkqs+pqRxMFfd5Td/0r0zWgjXdPd4G/jNpXJO4Tf2lPTAuDA32ue5cfAcU/ZM
         HyhGjzrARgbq6km6Hjp36yxgBGsaOarDmllKCXhhAA78T7Lx1QLNESTY8Hcnf3WrIVqK
         MWmCbjzQG91Eyhct1fAMoojenIeQF/cCtm4MmILuea2H+vUVkzYjhlleCkLa1fNgGIz8
         7FWpBk1GaSqV0UV0EvRBLfjYupeJZlsEJghLqdjOoXcjt4A9Zw9oJpwuP11N7VtFb1i7
         8c+g==
X-Gm-Message-State: AJIora+nwmLlhqY9SmITaLxpBELxFFYDNnC/FATil4IKzRyTJbVdpNk6
        vLA4G6z4dI9SlqcfCxnZd17Hoal+NdJNWA==
X-Google-Smtp-Source: AGRyM1t3NFjlPMMPhXryFmJ501+/qhG0UUibtr/WTQTP0ZMNGP5yM8uq3vKteLhBZfDmJf5cX7/JGQ==
X-Received: by 2002:a17:90b:1c07:b0:1f0:2077:6a9 with SMTP id oc7-20020a17090b1c0700b001f0207706a9mr1014621pjb.90.1657375519336;
        Sat, 09 Jul 2022 07:05:19 -0700 (PDT)
Received: from localhost.localdomain ([112.0.189.16])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b00528baea5dacsm1496163pfj.201.2022.07.09.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 07:05:18 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Novatek NT35596S panel bindings
Date:   Sat,  9 Jul 2022 22:04:22 +0800
Message-Id: <20220709140422.56851-1-mollysophia379@gmail.com>
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

