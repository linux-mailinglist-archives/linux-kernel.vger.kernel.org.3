Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14C44D529F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbiCJTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343694AbiCJTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:52:06 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB4518E3F6;
        Thu, 10 Mar 2022 11:51:04 -0800 (PST)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AG83qD001086;
        Thu, 10 Mar 2022 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=HT/Zyw2vb5zeoPXjSw9exN+E7/tncwg8EFwBwW430gQ=;
 b=Za+e/P/Y4EdZ43WBs6Pd01r/PvOUKSTsIWjq1eCeeIyetvYixsOxXS1O91L3NMdUwV0a
 /3++QbvGkh6CINhZzFWuSZiVHo/bm7B4qre0QsHvL0kZgtsmtOdGNmjkbE8VauvDpLzT
 x/4PZ0SUBmD3S28YcJkaIvHdX6osLGXjBUhm288UyvSaD4hWKxV3I2xueAYLBDi9hvvD
 +MupEhNQmno56A2rXsRePx/GHtNrNPIrd0k/XF7NJUIdJUB313KqGNH2jauBFPIIQoYe
 Yfiums4KHX2eHTPrf2BrGAX7OcGide+xgSUPeR5K0AxaugF+URB8ZCdBXLgu+Z9qJHZ5 vw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqmk3ss77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:44 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 939C265;
        Thu, 10 Mar 2022 19:50:43 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
Date:   Thu, 10 Mar 2022 13:52:25 -0600
Message-Id: <20220310195229.109477-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: NuClyLi5hTInMg_AMDnuW1R5_6e2pt91
X-Proofpoint-ORIG-GUID: NuClyLi5hTInMg_AMDnuW1R5_6e2pt91
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_08,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Add the hpe gxp watchdog timer binding hpe,gxp-wdt.
This will enable support for the HPE GXP Watchdog

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/watchdog/hpe,gxp-wdt.yaml        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
new file mode 100644
index 000000000000..6044496b4968
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/hpe,gxp-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Controlled Watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp-wdt
+
+  reg:
+    items:
+      - description: WDGRST register
+      - description: WDGCS register
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog0:  watchdog@c0000090 {
+      compatible = "hpe,gxp-wdt";
+      reg = <0xc0000090 0x02>, <0xc0000096 0x01>;
+    };
+
-- 
2.17.1

