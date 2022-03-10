Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD84D5299
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbiCJTwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbiCJTv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:58 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21AD199D5A;
        Thu, 10 Mar 2022 11:50:56 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AFr4Bw001432;
        Thu, 10 Mar 2022 19:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=SZx53i+eqeGI3co6VFGYV7MO2WwxuJ1mkjQXP17Pnz0=;
 b=e1NWWGnIxZ7LYMZmLv3r2DEd4E7443VMK3tF5WGH1veCoU4y/WaZ+btwkMFWoUtqMPlo
 KKV20IgspHhpwrtkYLstNUf5FJ77CDJ1vVDdr5TXRMaFoHek4Peu1vvOuRCbfVrwYih4
 BHgReraPMugh/VmX5bBIOkydgCK3yI0lQbztjAPZykhwhzjb7wwCrY0OrlRZy56Eehbk
 JMo3s8kvrfYgS4FG/k4/YM4Prn1dCE9jcIb86RyjlJYFya4itAJugCpIUtqGyCnXRWUi
 CJAytaKjkr2Z/84IE/+WeNmGagTn+ea6IyHV7uR+OagM6CIktjpLqWewtbsy7bzWox68 WA== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqa3sgd6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:47 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 1842D65;
        Thu, 10 Mar 2022 19:50:47 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/10] dt-bindings: arm: Add HPE GXP Binding
Date:   Thu, 10 Mar 2022 13:52:26 -0600
Message-Id: <20220310195229.109477-7-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: HIJRNdhy7cjK5Yx4OZkTlJuZ0wbJd_Bs
X-Proofpoint-ORIG-GUID: HIJRNdhy7cjK5Yx4OZkTlJuZ0wbJd_Bs
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_08,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100100
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

This adds support for the hpe,gxp binding. The GXP is based on
the cortex a9 processor and supports arm7.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../devicetree/bindings/arm/gxp.yaml          | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/gxp.yaml

diff --git a/Documentation/devicetree/bindings/arm/gxp.yaml b/Documentation/devicetree/bindings/arm/gxp.yaml
new file mode 100644
index 000000000000..edfd331c493e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/gxp.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/gxp.yaml#
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
+required:
+  - compatible
+
+additionalProperties: true
+
+examples:
+  - |
+      / {
+          model = "Hewlett Packard Enterprise GXP BMC";
+          compatible = "hpe,gxp";
+          #address-cells = <1>;
+          #size-cells = <1>;
+          cpus {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              CPU0: cpu@0 {
+                  compatible = "arm,cortex-a9";
+                  device_type = "cpu";
+                  reg = <0>;
+              };
+          };
+
+          memory@40000000 {
+            device_type = "memory";
+            reg = <0x40000000 0x20000000>;
+          };
+
+          ahb {
+
+          };
+      };
+
+...
-- 
2.17.1

