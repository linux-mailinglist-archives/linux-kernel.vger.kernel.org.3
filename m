Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16FE59E5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbiHWPJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241211AbiHWPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:09:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227732F084;
        Tue, 23 Aug 2022 05:38:08 -0700 (PDT)
X-UUID: ee130b6085b74b7daeda0204bab28a2b-20220823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GM6WTXEvXXaeWP7IaTOYxwKh7PWuxzkL54ETW+5S6+o=;
        b=A7tpUNT8RGpQrt2Isunu56TFyEg6/Io6g2tZp/Dv1i/B6HLWEuj+DilSpySZ02vsjM5xVoUDCEWOlmhLV2HPJJdRTS/tbfzqhVtzCE8o7SxVTk+h46w8HptYz4K8Rwtj5z6XIwp1oEOZIAzdurmrei5QrF7AhINDOKf8S00Lua0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:51e83e0f-3881-4e9a-b26c-34009394b720,OB:0,L
        OB:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:25
X-CID-META: VersionHash:84eae18,CLOUDID:40c75ccf-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ee130b6085b74b7daeda0204bab28a2b-20220823
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1481547005; Tue, 23 Aug 2022 20:38:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 23 Aug 2022 20:38:01 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 23 Aug 2022 20:38:00 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <eddie.huang@mediatek.com>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <fshao@chromium.org>
CC:     <sen.chu@mediatek.com>, <hui.liu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <zhiyong.tao@mediatek.com>,
        <hsin-hsiung.wang@mediatek.com>, <sean.wang@mediatek.com>,
        <macpaul.lin@mediatek.com>, <wen.su@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4] regulator: dt-bindings: mediatek: add mt6366
Date:   Tue, 23 Aug 2022 20:37:45 +0800
Message-ID: <20220823123745.14061-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt6366 regulator document

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
Changes in patch v4:
1)Add unevaluatedProperties in all places
2)Fix check warning and errors
3)remove "compatible="regulator-fixed"" properties for some ldo

Changes in patch v3:
1)change patch title
2)change "regulator.yaml#" to regulator.yaml#
3)remove regulator-name
4)fix 4 space for DTS example

Changes in patch v2:
1)fix patch title description.
2)fix patch maintainer description.
3)won't cc to srv_heupstream@mediatek.com
4)fix patch commit message description.
5)add properties node and compatible
6)put "unevaluatedProperties: false" after $ref
7)remove underscores in node names.
8)change Filename to "mediatek,mt6366-regulator.yaml"
[Zhiyong Tao <zhiyong.tao@mediatek.com>]
---
---
 .../regulator/mediatek,mt6366-regulator.yaml  | 279 ++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
