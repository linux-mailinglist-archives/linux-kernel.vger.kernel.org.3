Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004FC4D5296
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbiCJTwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343652AbiCJTvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:54 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF47B199D4F;
        Thu, 10 Mar 2022 11:50:52 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AFrS8g030113;
        Thu, 10 Mar 2022 19:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=gQPB1eRowvWJArtUO7a6OZAQ/oABoNMsxaUIqYwGI2o=;
 b=R+E4lakRjgJNuuuM64UkVdKp1IPOmiqPuJUKPSaUaAevLsFHcxD3pJUYD+v1COWqfc4I
 mbojYCsR1RkwP+TOaQEGUARtiOUUVfyoZtN4ADjsXP5YKW/LrrU2pFmWlWXuAXd+n/IN
 qmZ9B1RfFlYaRTyuAlRh5HyHBzkC6XJayUwOJbRfff5jOHIbaV84HKXHMlJFeAJH8XXi
 tafrAK7BWgzcw/rd7vJwxg/hvvdSbfy1L9Vs2h8VueDEY7uen8q1c45ilwQYozEE+CBb
 OzjMWfY8xDv1OuqFuCStRyPLDaETUUvKeoVWum8oaZ3lustvm5HqT9cPbun/adYo1ZHq JA== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqmarsyhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:42 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 59E2077;
        Thu, 10 Mar 2022 19:50:41 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 05/10] dt-bindings: timer: Add HPE GXP Timer Binding
Date:   Thu, 10 Mar 2022 13:52:24 -0600
Message-Id: <20220310195229.109477-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: GxTfFqPbar1nazPRQkQ7K4t26soLV8Ik
X-Proofpoint-ORIG-GUID: GxTfFqPbar1nazPRQkQ7K4t26soLV8Ik
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_08,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=753 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100100
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

Creating binding for gxp timer in device tree hpe,gxp-timer
Although there are multiple times on the SoC we are only
enabling one at this time.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

----

v2:
 *Removed maintainer change from patch
 *Verified there was no compilation errors
 *Added reference code in separate patch of patchset
---
 .../bindings/timer/hpe,gxp-timer.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
new file mode 100644
index 000000000000..1f4e345c5fb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/hpe,gxp-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP TIMER
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    const: hpe,gxp-timer
+
+  reg:
+    items:
+      - description: T0CNT register
+      - description: T0CS register
+      - description: TIMELO register
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    description: The frequency of the clock that drives the counter, in Hz.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@10003000 {
+        compatible = "hpe,gxp-timer";
+        reg = <0xc0000080 0x1>, <0xc0000094 0x01>, <0xc0000088 0x08>;
+        interrupts = <0>;
+        interrupt-parent = <&vic0>;
+        clock-frequency = <400000000>;
+    };
-- 
2.17.1

