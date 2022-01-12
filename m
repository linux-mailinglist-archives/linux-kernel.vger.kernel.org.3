Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F27848C384
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353003AbiALLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:47:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52986 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352982AbiALLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:47:48 -0500
X-UUID: 8a8b1c831867400a907cdd2d5a7a6961-20220112
X-UUID: 8a8b1c831867400a907cdd2d5a7a6961-20220112
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1762385160; Wed, 12 Jan 2022 19:47:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 19:47:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 19:47:42 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Tinghan Shen" <tinghan.shen@mediatek.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Sean Christopherson" <seanjc@google.com>,
        <maciej.szmigiero@oracle.com>,
        "David Matlack" <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Subject: [PATCH v9 1/3] dt-bindings: arm: mediatek: Add mt8195 pericfg compatible
Date:   Wed, 12 Jan 2022 19:47:22 +0800
Message-ID: <20220112114724.1953-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20220112114724.1953-1-tinghan.shen@mediatek.com>
References: <20220112114724.1953-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8195 pericfg compatible to binding document.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
index 8723dfe34bab..611f666f359d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml
@@ -26,6 +26,7 @@ properties:
               - mediatek,mt8135-pericfg
               - mediatek,mt8173-pericfg
               - mediatek,mt8183-pericfg
+              - mediatek,mt8195-pericfg
               - mediatek,mt8516-pericfg
           - const: syscon
       - items:
-- 
2.18.0

