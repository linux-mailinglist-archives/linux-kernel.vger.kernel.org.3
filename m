Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC5D5A800B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiHaOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiHaOXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:23:35 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D320DABF30;
        Wed, 31 Aug 2022 07:23:34 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VCXBgo023511;
        Wed, 31 Aug 2022 10:23:31 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7d48m9m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Aug 2022 10:23:31 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27VENUpO026320
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Aug 2022 10:23:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 31 Aug
 2022 10:23:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 31 Aug 2022 10:23:29 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 27VENHMm022580;
        Wed, 31 Aug 2022 10:23:19 -0400
From:   George Mois <george.mois@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lucas.p.stankus@gmail.com>, George Mois <george.mois@analog.com>
Subject: [PATCH v3 1/2] bindings: iio: accel: extend adxl313 documentation file
Date:   Wed, 31 Aug 2022 17:35:37 +0300
Message-ID: <20220831143538.65816-1-george.mois@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 6FdupHY1SRfZfOOMA7hr3pfRSdNh_LPQ
X-Proofpoint-ORIG-GUID: 6FdupHY1SRfZfOOMA7hr3pfRSdNh_LPQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_09,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310072
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the adi,adxl313.yaml file with information regrding the
ADXL312 and ADXL314 devices.

Signed-off-by: George Mois <george.mois@analog.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
no changes in v3.
 .../devicetree/bindings/iio/accel/adi,adxl313.yaml     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
index d6afc1b8c272..59d48ff1a16c 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
@@ -4,20 +4,24 @@
 $id: http://devicetree.org/schemas/iio/accel/adi,adxl313.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADXL313 3-Axis Digital Accelerometer
+title: Analog Devices ADXL312, ADXL313, and ADXL314 3-Axis Digital Accelerometers
 
 maintainers:
   - Lucas Stankus <lucas.p.stankus@gmail.com>
 
 description: |
-  Analog Devices ADXL313 3-Axis Digital Accelerometer that supports
-  both I2C & SPI interfaces.
+  Analog Devices ADXL312, ADXL313, and ADXL314 3-Axis Digital Accelerometer that
+  support both I2C & SPI interfaces.
+    https://www.analog.com/en/products/adxl312.html
     https://www.analog.com/en/products/adxl313.html
+    https://www.analog.com/en/products/adxl314.html
 
 properties:
   compatible:
     enum:
+      - adi,adxl312
       - adi,adxl313
+      - adi,adxl314
 
   reg:
     maxItems: 1
-- 
2.30.2

