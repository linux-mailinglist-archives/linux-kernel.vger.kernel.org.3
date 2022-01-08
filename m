Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411674883BF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 14:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiAHNUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 08:20:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40704 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232663AbiAHNUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 08:20:15 -0500
X-UUID: 82ddf57228204705b19c3493dfb8214a-20220108
X-UUID: 82ddf57228204705b19c3493dfb8214a-20220108
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1330450628; Sat, 08 Jan 2022 21:20:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 8 Jan 2022 21:20:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Jan 2022 21:20:09 +0800
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
Subject: [v1 1/2] dt-bindings: power: Add MT8186 power domains
Date:   Sat, 8 Jan 2022 21:19:52 +0800
Message-ID: <20220108131953.16744-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220108131953.16744-1-chun-jie.chen@mediatek.com>
References: <20220108131953.16744-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
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
index 000000000000..ca8ea2d24801
--- /dev/null
+++ b/include/dt-bindings/power/mt8186-power.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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

