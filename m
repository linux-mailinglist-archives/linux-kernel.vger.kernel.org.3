Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B780A4C1241
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiBWMDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbiBWMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:03:28 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6359AD9B;
        Wed, 23 Feb 2022 04:02:50 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21NC2OD4012124;
        Wed, 23 Feb 2022 07:02:46 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3edckssseb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 07:02:46 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 21NC2jrE019347
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 07:02:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 23 Feb
 2022 07:02:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 23 Feb 2022 07:02:44 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.126])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21NC2Y1a023695;
        Wed, 23 Feb 2022 07:02:36 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v6 1/3] dt-bindings: iio: amplifiers: add ada4250 doc
Date:   Wed, 23 Feb 2022 14:01:10 +0200
Message-ID: <20220223120112.8067-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 6wK6zHBltNCxB1HUYmjdybjYX_e6gJCN
X-Proofpoint-GUID: 6wK6zHBltNCxB1HUYmjdybjYX_e6gJCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_04,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=781 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230067
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the ADA4250 driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
changes in v6:
 - add space before `{` in the amplifier node example
 .../bindings/iio/amplifiers/adi,ada4250.yaml  | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
new file mode 100644
index 000000000000..5277479be382
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,ada4250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADA4250 Programmable Gain Instrumentation Amplifier
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  Precision Low Power, 110kHz, 26uA, Programmable Gain Instrumentation Amplifier.
+
+properties:
+  compatible:
+    enum:
+      - adi,ada4250
+
+  reg:
+    maxItems: 1
+
+  avdd-supply: true
+
+  adi,refbuf-enable:
+    description:
+      Enable internal buffer to drive the reference pin.
+    type: boolean
+
+  spi-max-frequency: true
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      amplifier@0 {
+        compatible = "adi,ada4250";
+        reg = <0>;
+        avdd-supply = <&avdd>;
+      };
+    };
+...
-- 
2.35.1

