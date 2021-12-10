Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6674706BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbhLJRQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:16:26 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56466 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229821AbhLJRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:16:25 -0500
X-UUID: 50ddce20e727446d82c4f22bc6fc5702-20211211
X-UUID: 50ddce20e727446d82c4f22bc6fc5702-20211211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 610780392; Sat, 11 Dec 2021 01:12:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Dec 2021 01:12:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:12:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:12:44 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>
Subject: [PATCH] soc: mediatek: Add command for APU SMC call
Date:   Sat, 11 Dec 2021 01:12:43 +0800
Message-ID: <20211210171243.30212-1-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add command for APU SMC call.
The APU microprocess's start and stop sequence will process in ATF.
In some SOCs, such as mt8195, it also requires clock and pll
controller through SMC call.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 include/linux/soc/mediatek/mtk_sip_svc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/soc/mediatek/mtk_sip_svc.h b/include/linux/soc/mediatek/mtk_sip_svc.h
index 082398e0cfb1..b0c19593f40d 100644
--- a/include/linux/soc/mediatek/mtk_sip_svc.h
+++ b/include/linux/soc/mediatek/mtk_sip_svc.h
@@ -22,4 +22,7 @@
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, MTK_SIP_SMC_CONVENTION, \
 			   ARM_SMCCC_OWNER_SIP, fn_id)
 
+/* APUSYS SMC call */
+#define MTK_SIP_APUSYS_CONTROL MTK_SIP_SMC_CMD(0x51E)
+
 #endif
-- 
2.18.0

