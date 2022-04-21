Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C650A902
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389418AbiDUTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387407AbiDUTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:22:38 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A204B41D;
        Thu, 21 Apr 2022 12:19:48 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LE4WG6011421;
        Thu, 21 Apr 2022 19:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=RM8T+JZ1lTYnyzKMhfwp9W9A1cYb3C0isL/BrOjFRt4=;
 b=JUQ6CyL29M6mAzt0WksuX6NJtUFaKJJpkNAY6OD5Ns9QSjC5RK7NdPRO5PSFB5D7CTCN
 regvMTZtNJOJSLiax26y8AHiAXzr8Yn0a2FMjjk3zrLiLPBuLX74LtcFzmt/BQjzid/K
 nguyat9WIbOfKjpg4XJqamPhlfU650TgQvdkDWlLBx/iKTK7d6aMsGU8W95pL3B/VgkK
 7bEKvdQ5o8gVdXusmNNouoC0jmd0EPOQFBmupJrZuNRp+s14eVJq28I6MPBdgrpND8E7
 8T9PEKSLlf4oZ0QeZSsmwHzQ/fIKkCPtp/QcmDAPkedGk9j4W2Gl4IqgX1ruVP6E2xbZ 1Q== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fk8q2aqha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 19:19:40 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 034C261;
        Thu, 21 Apr 2022 19:19:40 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id B26924A;
        Thu, 21 Apr 2022 19:19:39 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/11] dt-bindings: arm: Add HPE GXP Binding
Date:   Thu, 21 Apr 2022 14:21:28 -0500
Message-Id: <20220421192132.109954-8-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421192132.109954-1-nick.hawkins@hpe.com>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: KmpPjNSVEXJ7yEmeLAz3S0daz0zLJqQS
X-Proofpoint-ORIG-GUID: KmpPjNSVEXJ7yEmeLAz3S0daz0zLJqQS
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_04,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
v5:
* Fix version log
v4:
* Removed gxp.yaml
* Created hpe,gxp.yaml based on reviewer input
v3:
* Created gxp.yaml
v2:
* No change
---
 .../devicetree/bindings/arm/hpe,gxp.yaml      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hpe,gxp.yaml

diff --git a/Documentation/devicetree/bindings/arm/hpe,gxp.yaml b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
new file mode 100644
index 000000000000..cd86b67ea207
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hpe,gxp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE BMC GXP SoC driver
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - hpe,gxp-dl360gen10
+      - const: hpe,gxp
+
+additionalProperties: true
+
+...
-- 
2.17.1

