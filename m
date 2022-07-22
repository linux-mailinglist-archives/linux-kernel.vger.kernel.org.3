Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410D57E913
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiGVVsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiGVVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:48:26 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5356B5C82;
        Fri, 22 Jul 2022 14:48:24 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MLW3CB031786;
        Fri, 22 Jul 2022 21:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=C8v1r8RH08o7aWF4yxdcXrkdfup/54bNUUwMvrHULJ4=;
 b=g68yuMonhGjW3iQA74ecHbb3jcNkNTt4f2E1NVxcUT8iGdVg1C4l0RIWJIt0e/WgPzVd
 BwABtV09NP7FI1/mImH2JQ5HJfPYFfEBMEKTBRZdsEOXSEqjznGZ+/5jA+/URVhFRqY0
 K+C+u1J3joLWbuEhmLbY72Olmjvv8V0Y3JwDG0HzWXr8eD4bSOzCpesrpJqNnGN7NkS2
 7ANZrkSzjsHb3TgE+kXXvToOSJQ6JyqWQC9BayEBlg21oRvtvpGKKuuJhkdbmiO2AkNF
 iw0yytSSX8NCvxPTUREvHhoUCay5oypH3l/1qMHxauGHFJSQr0EqYIqQqRSw3bkYx7vg VA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hft5w4mtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 21:48:08 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 76155132D9;
        Fri, 22 Jul 2022 21:48:07 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E79F98032AD;
        Fri, 22 Jul 2022 21:48:06 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v3 2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
Date:   Fri, 22 Jul 2022 16:49:17 -0500
Message-Id: <20220722214920.40485-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722214920.40485-1-nick.hawkins@hpe.com>
References: <20220722214920.40485-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: bBVkIvcmhAu0zHolr181JwQRGAdwCWsP
X-Proofpoint-ORIG-GUID: bBVkIvcmhAu0zHolr181JwQRGAdwCWsP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=796 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220089
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Create documentation for the hpe,gxp-spifi binding to support access to
the SPI parts

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
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
index 000000000000..09b0c3fa5ec1
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
+  - $ref: "spi-controller.yaml#"
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

