Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F02595598
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiHPItU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiHPIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:48:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323BEA0269;
        Mon, 15 Aug 2022 23:53:56 -0700 (PDT)
X-UUID: e9224eb66ea64b4f984efed05cb45e67-20220816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9oVgoaXxIL1B3HWV/JiKuGizRKOz6e4IWKbv39NiYdw=;
        b=BelXgKmDx6hVXdViwZ3y8ogRdl2nLeicuUL0egfbkbtVtwKIKSz4S0DdfClU9dSaHHxdVQ6RGOIQDaJuUQJsc7UwRvUTcmkmheveApwVvq9qBubIpqqNmSFsdVndSCSesdzZanRhWT6dsOtZFsLwH9hbHVZMxP6LXzyhSDk/eKo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:cf12df31-a324-426a-b6e2-dad3c92d44bd,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:0
X-CID-META: VersionHash:3d8acc9,CLOUDID:7c4dca9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e9224eb66ea64b4f984efed05cb45e67-20220816
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <runyang.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 792189498; Tue, 16 Aug 2022 14:53:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 16 Aug 2022 14:53:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Aug 2022 14:53:42 +0800
From:   Runyang Chen <Runyang.Chen@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Runyang Chen" <runyang.chen@mediatek.com>
Subject: [PATCH v2 1/3] dt-bindings: watchdog: Add compatible for MediaTek MT8188
Date:   Tue, 16 Aug 2022 14:53:28 +0800
Message-ID: <20220816065330.27570-2-Runyang.Chen@mediatek.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
References: <20220816065330.27570-1-Runyang.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Runyang Chen <runyang.chen@mediatek.com>

Add dt-binding documentation of watchdog for MediaTek MT8188 Soc

Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
---
 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
index 762c62e428ef..b900c85d4560 100644
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
@@ -17,6 +17,7 @@ Required properties:
 	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
 	"mediatek,mt8183-wdt": for MT8183
 	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
+	"mediatek,mt8188-wdt", "mediatek,mt6589-wdt": for MT8188
 	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
 	"mediatek,mt8192-wdt": for MT8192
 	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
-- 
2.18.0

