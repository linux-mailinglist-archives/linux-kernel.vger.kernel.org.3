Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAD4F7B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiDGJOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243645AbiDGJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:13:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF14CFDE19;
        Thu,  7 Apr 2022 02:11:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 006981F45D10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649322699;
        bh=rEVxd+xPGVMs/CpV12WmQkqmi9WRB6BMXNDaHReiDOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GrHSP7XETyXeNfXB7qFfIC5PMGX8gULYeCFWgeYatt24/x3Cr++PSBrZXXEDOvVQD
         zs/hr7ro9iJT7vjFMHNtOcMVD8QHi0pAnLEnnAcdmYxUxe1fTTq/obSmiTWobVpv3E
         hZRrdJd8Kgj2aZqdQjH3pcoY+ZJ4oWJHUmNaiSP0NJv+reCJ1XFkG1PxhPkzFpoRNG
         espsRguBhGk7UZj63QcytFBdirmkJRI4z8iQC5UgB2I/SbPZGvrlwQgg1LTZKfey3t
         kh4ISTovwspxDqmtknZb180gcLm95u4P6CNEQFX2DHMUeou+QzWEClZ5WL31R9Yewh
         m+zptKh4mDY7A==
Message-ID: <8d5c41c0-ac7c-ed1e-726b-0d738bf22fed@collabora.com>
Date:   Thu, 7 Apr 2022 11:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND v17 3/7] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys0
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        postmaster@vger.kernel.org, hsinyi@chromium.org,
        fshao@chromium.org, moudy.ho@mediatek.com, roy-cw.yeh@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220407030409.9664-1-jason-jh.lin@mediatek.com>
 <20220407030409.9664-4-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220407030409.9664-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/22 05:04, jason-jh.lin ha scritto:
> 1. Add mt8195 mmsys compatible for vdosys0.
> 2. Add mt8195 routing table settings and fix build fail.
> 3. Add clock name, clock driver name and routing table into the driver data
>     of mt8195 vdosys0.
> 4. Add get match data by clock name function and clock platform labels
>     to identify which mmsys node is corresponding to vdosys0.
> 
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   2 +-
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   6 +-
>   drivers/soc/mediatek/mt8167-mmsys.h         |   2 +-
>   drivers/soc/mediatek/mt8183-mmsys.h         |   2 +-
>   drivers/soc/mediatek/mt8186-mmsys.h         |   4 +-
>   drivers/soc/mediatek/mt8192-mmsys.h         |   4 +-
>   drivers/soc/mediatek/mt8195-mmsys.h         | 370 ++++++++++++++++++++
>   drivers/soc/mediatek/mt8365-mmsys.h         |   4 +-
>   drivers/soc/mediatek/mtk-mmsys.c            |  62 ++++
>   drivers/soc/mediatek/mtk-mmsys.h            |   1 +
>   drivers/soc/mediatek/mtk-mutex.c            |   8 +-
>   include/linux/soc/mediatek/mtk-mmsys.h      |  13 +-
>   12 files changed, 461 insertions(+), 17 deletions(-)
>   create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
> 

..snip..

> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 4fc4c2c9ea20..b2fa239c5f5f 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -4,6 +4,8 @@
>    * Author: James Liao <jamesjj.liao@mediatek.com>
>    */
>   
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/io.h>
> @@ -17,6 +19,7 @@
>   #include "mt8183-mmsys.h"
>   #include "mt8186-mmsys.h"
>   #include "mt8192-mmsys.h"
> +#include "mt8195-mmsys.h"
>   #include "mt8365-mmsys.h"
>   
>   static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
> @@ -72,12 +75,24 @@ static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
>   };
>   
> +static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data = {
> +	.clk_name = "cfg_vdo0",
> +	.clk_driver = "clk-mt8195-vdo0",
> +	.routes = mmsys_mt8195_routing_table,
> +	.num_routes = ARRAY_SIZE(mmsys_mt8195_routing_table),
> +};
> +
>   static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8365-mm",
>   	.routes = mt8365_mmsys_routing_table,
>   	.num_routes = ARRAY_SIZE(mt8365_mmsys_routing_table),
>   };
>   
> +static const struct of_device_id mtk_clk_platform_labels[] = {
> +	{ .compatible = "mediatek,mt8195-mmsys",
> +	  .data = (void *)"clk-mt8195"},

I have a hunch that MT8195 won't be the first and last SoC having multiple
mmsys channels. I would tend to think that there will be more....

....so, to make it clean from the beginning, I think that you should, at
this point, assign a struct to that .data pointer, instead of declaring a
drvdata struct into mtk_mmsys_get_match_data_by_clk_name().

Besides, I think that this kind of usage for __clk_get_name() may be an API
abuse... but I'm not sure about that... in any case:
- if it's not an abuse, then you should simply pass mt8195_vdosys0_driver_data,
   or an array of pointers to mtk_mmsys_driver_data;
- if this is an abuse, you can do the same checks by looking at the iostart
   (mmio base address) of the vdosys{0,1} node(s).

Honestly, though, I'm not even sure that you need this different of_device_id
array here... since you could simply wrap the mtk_mmsys_driver_data in the
of_match_mtk_mmsys that you have below... here's another idea:

struct mtk_mmsys_match_data {
	const struct mtk_mmsys_driver_data *drv_data[];
	unsigned short num_drv_data;
};

...so that:

static int some_function_handling_multi_mmsys(struct mtk_mmsys *mmsys,
					      struct mtk_mmsys_match_data *match)
{
	int i;

	i = [ logic to find the right match->drv_data entry here ]

	return i;
}

static int mtk_mmsys_probe()
{
	.... variables, something else ....

	if (match_data->num_drv_data > 1) {
		/* This SoC has multiple mmsys channels */
		ret = some_function_handling_multi_mmsys(mmsys);
		if (ret < 0)
			return ret;

		mmsys->data = match_data->drv_data[ret];
	} else {
		dev_dbg(dev, "Using single mmsys channel\n");
		mmsys->data = match_data->drv_data[0];
	}

	...everything else that mtk_mmsys_probe does ...
}

What I'm trying to communicate with this is that the currently chosen solution
looks a bit fragile and needs to be made robust.
In comparison, even if it's not technically right to have two different compatibles
for the same hardware (and shall not be done), the former solution, even if wrong,
was more robust than this one, imo.

Regards,
Angelo