new file mode 100644
index 000000000000..8945bf20b574
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6366-regulator.yaml
@@ -0,0 +1,279 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6366-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MT6366 Regulator from MediaTek Integrated
+
+maintainers:
+  - Zhiyong Tao <zhiyong.tao@mediatek.com>
+
+description: |
+  List of regulators provided by this controller. It is named
+  according to its regulator type, buck_<name> and ldo_<name>.
+  MT6366 regulators node should be sub node of the MT6397 MFD node.
+
+properties:
+  compatible:
+    const: mediatek,mt6366-regulator
+
+  regulators:
+    type: object
+    description: List of regulators and its properties
+
+    patternProperties:
+      "^buck-v(dram1|core|coresshub|proc11|proc12|gpu|s2|modem|s1)$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-v(dram2|sim1|ibr|rf12|usb|camio|camd|cn18|fe28)$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-v(xo22|efuse|mch|vcama1|emc|a12|vcama2|mc)$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^buck-(vcore)-sshub$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-vcn(28|33)-bt$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-vcn(33)-wifi$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-vsram-(others)-sshub$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-vsram-(proc11|others|gpu|proc12)$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-v(aud|bif|io|ldo)28$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-v(io|aux|rf)18$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+      "^ldo-vsim[2]$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+        compatible = "mediatek,mt6366-regulator";
+
+        regulators {
+            mt6366_vdram1_reg: buck-vdram1 {
+                regulator-ramp-delay = <12500>;
+                regulator-enable-ramp-delay = <0>;
+                regulator-allowed-modes = <0 1>;
+            };
+
+            mt6366_vcore_reg: buck-vcore {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <200>;
+                regulator-allowed-modes = <0 1>;
+            };
+
+           mt6366_vproc11_reg: buck-vproc11 {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <200>;
+                regulator-allowed-modes = <0 1>;
+            };
+
+            mt6366_vproc12_reg: buck-vproc12 {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <200>;
+                regulator-allowed-modes = <0 1>;
+            };
+
+            mt6366_vgpu_reg: buck-vgpu {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <200>;
+                regulator-allowed-modes = <0 1>;
+            };
+
+            mt6366_vs2_reg: buck-vs2 {
+                regulator-ramp-delay = <12500>;
+                regulator-enable-ramp-delay = <0>;
+            };
+
+           mt6366_vmodem_reg: buck-vmodem {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <900>;
+                regulator-allowed-modes = <0 1>;
+            };
+
+            mt6366_vs1_reg: buck-vs1 {
+                regulator-ramp-delay = <12500>;
+                regulator-enable-ramp-delay = <0>;
+            };
+
+            mt6366_vdram2_reg: ldo-vdram2 {
+                regulator-enable-ramp-delay = <3300>;
+            };
+
+            mt6366_vsim1_reg: ldo-vsim1 {
+                regulator-enable-ramp-delay = <540>;
+            };
+
+            mt6366_vibr_reg: ldo-vibr {
+                regulator-enable-ramp-delay = <60>;
+            };
+
+            mt6366_vrf12_reg: ldo-vrf12 {
+                regulator-enable-ramp-delay = <120>;
+            };
+
+            mt6366_vio18_reg: ldo-vio18 {
+                regulator-enable-ramp-delay = <2700>;
+            };
+
+            mt6366_vusb_reg: ldo-vusb {
+                regulator-name = "vusb";
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vcamio_reg: ldo-vcamio {
+                regulator-enable-ramp-delay = <325>;
+            };
+
+            mt6366_vcamd_reg: ldo-vcamd {
+                regulator-enable-ramp-delay = <325>;
+            };
+
+            mt6366_vcn18_reg: ldo-vcn18 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vfe28_reg: ldo-vfe28 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vsram_proc11_reg: ldo-vsram-proc11 {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <240>;
+            };
+
+            mt6366_vcn28_reg: ldo-vcn28 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vsram_others_reg: ldo-vsram-others {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <240>;
+            };
+
+            mt6366_vsram_gpu_reg: ldo-vsram-gpu {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <240>;
+            };
+
+            mt6366_vxo22_reg: ldo-vxo22 {
+                regulator-enable-ramp-delay = <120>;
+            };
+
+            mt6366_vefuse_reg: ldo-vefuse {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vaux18_reg: ldo-vaux18 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vmch_reg: ldo-vmch {
+                regulator-enable-ramp-delay = <60>;
+            };
+
+            mt6366_vbif28_reg: ldo-vbif28 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vsram_proc12_reg: ldo-vsram-proc12 {
+                regulator-ramp-delay = <6250>;
+                regulator-enable-ramp-delay = <240>;
+            };
+
+            mt6366_vcama1_reg: ldo-vcama1 {
+                regulator-enable-ramp-delay = <325>;
+            };
+
+            mt6366_vemc_reg: ldo-vemc {
+                regulator-enable-ramp-delay = <60>;
+            };
+
+            mt6366_vio28_reg: ldo-vio28 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_va12_reg: ldo-va12 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vrf18_reg: ldo-vrf18 {
+                regulator-enable-ramp-delay = <120>;
+            };
+
+            mt6366_vcn33_bt_reg: ldo-vcn33-bt {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vcn33_wifi_reg: ldo-vcn33-wifi {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vcama2_reg: ldo-vcama2 {
+                regulator-enable-ramp-delay = <325>;
+            };
+
+            mt6366_vmc_reg: ldo-vmc {
+                regulator-enable-ramp-delay = <60>;
+            };
+
+            mt6366_vldo28_reg: ldo-vldo28 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vaud28_reg: ldo-vaud28 {
+                regulator-enable-ramp-delay = <270>;
+            };
+
+            mt6366_vsim2_reg: ldo-vsim2 {
+                regulator-enable-ramp-delay = <540>;
+            };
+
+            mt6366_vcore_sshub_reg: buck-vcore-sshub {
+            };
+
+            mt6366_vsram_others_sshub_reg: ldo-vsram-others-sshub {
+            };
+        };
+    };
+...
-- 
2.18.0

