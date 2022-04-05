Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF044F47DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbiDEVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442176AbiDEPhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:37:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E510FED9EE;
        Tue,  5 Apr 2022 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649166679; x=1680702679;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pgj7ZOhRJ/NrgOQpzcRmQAbblsKAlRLHGZGqyonC/0Y=;
  b=I/j8bbueLFse1K0gOKhPBU60uytgih4dbMJOg8jyrv4zwkhm4t7yFEvw
   0mzsJUm0ivYcuXmQtRO+i20zXkEnHDtAHCd0Le7CaQsi+53c9wOpH6NfT
   0NVjhxbbLYpaCTuZsDJ5cy63i7s49NPNh31GbI9HBV0IwdRwmybN1OpU5
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Apr 2022 06:51:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 06:51:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:19 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Apr 2022 06:51:14 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V9 2/6] dt-bindings: mfd: pm8008: Add pm8008 regulator bindings
Date:   Tue, 5 Apr 2022 19:20:29 +0530
Message-ID: <1649166633-25872-3-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for pm8008 regulators device.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V8:
 - This is split from pm8008.yaml binding.

Changes in V9:
 - Remove description for reg and drop unused phandle from example.

 .../bindings/mfd/qcom,pm8008-regulators.yaml       | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
new file mode 100644
index 0000000..9a82a8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008-regulators.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/qcom,pm8008-regulators.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. PM8008 Regulator bindings
+
+maintainers:
+  - Satya Priya <quic_c_skakit@quicinc.com>
+
+description: |
+  Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
+  containing 7 LDO regulators. This binding specifies the PM8008
+  regulator peripherals of PM8008 device.
+
+properties:
+  compatible:
+    const: qcom,pm8008-regulators
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 0
+
+  "#size-cells":
+    const: 0
+
+  vdd_l1_l2-supply:
+    description: Input supply phandle of ldo1 and ldo2 regulators.
+
+  vdd_l3_l4-supply:
+    description: Input supply phandle of ldo3 and ldo4 regulators.
+
+  vdd_l5-supply:
+    description: Input supply phandle of ldo5 regulator.
+
+  vdd_l6-supply:
+    description: Input supply phandle of ldo6 regulator.
+
+  vdd_l7-supply:
+    description: Input supply phandle of ldo7 regulator.
+
+patternProperties:
+  "^ldo[1-7]$":
+    type: object
+    $ref: "../regulator/regulator.yaml#"
+    description: PM8008 regulator peripherals of PM8008 regulator device
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/mfd/qcom-pm8008.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pmic@9 {
+        compatible = "qcom,pm8008-regulators";
+        reg = <0x9>;
+        #address-cells = <0>;
+        #size-cells = <0>;
+
+        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
+        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
+        vdd_l5-supply = <&vreg_bob>;
+        vdd_l6-supply = <&vreg_bob>;
+        vdd_l7-supply = <&vreg_bob>;
+
+        pm8008_l1: ldo1 {
+          regulator-name = "pm8008_l1";
+          regulator-min-microvolt = <950000>;
+          regulator-max-microvolt = <1300000>;
+        };
+      };
+    };
+...
-- 
2.7.4

