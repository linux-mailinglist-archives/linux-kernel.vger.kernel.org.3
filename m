Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD352CB3B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiESEmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiESEmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:42:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BDE5DA33;
        Wed, 18 May 2022 21:42:00 -0700 (PDT)
X-UUID: 3967da3e039a4802882ebc34d4da6908-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:c8d2e367-71e9-4c45-809a-d77cf2b321d0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:ad93bde2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 3967da3e039a4802882ebc34d4da6908-20220519
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 286526095; Thu, 19 May 2022 12:41:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 19 May 2022 12:41:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 12:41:53 +0800
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
Subject: Re: [PATCH v2 6/7] clk: mediatek: Export required symbols to compile clk drivers as module
Date:   Thu, 19 May 2022 12:41:53 +0800
Message-ID: <20220519044153.11078-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220518111652.223727-7-angelogioacchino.delregno@collabora.com>
References: <20220518111652.223727-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Angelo,

>In order to compile the clock drivers for various MediaTek SoCs as
>modules, it is necessary to export a few functions from the MediaTek
>specific clocks (and reset) libraries.
>
>Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>---
> drivers/clk/mediatek/clk-apmixed.c | 1 +
> drivers/clk/mediatek/clk-cpumux.c  | 2 ++
> drivers/clk/mediatek/clk-mtk.c     | 2 ++
> drivers/clk/mediatek/reset.c       | 1 +
> 4 files changed, 6 insertions(+)
>
>diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
>index 6b0ab0a346e8..f126da693a7f 100644
>--- a/drivers/clk/mediatek/clk-apmixed.c
>+++ b/drivers/clk/mediatek/clk-apmixed.c
>@@ -98,5 +98,6 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
> 
> 	return &tx->hw;
> }
>+EXPORT_SYMBOL_GPL(mtk_clk_register_ref2usb_tx);
> 
> MODULE_LICENSE("GPL");
>diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
>index 2b5d48591738..25618eff6f2a 100644
>--- a/drivers/clk/mediatek/clk-cpumux.c
>+++ b/drivers/clk/mediatek/clk-cpumux.c
>@@ -150,6 +150,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
> 
> 	return PTR_ERR(hw);
> }
>+EXPORT_SYMBOL_GPL(mtk_clk_register_cpumuxes);
> 
> void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
> 				 struct clk_hw_onecell_data *clk_data)
>@@ -166,5 +167,6 @@ void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
> 		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
> 	}
> }
>+EXPORT_SYMBOL_GPL(mtk_clk_unregister_cpumuxes);
> 
> MODULE_LICENSE("GPL");
>diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>index 05a188c62119..41e60a7e8ff9 100644
>--- a/drivers/clk/mediatek/clk-mtk.c
>+++ b/drivers/clk/mediatek/clk-mtk.c
>@@ -459,6 +459,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
> 	mtk_free_clk_data(clk_data);
> 	return r;
> }
>+EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
> 
> int mtk_clk_simple_remove(struct platform_device *pdev)
> {
>@@ -472,5 +473,6 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
> 
> 	return 0;
> }
>+EXPORT_SYMBOL_GPL(mtk_clk_simple_remove);

Thanks, I need this too. I am preparing a patch to use mtk_clk_simple_remove/mtk_clk_simple_probe
for MT6779 clks first and maybe I can apply this to all MediaTek clk drivers.

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

thanks,
Miles
> 
> MODULE_LICENSE("GPL");
>diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
>index 179505549a7c..290ceda84ce4 100644
>--- a/drivers/clk/mediatek/reset.c
>+++ b/drivers/clk/mediatek/reset.c
>@@ -228,5 +228,6 @@ int mtk_register_reset_controller_with_dev(struct device *dev,
> 
> 	return 0;
> }
>+EXPORT_SYMBOL_GPL(mtk_register_reset_controller_with_dev);
> 
> MODULE_LICENSE("GPL");
>-- 
>2.35.1
>
>
