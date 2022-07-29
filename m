Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69A584D98
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiG2Ing (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiG2Inc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:43:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1091F580;
        Fri, 29 Jul 2022 01:43:31 -0700 (PDT)
X-UUID: dbd154f9c28446d1af8d1f537ea81125-20220729
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:9b71d9dd-e480-4d18-b85c-0deceb6ab4e5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:105
X-CID-INFO: VERSION:1.1.8,REQID:9b71d9dd-e480-4d18-b85c-0deceb6ab4e5,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:105
X-CID-META: VersionHash:0f94e32,CLOUDID:488bb724-a982-4824-82d2-9da3b6056c2a,C
        OID:463c01612192,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: dbd154f9c28446d1af8d1f537ea81125-20220729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <elvis.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1041496241; Fri, 29 Jul 2022 16:43:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 29 Jul 2022 16:43:24 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 29 Jul 2022 16:43:23 +0800
From:   Elvis Wang <Elvis.Wang@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Elvis Wang <Elvis.Wang@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: mailbox: add definition for mt8188
Date:   Fri, 29 Jul 2022 16:43:18 +0800
Message-ID: <20220729084319.6880-2-Elvis.Wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729084319.6880-1-Elvis.Wang@mediatek.com>
References: <20220729084319.6880-1-Elvis.Wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding header for mt8188.

Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>
---
 Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index c2aeba63bd47..50f97f6feeef 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -41,9 +41,9 @@ Optional properties for a client mutex node:
   defined in 'dt-bindings/gce/<chip>-gce.h'.
 
 Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h',
-'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8186-gce.h'
-'dt-bindings/gce/mt8192-gce.h', 'dt-bindings/gce/mt8195-gce.h' or
-'dt-bindings/gce/mt6779-gce.h'.
+'dt-bindings/gce/mt8183-gce.h', 'dt-bindings/gce/mt8186-gce.h',
+'dt-bindings/gce/mt8188-gce.h', 'dt-bindings/gce/mt8192-gce.h',
+'dt-bindings/gce/mt8195-gce.h' or 'dt-bindings/gce/mt6779-gce.h'.
 Such as sub-system ids, thread priority, event ids.
 
 Example:
-- 
2.18.0

