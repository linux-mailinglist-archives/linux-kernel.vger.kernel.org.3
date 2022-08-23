Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB759E5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbiHWPOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243678AbiHWPNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:13:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC000147409;
        Tue, 23 Aug 2022 03:21:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id d5so6940934wms.5;
        Tue, 23 Aug 2022 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6B2aaE05A19n1QO6TV80aKcnYR+rV1SXKdzbvIzbg4g=;
        b=bLwUshR/KjjpH4/M3KjtV2uBz2zBwVDBfJbT8OMDXEi28JH9ev8nDErPAUzw6MCuKQ
         8XCdE5RF//bResXNcpor8urzvQAewr8Qw4yE8f3lOiw3j0qGlJ2RWiuICSGvzYQ2sqPq
         Pp+X7m7OTnsindTQcXlzP/kZ2sePM7umzfpwB3uWscvCz6sY0CkL67Hkd8Fe0AkjqUwC
         ueFa6YLybLL7F+tHigREto25Nlx8GPI73fGaF8znQ+OHSm4DquSpo4qzMxhJMaeQCSxT
         9DO/e7GFNuqG7XZKPPmxsiS/kMzTYJij6f3P3eh17kK6XtKLaAyHXSBXfw9yTdp+hfKB
         cBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6B2aaE05A19n1QO6TV80aKcnYR+rV1SXKdzbvIzbg4g=;
        b=bZ9j4vnJKxm11XbfXvlZPheAMbS9YRcN7BbuwwbtFaf6A0M3eE1zZ2D8hc/oz7/Ooj
         skfLz2qkh4H4Kv4HUUscHqyDdn/eGuc9lgpyQ63jW2gNYUi29LRfHQCbt0cplqJ4zOOj
         Px5CUbbF2UyGsfSh/I34886qBlqpp78QJmfDL/SimbAKUKEVTu46lfX50b2aaIt7c5gj
         AicJrpjb+Xjr1nC204bDvvU+zlccPdt1M4G0KGLInFevNh2IB+cFuQr7Abccaj4VCcmE
         AMX5nmqCLwJRio4T+HXc4hiKQjn/UX9R2UrWNOem4YBMNYPu2vzjLWowEw/fu3mq1dst
         vyeg==
X-Gm-Message-State: ACgBeo3zuNaGcZRWrWAAmRH74HmEzKUZPpu2+fY/pCP2xz5AwNWcKcZ4
        MJjBIlgVumv++2TkMN8LCzAL8U1fg8Y=
X-Google-Smtp-Source: AA6agR5QGCmY2+lpv3pmfgjOGB+SAsuaFxjHbidzi3vOftokbwnF4eT1UErnSpCGR87umteRm5QVRQ==
X-Received: by 2002:a1c:3b04:0:b0:3a5:487c:6240 with SMTP id i4-20020a1c3b04000000b003a5487c6240mr1715787wma.152.1661250051576;
        Tue, 23 Aug 2022 03:20:51 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z6-20020a1cf406000000b003a2f2bb72d5sm24302590wma.45.2022.08.23.03.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 03:20:50 -0700 (PDT)
Message-ID: <44c86ad9-8158-0a8a-ce31-a995c8d10e0b@gmail.com>
Date:   Tue, 23 Aug 2022 12:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v26 07/10] soc: mediatek: mmsys: add mmsys for support 64
 reset bits
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        nfraprado@collabora.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220819061011.7672-1-nancy.lin@mediatek.com>
 <20220819061011.7672-8-nancy.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220819061011.7672-8-nancy.lin@mediatek.com>
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



