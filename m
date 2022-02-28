Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E26C4C6A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiB1LVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiB1LVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:21:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80A3BA51;
        Mon, 28 Feb 2022 03:20:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p4so5478323wmg.1;
        Mon, 28 Feb 2022 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NccQv4LgTdxbFFV06no50kiwLRDXEmMnkBFh0QCPhBk=;
        b=eJNhF7g9oc4xDjbR6Yf3EM+nErRCpUStHnVBRBwnjtvZ6xgdHPysfTRYYU+MZD1XRT
         nsKGXw2ByxKqC44mQl5r7boAD7j9hMUi0i44uoVPSGjDa7NdafIS0Ej1rwA3/NBVVgV2
         chA7ZPL/rGOzc7PJTjZ/SQrN2403vVHE2Hm3/qsajUIUW/yV3JcJSzXGrZhs458aC6ZK
         E0idJ9CC3XKoWjf/43G8zyBrHNP12gbW+lbR/1l/ltFSR7x/do84aiQpqKBF7pf3/jax
         5vSCBFWZveOn71YqVlKdN+Er/EsbW1A7oLhJrjo/FW7n5aXUlwrjR2nrOyhvv1G0gcIg
         w2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NccQv4LgTdxbFFV06no50kiwLRDXEmMnkBFh0QCPhBk=;
        b=eAe1KJSpxu+8vHF/QG6Pb/CwVR4EYhPfAlvhrCL3kj/bTNgv9TvbzBn8Ex8KOKtl6a
         m//KGguFAN0f/RuF+VrOO5wInYtQBIirqv5qBHMC66UfHgtwcsuMotkUaIJyQVlJ5s6e
         vTMqLu4Vi/HqHPVCSZFM3uVzz1CnnpIyAu10tC0n9/C9bsvXohrTntr0gR39EXBoooZo
         ouIQkPm6mn62EmZz3xfZYBmXFapTzJE/5BblMtft2CoV2UNhcOLNVjXHwHfJVl65qarY
         DfMdkq3w+0+mmtk0BoI3UKmREjhaF8yttmTX/TZ6lnp9gFk+ChEHmS+Nc9nOobnuQrMN
         ELnA==
X-Gm-Message-State: AOAM532wvwPAaBnFcNXA4Wx2ZpumhLFyCb3k09W3f1uypJQrpFEln8Cv
        uKgXMQJ795xzkvVgLG4V/r0=
X-Google-Smtp-Source: ABdhPJxmBl1EpcRObVtB/hkFZeK7EFaScaFTcOoQofuXzqGQWUTkeSfN2I7XpWEitYnsdxfY9kTeVQ==
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr12762339wmj.98.1646047223541;
        Mon, 28 Feb 2022 03:20:23 -0800 (PST)
Received: from [192.168.0.14] (static-63-182-85-188.ipcom.comunitel.net. [188.85.182.63])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm12245755wmq.8.2022.02.28.03.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 03:20:23 -0800 (PST)
Message-ID: <ad5e8d2c-4347-00a7-9e34-18601c6e1e11@gmail.com>
Date:   Mon, 28 Feb 2022 12:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4,3/5] soc: mediatek: mmsys: add mt8186 mmsys routing
 table
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        jassisinghbrar@gmail.com, fparent@baylibre.com,
        yongqiang.niu@mediatek.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220222052803.3570-1-rex-bc.chen@mediatek.com>
 <20220222052803.3570-4-rex-bc.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220222052803.3570-4-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/02/2022 06:28, Rex-BC Chen wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Add new routing table for MT8186.
> In MT8186, there are two routing pipelines for internal and external
> display.
> 
> Internal display: OVL0->RDMA0->COLOR0->CCORR0->AAL0->GAMMA->POSTMASK0->
> 		  DITHER->DSI0
> External display: OVL_2L0->RDMA1->DPI0
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

applied, thanks!

