Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B425C5B263C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiIHSvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiIHSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:50:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF526FDBB4;
        Thu,  8 Sep 2022 11:50:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so3407279pjh.3;
        Thu, 08 Sep 2022 11:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Iyw15Up3SGizo1zKvWpnFD/JaWyOv/VL9C9xu5PlBg4=;
        b=FWihZgI5unW37D+/4+9443N54Q8x3HgHBUIYwbH0AD11/MHM6ccXd4+kHPqMUx6+R1
         Psa5I8ixqN/2LlZu00GgGz/EzJAiUOYPQ5X9CCZFbxg0rP1LpoLY6DYTyQFBQXkVjuk7
         /PvKP377ZznZIZDPnZEnotHIT+ImZZHlae3caN2mkGrxfrZm11vQifBZq91t8nCuJyL2
         UsSNh0FOplQ8jMFQ0sGzyS5tBmFwEm30QTGaA2Uf22uo5UvdoHtj5mxeoNi2PG5kWqL6
         NUvnrH84dGJKJ2iaNmriWlwANZ7WFLHRlZdVegF7ulO9jghxDhXuznclLjL9ybyWHHSR
         EZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Iyw15Up3SGizo1zKvWpnFD/JaWyOv/VL9C9xu5PlBg4=;
        b=hDLtePBgDsefSoaJs65RsTPDg27oOgO5ziEmZImuKEqF/2IOjdLe86wBtruw6/FslN
         8TyOW+TxA0M37vsG9KJTWQHneWP9sKe8F46Gy9FgLyVeJTZ+gEPyQfiqy5j7FIATTRDr
         EetLGOQbBo+f+own1Y9DyADqhPnHFZ3WQshVi/n9X6F2U7wG1TjeoycFCBtOuBnh/va/
         9tt4RSWiekeG5yYbaw1gvG1FlykdX5MN+smI63RMaU3KzuztloVyQW3szftqElOh4Z5E
         NyuSTMJpdoAXLfnozpWtWhgLOucB146KNq03g9dsEl5JZwFZIPIpV6vgLtWkOGrUeNf1
         6Wig==
X-Gm-Message-State: ACgBeo2fXOCNVmNC3rukjBDiUgcy8npRc/JvSSjx1OM6C+YsZ86/753S
        lrT3ppxFFyL2jBmKAJoejb1L2zENJgh4XlAT
X-Google-Smtp-Source: AA6agR5VxbvdX0w3VaWBKAQWVNvWDSHx8kypoTN6YK6kADZHFbChenTqVmPjLh/34ZR3bSSsKemByQ==
X-Received: by 2002:a17:902:7b95:b0:172:9dc3:6c12 with SMTP id w21-20020a1709027b9500b001729dc36c12mr10425106pll.94.1662663056791;
        Thu, 08 Sep 2022 11:50:56 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:ce83:3779:42da:b5f7:bc9e])
        by smtp.googlemail.com with ESMTPSA id 21-20020a170902c11500b001714c36a6e7sm8746030pli.284.2022.09.08.11.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:50:56 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     bjorn.andersson@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/4] dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
Date:   Fri,  9 Sep 2022 00:19:23 +0530
Message-Id: <20220908184925.2714098-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a direct conversion of the existing txt documentation to YAML.
It is in preparation for the addition of pronto-v3 to the docs. This
patch doesn't document any of the existing subnodes/properties that are
not documented in the existing txt file. That is done in a separate
patch.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 263 ++++++++++++++++++
 1 file changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
