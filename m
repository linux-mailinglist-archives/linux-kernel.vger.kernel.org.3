Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283204DDF06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbiCRQbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiCRQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:31:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C9E1959C2;
        Fri, 18 Mar 2022 09:29:58 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22ICwIRC029747;
        Fri, 18 Mar 2022 11:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=l0NijwQytPoPG4dLdvOKFpBqnKyQFX/aINmIG43AWEk=;
 b=JfaMbQWPES688gHHkz6CLnteAvfE4KwBlmyXrPXCw1Dl1BiwOgUwnQRZTSOegeS3DGky
 +ei+gHQ5f0zLrweM+Zrd4lAcqY5trgvgFJUwgKx4cpNjUgYagFaupmQcPDrqJNu0VKEk
 t2IEUMMgMq/EeX4TlYOZs0CA9PVjiOyXSUnQngfufQN92aC70BgHXZmZ67kqSkKwbS3C
 GLNa8BYmB24G8OYkcz8ZR2xOwYmJ1R8T6TqvAcKz63npGCGhhwomEkW6BHxLYJojFffy
 lgKj8SK+okrsPhzUFk8K5j9lfT5vU0242rTV0qZ2XnLGlbwsMBoYL3HiIWAL5DXwbbCm tg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3et5yp677a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 11:29:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Mar
 2022 16:29:44 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Mar 2022 16:29:44 +0000
Received: from debianA11184.ad.cirrus.com (debianA11184.ad.cirrus.com [198.90.251.45])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 906D5B16;
        Fri, 18 Mar 2022 16:29:44 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 4/5] ASoC: dt-bindings: cs35l45: Cirrus Logic CS35L45 Smart Amp
Date:   Fri, 18 Mar 2022 16:29:42 +0000
Message-ID: <20220318162943.1578102-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220318162943.1578102-1-rf@opensource.cirrus.com>
References: <20220318162943.1578102-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: u-rQOLOt-rSSuFI52R6XCuBSzBQ7qCBh
X-Proofpoint-GUID: u-rQOLOt-rSSuFI52R6XCuBSzBQ7qCBh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the schema binding for the Cirrus Logic CS35L45 Smart Amp
and associated header file.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../bindings/sound/cirrus,cs35l45.yaml        | 75 +++++++++++++++++++
 MAINTAINERS                                   |  2 +
 include/dt-bindings/sound/cs35l45.h           | 20 +++++
 3 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
 create mode 100644 include/dt-bindings/sound/cs35l45.h

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
new file mode 100644
index 000000000000..184a1344ea76
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs35l45.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS35L45 Speaker Amplifier
+
+maintainers:
+  - Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
+  - Richard Fitzgerald <rf@opensource.cirrus.com>
+
+description: |
+  CS35L45 is a Boosted Mono Class D Amplifier with DSP
+  Speaker Protection and Adaptive Battery Management.
+
+properties:
+  compatible:
+    enum:
+      - cirrus,cs35l45
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vdd-a-supply:
+    description: voltage regulator phandle for the VDD_A supply
+
+  vdd-batt-supply:
+    description: voltage regulator phandle for the VDD_BATT supply
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  cirrus,asp-sdout-hiz-ctrl:
+    description:
+      Audio serial port SDOUT Hi-Z control. Sets the Hi-Z
+      configuration for SDOUT pin of amplifier. Logical OR of
+      CS35L45_ASP_TX_HIZ_xxx values.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 3
+    default: 2
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/cs35l45.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cs35l45: cs35l45@2 {
+          #sound-dai-cells = <1>;
+          compatible = "cirrus,cs35l45";
+          reg = <2>;
+          spi-max-frequency = <5000000>;
+          vdd-a-supply = <&dummy_vreg>;
+          vdd-batt-supply = <&dummy_vreg>;
+          reset-gpios = <&gpio 110 0>;
+          cirrus,asp-sdout-hiz-ctrl = <(CS35L45_ASP_TX_HIZ_UNUSED |
+                                        CS35L45_ASP_TX_HIZ_DISABLED)>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 46ffe05eaeb7..0a2a8bcabbea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4580,10 +4580,12 @@ CIRRUS LOGIC AUDIO CODEC DRIVERS
 M:	James Schulman <james.schulman@cirrus.com>
 M:	David Rhodes <david.rhodes@cirrus.com>
 M:	Lucas Tanure <tanureal@opensource.cirrus.com>
+M:	Richard Fitzgerald <rf@opensource.cirrus.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	patches@opensource.cirrus.com
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cirrus,cs*
+F:	include/dt-bindings/sound/cs*
 F:	sound/pci/hda/cs*
 F:	sound/soc/codecs/cs*
 
diff --git a/include/dt-bindings/sound/cs35l45.h b/include/dt-bindings/sound/cs35l45.h
new file mode 100644
index 000000000000..076da4b2c28d
--- /dev/null
+++ b/include/dt-bindings/sound/cs35l45.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * cs35l45.h -- CS35L45 ALSA SoC audio driver DT bindings header
+ *
+ * Copyright 2022 Cirrus Logic, Inc.
+ */
+
+#ifndef DT_CS35L45_H
+#define DT_CS35L45_H
+
+/*
+ * cirrus,asp-sdout-hiz-ctrl
+ *
+ * TX_HIZ_UNUSED:   TX pin high-impedance during unused slots.
+ * TX_HIZ_DISABLED: TX pin high-impedance when all channels disabled.
+ */
+#define CS35L45_ASP_TX_HIZ_UNUSED	0x1
+#define CS35L45_ASP_TX_HIZ_DISABLED	0x2
+
+#endif /* DT_CS35L45_H */
-- 
2.30.2

