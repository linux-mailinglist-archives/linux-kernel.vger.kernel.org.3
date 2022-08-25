Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11965A1205
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbiHYN0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiHYN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:26:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7451A7204
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:26:41 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j26so10285480wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=l8Q++Ru9csFLxgnhJzeufcmNCmRUsGcf17MVPKICnH0=;
        b=RxAreS/eI7mqZ/PdSSm5cTrGl2S3fwpt9sYhIyYeA6E6mXtYUB5RhW0PYqMCq5rnLM
         F2kxTf1V1gdLJG+AsDxYQSjzA8MJMc9SpB5iZfhVSnIE/oKCXS2Bda/jx9OxORBg4DNM
         eomf2vopklY5SNbFbiMsXos8FLPKZ5Hdyd+iQHLusTpYz7B2IjPIv5jCCG14Jhv5O8Vq
         vUVhqUdRQSbsdK5ls+m8WVRqljDQsor+rm3ZM2YNVjhW3zWzxR2loApzhEY4nQ98tG3L
         1JZCnzWjOjBjg2Ws8ONS2tOcWZcuupOCoo1U3yjYeuJ4w3I/YwJ6LTUX6kjIrxzY0jF+
         K0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=l8Q++Ru9csFLxgnhJzeufcmNCmRUsGcf17MVPKICnH0=;
        b=rZtsCbDqW5oHylO1lOjIo67KqPNq5DPJ9ihMCFCkV5aa/NcDiyGTLADn0rGIDsiljo
         RGnJavgflpWOL3szD89E/ZpEJoHL+C5V7ZGAN1KHP/GJXsVRtt765StOQHNHFkbWQnEN
         huvI9o39wXDFOGD/r9oiyAy0pwuTpeCxjZc9y/wkfuhToI5U61P136nh3ocXeNRq1Efj
         2fP/Fa9eY4T92hBy75szmT8PYVnJ0DiO3f2ndMVeWrGHdntOOef+WlgbnLzsVBKyFQRs
         gUuODdGiCmtd2IFPAivHXAC4HOqaizCwRDgiMi2bGvlIYQK+8c9DoGzxwLfxnilX3/6G
         2IDw==
X-Gm-Message-State: ACgBeo2LWj/Rby6YrpFkAQLuIcEyifGW7RBdplDJ7DIX8WCe8ed5E2VK
        hqSAAEFRoU3lVvWHmUIp99w=
X-Google-Smtp-Source: AA6agR4oST7c6wvGCrpkNjV083dfHtO+/pRsLsJceDFTNG5zoXEEgag6nl7bW7voHJs1KwSZSbo3nw==
X-Received: by 2002:a7b:ca42:0:b0:3a6:9d:a444 with SMTP id m2-20020a7bca42000000b003a6009da444mr8538802wml.51.1661434000373;
        Thu, 25 Aug 2022 06:26:40 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q1-20020a056000136100b0021d80f53324sm20206297wrz.7.2022.08.25.06.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:26:39 -0700 (PDT)
Message-ID: <c757c143-44b4-a6f9-299a-6a35b05d9f64@gmail.com>
Date:   Thu, 25 Aug 2022 15:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/6] soc: mediatek: mtk-svs: Switch to platform_get_irq()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
 <20220726141653.177948-3-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220726141653.177948-3-angelogioacchino.delregno@collabora.com>
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



On 26/07/2022 16:16, AngeloGioacchino Del Regno wrote:
> Instead of using irq_of_parse_and_map() to retrieve the interrupt from
> devicetree, switch to platform_get_irq() instead: this function will
> conveniently also write an error message in case the irq is not found.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks.

> ---
>   drivers/soc/mediatek/mtk-svs.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 600492dc334c..ee990acfc2d5 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2757,8 +2757,7 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
>   static int svs_probe(struct platform_device *pdev)
>   {
>   	struct svs_platform *svsp;
> -	unsigned int svsp_irq;
> -	int ret;
> +	int svsp_irq, ret;
>   
>   	svsp = svs_platform_probe(pdev);
>   	if (IS_ERR(svsp))
> @@ -2776,7 +2775,12 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_free_resource;
>   	}
>   
> -	svsp_irq = irq_of_parse_and_map(svsp->dev->of_node, 0);
> +	svsp_irq = platform_get_irq(pdev, 0);
> +	if (svsp_irq < 0) {
> +		ret = svsp_irq;
> +		goto svs_probe_free_resource;
> +	}
> +
>   	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
>   					svsp->irqflags | IRQF_ONESHOT,
>   					svsp->name, svsp);
