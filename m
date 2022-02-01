Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879624A611B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiBAQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:12:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45874 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240848AbiBAQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:12:50 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211FVMX8032227;
        Tue, 1 Feb 2022 11:12:43 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dx8jbvvnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 11:12:42 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 211GCf0Y045166
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Feb 2022 11:12:41 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 1 Feb 2022 11:12:40 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 1 Feb 2022 11:12:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 1 Feb 2022 11:12:40 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 211GCWGa019228;
        Tue, 1 Feb 2022 11:12:34 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v2 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Date:   Tue, 1 Feb 2022 18:23:50 +0200
Message-ID: <20220201162351.53520-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vm1ni3cvA7FvzkoUTE-YRYnD4eucenw_
X-Proofpoint-ORIG-GUID: vm1ni3cvA7FvzkoUTE-YRYnD4eucenw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_08,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the ADMV4420 K band downconverter.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
changes in v2:
 - Fix indentation
 - Remove '|', there is no formatting to persevere
 - Add plank line before 'properties:'
 - replace '_' with '-' in property names
 .../bindings/iio/frequency/adi,admv4420.yaml  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
new file mode 100644
index 000000000000..43a27d8e5da1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
@@ -0,0 +1,54 @@
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
+    The ADMV4420 is a highly integrated, double balanced, active
+    mixer with an integrated fractional-N synthesizer, ideally suited
+    for next generation K band satellite communications
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
+  adi,lo-freq-hz:
+    description: LO Frequency
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
+      admv4420@0 {
+        compatible = "adi,admv4420";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        adi,lo-freq-hz = /bits/ 64 <16743700000>;
+        adi,ref-ext-single-ended-en;
+      };
+    };
+...
-- 
2.17.1

