Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7304B4B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbiBNJ6h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 04:58:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344967AbiBNJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:52:08 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1456735C;
        Mon, 14 Feb 2022 01:43:34 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E8sLWM021842;
        Mon, 14 Feb 2022 09:42:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e7c4dscmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21E9biYV021918;
        Mon, 14 Feb 2022 09:42:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jbjs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21E9WNfw31326704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 09:32:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F0F04203F;
        Mon, 14 Feb 2022 09:42:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFB9042045;
        Mon, 14 Feb 2022 09:42:40 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Feb 2022 09:42:40 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.60.190])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 3F91F2201DE;
        Mon, 14 Feb 2022 10:42:39 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 02/10] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
Date:   Mon, 14 Feb 2022 10:42:23 +0100
Message-Id: <20220214094231.3753686-3-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SVAXzlNXx-lcWtADIb1AJM6h38RvEX5S
X-Proofpoint-ORIG-GUID: SVAXzlNXx-lcWtADIb1AJM6h38RvEX5S
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_01,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1034 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=815 priorityscore=1501 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140058
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "interrupt" property is optional because it is only necessary for
controllers supporting DMAs (Not implemented yet in the new driver).

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 .../bindings/spi/aspeed,ast2600-fmc.yaml      | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
new file mode 100644
index 000000000000..ed71c4d86930
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/aspeed,ast2600-fmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed SMC controllers bindings
+
+maintainers:
+  - Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
+  - Cédric Le Goater <clg@kaod.org>
+
+description: |
+  This binding describes the Aspeed Static Memory Controllers (FMC and
+  SPI) of the AST2400, AST2500 and AST2600 SOCs.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-fmc
+      - aspeed,ast2600-spi
+      - aspeed,ast2500-fmc
+      - aspeed,ast2500-spi
+      - aspeed,ast2400-fmc
+      - aspeed,ast2400-spi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+patternProperties:
+  "@[0-9a-f]+":
+    type: object
+
+    properties:
+      spi-rx-bus-width:
+        enum: [1, 2, 4]
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
+    #include <dt-bindings/clock/ast2600-clock.h>
+
+    spi@1e620000 {
+        reg = < 0x1e620000 0xc4
+                0x20000000 0x10000000 >;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "aspeed,ast2600-fmc";
+        clocks = <&syscon ASPEED_CLK_AHB>;
+        status = "disabled";
+        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+        flash@0 {
+                reg = < 0 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                status = "disabled";
+        };
+        flash@1 {
+                reg = < 1 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                status = "disabled";
+        };
+        flash@2 {
+                reg = < 2 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                status = "disabled";
+        };
+    };
-- 
2.34.1

