Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13A24F4DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583654AbiDEXxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443108AbiDEPi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:38:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E21456F5;
        Tue,  5 Apr 2022 06:54:40 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2356jiGD029879;
        Tue, 5 Apr 2022 08:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=KkkHloQadDKnUAPAtQgcoCi4hkh/UX+yykA6cYn8qf8=;
 b=Fz4fXi340YyTCddfW+2PpTBQ1Enozlxs0xjYXHiMBzEh3tJaaJ/haqL+D21KxG1Kw5WJ
 C3Z+QHhtPvPliWLQ919Oh19Y1Zockrw3DEBtMkobzBoDMmI3ysYhpu69INj9fZhLWazA
 N7JG97+/h1gzL/RlH46L9HeRqodWeY0PCFbLTNQj5Sz33x9jz4p7dvvmLkl/xd4nDx5h
 7I6Ap6bmQNUa8xrlXCN5IsrzhR0jsHZLpI1Ozm5asoIKVar54nKW6LN5SJIOtEqvkrfx
 SEIXXfoY0wHikIxXlYI9CtGZMVmKgPY+IbeG+pTsXpvE/I4AgXaJ8QnbpUhv4iUjBfWF ZA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2brws-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Apr 2022 08:54:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 14:54:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 5 Apr 2022 14:54:24 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5847611D1;
        Tue,  5 Apr 2022 13:54:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/5] ASoC: dt-bindings: cs35l45: Cirrus Logic CS35L45 Smart Amp
Date:   Tue, 5 Apr 2022 14:54:18 +0100
Message-ID: <20220405135419.1230088-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135419.1230088-1-rf@opensource.cirrus.com>
References: <20220405135419.1230088-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k_jXz7fUPpSocaD54GXH1_gdO47XDFKw
X-Proofpoint-GUID: k_jXz7fUPpSocaD54GXH1_gdO47XDFKw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the schema binding for the Cirrus Logic CS35L45 Smart Amp
and associated header file.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
index fd768d43e048..0c5971c3dd9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4688,10 +4688,12 @@ CIRRUS LOGIC AUDIO CODEC DRIVERS
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

