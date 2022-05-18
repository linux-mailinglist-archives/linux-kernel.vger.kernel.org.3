Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505552B880
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiERLRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbiERLRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:17:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7906FA39;
        Wed, 18 May 2022 04:17:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 698371F44F26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652872629;
        bh=ed21MxQBys0eLKmWDwmejvGmdOdkFhFLW6SX1N40rec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAYVeaVpRGNpnK7K1rMus17w1kFCl3LUYG91K0kD28S36a8XsUrw1y+vA9JP+lfGm
         uqldoPrL7vcpA2gis7rnT+MUAuxD38amDbfLdd669bWIsZV/jCmwdyO3fsXPpUWNC+
         CUlWitQppVodbyimMcdSwqLYWryK06YeT/gb0tTStwV/XM/n8hRriLiUNc2G8iXjrB
         +YYILvOJUsY/4k1npTZ2piZV4gnDV9SSpnhlfSFIhUjtqKW2L3qbIpR706PrptzGOu
         5uATAPiEgZdkaO/mvMgmu/YIOHH4E8rEVsEQs2fwS5TuUkthoAMjklwDTj6OhsehDD
         xu2rii6BJRc4A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: [PATCH v2 5/7] clk: mediatek: clk-apmixed: Remove unneeded __init annotation
Date:   Wed, 18 May 2022 13:16:50 +0200
Message-Id: <20220518111652.223727-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com>
References: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com>
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

Remove an unneeded __init annotation from the declaration of function
mtk_clk_register_ref2usb_tx(): this avoids section mismatch warnings
during modpost phase when called from functions that have no such
annotation (useful when clocks are platform drivers).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index fc3d4146f482..6b0ab0a346e8 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -70,7 +70,7 @@ static const struct clk_ops mtk_ref2usb_tx_ops = {
 	.unprepare	= mtk_ref2usb_tx_unprepare,
 };
 
-struct clk_hw * __init mtk_clk_register_ref2usb_tx(const char *name,
+struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg)
 {
 	struct mtk_ref2usb_tx *tx;
-- 
2.35.1

