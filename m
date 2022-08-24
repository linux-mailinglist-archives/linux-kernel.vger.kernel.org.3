Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1300159FA96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiHXMzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiHXMzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:55:04 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8616DF96;
        Wed, 24 Aug 2022 05:55:02 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OCiL9m012738;
        Wed, 24 Aug 2022 08:54:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j5ad43vxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:54:54 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27OCsrNj040110
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Aug 2022 08:54:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Aug 2022 08:54:52 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 24 Aug 2022 08:54:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 24 Aug 2022 08:54:52 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27OCseSU004251;
        Wed, 24 Aug 2022 08:54:46 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH 1/2] bindings: iio: adc: Add max11205 documentation file
Date:   Wed, 24 Aug 2022 15:52:02 +0300
Message-ID: <20220824125203.685287-2-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824125203.685287-1-ramona.bolboaca@analog.com>
References: <20220824125203.685287-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tKnM75TFC_3XaUtwuX_csVXNPbs2PN51
X-Proofpoint-ORIG-GUID: tKnM75TFC_3XaUtwuX_csVXNPbs2PN51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_07,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 mlxscore=0 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208240049
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation file and MAINTAINERS entry for MAX11205.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
 .../bindings/iio/adc/maxim,max11205.yaml      | 65 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
new file mode 100644
index 000000000000..bddd18a44969
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max11205.yaml
@@ -0,0 +1,65 @@
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
+  The MAX11205 is an ultra-low-power (< 300FA max
+  active current), high-resolution, serial-output ADC.
+
+  https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
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
+      The regulator supply for the ADC reference voltage.
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-cpha
+  - interrupts
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        max11205@0 {
+                      compatible = "maxim,max11205a";
+                      reg = <0>;
+                      spi-max-frequency = <5000000>;
+                      spi-cpha;
+                      interrupt-parent = <&gpio>;
+                      interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
+                      vref-supply = <&max11205_vref>;
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

