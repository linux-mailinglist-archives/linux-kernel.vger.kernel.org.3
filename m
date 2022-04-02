Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1784EFEDC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353769AbiDBFO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353742AbiDBFOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:14:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20018D9AE;
        Fri,  1 Apr 2022 22:12:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k14so3935787pga.0;
        Fri, 01 Apr 2022 22:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MErvedHfDHC4lr+xkiSj1NOx3p7e7op+yy3jW2e34dI=;
        b=J1J5AyiKM1mnABNbsSad47zaxB3zki9ezzHOrLKCltEqxoW3hiCTrs5YvkV8RVA+Uv
         e4JIscypTiH3roW18PET81j5+hZintrUhxB1rxn7GwYHKEI31mhiGXe8EexttDM2Ugrz
         XEDe9Wb0YKpgZ0JEj8MPkk/wuQ8HLKHQsS4HHNnzyyn63botdv4cmxK0HE06Q7cUiJvq
         kWHpBBa6Dw6oexF5hbnspAStjULllvspFVCQakGeigEMUnGM1XswmrxAxLaC+4+uCUDv
         QBPdWnxXQ0n9mVg1YRC38/bsHThuNTEcXQaZR86viR0bp1InRTDIZ4OjYR5jvwWFfv7S
         OHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MErvedHfDHC4lr+xkiSj1NOx3p7e7op+yy3jW2e34dI=;
        b=Ftr1pzHQBvKivg5yDv75CFNjCxzG0w1M+klIiLUwkLOKyMv8uAVKkakz3+O5Q7ztWC
         bRoA2+mXjfGwpVEI+Kb6pRpiAHi0KowJ+Kr32gvBH9QGHfGpQDwMgQZ1Hi9/q+Pv8+4I
         QdS7ibOxYdlKa8AjlBqTROseBHwPz4M5kGkn50NQ7skHFfQnGmHSbSe2LHbQf9xOSXfZ
         WsSgZRFxEOp2EiLE/+K1ED9EbxgIDK54kK7nXZgS19v/8j14ibPjOQx7908BlpRIAnPx
         k0lUi+/6uYnnbq1ezjxDXW6m7ff5qx3QsoFoI7z/R1+U/vqOrwoXBLta2B6ZtUzybCh4
         w52Q==
X-Gm-Message-State: AOAM531DkMnf7kDh5nOVy/v80iK9iOwPyIEiIwZcu4d+Ju0PZW/LNau7
        QEMz+GRRlQnYo0X+Hd2Sy48bSaXmbiI=
X-Google-Smtp-Source: ABdhPJwpo0SffUyF7/y1s+uJHNxuHjfDEdKm7Wa4JaOVgyke1VERVUw5eEsf7qWr+462HzK6oFNRFA==
X-Received: by 2002:a63:d149:0:b0:384:b288:8704 with SMTP id c9-20020a63d149000000b00384b2888704mr17416252pgj.112.1648876343770;
        Fri, 01 Apr 2022 22:12:23 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm3834721pgo.6.2022.04.01.22.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 22:12:23 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: serial: Update Qualcomm geni based QUP uart bindings
Date:   Sat,  2 Apr 2022 10:42:04 +0530
Message-Id: <20220402051206.6115-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
References: <20220402051206.6115-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to i2c controller, move geni based QUP uart controller bindings
out from parent schema to an individual binding and let parent refer to
child schema later on. Uart bindings also stand incomplete right now
similar to i2c, complete it along this process.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 .../serial/qcom,serial-geni-qcom.yaml         | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml

diff --git a/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
new file mode 100644
index 000000000000..717b0909280a
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/qcom,serial-geni-qcom.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/serial/qcom,serial-geni-qcom.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Geni based QUP UART interface
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,geni-uart
+      - qcom,geni-debug-uart
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: se
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: qup-core
+      - const: qup-config
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: UART core irq
+      - description: Wakeup irq (RX GPIO)
+
+  operating-points-v2: true
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+    #include <dt-bindings/interconnect/qcom,sc7180.h>
+
+    serial@a88000 {
+        compatible = "qcom,geni-uart";
+        reg = <0xa88000 0x7000>;
+        interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "se";
+        clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+        pinctrl-0 = <&qup_uart0_default>;
+        pinctrl-names = "default";
+        interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+                        <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
+        interconnect-names = "qup-core", "qup-config";
+    };
+...
-- 
2.25.1

