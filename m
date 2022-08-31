Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E1E5A7EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiHaNbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:30:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D4C04CC;
        Wed, 31 Aug 2022 06:30:51 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VCNCuG026265;
        Wed, 31 Aug 2022 09:30:44 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7d48kxj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 09:30:44 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27VDUgUa021322
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Aug 2022 09:30:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 31 Aug
 2022 09:30:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 31 Aug 2022 09:30:41 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.113])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27VDUTRF019685;
        Wed, 31 Aug 2022 09:30:32 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH v2 1/2] bindings: iio: adc: Add max11205 documentation file
Date:   Wed, 31 Aug 2022 16:30:20 +0300
Message-ID: <20220831133021.215625-1-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: wI204ToU81DzyZbPbV5CL3VT19ZzNk-v
X-Proofpoint-ORIG-GUID: wI204ToU81DzyZbPbV5CL3VT19ZzNk-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310068
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation file and MAINTAINERS entry for MAX11205.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
changes in v2:
 - reference /schemas/spi/spi-peripheral-props.yaml in allOf 
 - use unevaluatedProperties:false and remove additionalProperties:false
 - use generic node name and fix indentation in device-tree example
 - wrap lines nearer to 75-80 chars in documentation
 - add extra information to the description of the regulator
 .../bindings/iio/adc/maxim,max11205.yaml      | 69 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
new file mode 100644
index 000000000000..7902f82da927
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max11205.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX11205 ADC
+
+maintainers:
+  - Ramona Bolboaca <ramona.bolboaca@analog.com>
+
+description: |
+  The MAX11205 is an ultra-low-power (< 300FA max active current),
+  high-resolution, serial-output ADC.
+
+  https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max11205a
+      - maxim,max11205b
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  spi-cpha: true
+
+  vref-supply:
+    description:
+      The regulator supply for the ADC reference voltage. This is a differential
+      reference. It is equal to the V_REFP - V_REFN. The maximum value is 3.6V.
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-cpha
+  - interrupts
+  - vref-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "maxim,max11205a";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpha;
+            interrupt-parent = <&gpio>;
+            interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+            vref-supply = <&max11205_vref>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 96f47a7865d6..db1b5dc03988 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12341,6 +12341,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
 F:	drivers/iio/proximity/mb1232.c
 
+MAXIM MAX11205 DRIVER
+M:	Ramona Bolboaca <ramona.bolboaca@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
+F:	drivers/iio/adc/max11205.c
+
 MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
 R:	Iskren Chernev <iskren.chernev@gmail.com>
 R:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
-- 
2.25.1

