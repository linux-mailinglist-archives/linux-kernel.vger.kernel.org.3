Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6049B4E1CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbiCTQbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245577AbiCTQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:30:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0CB34B93;
        Sun, 20 Mar 2022 09:28:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j10so4786968wrb.13;
        Sun, 20 Mar 2022 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bWYd0ZpRAfAuB31BLlnofWY+miD3D1gba77XW/wHzGs=;
        b=XnmzBxuV5/vK3HlluSJZzpHv1c2GPio9UzINtI1YnHEFLZkG3A3ymyu5TC0BcmR8IW
         C0JnFcydq3sTQ7b3HOotTL3HAi+28lgh2tYA9JZB5Ct1LmBr07PCkN3zyHvbyrHzmY+C
         jrrPWbynH78NzqLL4wJFNzXwr7GWYz2Wus/kRoLwv54K0ilClrPxU6obYx+3LKIJ4jLZ
         n+Y4m5EjUHD3KWmWWeHZBpKDCQgs9PHGEx0CYHxugCK3Eps8sOuTOW2y2Zsnb6JUG6Gg
         I6hx1OPOspfy1qUAlXHwbEetQuw0+niirSkXsde+QPU4zkEO0CBOe3KCPjZdM35V/3Wm
         1C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWYd0ZpRAfAuB31BLlnofWY+miD3D1gba77XW/wHzGs=;
        b=wKfBwEm8Nnyn9J8ZxZSv/Uhuk2O4tO35XUvoHRMPxDj1MLx2K5yG0HTMaPyLHfWNhf
         LzXtYaK79oo+2e/fvGxEDGenqZThzSWlAEwWyzNIOxaOkA6T7WOZ8QYGFRDjZo4zCJvy
         F2qSjO4TS8pIFGh3Aq+kR73b8xcKAbLB2FUjFNlK+i56nL1qyptxSTn7cS4+M/+xQ1IA
         v41HCa/aQPyUZu0CXFzfBL3v1afX5yE9zO6jX2E6QgIUYvupU4sRwUFqypUJGf7O49IP
         bPwEATCnQKo7+IyQ8IvqfGfzv7GcS981fAndp7AUE3n16Z2XRC8AuST2EsrWmgm6578/
         vNMQ==
X-Gm-Message-State: AOAM5303NmNrmYPFRMXHXX87T2+euzNnU1R+OBzBijg/G/az7jvWy0Gt
        LmH2wXNEI5Lf01fYTuI+mqU=
X-Google-Smtp-Source: ABdhPJyCo4b07tPqAd2n2Tfj5cGhlXIbHbPs7A/prP7cmRtwP+qoM0Htxh3UWDO6EKTmZkeKUXFuig==
X-Received: by 2002:a5d:6442:0:b0:203:dff2:866c with SMTP id d2-20020a5d6442000000b00203dff2866cmr14974513wrw.465.1647793709832;
        Sun, 20 Mar 2022 09:28:29 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:29 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 17/18] dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
Date:   Sun, 20 Mar 2022 12:34:29 +0100
Message-Id: <20220320113430.26076-18-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kpss-acc driver Documentation to yaml.
The original Documentation was wrong all along. Fix it while we are
converting it.
The example was wrong as kpss-acc-v2 should only expose the regs but we
don't have any driver that expose additional clocks. The kpss-acc driver
is only specific to v1. For this exact reason, limit all the additional
bindings to v1.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -----------
 .../bindings/arm/msm/qcom,kpss-acc.yaml       | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
deleted file mode 100644
index 7f696362a4a1..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
-
-The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
-There is one ACC register region per CPU within the KPSS remapped region as
-well as an alias register region that remaps accesses to the ACC associated
-with the CPU accessing the region.
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: should be one of:
-			"qcom,kpss-acc-v1"
-			"qcom,kpss-acc-v2"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: the first element specifies the base address and size of
-		    the register region. An optional second element specifies
-		    the base address and size of the alias register region.
-
-- clocks:
-        Usage: required
-        Value type: <prop-encoded-array>
-        Definition: reference to the pll parents.
-
-- clock-names:
-        Usage: required
-        Value type: <stringlist>
-        Definition: must be "pll8_vote", "pxo".
-
-- clock-output-names:
-	Usage: optional
-	Value type: <string>
-	Definition: Name of the output clock. Typically acpuX_aux where X is a
-		    CPU number starting at 0.
-
-Example:
-
-	clock-controller@2088000 {
-		compatible = "qcom,kpss-acc-v2";
-		reg = <0x02088000 0x1000>,
-		      <0x02008000 0x1000>;
-		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
-		clock-names = "pll8_vote", "pxo";
-		clock-output-names = "acpu0_aux";
-	};
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
new file mode 100644
index 000000000000..5a3233b1654a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
+  There is one ACC register region per CPU within the KPSS remapped region as
+  well as an alias register region that remaps accesses to the ACC associated
+  with the CPU accessing the region.
+
+properties:
+  compatible:
+    enum:
+      - qcom,kpss-acc-v1
+      - qcom,kpss-acc-v2
+
+  reg:
+    items:
+      - description: Base address and size of the register region
+      - description: Optional base address and size of the alias register region
+
+  clocks:
+    items:
+      - description: phandle to pll8_vote
+      - description: phandle to pxo_board
+
+  clock-names:
+    items:
+      - const: pll8_vote
+      - const: pxo
+
+  clock-output-names:
+    description: Name of the aux clock. Krait can have at most 4 cpu.
+    enum:
+      - acpu0_aux
+      - acpu1_aux
+      - acpu2_aux
+      - acpu3_aux
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kpss-acc-v1
+      then:
+        required:
+          - clocks
+          - clock-names
+          - clock-output-names
+          - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+
+    clock-controller@2088000 {
+      compatible = "qcom,kpss-acc-v1";
+      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+      clock-names = "pll8_vote", "pxo";
+      clock-output-names = "acpu0_aux";
+      #clock-cells = <0>;
+    };
+
+  - |
+    clock-controller@f9088000 {
+      compatible = "qcom,kpss-acc-v2";
+      reg = <0xf9088000 0x1000>,
+            <0xf9008000 0x1000>;
+    };
+...
-- 
2.34.1

