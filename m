Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438564B8FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiBPSMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:12:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiBPSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:12:47 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B622BB1500;
        Wed, 16 Feb 2022 10:12:34 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GGLWm2004026;
        Wed, 16 Feb 2022 18:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=NBgEHXwEt9kr7YR2IGB06wDWw+4uN7Knz3OdbAzGQNU=;
 b=gPyd6cxJFCe6rNWfQ8RtEzU5m0yKMuhBRuChOTA1AA2FDmWSVWxzTlY29c64AjAX7AHR
 fqjAtkZ/10INywDHUjRbJt2wms/mabWV/u5Hi7XdAS6xpQohreleroxngdlLMTJTjakO
 PulSVf4CiIWN+t6k/Zvi12GXr7TfMHo4itHqZuKv9C9TVHHtQ7m8lmyc1h/0Hu3mPUs6
 Wh1SoeK2gb+j7f7YJPQDD5Av5k/HxxF/Pd8N5Eue+HrVZyAe3dvjBqqP0JIL3Z0fIZ2A
 HckXbbENAEr0DZR8q/0aBRwlJg2X5SHdWm8v4flJauKhS/APRSeyTxxdwinbkr9wXQ21 bw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3e913au2xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 18:12:32 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 8B8E759;
        Wed, 16 Feb 2022 18:12:31 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: Add HPE GXP SOC binding
Date:   Wed, 16 Feb 2022 12:14:33 -0600
Message-Id: <20220216181434.41682-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <nick.hawkins@hpe.com>
References: <nick.hawkins@hpe.com>
X-Proofpoint-GUID: 4i1ys5oYK1241Devbaf3Admaxhel6jB9
X-Proofpoint-ORIG-GUID: 4i1ys5oYK1241Devbaf3Admaxhel6jB9
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_08,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160102
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Description: This binding will be used in creating the HPE GXP
 architecture. GXP is the name of the HPE SoC.
This SoC is used to implement BMC features of HPE servers
(all ProLiant, Synergy, and many Apollo, and Superdome machines)
It does support many features including:
        ARMv7 architecture, and it is based on a Cortex A9 core
        Use an AXI bus to which
                a memory controller is attached, as well as
                 multiple SPI interfaces to connect boot flash,
                 and ROM flash, a 10/100/1000 Mac engine which
                 supports SGMII (2 ports) and RMII
                Multiple I2C engines to drive connectivity with a
				 host infrastructure
                A video engine which support VGA and DP, as well as
                 an hardware video encoder
                Multiple PCIe ports
                A PECI interface, and LPC eSPI
                Multiple UART for debug purpose, and Virtual UART for
                 host connectivity
                A GPIO engine.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../devicetree/bindings/soc/hpe/gxp.yaml      | 35 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/hpe/gxp.yaml

diff --git a/Documentation/devicetree/bindings/soc/hpe/gxp.yaml b/Documentation/devicetree/bindings/soc/hpe/gxp.yaml
new file mode 100644
index 000000000000..8690c1e28ed2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/hpe/gxp.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/hpe/gxp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE bmc GXP SoC driver
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    gxp {
+        model = "Hewlett Packard Enterprise GXP BMC";
+        compatible = "hpe,gxp";
+        #address-cells: 1;
+        #size-cells: 0;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..e482386bb248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8385,6 +8385,12 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GXP ARCHITECTURE
+M:	Jean-Marie Verdun <verdun@hpe.com>
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/hpe
+
 H8/300 ARCHITECTURE
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
-- 
2.17.1

