Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA675843FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 18:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiG1QOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiG1QOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 12:14:32 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D786E889;
        Thu, 28 Jul 2022 09:14:16 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SG4OmH010752;
        Thu, 28 Jul 2022 16:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=VQFmGVeO8SEO5GJoTRngkqsAp2Qimurswup3W5FPokY=;
 b=iVErPSmHCjquawyzyejVUJP6yDubyc7uGfB5NGsUkjZqobs282eAFtm6PAO2ggT3Q7lb
 gYzOMBysnZBORhENxsEULFMR6VRYj/gcEiMoruiDVKcX5eiSz4QkYPF9wHKMlLiOgz3y
 E8QQ8vy5G90lgqsa724aN6IGGEv5jYyH2kj33ChzFPNY9fZzsAnKE6h1MIIoJ3W5Ah94
 lNi8eU4qqxaJDsneSy7sQL3v9Bz2lmaCLZKMT1DkfOfW4logColKciu/ymItem5acAXg
 kwreRN52CLjlD6udUvOrbv255afYtqGR7XhjHUHZWxhJAL0/BcHxMACyvONPNUsdeLgF Vw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hkvg00tc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 16:13:54 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7385F8001AD;
        Thu, 28 Jul 2022 16:13:53 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id E3BED8041E9;
        Thu, 28 Jul 2022 16:13:52 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de
Subject: [PATCH v6 2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
Date:   Thu, 28 Jul 2022 11:14:56 -0500
Message-Id: <20220728161459.7738-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220728161459.7738-1-nick.hawkins@hpe.com>
References: <20220728161459.7738-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: U8oZZ-KbcUYZIIGHO2A09iC4IcmnEPtg
X-Proofpoint-ORIG-GUID: U8oZZ-KbcUYZIIGHO2A09iC4IcmnEPtg
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=733
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280073
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Create documentation for the hpe,gxp-spifi binding to support access to
the SPI parts

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v6:
 *Remove blank line between tags in commit description
v5:
 *No change, add Krzysztof review from previous version
v4:
 *Remove uneccessary quotes
v3:
 *Fix indentation
v2:
 *Removed extra space around < > for reg
 *Changed interrupt-parrent to interrupt-parent
---
 .../bindings/spi/hpe,gxp-spifi.yaml           | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml

diff --git a/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
new file mode 100644
index 000000000000..7797c3123b7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/hpe,gxp-spifi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP spi controller flash interface
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: hpe,gxp-spifi
+
+  reg:
+    items:
+      - description: cfg registers
+      - description: data registers
+      - description: mapped memory
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    spi@200 {
+      compatible = "hpe,gxp-spifi";
+      reg = <0x200 0x80>, <0xc000 0x100>, <0x38000000 0x800000>;
+      interrupts = <20>;
+      interrupt-parent = <&vic0>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      flash@0 {
+        reg = <0>;
+        compatible = "jedec,spi-nor";
+      };
+
+      flash@1 {
+        reg = <1>;
+        compatible = "jedec,spi-nor";
+      };
+    };
-- 
2.17.1

