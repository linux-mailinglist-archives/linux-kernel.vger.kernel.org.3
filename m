Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA552EC61
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349339AbiETMld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349437AbiETMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:40:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A6113F;
        Fri, 20 May 2022 05:40:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BCAE21F462BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653050447;
        bh=L5qU1nQ2bI4UYhJq6gU4Byb4OsjwVhaJ+WdCE8eB27c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TL5S2cNOJL2dDtgaRf7qSDsTCdcJnljZCSi0GZfDAa4ANsrs/v6qYiU4irLpErJ36
         CWhdXWKu5nFGXMfH+Z8Hf+0pXiPAIzm/DHHolEJiOOka7fv2e1MfCfSn/77asP04B1
         OcF4MPyV8Q6vV3HlGb2apU2S2dLQgN/FZL0dhaOuqeD4rUIU/HRj7kSr5YnHvFM5GS
         WSZ07rbQlaKdCOa0CIPMZ5Km5ekeHC+hvUjgvJH7VBTRyMqdJ/Pqj9s2qMSnHzi7AT
         lVvqd80XhD0lpGC20wgUarP7DTeU72pe6j5y/DDKn7AJtgErSldS5yU5/QKexuyofk
         Vak+JSF/SAQvA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        zhiyong.tao@mediatek.com, henryc.chen@mediatek.com,
        johnson.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dt-bindings: mediatek: pwrap: Add a compatible for MT6795 Helio X10
Date:   Fri, 20 May 2022 14:40:38 +0200
Message-Id: <20220520124039.228314-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
References: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for the MT6765 Helio X10 SoC's PMIC Wrapper.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index 0581dbda4828..b53ebebc44bf 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -21,6 +21,7 @@ Required properties in pwrap device node.
 	"mediatek,mt2701-pwrap" for MT2701/7623 SoCs
 	"mediatek,mt6765-pwrap" for MT6765 SoCs
 	"mediatek,mt6779-pwrap" for MT6779 SoCs
+	"mediatek,mt6795-pwrap" for MT6795 SoCs
 	"mediatek,mt6797-pwrap" for MT6797 SoCs
 	"mediatek,mt6873-pwrap" for MT6873/8192 SoCs
 	"mediatek,mt7622-pwrap" for MT7622 SoCs
-- 
2.35.1

