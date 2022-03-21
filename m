Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5914E2BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbiCUPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350056AbiCUPTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4433031211;
        Mon, 21 Mar 2022 08:18:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d7so21162498wrb.7;
        Mon, 21 Mar 2022 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bWYd0ZpRAfAuB31BLlnofWY+miD3D1gba77XW/wHzGs=;
        b=ZObiOeh4gNAfK89eNiUBnF9jWtBmc5DiUZ6mX8+8vNFaQ0BJwnMKX0PH7lmyV9xRyn
         EvI5CWdKI5Iz594OTrSIexoxOZEeU3bD4EKHccr0hbwuVqI7h2985p5dmcq2aI+CCtXB
         vIBx8eXM1YmfBGh6d4b+gGrZexMV4EC4kEmTVNrGHJjAdh6Y37Nb9eUQqz1L7TbpgxO/
         QYyWS3iJxItCakNc4kNNdWNJYpWVzwp3cskrD2BkSVakhTb2tUm6nHClat4MhMAhkaYn
         bPOMTEE0KmYsaPxZdeOHIqxzqJV8SVOUFRDere9HZJ1PWPrLVonEWDycmnhz9zIlET/E
         6Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWYd0ZpRAfAuB31BLlnofWY+miD3D1gba77XW/wHzGs=;
        b=UQm7lMy66Jy1TvnChdtE2BSpNDs2Vx6URBnoY4xBgxaQYNdpeuFj8d5/Z5WjgS0sCO
         tQZ/9xY5io+ORJgXVhcgq9nc0W3XHxNsY1RlP+vmMvJfZ3dHyltxfNooPkh60quCAfX4
         BcZXwcCzH8jmPEyRbQ8txCm5TtlMgxKxC5/RaHTjPHRTOm4DtceXzp1CJF5SOO7fLYmw
         KZowat8U50WzYbaaupmX8AoqdaPkkB/F1mOW9VgRyyiC+zfizmjexC1ameP6vUCj1Td/
         YNSB6+vDhPQ6SsGNBe2vNOICC+DuG7PpokAZPXFOZ5s/VuV/WQrMiQVK0nssCZjfVsBr
         DozA==
X-Gm-Message-State: AOAM532CuQMawBeLQCvKp92+9EQTjS4eVVOWxabpkMxGRI4csi919VOs
        5LWuLB/NAAX76NrcjJ0NCV+uWOzPKe8=
X-Google-Smtp-Source: ABdhPJwm3eMCK7nuhCEXZAxv63oO6n86SXHhOzWW0VwTUpcHvrbm6/Jw/bPr6AvmUSYgnXbtFxO/nA==
X-Received: by 2002:a05:6000:128f:b0:1f1:e586:87af with SMTP id f15-20020a056000128f00b001f1e58687afmr18728049wrx.222.1647875883534;
        Mon, 21 Mar 2022 08:18:03 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:18:03 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 17/18] dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml
Date:   Mon, 21 Mar 2022 15:48:24 +0100
Message-Id: <20220321144825.11736-18-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

