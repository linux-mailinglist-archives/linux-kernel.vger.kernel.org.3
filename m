Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343785609C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiF2Sur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiF2Sun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:50:43 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE518361;
        Wed, 29 Jun 2022 11:50:41 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id d3so396672ioi.9;
        Wed, 29 Jun 2022 11:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lC0FS/YwnawDE3dIPNG4OuxNJ6LL8yKImCI5KP81WTo=;
        b=Qx+TfCA4efLbZ0Iljr1XJc1pXkkrmqyyN7sMuKrxW9NZiwDDyedsVujEPwJevyKXyr
         5TJCHEYbdoBN0V8xawpBfM+wuy2Olshkqoewc/UxyuZIhfAubMM1iqSlgLednIXs6j+/
         GzJ5idwwz68EN25XoGlFfOQxqed8xnx46KeFEEcCaxALHkM31LMX3Gnrog+YDjiPcL/v
         4p91DF9sTFS12suemQh/OeojvRZZ2lv+dgXiGZ/3ff81gW3PCEPlaXUhqThHLP/Yq4Kn
         9dZb5/NH9Yi7sDvdWBS1v9sZLwBeLAh4irfeZImuVq9tgGWx9t5Hl56uXNG+1/M0xfYv
         GEdw==
X-Gm-Message-State: AJIora9dhJi1KnT2VYhnTfriolRx2D+kC0pXEoOh5QwMQ/OSxlCSuN+H
        UhDToARuSGIh4A7a7WambaZDjRAjig==
X-Google-Smtp-Source: AGRyM1s9g2WdbEij2eOEMPLKdKNm0dwWC39LBthQsHU267ZmYwdIO2ymTwvBSF9TitvUxDyFhC6YIA==
X-Received: by 2002:a02:c057:0:b0:339:e390:c94a with SMTP id u23-20020a02c057000000b00339e390c94amr2813647jam.20.1656528641021;
        Wed, 29 Jun 2022 11:50:41 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id w3-20020a02b0c3000000b00339d4037e7csm7617381jah.44.2022.06.29.11.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:50:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mtd/partitions: Convert arm-firmware-suite to DT schema
Date:   Wed, 29 Jun 2022 12:50:30 -0600
Message-Id: <20220629185031.23826-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the arm,arm-firmware-suite partition binding to DT schema
format. Simple conversion as there's only a compatible property.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix example dtc warning
---
 .../mtd/partitions/arm,arm-firmware-suite.txt | 17 -----------
 .../partitions/arm,arm-firmware-suite.yaml    | 28 +++++++++++++++++++
 2 files changed, 28 insertions(+), 17 deletions(-)
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
index 000000000000..76c88027b6d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/arm,arm-firmware-suite.yaml
@@ -0,0 +1,28 @@
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
+    partitions {
+        compatible = "arm,arm-firmware-suite";
+    };
+...
-- 
2.34.1

