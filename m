Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EED4C1367
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiBWM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiBWM6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:58:12 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35882714E;
        Wed, 23 Feb 2022 04:57:42 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21NBvflK011773;
        Wed, 23 Feb 2022 07:57:40 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3edckssydj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 07:57:40 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 21NCvdmt021395
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 07:57:39 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 23 Feb
 2022 07:57:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 23 Feb 2022 07:57:38 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21NCvU5u025973;
        Wed, 23 Feb 2022 07:57:32 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: frequency: Add ADMV4420 doc
Date:   Wed, 23 Feb 2022 15:08:07 +0200
Message-ID: <20220223130808.13352-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7GtzbpIT1MfhuB612vJ1E27FiFwKIzNo
X-Proofpoint-GUID: 7GtzbpIT1MfhuB612vJ1E27FiFwKIzNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_05,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230074
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the ADMV4420 K band downconverter.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changes in v7:
 - Fix commit message
 .../bindings/iio/frequency/adi,admv4420.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
new file mode 100644
index 000000000000..da7fe85ec92e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,admv4420.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMV4420 K Band Downconverter
+
+maintainers:
+  - Cristian Pop <cristian.pop@analog.com>
+
+description:
+  The ADMV4420 is a highly integrated, double balanced, active
+  mixer with an integrated fractional-N synthesizer, ideally suited
+  for next generation K band satellite communications
+
+properties:
+  compatible:
+    enum:
+      - adi,admv4420
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  adi,lo-freq-khz:
+    description: LO Frequency
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  adi,ref-ext-single-ended-en:
+    description: External reference selected.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      mixer@0 {
+        compatible = "adi,admv4420";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        adi,lo-freq-khz = <16750000>;
+        adi,ref-ext-single-ended-en;
+      };
+    };
+...
-- 
2.17.1

