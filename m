Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF8546E85
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348082AbiFJUiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346497AbiFJUiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:38:15 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED68EC30C;
        Fri, 10 Jun 2022 13:38:13 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id u2so190201iln.2;
        Fri, 10 Jun 2022 13:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4m3Bo0gVkhfyIGU9xra6MloozgwWOG3t7N6ZclZnQ/I=;
        b=L4sGfIYPckBMlF7ZP3tzeiTkUORZIRsYWnGQVDe3QhQsz6CCxigihhbkFiWLDQcvoj
         Ar+pJniGyzEGFKwNKW0DHNNTnHSm7wPsJrgc5pclEL/JkGVyFyvmBHXX5j+7VdtO3laO
         B8jSs8KwNPJKRwMQJOjYEGZ+rarwHvzJjrI2owijXqD+yLq2x6+xlZYrCcEyWVnFaN6B
         1tYa6NWzll4LyltauiTOKMvfu0XZY8smOsHpR84sNTMpWvGX8ulqLcvzKTeIpjWhv/sL
         GOJN+a2HvNfV+aINx0YV20s3dQVoihlWFMkw8nmRcPl/EITO2uVJZ+NM8kvrx5a63jhm
         UUHg==
X-Gm-Message-State: AOAM531i8VcqDbvTszamjaOk+HJNipnfp58Xf4Y2KzrxH+qq4/b8E6qH
        LGj9wdUYOTvJcgT/7PL4KQ==
X-Google-Smtp-Source: ABdhPJyVB3wPO8qibfrXXcaLUISXcn2Swhm7rrrKY18ybttaAXPFa7pxNWCllTPtZVYk3Nc3HqhWMw==
X-Received: by 2002:a92:cbcd:0:b0:2d1:ba4f:2f4f with SMTP id s13-20020a92cbcd000000b002d1ba4f2f4fmr25692107ilq.181.1654893492813;
        Fri, 10 Jun 2022 13:38:12 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id z20-20020a056638001400b003316f4b9b26sm16014jao.131.2022.06.10.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:38:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd/partitions: Convert arm-firmware-suite to DT schema
Date:   Fri, 10 Jun 2022 14:37:44 -0600
Message-Id: <20220610203746.2191518-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the arm,arm-firmware-suite partition binding to DT schema
format. Simple conversion as there's only a compatible property.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../mtd/partitions/arm,arm-firmware-suite.txt | 17 -----------
 .../partitions/arm,arm-firmware-suite.yaml    | 30 +++++++++++++++++++
 2 files changed, 30 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.txt b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.txt
deleted file mode 100644
index d5c5616f6db5..000000000000
--- a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-ARM AFS - ARM Firmware Suite Partitions
-=======================================
-
-The ARM Firmware Suite is a flash partitioning system found on the
-ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
-Versatile PB, the RealView family, Versatile Express and Juno.
-
-Required properties:
-- compatible : (required) must be "arm,arm-firmware-suite"
-
-Example:
-
-flash@0 {
-	partitions {
-		compatible = "arm,arm-firmware-suite";
-	};
-};
diff --git a/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
new file mode 100644
index 000000000000..baf19ac0ea1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/arm,arm-firmware-suite.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Firmware Suite (AFS) Partitions
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  The ARM Firmware Suite is a flash partitioning system found on the
+  ARM reference designs: Integrator AP, Integrator CP, Versatile AB,
+  Versatile PB, the RealView family, Versatile Express and Juno.
+
+properties:
+  compatible:
+    const: arm,arm-firmware-suite
+
+additionalProperties: false
+
+examples:
+  - |
+    flash@0 {
+        partitions {
+            compatible = "arm,arm-firmware-suite";
+        };
+    };
+...
-- 
2.34.1

