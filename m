Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D14B789D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbiBOSjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:39:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbiBOSjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:39:14 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB59FDA85E;
        Tue, 15 Feb 2022 10:39:03 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21FCbhSf027207;
        Tue, 15 Feb 2022 18:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=zauf/5fk/84eZzLuty5kiNbYNLB7kIi/6If/F+Ht028=;
 b=gZvKSclvbLg3PP7EIcTRV7ha/sbqabmujm/zxk1wPGHeLyH/2BQVrPw4W/44uH63ls3J
 qd1EEl/l0nkgQVTbeYevH4CNp8/v4tkxc1xQhENlIBqO2PC4RHcKivuRCFTN4Pj3ZZfD
 LsbLTrdf5rJj0nzYbO9xREDFQRPkS5bwyL9BuTiZl9RbPXgI0f638xCBchLzy+0QHwOW
 FbG5OmDYdSxmGvZkVgn27JVqIPLzM/sOOIhf91miyzhuud3XNwRCxNwTPwekVZvMGkig
 2QK52FxbliMlChxEqEGYjtsuPHQme7aDlmzzF+pXUzaoqByU4vZVn4SRlfDSuCeXm99A Vg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e8cba3969-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 18:38:42 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id F0CD75C;
        Tue, 15 Feb 2022 18:38:40 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v1] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
Date:   Tue, 15 Feb 2022 12:40:37 -0600
Message-Id: <20220215184039.41882-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <nick.hawkins@hpe.com>
References: <nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: IC5osYlRBwWyNvwiOMS0aZhLee-Y3GNm
X-Proofpoint-GUID: IC5osYlRBwWyNvwiOMS0aZhLee-Y3GNm
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_05,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150107
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

Description: Creating binding for the GXP watchdog timer to be used in
 the device tree. This along with the
  dt-bindings: timer: Add HPE GXP Timer binding patch will be used to
   create the basic dts and dtsi for GXP.
Information: GXP is the name of the HPE SoC.
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
 .../bindings/watchdog/hpe,gxp-wdt.yaml        | 37 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 43 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..8c96f4db900c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8385,6 +8385,12 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GXP WATCHDOG TIMER
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+M:	Jean-Marie Verdun <verdun@hpe.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/hpe,gxp-wdt.yaml
+
 H8/300 ARCHITECTURE
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
-- 
2.17.1

