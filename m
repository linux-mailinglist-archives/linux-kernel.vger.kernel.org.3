Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F4E51DF8C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390071AbiEFTRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389993AbiEFTRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:17:11 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE8462A32;
        Fri,  6 May 2022 12:13:27 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246E3W3h005738;
        Fri, 6 May 2022 19:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=j87gFY3Pj67OC6sGCQ5Idrs/6yWU6Nm3Ab9iuHPz/VQ=;
 b=JjmCCwucACpOhHz/VweeSBc2sK72yFJ8lbQNYWXKYXMwmqTi7/hYS8sGyT5lNfrsXawe
 O76uwD4VD8cgvD008DPEWVvl9agvFjb38liT7rC9oL0OF1Mu62osMXcQgcDQpIyVL+Dd
 q6S9pRsk0JJMDN2L8kO5dAH7vsi1rs1whBSaO4Cu3PjFJTy9UeM7fPUu5eNkgYxmK7Bc
 BEriFrGqyzi0NqLXaZq1t2CvmQonTn3qDLp6t+x6Xx2vWUmrSALtfyYSOtwBs2fS1/Yf
 Jg8SZenDq+vIsE1tsAg0P/Qi5rdyWyiA7w2fGzf6YQ9gj52/83y4OlABOG/MfpafhYLs dA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fw53f2dqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 19:13:17 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 220D75E;
        Fri,  6 May 2022 19:13:16 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id C53244A;
        Fri,  6 May 2022 19:13:15 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v7 5/8] dt-bindings: timer: hpe,gxp-timer: Add HPE GXP Timer and Watchdog
Date:   Fri,  6 May 2022 14:13:36 -0500
Message-Id: <20220506191339.78617-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506191339.78617-1-nick.hawkins@hpe.com>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: lyXynusE0TCPEQDF_bdby4QpfOe19eCF
X-Proofpoint-ORIG-GUID: lyXynusE0TCPEQDF_bdby4QpfOe19eCF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_07,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060097
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for the HPE GXP Timer and Watchdog. There are multiple
timers on the SoC but only one is enabled at this time.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---
v7:
* Resubmission to fix subject from
  dt-bindings: timer: hpe,gxp-timer: Creation to
  dt-bindings: timer: hpe,gxp-timer: Add HPE GXP Timer and Watchdog
  based on comment: 'The subject after prefixes does not match it better.
  What is "creation"? "Add HPE GXP Timer and Watchdog"'
* Copied over Reviewed-by tags from previous patch.
v6:
* Removed simple-mfd compatible, timer will create watchdog without
  watchdog node.
* Removed timer0 label
* Changed title from HPE GXP TIMER to HPE GXP Timer
* Changed clock name iopclk to iop
* Set additionalProperties to false
* Added space after ',' in the compatible list
* Changed subject to match the log better
* Altered description to take up 75 characters per line
* Changed description to better describe the patch
v5:
* Fix versioning
* Fixed typo time -> timer
v4:
* Made watchdog a child of timer
* Added reference clock
v3:
* Removed maintainer change from patch
* Verified there was no compilation errors
* Added reference code in separate patch of patchset
v2:
* Converted from txt to yaml
---
 .../bindings/timer/hpe,gxp-timer.yaml         | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
new file mode 100644
index 000000000000..d33d90f44d28
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/hpe,gxp-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Timer
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
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: iop
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@c0000000 {
+        compatible = "hpe,gxp-timer";
+        reg = <0x80 0x16>;
+        interrupts = <0>;
+        interrupt-parent = <&vic0>;
+        clocks = <&iopclk>;
+        clock-names = "iop";
+    };
-- 
2.17.1

