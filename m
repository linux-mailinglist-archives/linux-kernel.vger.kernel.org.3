Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789FF574D35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbiGNMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238411AbiGNMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:13:37 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5382DEA;
        Thu, 14 Jul 2022 05:13:37 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E3efQ1018415;
        Thu, 14 Jul 2022 05:13:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=S50ojiroZ1r/0/PPBdwCdzqkGePj2RtjkHHmNjQqNMU=;
 b=ZpA6HTTOnGUa3VoRd6VBbOQONINXdUmVQMbFjdt5IhqYBJBxnx48pICzim/Mrbi9etnp
 EmwdjuSKHNCE7lY5/WwZhXGbdNMENVKvdht5gs+OmMj1S29VFSsxTH9JTT8xSWhmPANB
 SC+wiNRs7KbenXt2Lexp1Bi88ub3EdD9nwYAtJuKlXJqxxEa9goRJTPeyT0hFdHeuqaI
 1RB/OF2O8jgxO4g4XEzVDHVhy9sS3ww1bTBVjssnjqXvbnf+RYNzJvm3mjiwr9FnDnwm
 yEezzsQNpawC/vlFHLFCgh4gRVffblLCFB4yKhNO92QaboO3w7ioW+ifMuazSBFI6jo3 DQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3habegsk5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:13:33 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jul
 2022 05:12:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 14 Jul 2022 05:12:23 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 75F343F704D;
        Thu, 14 Jul 2022 05:12:23 -0700 (PDT)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <wbartczak@marvell.com>, <linux-kernel@vger.kernel.org>
CC:     <wbartczak@gmail.com>, Piyush Malgujar <pmalgujar@marvell.com>,
        "Sunil Goutham" <sgoutham@marvell.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: mailbox : marvell,mbox: Add bindings
Date:   Thu, 14 Jul 2022 05:12:12 -0700
Message-ID: <20220714121215.22931-2-wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220714121215.22931-1-wbartczak@marvell.com>
References: <20220714121215.22931-1-wbartczak@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -WNRLDvgd4WPXGNREzpu8r2WknynHCR7
X-Proofpoint-ORIG-GUID: -WNRLDvgd4WPXGNREzpu8r2WknynHCR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_10,2022-07-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree binding for Marvell Message Handling Unit
(MHU) controller.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
---
 .../mailbox/marvell,mbox-mailbox.yaml         | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d9a6e14dcb12da6c3a9db2dfafc075ccefa8711c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/marvell,mbox-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Message Handling Unit
+
+maintainers:
+  - Wojciech Bartczak <wbartczak@marvell.com>
+  - Piyush Malgujar <pmalgujar@marvell.com>
+
+description:
+  The Marvell's Message Handling Unit is a mailbox controller
+  with a single channel used to communicate with System Control Processor.
+  Driver supports series of cn9x and cn10x SoC.
+  Sole purpose of the link is to exchange SCMI related data with SCP.
+  The link has hardwired configuration, it uses simple notification scheme
+  over shared memory block to push data back and forth.
+  Interrupts used by mailbox may be configured in two ways,
+  as SPI interrupts, then driver uses platform device forntend.
+  Other way is to use PCI bus frontend with LPI interrupts.
+
+properties:
+  compatible:
+    items:
+      - const: marvell,mbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: interrupt type
+        const: 0
+      - description: interrupt number
+      - description: interrupt trigger type
+        const: 1
+
+  '#mbox-cells':
+    description: Index of the channel
+    const: 1
+
+  shmem:
+    description:
+      List of phandle pointing to the shared memory area between SCP and AP.
+      The area is used to exchange additional information not covered by SCMI.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#mbox-cells'
+  - shmem
+
+additionalProperties: false
+
+examples:
+  - |
+    soc@0 {
+      reg = <0 0>;
+       #address-cells = <2>;
+       #size-cells = <2>;
+
+      sram@36,0 {
+        compatible = "cpc-shmem";
+        reg = <0x86d0 0xdd400 0 0x200>;
+        #address-cells = <2>;
+        #size-cells = <1>;
+        ranges = <0 0x0 0x86d0 0xdd400 0x200>;
+
+        scp_to_cpu0: scp-shmame@0 {
+          compatible = "cpc-shmem";
+          reg = <0x0 0x0 0x200>;
+        };
+      };
+
+      mailbox0: mailbox@28,0 {
+        #mbox-cells = <1>;
+        compatible = "marvell,mbox";
+        reg = <0xe000 0 0 0>;
+        shmem = <&scp_to_cpu0>;
+      };
+    };
+  - |
+    soc@1 {
+      reg = <1 0>;
+       #address-cells = <2>;
+       #size-cells = <2>;
+
+      sram@36,0 {
+        compatible = "cpc-shmem";
+        reg = <0x86d0 0xdd400 0 0x200>;
+        #address-cells = <2>;
+        #size-cells = <1>;
+        ranges = <0 0x0 0x86d0 0xdd400 0x200>;
+
+        scp_to_cpu1: scp-shmame@1 {
+          compatible = "cpc-shmem";
+          reg = <0x0 0x0 0x200>;
+        };
+      };
+
+      mailbox1: mailbox@82c000000000 {
+        #mbox-cells = <1>;
+        compatible = "marvell,mbox";
+        reg = <0x82c0 0x00000000 0x0 0x100000>;
+        interrupt-parent = <&gic0>;
+        interrupts = <0 59 1>;
+        shmem = <&scp_to_cpu1>;
+      };
+    };
-- 
2.17.1

