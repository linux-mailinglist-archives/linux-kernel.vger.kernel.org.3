Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E24051302C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbiD1Jba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347286AbiD1Jau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:30:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC92C7CB22;
        Thu, 28 Apr 2022 02:27:35 -0700 (PDT)
X-UUID: f061bfd7b48046aebe7282d6c7c98cd0-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:78fbf268-8de0-4134-b325-16baa79af4ce,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.4,REQID:78fbf268-8de0-4134-b325-16baa79af4ce,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:faefae9,CLOUDID:f211082f-6199-437e-8ab4-9920b4bc5b76,C
        OID:8903f490233d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: f061bfd7b48046aebe7282d6c7c98cd0-20220428
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 86142278; Thu, 28 Apr 2022 17:27:31 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 17:27:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 17:27:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 17:27:30 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Yuchen Huang <yuchen.huang@mediatek.com>
Subject: [PATCH v2 1/1] dt-bindings: rtc: mediatek: add mt6358 and mt6366 compatible
Date:   Thu, 28 Apr 2022 17:27:26 +0800
Message-ID: <20220428092726.25814-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220428092726.25814-1-allen-kh.cheng@mediatek.com>
References: <20220428092726.25814-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt6358 and mt6366 compatible in devicetree-binding document for
MediaTek PMIC based RTC. mt6358 and mt6366 use same compatible data
to store RTC_WRTGR address offset.

mt6358-rts should be used as fallback for mt6366-rtc.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Signed-off-by: Yuchen Huang <yuchen.huang@mediatek.com>
---
 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
index 55a0c8874c03..7212076a8f1b 100644
--- a/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
@@ -14,6 +14,8 @@ For MediaTek PMIC wrapper bus bindings, see:
 Required properties:
 - compatible: Should be one of follows
        "mediatek,mt6323-rtc": for MT6323 PMIC
+       "mediatek,mt6358-rtc": for MT6358 PMIC
+       "mediatek,mt6366-rtc", "mediatek,mt6358-rtc": for MT6366 PMIC
        "mediatek,mt6397-rtc": for MT6397 PMIC
 
 Example:
-- 
2.18.0

