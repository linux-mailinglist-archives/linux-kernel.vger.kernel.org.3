Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4935E4E2D75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350699AbiCUQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350776AbiCUQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:10:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3762A709;
        Mon, 21 Mar 2022 09:08:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j18so11741453wrd.6;
        Mon, 21 Mar 2022 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FUy/r9Be6sB+uJt1vdamBW63PDhsfX/EA9tDB1Eiasg=;
        b=qu88LCHuPVn7AFxJZgq681bD5nNpZ1cmwe3q/lcZukRgeiNtH4jeXe6Gq28zmbBsQW
         PnG7Ry3M1GNTjqWNxtoFF3f+0EJVjWIbS+UDBtCWHAFiyiudvDDcq5ZDSQrRsM/PGQTd
         elLlmiGWmni3XLDsi98xhx9WSPUlQLLTkoY3TGEEQ+8AFMkg5xhY6elVn4WLEa+nMRrO
         GuRvNCiOJj0MqdS1jP7whBnFlFUzMimY3jw069ayoXLQgxP184GQ350B2n6SyBm0PbHs
         3Iw82XFOQAJxV9u+ywZoJKqhTbqb2+VpeTpn3mIdrnkR4Ih8wuplT1W+wSBuDu19M5PR
         VYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUy/r9Be6sB+uJt1vdamBW63PDhsfX/EA9tDB1Eiasg=;
        b=cWaFwqOQcG4i5Gat1hBOpbkMkWCc//yWq1YAg+Ey3xU8huCjJrsqy6DTqfM5IBZ0t8
         T1Y1LvK4xYoIfwvpg/IVTcFCjRVJvcYsXsrbr8fb08tR4MxtwuO2rIEZvY8RJmJyYssT
         uLTEsHodUiu0tZ1W0D+FBGsH1kRPY5tA9XBxcpcpeTP8kUhB54e1lrq1wKESr0t2ligB
         WEIsfW+5e5hWUOwADFPleVSNcn6L2qdmISeaaVPxPzS3dES0N4hZZbi0FT/EwcMm4DNA
         gU9Ha8ZyXBPmb4kGAaoOsP+Z5InnBjv36o3Em/q/mCC4aDsoKswHIXqVnFQ45E8QLPhY
         KLZQ==
X-Gm-Message-State: AOAM531Am4Y/1O+/UbFmmbScF0wS6+cwyG79jexaSULsuP2nIOi9e41v
        krFlj62Uiro2Rj5T4YEEwyw=
X-Google-Smtp-Source: ABdhPJzN/TJk/yV+t+YAxeMzAmYMbqfRPoSyPVymQcoHJi1lmIcNRoQ7HePTAAS/mKeYTLWLk6EKeg==
X-Received: by 2002:a05:6000:1d97:b0:204:1b0:74b2 with SMTP id bk23-20020a0560001d9700b0020401b074b2mr9042793wrb.14.1647878914463;
        Mon, 21 Mar 2022 09:08:34 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:34 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 18/18] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Mon, 21 Mar 2022 16:38:55 +0100
Message-Id: <20220321153855.12082-19-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

Convert kpss-gcc driver Documentation to yaml. Since kpss-gcc expose a
clock add the required '#clock-cells' binding while converting it.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/arm/msm/qcom,kpss-gcc.txt        | 44 ------------
 .../bindings/arm/msm/qcom,kpss-gcc.yaml       | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
deleted file mode 100644
index e628758950e1..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: should be one of the following. The generic compatible
-			"qcom,kpss-gcc" should also be included.
-			"qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-apq8064", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-msm8974", "qcom,kpss-gcc"
-			"qcom,kpss-gcc-msm8960", "qcom,kpss-gcc"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: base address and size of the register region
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the pll parents.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "pll8_vote", "pxo".
-
-- clock-output-names:
-	Usage: required
-	Value type: <string>
-	Definition: Name of the output clock. Typically acpu_l2_aux indicating
-		    an L2 cache auxiliary clock.
-
-Example:
-
-	l2cc: clock-controller@2011000 {
-		compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
-		reg = <0x2011000 0x1000>;
-		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
-		clock-names = "pll8_vote", "pxo";
-		clock-output-names = "acpu_l2_aux";
-	};
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
new file mode 100644
index 000000000000..20ee182eb16f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Krait Processor Sub-system (KPSS) Global Clock Controller (GCC)
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Krait Processor Sub-system (KPSS) Global Clock Controller (GCC). Used
+  to control L2 mux (in the current implementation).
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,kpss-gcc-ipq8064
+          - qcom,kpss-gcc-apq8064
+          - qcom,kpss-gcc-msm8974
+          - qcom,kpss-gcc-msm8960
+      - const: qcom,kpss-gcc
+
+  reg:
+    maxItems: 1
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
+    const: acpu_l2_aux
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-output-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+
+    clock-controller@2011000 {
+      compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc";
+      reg = <0x2011000 0x1000>;
+      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
+      clock-names = "pll8_vote", "pxo";
+      clock-output-names = "acpu_l2_aux";
+      #clock-cells = <0>;
+    };
+...
+
-- 
2.34.1

