Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A618A48A7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348234AbiAKGjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:39:40 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43114 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348237AbiAKGjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:39:32 -0500
X-UUID: c7b37adea6b14ec496cae1b3acb65ff4-20220111
X-UUID: c7b37adea6b14ec496cae1b3acb65ff4-20220111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1345777211; Tue, 11 Jan 2022 14:39:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 11 Jan 2022 14:39:27 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 14:39:26 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <lc.kan@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/6] dt-bindings: memory: mtk-smi: Fix larb-id dtbs_check warning
Date:   Tue, 11 Jan 2022 14:38:59 +0800
Message-ID: <20220111063904.7583-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220111063904.7583-1-yong.wu@mediatek.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mute the warning from "make dtbs_check":

larb@14016000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
larb@15001000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
larb@16010000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../bindings/memory-controllers/mediatek,smi-larb.yaml           | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index eaeff1ada7f8..80907e357892 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -108,7 +108,6 @@ allOf:
               - mediatek,mt2701-smi-larb
               - mediatek,mt2712-smi-larb
               - mediatek,mt6779-smi-larb
-              - mediatek,mt8167-smi-larb
               - mediatek,mt8192-smi-larb
               - mediatek,mt8195-smi-larb
 
-- 
2.18.0

