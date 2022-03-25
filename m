Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5BA4E70DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358748AbiCYKMD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Mar 2022 06:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358704AbiCYKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:11:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945457494;
        Fri, 25 Mar 2022 03:09:53 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PA28NN016760;
        Fri, 25 Mar 2022 10:09:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f0t9e4w47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:03 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22PA1hnr014611;
        Fri, 25 Mar 2022 10:09:02 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f0t9e4w38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:02 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22P9x5b8023209;
        Fri, 25 Mar 2022 10:08:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3ew6ej333d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:08:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22PA8vmP35979620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 10:08:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58B744C044;
        Fri, 25 Mar 2022 10:08:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2B784C040;
        Fri, 25 Mar 2022 10:08:56 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 25 Mar 2022 10:08:56 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.95.248])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id EFEEE220121;
        Fri, 25 Mar 2022 11:08:54 +0100 (CET)
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
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 02/11] dt-bindings: spi: Add Aspeed SMC controllers device tree binding
Date:   Fri, 25 Mar 2022 11:08:40 +0100
Message-Id: <20220325100849.2019209-3-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325100849.2019209-1-clg@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q-27StTgKDb35ieqFiSdYeia6W_noiKn
X-Proofpoint-ORIG-GUID: kCf6gJuDrwltAHACiC67eMfQ65Vzxeh-
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1034 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250057
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
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 .../bindings/spi/aspeed,ast2600-fmc.yaml      | 87 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml

diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
new file mode 100644
index 000000000000..e16bbcd38560
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -0,0 +1,87 @@
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
+        reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "aspeed,ast2600-fmc";
+        clocks = <&syscon ASPEED_CLK_AHB>;
+        interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+        flash@0 {
+                reg = < 0 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+        flash@1 {
+                reg = < 1 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+        flash@2 {
+                reg = < 2 >;
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <50000000>;
+                spi-rx-bus-width = <2>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ea9d74b6236f..7d5f81dcd837 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3021,6 +3021,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 F:	drivers/mmc/host/sdhci-of-aspeed*
 
+ASPEED SMC SPI DRIVER
+M:	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
+M:	Cédric Le Goater <clg@kaod.org>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

