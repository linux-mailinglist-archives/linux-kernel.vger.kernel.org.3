Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DAA4D5298
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbiCJTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbiCJTvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:53 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B718C780;
        Thu, 10 Mar 2022 11:50:52 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AG4T4s003546;
        Thu, 10 Mar 2022 19:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=Mdt1O4IRk/a/5+A8KpLGCY9aJduoOznfdvjClCusL6E=;
 b=dSplmCznLIaR2gjkFXpus/BzuWZuGxp/YsgM3fUt0KSFgA4fJPL+5nrF14YAIfSCvkJb
 NYvomG/FQgGF53pJ+4mXJF3eCcpfI5w0KjGkcYRMejb3LaimO3PtrgwhLNuKJORzXSBh
 5p/iNkaDI7JCIfctikgTzXNMJfIwyYxdgzSMT8ClvvUTsjGQx5EcFWiWp2NuO2suhblz
 +hwPLKFLbpjHLieN7vg7rKP62EghWLN0HMoSW0S6PKYT9F/PL4v4LXd2d1N1R7G32+kK
 PhSxk3yoTcbXG6hnfMFnEUEXPGFnLiNJ8E7tqM8dtueypfUOtZv3RPzfGSj/GuJlSSmO 5Q== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqmhd9rtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:49 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id EB5E965;
        Thu, 10 Mar 2022 19:50:48 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] dt-bindings: arm: Add HPE GXP CPU Init
Date:   Thu, 10 Mar 2022 13:52:27 -0600
Message-Id: <20220310195229.109477-8-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: 8fkTNnu9vC__07IZNIilkBBLWjo6SPKa
X-Proofpoint-ORIG-GUID: 8fkTNnu9vC__07IZNIilkBBLWjo6SPKa
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_08,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=850 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This adds support for the hpe,gxp-cpu-init binding.
With the HPE GXP initialization it is necessary to have access to this
register for it to boot.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../cpu-enable-method/hpe,gxp-cpu-init.yaml   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml

diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml b/Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml
new file mode 100644
index 000000000000..a17c3fcc5421
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Initialize GXP CPU
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp-cpu-init
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gxp-init@cefe0010 {
+      compatible = "hpe,gxp-cpu-init";
+      reg = <0xcefe0010 0x04>;
+    };
-- 
2.17.1

