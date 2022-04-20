Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09885508B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355558AbiDTPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379900AbiDTPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:46 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D16176;
        Wed, 20 Apr 2022 07:59:59 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KEX80G009745;
        Wed, 20 Apr 2022 14:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=2AVoIDcJeFuQ5xIrTyKH31H/gdp/otBvvdy7T/5QB4k=;
 b=f/Wu0m9hX6BsX8mumuLJnPz7Ooa6YQLZeIWSkR02R/zjDv1YXHDxDnU/8uiVzVvsJs2v
 0oUiHsMN9h3i5Kb3r/TZPRpTeIS0nEZPivEZmYgF7o3m32PALYFvkhmw99HSrssrkQEM
 b+IKSHwh1Zp5/4mYlc7i+C09QT5sK6OqnN3e0jQkMRYUcb2DXNp1Rz4QBbgy8VtptJPH
 80AjuYIw/KeruXrFbqvR/5bpm4KFYMptwkctlrh3mBuM/WUgLOK9IObzs0w9A4Y+hu7q
 DRYBAc6sS8qmmOOoGTwbCIUGUVMSQDjXLuI8OaMKVThGLQHLpXQEhzs2MpfXdcIGEab6 Yg== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjbhjd7fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:54 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id E537481;
        Wed, 20 Apr 2022 14:59:53 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id A6FF537;
        Wed, 20 Apr 2022 14:59:53 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] dt-bindings: arm: Add HPE GXP Binding
Date:   Wed, 20 Apr 2022 10:01:51 -0500
Message-Id: <20220420150156.47405-7-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420150156.47405-1-nick.hawkins@hpe.com>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: konGJ45vu20-aTiHw3lqPojT4ymtgleH
X-Proofpoint-ORIG-GUID: konGJ45vu20-aTiHw3lqPojT4ymtgleH
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=923
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v4:
*Removed gxp.yaml
*Created hpe,gxp.yaml based on reviewer input
---
 .../devicetree/bindings/arm/hpe,gxp.yaml      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hpe,gxp.yaml

diff --git a/Documentation/devicetree/bindings/arm/hpe,gxp.yaml b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
new file mode 100644
index 000000000000..f896fc602d64
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hpe,gxp.yaml#
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

