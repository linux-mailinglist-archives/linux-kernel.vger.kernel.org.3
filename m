Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32AA56525C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiGDK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiGDK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:29:50 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DE3BF5F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:29:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r9so10505548ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 03:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpLOB+GeqZUZaWdoW3n5TUSSrySl3KCsNy7wywNHGKA=;
        b=b6CpaGtKjjfHIHJCOvE2hZQK80YR/EuQRFB5PMr17yruaa8c7aJzT0RzikFjXQ0tAR
         8HQFv8qPgr3zo/KRdpS3ELul484i4ljl9Ae1AYC8MNgqO/2yruNhhTwC7SF2z12jdjT2
         j8J1l2hCzr5qcUNzLWpx/W6+TarQXZhO6/WNYH7LOHlp5mEwzUQZXjxAgTsihTdP5ldj
         s0QMgG2g6UaUHPU7vZ4fH3rwU8X/5ELJ3XsrTFCWhqh6BxFFrTuZLR9XR9wlnis1gJQm
         wwbGGATK4vvT4G7SrX07ekgy7ERI+NQ+Srm2OSXWwQ5Pbv8IGDgoJa2tBfr4fwykw5zA
         +WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZpLOB+GeqZUZaWdoW3n5TUSSrySl3KCsNy7wywNHGKA=;
        b=b2bpFcwlYTE0sB03va4YCY3BdDRPXNJKmqrXxeRnSfw7xezICkYhZ/UTzVT3bLpw6d
         O2ZHmigTGne21kTK0XGyHU+mnZU1XwtzF+WJfHSi41QRkeHt7eLYXK0RQXM82Qtl3bG8
         OjqVSC7MEoK8KrQN28lWMDIa98rCwQKCz4EGUi3+jSl7ZvRwrqOyaB6Il/MOZ9uypSUZ
         xcG/UUwt/f/JxcosSiPD0eYGDTXed1YFFkcj5t+NWJ81tqB6yeXgOPSowBsKE+VpapAE
         ouzTBq5tg/koIoRZuT1MAQ98Z7Iq5EaP+YAvxpD+LqVz2RatrGHuqPkNIE9oJ/cw4DO+
         s7UQ==
X-Gm-Message-State: AJIora+dYwMgy86iJC3klz4EcF7tp4QYuvYLWPP1TL7aXrEblrwjxDnZ
        ypf0RPmXHRHxAsh5MpR1iUolkA==
X-Google-Smtp-Source: AGRyM1tCDuktvi2GzIE4J+9Ye28RHU50EuxwYQs3Ch8ATjRmMsdXxAWN1iTcqxp4UDuEbfIblpr1/w==
X-Received: by 2002:a2e:9105:0:b0:25a:7461:55b2 with SMTP id m5-20020a2e9105000000b0025a746155b2mr16537845ljg.326.1656930585167;
        Mon, 04 Jul 2022 03:29:45 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id j24-20020ac253b8000000b004796a17246esm2930279lfh.252.2022.07.04.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 03:29:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: samsung: document preferred compatible naming
Date:   Mon,  4 Jul 2022 12:29:12 +0200
Message-Id: <20220704102912.110881-1-krzysztof.kozlowski@linaro.org>
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
 .../bindings/arm/samsung/samsung-soc.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
new file mode 100644
index 000000000000..97ed793cd9c3
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
+      # Legacy compatibles with wild-cards - list cannot grow:
+      - enum:
+          - samsung,exynos4x12-pinctrl
+          - samsung,exynos4x12-usb2-phy
+          - samsung,s3c64xx-pinctrl
+          - samsung,s3c64xx-wakeup-eint
+
+additionalProperties: true
-- 
2.34.1