On 19/08/2022 08:10, Nancy.Lin wrote:
> Add mmsys for support 64 reset bits. It is a preparation for MT8195
> vdosys1 HW reset. MT8195 vdosys1 has more than 32 reset bits.
> 
> 1. Add the number of reset bits in mmsys private data
> 2. move the whole "reset register code section" behind the
> "get mmsys->data" code section for getting the num_resets in mmsys->data.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Tested-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 40 +++++++++++++++++++++-----------
>   drivers/soc/mediatek/mtk-mmsys.h |  1 +
>   2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 999be064103b..20ae751ad8a7 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -20,6 +20,8 @@
>   #include "mt8195-mmsys.h"
>   #include "mt8365-mmsys.h"
>   
> +#define MMSYS_SW_RESET_PER_REG 32
> +
>   static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>   	.clk_driver = "clk-mt2701-mm",
>   	.routes = mmsys_default_routing_table,
> @@ -86,6 +88,7 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
>   	.routes = mmsys_default_routing_table,
>   	.num_routes = ARRAY_SIZE(mmsys_default_routing_table),
>   	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
> +	.num_resets = 32,
>   };
>   
>   static const struct mtk_mmsys_match_data mt8173_mmsys_match_data = {
> @@ -100,6 +103,7 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>   	.routes = mmsys_mt8183_routing_table,
>   	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
>   	.sw0_rst_offset = MT8183_MMSYS_SW0_RST_B,
> +	.num_resets = 32,
>   };
>   
>   static const struct mtk_mmsys_match_data mt8183_mmsys_match_data = {
> @@ -114,6 +118,7 @@ static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
>   	.routes = mmsys_mt8186_routing_table,
>   	.num_routes = ARRAY_SIZE(mmsys_mt8186_routing_table),
>   	.sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
> +	.num_resets = 32,
>   };
>   
>   static const struct mtk_mmsys_match_data mt8186_mmsys_match_data = {
> @@ -128,6 +133,7 @@ static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.routes = mmsys_mt8192_routing_table,
>   	.num_routes = ARRAY_SIZE(mmsys_mt8192_routing_table),
>   	.sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
> +	.num_resets = 32,

You didn't reply to Nicolas regarding the reset numbers. I actually agree with 
him that we will need the num_resets declared for all devices. Why do you think 
this is not the case?

Regards,
Matthias


>   };
>   
>   static const struct mtk_mmsys_match_data mt8192_mmsys_match_data = {
> @@ -288,13 +294,19 @@ static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned l
>   {
>   	struct mtk_mmsys *mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
>   	unsigned long flags;
> +	u32 offset;
> +	u32 reg;
> +
> +	offset = (id / MMSYS_SW_RESET_PER_REG) * sizeof(u32);
> +	id = id % MMSYS_SW_RESET_PER_REG;
> +	reg = mmsys->data->sw0_rst_offset + offset;
>   
>   	spin_lock_irqsave(&mmsys->lock, flags);
>   
>   	if (assert)
> -		mtk_mmsys_update_bits(mmsys, mmsys->data->sw0_rst_offset, BIT(id), 0, NULL);
> +		mtk_mmsys_update_bits(mmsys, reg, BIT(id), 0, NULL);
>   	else
> -		mtk_mmsys_update_bits(mmsys, mmsys->data->sw0_rst_offset, BIT(id), BIT(id), NULL);
> +		mtk_mmsys_update_bits(mmsys, reg, BIT(id), BIT(id), NULL);
>   
>   	spin_unlock_irqrestore(&mmsys->lock, flags);
>   
> @@ -351,18 +363,6 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	spin_lock_init(&mmsys->lock);
> -
> -	mmsys->rcdev.owner = THIS_MODULE;
> -	mmsys->rcdev.nr_resets = 32;
> -	mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
> -	mmsys->rcdev.of_node = pdev->dev.of_node;
> -	ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
> -		return ret;
> -	}
> -
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res) {
>   		dev_err(dev, "Couldn't get mmsys resource\n");
> @@ -384,6 +384,18 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   		mmsys->data = match_data->drv_data[0];
>   	}
>   
> +	spin_lock_init(&mmsys->lock);
> +
> +	mmsys->rcdev.owner = THIS_MODULE;
> +	mmsys->rcdev.nr_resets = mmsys->data->num_resets;
> +	mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
> +	mmsys->rcdev.of_node = pdev->dev.of_node;
> +	ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
> +		return ret;
> +	}
> +
>   #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>   	ret = cmdq_dev_get_client_reg(dev, &mmsys->cmdq_base, 0);
>   	if (ret)
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index f01ba206481d..20a271b80b3b 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -92,6 +92,7 @@ struct mtk_mmsys_driver_data {
>   	const struct mtk_mmsys_routes *routes;
>   	const unsigned int num_routes;
>   	const u16 sw0_rst_offset;
> +	const u32 num_resets;
>   };
>   
>   struct mtk_mmsys_match_data {
