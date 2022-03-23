Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AB4E503D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbiCWKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243485AbiCWKY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:24:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C25BE4A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:23:23 -0700 (PDT)
X-UUID: 46d9b7a7f2694a19ad783069ea12ddeb-20220323
X-UUID: 46d9b7a7f2694a19ad783069ea12ddeb-20220323
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2143219222; Wed, 23 Mar 2022 18:23:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Mar 2022 18:23:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 18:23:15 +0800
Message-ID: <314a9839609898933bf19a6d29b83807391845af.camel@mediatek.com>
Subject: Re: [PATCH v2] soc: mediatek: mmsys: Add sw0_rst_offset for MT8192
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Date:   Wed, 23 Mar 2022 18:23:15 +0800
In-Reply-To: <20220323091932.10648-1-angelogioacchino.delregno@collabora.com>
References: <20220323091932.10648-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-03-23 at 17:19 +0800, AngeloGioacchino Del Regno wrote:
> MT8192 has the same sw0 reset offset as MT8186: add the parameter
> to be able to use mmsys as a reset controller for managing at
> least the DSI reset line.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
> 
> v2: Change the offset to 0x160 (as defined for MT8186). Thanks, Rex-
> BC!
> 

You are welcome!

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

>  drivers/soc/mediatek/mtk-mmsys.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c
> b/drivers/soc/mediatek/mtk-mmsys.c
> index 4fc4c2c9ea20..f69521fabcce 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -70,6 +70,7 @@ static const struct mtk_mmsys_driver_data
> mt8192_mmsys_driver_data = {
>  	.clk_driver = "clk-mt8192-mm",
>  	.routes = mmsys_mt8192_routing_table,
>  	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
> +	.sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
>  };
>  
>  static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data =
> {
> -- 
> 2.35.1
> 

