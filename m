Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EC74860C2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 07:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiAFGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 01:54:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38866 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235172AbiAFGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 01:54:28 -0500
X-UUID: 8b137e16475741028ed2340d384d0748-20220106
X-UUID: 8b137e16475741028ed2340d384d0748-20220106
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1150771980; Thu, 06 Jan 2022 14:54:26 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 6 Jan 2022 14:54:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Jan
 2022 14:54:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 14:54:18 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH 4/4] dt-bindings: regulator: Add MT6358 regulators
Date:   Thu, 6 Jan 2022 14:54:07 +0800
Message-ID: <20220106065407.16036-5-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220106065407.16036-1-johnson.wang@mediatek.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add buck_vcore_sshub and ldo_vsram_others_sshub
regulators to binding document for MT6358 and MT6366.

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

