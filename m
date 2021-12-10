Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4D47069E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbhLJRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:05:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49780 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244306AbhLJRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:05:24 -0500
X-UUID: b62e682c810045e3a790dbf4086541d6-20211211
X-UUID: b62e682c810045e3a790dbf4086541d6-20211211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 94017460; Sat, 11 Dec 2021 01:01:47 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:01:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:01:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:01:45 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "Yong Wu" <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH v4 8/8] arm64: dts: mt8192: Set up apu power domain regulators
Date:   Sat, 11 Dec 2021 01:01:13 +0800
Message-ID: <20211210170113.30063-9-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210170113.30063-1-flora.fu@mediatek.com>
References: <20211210170113.30063-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up apu power domain related regulators.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
Note:
This patch depends on mt6359[3] dts patches which haven't yet been accepted.
[1] https://patchwork.kernel.org/patch/12140237

---
 arch/arm64/boot/dts/mediatek/mt8192-evb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-evb.dts b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
index 808be492e970..5d9e108e41f5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-evb.dts
@@ -28,3 +28,10 @@
 &uart0 {
 	status = "okay";
 };
+
+&apuspm {
+	vsram-supply = <&mt6359_vsram_md_ldo_reg>;
+	apu_top: power-domain@0 {
+		domain-supply = <&mt6359_vproc1_buck_reg>;
+	};
+};
-- 
2.18.0

