Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0914C4A3FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358053AbiAaKCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:02:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5998 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348337AbiAaKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:02:21 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20V4E1Bj000351;
        Mon, 31 Jan 2022 05:02:18 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dx8jbrkjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 05:02:18 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20VA2HV4023784
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jan 2022 05:02:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 31 Jan
 2022 05:02:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 31 Jan 2022 05:02:16 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20VA26eO009375;
        Mon, 31 Jan 2022 05:02:12 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 2/4] dt-bindings:iio:frequency: add admv1014 binding
Date:   Mon, 31 Jan 2022 12:01:00 +0200
Message-ID: <20220131100102.15372-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220131100102.15372-1-antoniu.miclaus@analog.com>
References: <20220131100102.15372-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zJk93oJQ7PAHo05IQaIl_aU-jaceU2Nt
X-Proofpoint-ORIG-GUID: zJk93oJQ7PAHo05IQaIl_aU-jaceU2Nt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_02,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the ADMV1014 Upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 .../bindings/iio/frequency/adi,admv1014.yaml  | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
new file mode 100644
index 000000000000..fe352c01dd94
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,admv1014.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMV1014 Microwave Downconverter
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   Wideband, microwave downconverter optimized for point to point microwave
+   radio designs operating in the 24 GHz to 44 GHz frequency range.
+
+   https://www.analog.com/en/products/admv1014.html
+
+properties:
+  compatible:
+    enum:
+      - adi,admv1014
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: lo_in
+    description:
+      External clock that provides the Local Oscilator input.
+
+  vcm-supply:
+    description:
+      Common-mode voltage regulator.
+
+  vcc-if-bb-supply:
+    description:
+      BB and IF supply voltage regulator.
+
+  vcc-vga-supply:
+    description:
+      RF Amplifier supply voltage regulator.
+
+  vcc-vva-supply:
+    description:
+      VVA Control Circuit supply voltage regulator.
+
+  vcc-lna-3p3-supply:
+    description:
+      Low Noise Amplifier 3.3V supply voltage regulator.
+
+  vcc-lna-1p5-supply:
+    description:
+      Low Noise Amplifier 1.5V supply voltage regulator.
+
+  vcc-bg-supply:
+    description:
+      Band Gap Circuit supply voltage regulator.
+
+  vcc-quad-supply:
+    description:
+      Quadruple supply voltage regulator.
+
+  vcc-mixer-supply:
+    description:
+      Mixer supply voltage regulator.
+
+  adi,input-mode:
+    description:
+      Select the input mode.
+      iq - in-phase quadrature (I/Q) input
+      if - complex intermediate frequency (IF) input
+    enum: [iq, if]
+
+  adi,detector-enable:
+    description:
+      Digital Rx Detector Enable. The Square Law Detector output is
+      available at output pin VDET.
+    type: boolean
+
+  adi,p1db-compensation-enable:
+    description:
+      Turn on bits to optimize P1dB.
+    type: boolean
+
+  adi,quad-se-mode:
+    description:
+      Switch the LO path from differential to single-ended operation.
+      se-neg - Single-Ended Mode, Negative Side Disabled.
+      se-pos - Single-Ended Mode, Positive Side Disabled.
+      diff - Differential Mode.
+    enum: [se-neg, se-pos, diff]
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vcm-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      admv1014@0{
+        compatible = "adi,admv1014";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        clocks = <&admv1014_lo>;
+        clock-names = "lo_in";
+        vcm-supply = <&vcm>;
+        vcc-if-bb-supply = <&vcc_if_bb>;
+        vcc-vga-supply = <&vcc_vga>;
+        vcc-vva-supply = <&vcc_vva>;
+        vcc-lna-3p3-supply = <&vcc_lna_3p3>;
+        vcc-lna-1p5-supply = <&vcc_lna_1p5>;
+        vcc-bg-supply = <&vcc_bg>;
+        vcc-quad-supply = <&vcc_quad>;
+        vcc-mixer-supply = <&vcc_mixer>;
+        adi,quad-se-mode = "diff";
+        adi,detector-enable;
+        adi,p1db-compensation-enable;
+      };
+    };
+...
-- 
2.35.0

