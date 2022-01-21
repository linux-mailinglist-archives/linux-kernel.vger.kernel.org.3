Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363DA4966D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiAUVED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiAUVDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D14C06173B;
        Fri, 21 Jan 2022 13:03:55 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p15so3327975ejc.7;
        Fri, 21 Jan 2022 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Fu9s/T6wtJsMWKi3wycsF6L8ty8BEzxmIHzs5XytTf8=;
        b=UX1jwwY+pGihtIh1kvKPVw/ZdUZcZfpyTR8rb75lRd/CsbyuSsUsXPC5YcfBfdQ2cm
         fGYY9yABCspA71NvyiKsXmWzlD778+1N9pGSQD86BbunEQshH1r5JwFThJKkauR0tBsK
         iUIx2homGQoZ26ESF0nXz/oq2KiqQDC85FxlTthJNCRuHhDWgKqAGha3YmPwSDV8PsL5
         fkwCek8Fv18unDLcuD05rz9fch+NW01p6+PjfeCTf/rWg/vg0SVBRrbjKxZU3V4UkT89
         3EEF1IVUfrCOKNhfLmOtvM511f2CBv+K+qiz+zX+KSUzuwJKeVxMB0onivBZy/ITW4H1
         ooFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fu9s/T6wtJsMWKi3wycsF6L8ty8BEzxmIHzs5XytTf8=;
        b=d7vptPHc+cpDDr6o9u7dDWI4pnVsFCf3e4F0iOhpioNt0fTzu9799dmoeitRXv4qRt
         zBq8WdZx8fGy3tPthJQLMWdZijVTwAbqT7UOzt23z8QJvjVrvB/CdJRtzrIcvbkZCDoF
         x5TRZfxtX7gS+xDuF0pMLSU4RyGfiTGVeknloxjwubCXhG9xPAdBH7smOv7079dyKSBh
         MzRhhwdpgcS1z3ZR3UkQuvyG5RTj7D515J3+KiNllf1n/R1SbnuwF2q5kgs99IGpe2au
         o+bNISgA+8+xKHDAI9Ij/3jnAZfGqK5G2jiFEUWvPWAXnW+TQp95rS49g8j3/daG71lP
         Swlw==
X-Gm-Message-State: AOAM533CWrEIpMKKdlMHIlsF4BWXuJvXj0dwYZE9Kg/WEUtvO4Cxx/Z9
        g/9DamqXRZOPQboJini6NOqg1NwQFWY=
X-Google-Smtp-Source: ABdhPJw1A5nL8FIEUzzZCiKPVR3xb5LxKg5hyb/8bEESHHwMO8XOnI8lLT0eysypFXe4lkb+z/UpOQ==
X-Received: by 2002:a17:906:65c8:: with SMTP id z8mr4981284ejn.727.1642799033758;
        Fri, 21 Jan 2022 13:03:53 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:53 -0800 (PST)
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
Subject: [PATCH v3 03/15] dt-bindings: clock: Document qcom,gcc-ipq8064 binding
Date:   Fri, 21 Jan 2022 22:03:28 +0100
Message-Id: <20220121210340.32362-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 .../devicetree/bindings/clock/qcom,gcc.yaml   |  3 -
 2 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
new file mode 100644
index 000000000000..fac9c10eba0b
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
+  - $ref: qcom,gcc-common.yaml#
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
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index 04745bb407be..98057ed9bfc1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -18,8 +18,6 @@ description: |
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
2.33.1

