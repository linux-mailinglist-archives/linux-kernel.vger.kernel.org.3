Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7884BADA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiBQX5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:57:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiBQX5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:57:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0F9419BF;
        Thu, 17 Feb 2022 15:57:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k1so11647549wrd.8;
        Thu, 17 Feb 2022 15:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PF/Xktp+y8WDs9emzgOxJszpKtHSj7ua4RGqvfCUZ+w=;
        b=TULljE1TxC6FJWocaG3II3RnYzTxlg1TGybQIyU5Qff+YaMBpAWAWgL+tQfNwOFO20
         LwBfSk5mOE/ZgL/slqGEFgGezqIVamLYUnJ2+z6LIUJYHPrjSWo6GhcHalBvbOdjsAB3
         +MP5dyz/TtnMBM7iANfvYAGpo5dGmIBlqSQeBWqyotDNLEjT2QbsFUSf8bf223NAUWmz
         Vw0no1fkqTzrlKb8ybO1GgObXj7ZZTcdGvUfNZ0lui9kg9iM3UfqnAlnV4cOhx7LRuqf
         tOPgd8Wwmiku+NwOCPYvk/Nogf+iXEtdoxsOHqtGU43I3eW9Ab1p0SrfzyYOClAgzaxq
         eLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PF/Xktp+y8WDs9emzgOxJszpKtHSj7ua4RGqvfCUZ+w=;
        b=tTTmsqIJm6fYI9QuMBR7MxWo2o7a1b3nRauJ/R327XKXZs91r++NVzY4lw4S5anw4H
         oX6ApXfISVDP3IqPYKAubbooexu2QjmUcfTwN1/NFhh8Hy6zbCJrTtHwpl4BHyc6GERJ
         VlPEn7AAdGbeMPEcs6CbKLvdIgPkdp3TZAwdS0C773CQicuQ1Hvi9K0ZaIY98AHjIu79
         z6aRh6H3P9JqaJSgbEBZkaP3uG8qVF9J5fajO4T/MktB8d0+VXJ/wcXUGtU5RExzW54D
         mEyIb/QIE2SwIODWH9dLCAnFmHauT5Il5a4hgJpKf0UUBnPdQREuBnEsebsDZ4cpDfKR
         nQaw==
X-Gm-Message-State: AOAM530ZVrGJoEhYJ9uB55C6JqBzDiF8jdgdLRTk4lM8f9++1tYj1Ujb
        23WNR8+a3s2xvaPfdsQ/CsNDmznt+KE=
X-Google-Smtp-Source: ABdhPJxPX02mpKTE+ojtFqc4u1V7oQhNShbKBQt8NIALjUzJ8pfzDM0MpIsXXDTNvesFpiTlQwlLjQ==
X-Received: by 2002:a5d:64aa:0:b0:1e8:59c0:93c3 with SMTP id m10-20020a5d64aa000000b001e859c093c3mr4128032wrp.173.1645142226337;
        Thu, 17 Feb 2022 15:57:06 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:05 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/16] dt-bindings: clock: Document qcom,gcc-ipq8064 binding
Date:   Fri, 18 Feb 2022 00:56:50 +0100
Message-Id: <20220217235703.26641-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
clocks. The gcc node is also used by the tsens driver, already documented,
to get the calib nvmem cells and the base reg from gcc. Use
qcom,gcc-common.yaml as a template and remove the compatible from
generic qcom,gcc.yaml

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-ipq8064.yaml      | 76 +++++++++++++++++++
 .../bindings/clock/qcom,gcc-other.yaml        |  3 -
 2 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
new file mode 100644
index 000000000000..9eb91dd22557
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on IPQ8064.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+
+properties:
+  compatible:
+    items:
+      - const: qcom,gcc-ipq8064
+      - const: syscon
+
+  clocks:
+    items:
+      - description: PXO source
+      - description: CXO source
+
+  clock-names:
+    items:
+      - const: pxo
+      - const: cxo
+
+  thermal-sensor:
+    type: object
+
+    allOf:
+      - $ref: /schemas/thermal/qcom-tsens.yaml#
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gcc: clock-controller@900000 {
+      compatible = "qcom,gcc-ipq8064", "syscon";
+      reg = <0x00900000 0x4000>;
+      clocks = <&pxo_board>, <&cxo_board>;
+      clock-names = "pxo", "cxo";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+
+      tsens: thermal-sensor {
+        compatible = "qcom,ipq8064-tsens";
+
+        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
+        nvmem-cell-names = "calib", "calib_backup";
+        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "uplow";
+
+        #qcom,sensors = <11>;
+        #thermal-sensor-cells = <1>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 2703b53150d8..ebafdef71766 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -18,8 +18,6 @@ description:
   - dt-bindings/clock/qcom,gcc-ipq4019.h
   - dt-bindings/clock/qcom,gcc-ipq6018.h
   - dt-bindings/reset/qcom,gcc-ipq6018.h
-  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
   - dt-bindings/clock/qcom,gcc-msm8939.h
   - dt-bindings/clock/qcom,gcc-msm8953.h
   - dt-bindings/reset/qcom,gcc-msm8939.h
@@ -40,7 +38,6 @@ properties:
     enum:
       - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
-      - qcom,gcc-ipq8064
       - qcom,gcc-mdm9607
       - qcom,gcc-msm8226
       - qcom,gcc-msm8660
-- 
2.34.1

