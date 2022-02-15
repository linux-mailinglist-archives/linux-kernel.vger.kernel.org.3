Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565154B69B7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiBOKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:49:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbiBOKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:49:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8444AD1D6E;
        Tue, 15 Feb 2022 02:49:34 -0800 (PST)
X-UUID: c69e7ba1ec7840f4b52fed28d2d324d8-20220215
X-UUID: c69e7ba1ec7840f4b52fed28d2d324d8-20220215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2011084917; Tue, 15 Feb 2022 18:49:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 18:49:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 18:49:29 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v2 1/2] dt-bindings: power: Add MT8186 power domains
Date:   Tue, 15 Feb 2022 18:49:16 +0800
Message-ID: <20220215104917.5726-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220215104917.5726-1-chun-jie.chen@mediatek.com>
References: <20220215104917.5726-1-chun-jie.chen@mediatek.com>
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

Add power domains dt-bindings for MT8186.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 .../power/mediatek,power-controller.yaml      |  1 +
 include/dt-bindings/power/mt8186-power.h      | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8186-power.h

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index d6ebd77d28a7..135c6f722091 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -26,6 +26,7 @@ properties:
       - mediatek,mt8167-power-controller
       - mediatek,mt8173-power-controller
       - mediatek,mt8183-power-controller
+      - mediatek,mt8186-power-controller
       - mediatek,mt8192-power-controller
       - mediatek,mt8195-power-controller
 
diff --git a/include/dt-bindings/power/mt8186-power.h b/include/dt-bindings/power/mt8186-power.h
new file mode 100644
index 000000000000..429f7197f6b6
--- /dev/null
+++ b/include/dt-bindings/power/mt8186-power.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8186_POWER_H
+#define _DT_BINDINGS_POWER_MT8186_POWER_H
+
+#define MT8186_POWER_DOMAIN_MFG0			0
+#define MT8186_POWER_DOMAIN_MFG1			1
+#define MT8186_POWER_DOMAIN_MFG2			2
+#define MT8186_POWER_DOMAIN_MFG3			3
+#define MT8186_POWER_DOMAIN_SSUSB			4
+#define MT8186_POWER_DOMAIN_SSUSB_P1			5
+#define MT8186_POWER_DOMAIN_DIS				6
+#define MT8186_POWER_DOMAIN_IMG				7
+#define MT8186_POWER_DOMAIN_IMG2			8
+#define MT8186_POWER_DOMAIN_IPE				9
+#define MT8186_POWER_DOMAIN_CAM				10
+#define MT8186_POWER_DOMAIN_CAM_RAWA			11
+#define MT8186_POWER_DOMAIN_CAM_RAWB			12
+#define MT8186_POWER_DOMAIN_VENC			13
+#define MT8186_POWER_DOMAIN_VDEC			14
+#define MT8186_POWER_DOMAIN_WPE				15
+#define MT8186_POWER_DOMAIN_CONN_ON			16
+#define MT8186_POWER_DOMAIN_CSIRX_TOP			17
+#define MT8186_POWER_DOMAIN_ADSP_AO			18
+#define MT8186_POWER_DOMAIN_ADSP_INFRA			19
+#define MT8186_POWER_DOMAIN_ADSP_TOP			20
+
+#endif /* _DT_BINDINGS_POWER_MT8186_POWER_H */
-- 
2.18.0

