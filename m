Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755E55A0893
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiHYF5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiHYF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:57:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A609A9F193;
        Wed, 24 Aug 2022 22:57:06 -0700 (PDT)
X-UUID: b7a6e533a8524dab97ee66b57a82c6d6-20220825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aUWpRgHtNV4o5Os9E2A3UPYhpEU1YCs0RcI9qd2YUws=;
        b=sCM5Eht3nH7SqAM7eG/cCXGiL3NqlBpryBguiKPHxkffvUcPe1anDiIgDLSd36JrR9XlhpvLbsW2QMQjyUmGUIW1A4+0s/uppNHGqVSovGUi0SH7GqW2ohUiLhozU4UrN2dEPGJxMmrJHx6Hfwdl6NLF9vu0lhWqWL7sFH39J94=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:712b4e72-5017-4300-a0d1-fe6a75e40b34,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:712b4e72-5017-4300-a0d1-fe6a75e40b34,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS98
        1B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:01618ecf-20bd-4e5e-ace8-00692b7ab380,C
        OID:b793547d364d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b7a6e533a8524dab97ee66b57a82c6d6-20220825
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1310616124; Thu, 25 Aug 2022 13:57:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 25 Aug 2022 13:57:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 25 Aug 2022 13:57:00 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
        <ck.hu@mediatek.com>, <chunkuang.hu@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <hsinyi@google.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH] dt-bindings: arm: mediatek: mmsys: change compatible for MT8195
Date:   Thu, 25 Aug 2022 13:56:58 +0800
Message-ID: <20220825055658.12429-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,URIBL_CSS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

For previous MediaTek SoCs, such as MT8173, there are 2 display HW
pipelines binding to 1 mmsys with the same power domain, the same
clock driver and the same mediatek-drm driver.

For MT8195, VDOSYS0 and VDOSYS1 are 2 display HW pipelines binding to
2 different power domains, different clock drivers and different
mediatek-drm drivers.

Therefore, we need to separate these two different mmsys hardwares to
2 different compatibles for MT8195.

Fixes: 81c5a41d10b9 ("dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
index 6ad023eec193..bfbdd30d2092 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
@@ -31,7 +31,8 @@ properties:
               - mediatek,mt8183-mmsys
               - mediatek,mt8186-mmsys
               - mediatek,mt8192-mmsys
-              - mediatek,mt8195-mmsys
+              - mediatek,mt8195-vdosys0
+              - mediatek,mt8195-vdosys1
               - mediatek,mt8365-mmsys
           - const: syscon
       - items:
-- 
2.18.0

