Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E2517854
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387445AbiEBUnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387444AbiEBUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:43:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33ADEE2;
        Mon,  2 May 2022 13:39:34 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242JWf96008688;
        Mon, 2 May 2022 20:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=Cv5cceeI2j6Wcb2ynV1/8GdNxpr2Gw5wjtyLo7SyBsM=;
 b=CbXwf81Qmrzl2vJF3p7jlXauUKwnUOR7LZ64vs7WvWQWZP/Q7WFDWNyn837B0MogTZen
 9ZNZOJrsiqyrNGruC9bqT4zIWJQ+ajB19kaiIpvVSf/GtxFNRcjmnwS8PcidddAcaJIR
 fYZgUdL2paNywq4eAPEZ9ZKHkBPmSXll4/lfwmAoLNGZVuFQJZsPtwcf+h9eKIXhRb9r
 WXqUXbeRI9sxecfZyiUDaLM5yVwnSd0yeIXnozwTSY9kq6RFaICzONLijVTvtOQ0Js2i
 hJGsXzK8NlrdaIsp4i0v0mG+/44BL0X6D58fxqZQolJB/Zvb67UVl/PEgLeEyi/qqXbo Lg== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fthvu2mnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 20:39:24 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 7E62B56;
        Mon,  2 May 2022 20:39:23 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 1C6CC4A;
        Mon,  2 May 2022 20:39:23 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v6 5/8] dt-bindings: timer: hpe,gxp-timer: Creation
Date:   Mon,  2 May 2022 15:40:47 -0500
Message-Id: <20220502204050.88316-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220502204050.88316-1-nick.hawkins@hpe.com>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: lS9TtkIjdh30kpIdKL9oJJkYJXX5aiUX
X-Proofpoint-ORIG-GUID: lS9TtkIjdh30kpIdKL9oJJkYJXX5aiUX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_06,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=791
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020153
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

---
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

