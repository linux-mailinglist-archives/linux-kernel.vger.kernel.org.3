Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA2C4B78C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbiBOSSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:18:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiBOSSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:18:04 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F111987F;
        Tue, 15 Feb 2022 10:17:54 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FBOdZP005191;
        Tue, 15 Feb 2022 18:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=RCkzmuESPRr4IslVHQvPvdBg55wuFVjTn9z8RMSyDR4=;
 b=Ews5Rs0BxWZ1Qrp2HP5T4/NmZzcug5qg29f5MpGDrL0PO9cSgEmK1znOBhRlUWJ5kcQf
 jS02mtPt2u+W69hDnTzGvuP1zfMF8i9eZKHT3tjlx3uHWdub/ToE17DtXRI4wDHniZm9
 w/4CDm4AuzAKFSh83MQD/N7bf0mGlNlartLDKQb1ZTJCxJj9Tyh9FpCuN1sk3Xr7kU63
 WjOfpb5pCL6TszNyrM802VLu1kYB5NesLYwKnIf2atjeIaKLogxZS7eoHo5hmhDLYvnt
 Jgsm2t7WZgRu08bmaKE7Z9EY9GHj8xW0ngKIdPrIk//qriNu3rMX9SQtD4wrzwfKWlb6 6g== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e8b92ugyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 18:17:32 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D7D6D54;
        Tue, 15 Feb 2022 18:17:31 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] [v1] dt-bindings: timer: Add HPE GXP Timer binding
Date:   Tue, 15 Feb 2022 12:19:35 -0600
Message-Id: <20220215181936.41551-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <nick.hawkins@hpe.com>
References: <nick.hawkins@hpe.com>
X-Proofpoint-GUID: i-Dgm6jTiXXXdOm-5Xv1gUJkP2Zf4Di3
X-Proofpoint-ORIG-GUID: i-Dgm6jTiXXXdOm-5Xv1gUJkP2Zf4Di3
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_05,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150106
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

Description: Creating binding for the GXP timer to be used in device tree.
 GXP is the name of the HPE SoC.
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
 .../bindings/timer/hpe,gxp-timer.yaml         | 45 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 51 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..8c2c1e8e0934 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8385,6 +8385,12 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GXP TIMER
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+M:	Jean-Marie Verdun <verdun@hpe.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
+
 H8/300 ARCHITECTURE
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
-- 
2.17.1

