Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727D555A537
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiFYAHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiFYAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:07:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDC78AC36;
        Fri, 24 Jun 2022 17:07:24 -0700 (PDT)
X-UUID: b9183ccfe3574f87899e93a81761789e-20220625
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:042ac45f-7b1d-49cd-b928-455eb01938c5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:ed3776ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,QS:nil,BEC:nil,COL:0
X-UUID: b9183ccfe3574f87899e93a81761789e-20220625
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 596147150; Sat, 25 Jun 2022 08:07:17 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 25 Jun 2022 08:07:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 25 Jun 2022 08:07:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Jun 2022 08:07:16 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <bgolaszewski@baylibre.com>, <chun-jie.chen@mediatek.com>,
        <ck.hu@mediatek.com>, <devicetree@vger.kernel.org>,
        <fparent@baylibre.com>, <ikjn@chromium.org>,
        <jason-jh.lin@mediatek.com>, <kernel@collabora.com>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <marijn.suijten@somainline.org>, <martin.botka@somainline.org>,
        <matthias.bgg@gmail.com>, <miles.chen@mediatek.com>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <paul.bouchara@somainline.org>, <phone-devel@vger.kernel.org>,
        <rex-bc.chen@mediatek.com>, <robh+dt@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <tinghan.shen@mediatek.com>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>, <y.oudjana@protonmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v3 5/7] clk: mediatek: clk-apmixed: Remove unneeded __init annotation
Date:   Sat, 25 Jun 2022 08:07:16 +0800
Message-ID: <20220625000716.12272-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220624093525.243077-6-angelogioacchino.delregno@collabora.com>
References: <20220624093525.243077-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Remove an unneeded __init annotation from the declaration of function
> mtk_clk_register_ref2usb_tx(): this avoids section mismatch warnings
> during modpost phase when called from functions that have no such
> annotation (useful when clocks are platform drivers).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

> ---
>  drivers/clk/mediatek/clk-apmixed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
> index fc3d4146f482..6b0ab0a346e8 100644
> --- a/drivers/clk/mediatek/clk-apmixed.c
> +++ b/drivers/clk/mediatek/clk-apmixed.c
> @@ -70,7 +70,7 @@ static const struct clk_ops mtk_ref2usb_tx_ops = {
>  	.unprepare	= mtk_ref2usb_tx_unprepare,
>  };
>  
> -struct clk_hw * __init mtk_clk_register_ref2usb_tx(const char *name,
> +struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
>  			const char *parent_name, void __iomem *reg)
>  {
>  	struct mtk_ref2usb_tx *tx;
> -- 
> 2.35.1


