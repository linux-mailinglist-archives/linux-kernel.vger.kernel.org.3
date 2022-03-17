Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CF74DBD57
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 04:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358514AbiCQDFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 23:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352630AbiCQDFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 23:05:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF89020F72;
        Wed, 16 Mar 2022 20:04:16 -0700 (PDT)
X-UUID: 553e777eda3341d88cf12e717ce87d86-20220317
X-UUID: 553e777eda3341d88cf12e717ce87d86-20220317
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1932598311; Thu, 17 Mar 2022 11:04:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 11:04:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 11:04:07 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH v2 2/2] dt-bindings: regulator: Add BUCK and LDO document for MT6358 and MT6366
Date:   Thu, 17 Mar 2022 11:04:02 +0800
Message-ID: <20220317030402.24894-3-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220317030402.24894-1-johnson.wang@mediatek.com>
References: <20220317030402.24894-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add buck_vcore_sshub and ldo_vsram_others_sshub
regulators to binding document for MT6358 and MT6366.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 .../bindings/regulator/mt6358-regulator.txt   | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
index 9a90a92f2d7e..7034cdca54e0 100644
--- a/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
@@ -8,14 +8,14 @@ Documentation/devicetree/bindings/regulator/regulator.txt.
 
 The valid names for regulators are::
 BUCK:
-  buck_vdram1, buck_vcore, buck_vpa, buck_vproc11, buck_vproc12, buck_vgpu,
-  buck_vs2, buck_vmodem, buck_vs1
+  buck_vdram1, buck_vcore, buck_vcore_sshub, buck_vpa, buck_vproc11,
+  buck_vproc12, buck_vgpu, buck_vs2, buck_vmodem, buck_vs1
 LDO:
   ldo_vdram2, ldo_vsim1, ldo_vibr, ldo_vrf12, ldo_vio18, ldo_vusb, ldo_vcamio,
   ldo_vcamd, ldo_vcn18, ldo_vfe28, ldo_vsram_proc11, ldo_vcn28, ldo_vsram_others,
-  ldo_vsram_gpu, ldo_vxo22, ldo_vefuse, ldo_vaux18, ldo_vmch, ldo_vbif28,
-  ldo_vsram_proc12, ldo_vcama1, ldo_vemc, ldo_vio28, ldo_va12, ldo_vrf18,
-  ldo_vcn33_bt, ldo_vcn33_wifi, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28,
+  ldo_vsram_others_sshub, ldo_vsram_gpu, ldo_vxo22, ldo_vefuse, ldo_vaux18,
+  ldo_vmch, ldo_vbif28, ldo_vsram_proc12, ldo_vcama1, ldo_vemc, ldo_vio28, ldo_va12,
+  ldo_vrf18, ldo_vcn33_bt, ldo_vcn33_wifi, ldo_vcama2, ldo_vmc, ldo_vldo28, ldo_vaud28,
   ldo_vsim2
 
 Example:
@@ -354,5 +354,17 @@ Example:
 				regulator-max-microvolt = <3100000>;
 				regulator-enable-ramp-delay = <540>;
 			};
+
+			mt6358_vcore_sshub_reg: buck_vcore_sshub {
+				regulator-name = "vcore_sshub";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+			};
+
+			mt6358_vsram_others_sshub_reg: ldo_vsram_others_sshub {
+				regulator-name = "vsram_others_sshub";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+			};
 		};
 	};
-- 
2.18.0

