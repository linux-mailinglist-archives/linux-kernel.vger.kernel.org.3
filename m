Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA84B515D53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382675AbiD3NNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382659AbiD3NNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:13:13 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F31482D02;
        Sat, 30 Apr 2022 06:09:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p18so11896552edr.7;
        Sat, 30 Apr 2022 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3P6gFLiLHpQOXPwOnJdtu8LsXK946l+L0SXzplHXgp8=;
        b=A2zQVsk6TsPWFFnKRLzrD/HI3vGHQL6AVekVCNp500SknGG8SJwz7kyiJrvA19EShI
         BNLPMmTKIeNYoM41oByYLvde4UGaWMc2tYI4swETHVbaT+110s4N2rW4HtT0AkQqwgcg
         6g4P2bCl4tWQf3CHllg+3VcNxxdsEKJuUGSWm/3lrydS56ig/rf1Z/h7qjdfsfu68zv3
         wwNUX8OSrEuZa5pgRoqW9YsfimCitya3OdMFujgs9WeaPLqRgpWQRsOYk8qrH/WzaxbH
         eWZ2WTaKxAFrS4PQquJe2V2vvHteqNqF7y1hJGibl08BKdS0sADiZicXmAclcH2bgZnu
         qQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3P6gFLiLHpQOXPwOnJdtu8LsXK946l+L0SXzplHXgp8=;
        b=bm1LRLhmXFWousbf4UyBf/BrjS4mPuFx+42eo0+sglVyXUQCC685O5eYYaXvHPhF4a
         iLRbhl/+Mt0cHueRYoEVjytCUdMPSFForGZp9t0mr7xSYZonHD+ldRjXE5aGPc1X7gYc
         Y3lbOzRWkJdbjogSzooMWlszoeYQTv3XT1AsH19OLvc7ruuXMBKIoJu8wB8LljTovJW5
         0R28F6fR1sXd6gwFMmV1ZnYk3HIWKhpEoQBkYKBm9wo+xgBoNntxqWLjMI1cOGQQjhcv
         9Yz/cwQL4X2DPFtj9djyKifDMmUZwf6TBz/fhiddDBY91S6ODWnDNB8RiDxvuY3BseWO
         iarA==
X-Gm-Message-State: AOAM531JN4hG6jZ6QRHVM+hIT5SsCPssh+qpSTBoksRUWAzBdnhIQd1m
        fG4rvvUr8Zp2DkFrE+jqh6A=
X-Google-Smtp-Source: ABdhPJx2qDGExsPDlSuKlEw7Cpu8Sx2qH4tTWnvkjIQ9BFGSbprqbq1Qr0JkUcxBM7IZ2RjZDFTROg==
X-Received: by 2002:aa7:c49a:0:b0:425:d526:98ad with SMTP id m26-20020aa7c49a000000b00425d52698admr4312411edq.352.1651324189976;
        Sat, 30 Apr 2022 06:09:49 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u5-20020a056402064500b0042617ba63a0sm4142404edx.42.2022.04.30.06.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:09:49 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: arm: msm: Convert kpss-gcc driver Documentation to yaml
Date:   Sat, 30 Apr 2022 08:01:25 +0200
Message-Id: <20220430060125.9124-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430060125.9124-1-ansuelsmth@gmail.com>
References: <20220430060125.9124-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kpss-gcc driver Documentation to yaml.
Add #clock-cells additional binding to required bindings and example
as it's a required binding for clock-output-names.

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