new file mode 100644
index 000000000000..bc18139fdb91
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -0,0 +1,263 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,wcnss-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCNSS Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  This document defines the binding for a component that loads and boots
+  firmware on the Qualcomm WCNSS core.
+
+properties:
+  compatible:
+    enum:
+      - qcom,riva-pil
+      - qcom,pronto-v1-pil
+      - qcom,pronto-v2-pil
+
+  reg:
+    maxItems: 3
+    description:
+      The base address and size of the CCU, DXE and PMU register blocks
+
+  reg-names:
+    items:
+      - const: ccu
+      - const: dxe
+      - const: pmu
+
+  interrupts:
+    minItems: 2
+    maxItems: 5
+
+  interrupt-names:
+    minItems: 2
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Relative firmware image path for the WCNSS core. Defaults to
+      "wcnss.mdt".
+
+  vddpx-supply:
+    description:
+      PX regulator to be held on behalf of the booting of the WCNSS core
+
+  vddmx-supply:
+    description:
+      MX regulator to be held on behalf of the booting of the WCNSS core.
+
+  vddcx-supply:
+    description:
+      CX regulator to be held on behalf of the booting of the WCNSS core.
+
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mx
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      States used by the AP to signal the WCNSS core that it should shutdown
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output
+    items:
+      - const: stop
+
+  memory-region:
+    maxItems: 1
+    description: reserved-memory for the WCNSS core
+
+  smd-edge:
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
+    description:
+      Qualcomm Shared Memory subnode which represents communication edge,
+      channels and devices related to the ADSP.
+
+  iris:
+    type: object
+    description:
+      The iris subnode of the WCNSS PIL is used to describe the attached RF module
+      and its resource dependencies.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,wcn3620
+          - qcom,wcn3660
+          - qcom,wcn3660b
+          - qcom,wcn3680
+
+      clocks:
+        minItems: 1
+        items:
+          - description: XO clock
+          - description: RF clock
+
+      clock-names:
+        minItems: 1
+        items:
+          - const: xo
+          - const: rf
+
+      vddxo-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+      vddrfa-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+      vddpa-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+      vdddig-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+    required:
+      - compatible
+      - clocks
+      - clock-names
+      - vddxo-supply
+      - vddrfa-supply
+      - vddpa-supply
+      - vdddig-supply
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts-extended
+  - interrupt-names
+  - iris
+  - vddpx-supply
+  - memory-region
+  - smd-edge
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,riva-pil
+    then:
+      required:
+        - vddcx-supply
+        - vddmx-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pronto-v1-pil
+              - qcom,pronto-v2-pil
+    then:
+      properties:
+        vddmx-supply:
+          deprecated: true
+          description: Deprecated for qcom,pronto-v1/2-pil
+
+        vddcx-supply:
+          deprecated: true
+          description: Deprecated for qcom,pronto-v1/2-pil
+
+      required:
+        - power-domains
+        - power-domain-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    pronto@a21b000 {
+        compatible = "qcom,pronto-v2-pil";
+        reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
+        reg-names = "ccu", "dxe", "pmu";
+
+        interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+        power-domains = <&rpmpd MSM8916_VDDCX>, <&rpmpd MSM8916_VDDMX>;
+        power-domain-names = "cx", "mx";
+
+        vddpx-supply = <&pm8916_l7>;
+
+        qcom,smem-states = <&wcnss_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        memory-region = <&wcnss_region>;
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&wcnss_pin_a>;
+
+        iris {
+            compatible = "qcom,wcn3620";
+
+            clocks = <&rpmcc RPM_SMD_RF_CLK2>;
+            clock-names = "xo";
+        };
+
+        smd-edge {
+            interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
+
+            qcom,ipc = <&apcs 8 17>;
+            qcom,smd-edge = <6>;
+            qcom,remote-pid = <4>;
+
+            label = "pronto";
+
+            wcnss {
+                compatible = "qcom,wcnss";
+                qcom,smd-channels = "WCNSS_CTRL";
+
+                qcom,mmio = <&pronto>;
+
+                bt {
+                    compatible = "qcom,wcnss-bt";
+                };
+
+                wifi {
+                    compatible = "qcom,wcnss-wlan";
+
+                    interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                                 <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "tx", "rx";
+
+                    qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
+                    qcom,smem-state-names = "tx-enable", "tx-rings-empty";
+                };
+            };
+        };
+    };
-- 
2.37.2