> ---
>   drivers/soc/mediatek/mt8186-mmsys.h | 113 ++++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c    |  11 +++
>   2 files changed, 124 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mt8186-mmsys.h
> 
> diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
> new file mode 100644
> index 000000000000..7de329f2d729
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8186-mmsys.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
> +#define __SOC_MEDIATEK_MT8186_MMSYS_H
> +
> +#define MT8186_MMSYS_OVL_CON			0xF04
> +#define MT8186_MMSYS_OVL0_CON_MASK			0x3
> +#define MT8186_MMSYS_OVL0_2L_CON_MASK			0xC
> +#define MT8186_OVL0_GO_BLEND				BIT(0)
> +#define MT8186_OVL0_GO_BG				BIT(1)
> +#define MT8186_OVL0_2L_GO_BLEND				BIT(2)
> +#define MT8186_OVL0_2L_GO_BG				BIT(3)
> +#define MT8186_DISP_RDMA0_SOUT_SEL		0xF0C
> +#define MT8186_RDMA0_SOUT_SEL_MASK			0xF
> +#define MT8186_RDMA0_SOUT_TO_DSI0			(0)
> +#define MT8186_RDMA0_SOUT_TO_COLOR0			(1)
> +#define MT8186_RDMA0_SOUT_TO_DPI0			(2)
> +#define MT8186_DISP_OVL0_2L_MOUT_EN		0xF14
> +#define MT8186_OVL0_2L_MOUT_EN_MASK			0xF
> +#define MT8186_OVL0_2L_MOUT_TO_RDMA0			BIT(0)
> +#define MT8186_OVL0_2L_MOUT_TO_RDMA1			BIT(3)
> +#define MT8186_DISP_OVL0_MOUT_EN		0xF18
> +#define MT8186_OVL0_MOUT_EN_MASK			0xF
> +#define MT8186_OVL0_MOUT_TO_RDMA0			BIT(0)
> +#define MT8186_OVL0_MOUT_TO_RDMA1			BIT(3)
> +#define MT8186_DISP_DITHER0_MOUT_EN		0xF20
> +#define MT8186_DITHER0_MOUT_EN_MASK			0xF
> +#define MT8186_DITHER0_MOUT_TO_DSI0			BIT(0)
> +#define MT8186_DITHER0_MOUT_TO_RDMA1			BIT(2)
> +#define MT8186_DITHER0_MOUT_TO_DPI0			BIT(3)
> +#define MT8186_DISP_RDMA0_SEL_IN		0xF28
> +#define MT8186_RDMA0_SEL_IN_MASK			0xF
> +#define MT8186_RDMA0_FROM_OVL0				0
> +#define MT8186_RDMA0_FROM_OVL0_2L			2
> +#define MT8186_DISP_DSI0_SEL_IN			0xF30
> +#define MT8186_DSI0_SEL_IN_MASK				0xF
> +#define MT8186_DSI0_FROM_RDMA0				0
> +#define MT8186_DSI0_FROM_DITHER0			1
> +#define MT8186_DSI0_FROM_RDMA1				2
> +#define MT8186_DISP_RDMA1_MOUT_EN		0xF3C
> +#define MT8186_RDMA1_MOUT_EN_MASK			0xF
> +#define MT8186_RDMA1_MOUT_TO_DPI0_SEL			BIT(0)
> +#define MT8186_RDMA1_MOUT_TO_DSI0_SEL			BIT(2)
> +#define MT8186_DISP_RDMA1_SEL_IN		0xF40
> +#define MT8186_RDMA1_SEL_IN_MASK			0xF
> +#define MT8186_RDMA1_FROM_OVL0				0
> +#define MT8186_RDMA1_FROM_OVL0_2L			2
> +#define MT8186_RDMA1_FROM_DITHER0			3
> +#define MT8186_DISP_DPI0_SEL_IN			0xF44
> +#define MT8186_DPI0_SEL_IN_MASK				0xF
> +#define MT8186_DPI0_FROM_RDMA1				0
> +#define MT8186_DPI0_FROM_DITHER0			1
> +#define MT8186_DPI0_FROM_RDMA0				2
> +
> +static const struct mtk_mmsys_routes mmsys_mt8186_routing_table[] = {
> +	{
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
> +		MT8186_DISP_OVL0_MOUT_EN, MT8186_OVL0_MOUT_EN_MASK,
> +		MT8186_OVL0_MOUT_TO_RDMA0
> +	},
> +	{
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
> +		MT8186_DISP_RDMA0_SEL_IN, MT8186_RDMA0_SEL_IN_MASK,
> +		MT8186_RDMA0_FROM_OVL0
> +	},
> +	{
> +		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
> +		MT8186_MMSYS_OVL_CON, MT8186_MMSYS_OVL0_CON_MASK,
> +		MT8186_OVL0_GO_BLEND
> +	},
> +	{
> +		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
> +		MT8186_DISP_RDMA0_SOUT_SEL, MT8186_RDMA0_SOUT_SEL_MASK,
> +		MT8186_RDMA0_SOUT_TO_COLOR0
> +	},
> +	{
> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +		MT8186_DISP_DITHER0_MOUT_EN, MT8186_DITHER0_MOUT_EN_MASK,
> +		MT8186_DITHER0_MOUT_TO_DSI0,
> +	},
> +	{
> +		DDP_COMPONENT_DITHER, DDP_COMPONENT_DSI0,
> +		MT8186_DISP_DSI0_SEL_IN, MT8186_DSI0_SEL_IN_MASK,
> +		MT8186_DSI0_FROM_DITHER0
> +	},
> +	{
> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA1,
> +		MT8186_DISP_OVL0_2L_MOUT_EN, MT8186_OVL0_2L_MOUT_EN_MASK,
> +		MT8186_OVL0_2L_MOUT_TO_RDMA1
> +	},
> +	{
> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA1,
> +		MT8186_DISP_RDMA1_SEL_IN, MT8186_RDMA1_SEL_IN_MASK,
> +		MT8186_RDMA1_FROM_OVL0_2L
> +	},
> +	{
> +		DDP_COMPONENT_OVL_2L0, DDP_COMPONENT_RDMA1,
> +		MT8186_MMSYS_OVL_CON, MT8186_MMSYS_OVL0_2L_CON_MASK,
> +		MT8186_OVL0_2L_GO_BLEND
> +	},
> +	{
> +		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
> +		MT8186_DISP_RDMA1_MOUT_EN, MT8186_RDMA1_MOUT_EN_MASK,
> +		MT8186_RDMA1_MOUT_TO_DPI0_SEL
> +	},
> +	{
> +		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
> +		MT8186_DISP_DPI0_SEL_IN, MT8186_DPI0_SEL_IN_MASK,
> +		MT8186_DPI0_FROM_RDMA1
> +	},
> +};
> +
> +#endif /* __SOC_MEDIATEK_MT8186_MMSYS_H */
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 1e448f1ffefb..0da25069ffb3 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -15,6 +15,7 @@
>   #include "mtk-mmsys.h"
>   #include "mt8167-mmsys.h"
>   #include "mt8183-mmsys.h"
> +#include "mt8186-mmsys.h"
>   #include "mt8192-mmsys.h"
>   #include "mt8365-mmsys.h"
>   
> @@ -56,6 +57,12 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>   	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
>   };
>   
> +static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
> +	.clk_driver = "clk-mt8186-mm",
> +	.routes = mmsys_mt8186_routing_table,
> +	.num_routes = ARRAY_SIZE(mmsys_mt8186_routing_table),
> +};
> +
>   static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8192-mm",
>   	.routes = mmsys_mt8192_routing_table,
> @@ -242,6 +249,10 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>   		.compatible = "mediatek,mt8183-mmsys",
>   		.data = &mt8183_mmsys_driver_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt8186-mmsys",
> +		.data = &mt8186_mmsys_driver_data,
> +	},
>   	{
>   		.compatible = "mediatek,mt8192-mmsys",
>   		.data = &mt8192_mmsys_driver_data,
