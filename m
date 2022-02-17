Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1A84BA1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241351AbiBQNwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:52:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiBQNw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:52:26 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9992A729;
        Thu, 17 Feb 2022 05:52:11 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21H50AG8022425;
        Thu, 17 Feb 2022 08:52:10 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e9fu11tr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 08:52:10 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 21HDq98x050807
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 08:52:09 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 17 Feb 2022 08:52:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 17 Feb 2022 08:52:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 17 Feb 2022 08:52:07 -0500
Received: from chegbeli-l02.ad.analog.com ([10.48.65.189])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21HDppjY000640;
        Thu, 17 Feb 2022 08:52:03 -0500
From:   chegbeli <ciprian.hegbeli@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     chegbeli <ciprian.hegbeli@analog.com>
Subject: [PATCH 2/3] dt-bindings: iio: add ADE9078
Date:   Thu, 17 Feb 2022 15:51:39 +0200
Message-ID: <20220217135140.5658-3-ciprian.hegbeli@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
References: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Y1uqEXci9-G48L0g8agSIAXxXTnfi7OH
X-Proofpoint-GUID: Y1uqEXci9-G48L0g8agSIAXxXTnfi7OH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_05,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170063
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree bindings for the ADE9078

Signed-off-by: chegbeli <ciprian.hegbeli@analog.com>
---
 .../bindings/iio/meter/adi,ade9078.yaml       | 153 ++++++++++++++++++
 include/dt-bindings/iio/meter/adi,ade9078.h   |  21 +++
 2 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
 create mode 100644 include/dt-bindings/iio/meter/adi,ade9078.h

diff --git a/Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml b/Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
new file mode 100644
index 000000000000..e27d52e06e32
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/meter/adi,ade9078.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2021 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/addac/adi,ade9078.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADE9078 High Performance, Polyphase Energy Metering driver
+
+mainterners:
+  -Ciprian Hegbeli <ciprian.hegbeli@analog.com>
+
+description: |
+  The ADE9078 1 is a highly accurate, fully integrated energy
+  metering device. Interfacing with both current transformer
+  (CT) and Rogowski coil sensors, the ADE9078 enables users to
+  develop a 3-phase metrology platform, which achieves high
+  performance for Class 1 up to Class 0.2 meters.
+
+properties:
+  compatible:
+    enum:
+      - adi,ade9078
+
+    reg:
+      maxItems: 1
+
+    '#address-cells':
+      const: 1
+
+    '#size-cells':
+      const: 0
+
+    spi-max-frequency:
+      maximum: 1000000
+
+    interrupts:
+      maxItems: 2
+
+    reset-gpios:
+      description: |
+        Must be the device tree identifier of the RESET pin. As the line is
+        active low, it should be marked GPIO_ACTIVE_LOW.
+      maxItems: 1
+
+    interrupt-names:
+      description: |
+        Names to be attributed to the interrupts of the device. Should be "irq0"
+        or "irq1"
+
+    adi,wf-cap-sel:
+      description: |
+        This bit selects whether the waveform buffer is filled with resampled
+        data or fixed data rate data
+        0 - WF_RESAMPLED_DATA
+        1 - WF_FIXED_DATA_RATE
+      maxItems: 1
+      minimum: 0
+      maximum: 1
+
+    adi,wf-mode:
+      description: |
+        Fixed data rate waveforms filling and trigger based modes.
+        0 - WFB_FULL_MODE (Stop when waveform buffer is full)
+        1 - WFB_EN_TRIG_MODE (Continuous fill—stop only on enabled trigger events)
+        2 - WFB_CENTER_EN_TRIG_MODE (Continuous filling—center capture around enabled trigger events)
+        3 - WFB_SVAE_EN_TRIG_MODE (Continuous fill—save event address of enabled trigger events)
+      maxItems: 1
+      minimum: 0
+      maximum: 3
+
+    adi,wf-src:
+      description: |
+        Waveform buffer source and DREADY, data ready update rate, selection.
+        0 - WFB_SRC_SINC4 (Sinc4 output, at 16 kSPS)
+        1 - Reserved
+        2 - WFB_SRC_SINC4_IIR_LPF (Sinc4 + IIR LPF output, at 4 kSPS)
+        3 - WFB_SRC_DSP (Current and voltage channel waveform samples,processed by the DSP
+            (xI_PCF, xV_PCF) at 4 kSPS)
+      maxItems: 1
+      minimum: 0
+      maximum: 3
+
+    adi,wf-in-en:
+      description: |
+        This setting determines whether the IN waveform samples are read out of
+        the waveform buffer through SPI.
+        0 - WFB_IN_DISABLE
+        1 - WFB_IN_EN
+      maxItems: 1
+      minimum: 0
+      maximum: 1
+
+  required:
+    - compatible
+    - reg
+    - reset-gpios
+    - interrupts
+    - interrupt-names
+    - adi,wf-cap-sel
+    - adi,wf-mode
+    - adi,wf-src
+    - adi,wf-in-en
+
+patternProperties:
+  "^phase@[0-3]$":
+    type: object
+    description: |
+      Represents the external phases which are externally connected. Each phase
+      has a current, voltage and power component
+
+    properties:
+      reg:
+        description: |
+          The phase represented by a number
+          0 - Phase A
+          1 - unused
+          2 - Phase B
+          3 - unused
+          4 - Phase C
+        maxItems: 1
+        minimum: 0
+        maximum: 4
+
+    required:
+      - reg
+
+examples:
+  - |
+    ade9078@0 {
+	compatible = "adi,ade9078";
+	reg = <0>;
+	spi-max-frequency = <7000000>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+	interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>;
+	interrupt-names = "irq0", "irq1";
+	interrupt-parent = <&gpio>;
+
+	adi,wf-cap-sel = <WF_FIXED_DATA_RATE>;
+	adi,wf-mode = <WFB_FULL_MODE>;
+	adi,wf-src = <WFB_SRC_DSP>;
+	adi,wf-in-en = <WFB_IN_DISABLE>;
+
+	phase@0 {
+	    reg = <0>;
+	};
+	phase@1 {
+	    reg = <4>;
+	};
+    };
diff --git a/include/dt-bindings/iio/meter/adi,ade9078.h b/include/dt-bindings/iio/meter/adi,ade9078.h
new file mode 100644
index 000000000000..85004251a36b
--- /dev/null
+++ b/include/dt-bindings/iio/meter/adi,ade9078.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_ADI_ADE9078_H
+#define _DT_BINDINGS_ADI_ADE9078_H
+
+#define WF_RESAMPLED_DATA	0x0
+#define WF_FIXED_DATA_RATE	0x1
+
+#define WFB_FULL_MODE		0x0
+#define WFB_EN_TRIG_MODE	0x1
+#define WFB_CENTER_EN_TRIG_MODE	0x2
+#define WFB_SVAE_EN_TRIG_MODE	0x3
+
+#define WFB_SRC_SINC4		0x0
+#define WFB_SRC_SINC4_IIR_LPF	0x2
+#define WFB_SRC_DSP		0x3
+
+#define WFB_IN_DISABLE		0x0
+#define WFB_IN_EN		0x1
+
+#endif /* _DT_BINDINGS_ADI_ADE9078_H */
-- 
2.34.1

