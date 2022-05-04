Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C650B519FE8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiEDMuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349960AbiEDMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:50:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA812CE37;
        Wed,  4 May 2022 05:46:34 -0700 (PDT)
X-UUID: ff51b7b729c14e0596b313d43118dd51-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:7cb0b557-e4f6-4203-a9cd-3b6a0786fdd6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:7cb0b557-e4f6-4203-a9cd-3b6a0786fdd6,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:81522c16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: ff51b7b729c14e0596b313d43118dd51-20220504
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1635945887; Wed, 04 May 2022 20:46:28 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 20:46:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 20:46:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 4 May 2022 20:46:27 +0800
Message-ID: <fda797664ad3cde1143838bdf63cc587459b2c2f.camel@mediatek.com>
Subject: Re: [PATCH 09/13] clk: mediatek: reset: Export
 mtk_register_reset_controller symbols
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "Tinghan Shen" <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        "Sam Shih" <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 4 May 2022 20:46:22 +0800
In-Reply-To: <20220504122601.335495-10-y.oudjana@protonmail.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
         <20220504122601.335495-10-y.oudjana@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 16:25 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Export mtk_register_reset_controller and
> mtk_register_reset_controller_set_clr to support building reset
> drivers as modules.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  drivers/clk/mediatek/reset.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/reset.c
> b/drivers/clk/mediatek/reset.c
> index bcec4b89f449..6c2effe6afef 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -129,6 +129,7 @@ void mtk_register_reset_controller(struct
> device_node *np,
>  	mtk_register_reset_controller_common(np, num_regs, regofs,
>  		&mtk_reset_ops);
>  }
> +EXPORT_SYMBOL_GPL(mtk_register_reset_controller);
>  
>  void mtk_register_reset_controller_set_clr(struct device_node *np,
>  	unsigned int num_regs, int regofs)
> @@ -136,5 +137,6 @@ void mtk_register_reset_controller_set_clr(struct
> device_node *np,
>  	mtk_register_reset_controller_common(np, num_regs, regofs,
>  		&mtk_reset_ops_set_clr);
>  }
> +EXPORT_SYMBOL_GPL(mtk_register_reset_controller_set_clr);
>  
>  MODULE_LICENSE("GPL");

Hello Yassine,

Thanks for your patch for mediatek clk reset.
But I have another series to cleanup mediatek clk reset drivers and
most of my patches are reviewed.
Please refer to
https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849

BRs,
Rex

