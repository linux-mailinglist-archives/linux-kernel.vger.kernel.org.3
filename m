Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF351493A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354636AbiASMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:36:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51420 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354531AbiASMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:36:01 -0500
X-UUID: d0c068aee43d427aa0d89ad9dbeb3d39-20220119
X-UUID: d0c068aee43d427aa0d89ad9dbeb3d39-20220119
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1444180965; Wed, 19 Jan 2022 20:35:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 19 Jan 2022 20:35:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 20:35:56 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Ryder Lee <ryder.lee@kernel.org>,
        "Sam Shih" <sam.shih@mediatek.com>
Subject: [PATCH 1/2] arm64: dts: mediatek: update mt7986a memory node
Date:   Wed, 19 Jan 2022 20:35:36 +0800
Message-ID: <20220119123537.9968-2-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220119123537.9968-1-sam.shih@mediatek.com>
References: <20220119123537.9968-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the format of memory node in DT based on
maintainer comments in the following thread:
https://lore.kernel.org/all/bc0a9df0-8ba0-76ed-4522-43a3082f42b4@gmail.com/

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 5cd760abff51..21e420829572 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -19,7 +19,8 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory@40000000 {
+		device_type = "memory";
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 };
-- 
2.29.2

