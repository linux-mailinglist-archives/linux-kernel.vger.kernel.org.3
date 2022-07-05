Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1EF5673F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiGEQNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiGEQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:13:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB7418E25
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:13:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f39so21403493lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nEMULX3caekxu6IpY9n8CKmBGs6wAVmggM/WX7upL/g=;
        b=Rl/7x4CQYuJWvdvPRT/Fd12K+OtOYzZyehhYXXybqaX5Pi1Fm79tfO97h/nw4uRwTN
         enn7gP8dyPyoOt3/06dnhdb+FAmJ3RVJediqdupFIuxalILZIU6vcCV5dANfG66eE4gs
         Nz8L9XajeDNNTRI0LGqndecWA7pnAx57WTaYqmLbDFnT8vOhptPErY68v0Fx6WN75stX
         XYf9RepWt5n5rR09DrFMwnzcgYdt+kmXdJ7yKmUX7Ev4nMFAxpKOWW0BHudnX0zNNTA7
         01Pg7KWVUX4Z6gfIx+4QFkkMblccgNY8Bhs+ORw9n0V3W4aVbQYTzTV2KnxaH9zEp5ht
         7B3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nEMULX3caekxu6IpY9n8CKmBGs6wAVmggM/WX7upL/g=;
        b=KtHGI72ccb8uwG0x1AMTCRry9LESUs9BrqElbZWzdvp7KkJTf6pOORW5iyaGsaBq1x
         HbtGW7SbUcbF0XVtQUYLr9AsGZJhL2AZMqf+3/EloBULh+zTX2+pg5mc36bmiwDE1BtQ
         UxfQLbTERAIXiQROoDsLZ5w2K6dGTFC+7cmj6y7nCMbv1gI2WScsFfxC5r1CLuBmrubG
         VDYXxsCjBD0ujxSi/gluLgAhdbkVo8j5AgOZ5rApW1gIO7AZd32Hg/HWDyNJaKkfJJ5O
         gT/iwf8Kk4zGJXoRBPn2y9fHk5jG5vyg0y8qx+uxGBFbANlry0grxPmAMHE9Hn/VygJ3
         dZCg==
X-Gm-Message-State: AJIora80pQhSNaAi4h+ck/9iBRD83px5v9XviQ+OlAt/r2XHrdoyj6hv
        owWoH3Yq8gTcPvxjSzg1nac0uw==
X-Google-Smtp-Source: AGRyM1uXPNWr5J019pOwxyaVBGGm+iRfywVs4R8TnnmZUvoBDkzQOea44sJZsQ0iWjDVlozwoQVC6g==
X-Received: by 2002:a05:6512:220c:b0:483:d9ad:b56c with SMTP id h12-20020a056512220c00b00483d9adb56cmr2240655lfu.150.1657037624199;
        Tue, 05 Jul 2022 09:13:44 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id r25-20020a2e9959000000b0025a70f7ea3asm5638346ljj.138.2022.07.05.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:13:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: samsung: document preferred compatible naming
Date:   Tue,  5 Jul 2022 18:13:40 +0200
Message-Id: <20220705161340.493474-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatibles can come in two formats.  Either "vendor,ip-soc" or
"vendor,soc-ip".  Add a DT schema documenting preferred policy and
enforcing it for all new compatibles, except few existing patterns.  The
schema also disallows wild-cards used in SoC compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Update comment.
---
 .../bindings/arm/samsung/samsung-soc.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
new file mode 100644
index 000000000000..653f85997643
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/samsung/samsung-soc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S3C, S5P and Exynos SoC compatibles naming convention
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |
+  Guidelines for new compatibles for SoC blocks/components.
+  When adding new compatibles in new bindings, use the format::
+    samsung,SoC-IP
+
+  For example::
+    samsung,exynos5433-cmu-isp
+
+select:
+  properties:
+    compatible:
+      pattern: "^samsung,.*(s3c|s5pv|exynos)[0-9a-z]+.*$"
+  required:
+    - compatible
+
+properties:
+  compatible:
+    oneOf:
+      - description: Preferred naming style for compatibles of SoC components
+        pattern: "^samsung,(s3c|s5pv|exynos|exynosautov)[0-9]+-.*$"
+
+      # Legacy compatibles with wild-cards - list cannot grow with new bindings:
+      - enum:
+          - samsung,exynos4x12-pinctrl
+          - samsung,exynos4x12-usb2-phy
+          - samsung,s3c64xx-pinctrl
+          - samsung,s3c64xx-wakeup-eint
+
+additionalProperties: true
-- 
2.34.1

