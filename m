Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B052056B482
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiGHI3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiGHI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:29:33 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9111F2FE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:29:32 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id u13so8147237iln.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Voj254B0p3wkYRVS8bJszZbCEXbEP6UJbrfd6/44x4s=;
        b=NOoI0w9SPNgApsuy7D0rRt//K01GWYCh2YVqOTCqwwVhAsF0MkiJHZOx/w8Kz/UkGu
         U9iFfyc813badJjJwM/J+ab0brj853pwzahsuyw5AGS6vC2HI32dZHU567dRWSIANPf9
         f1IKCGaEMwy/XzQMj9lFhIneZ1+F666VhWCXm2K0OwPN6Vgl+ED1h+SIjHkncMeAqyy0
         ss5xU7ZwXafKpFOQkKB/g/HoG/rl+UMnAc1aeCsx2R7DnnjCRDF7cN/NAzuRztg7ngS1
         1aTmSMXn+Vmn59wggVifPMudq3P8oh5wog3n4yNsY3JxUXqkPFDZQSyGSnDVkr00vdIQ
         DL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Voj254B0p3wkYRVS8bJszZbCEXbEP6UJbrfd6/44x4s=;
        b=kiQU0+aizW5gzTnMD3jzq6SPNWZiRZdhxkr0EJiVh90mfM2Nv1mce7YbCzUoid7hLO
         csf3ln21Zx47uMzCPsL1XwaQ05d++c0RkHDHF5y7xaK4KaHOK5gQDh6myzxSz26nRupH
         N6LExxEXbjogDUD6sXx0IO3eSzgx6DsIvDlLAj6oV2Q6rBPca+HEW7mNhspmPCk3/L6i
         jM4gBOV6GCcklNaiCtYlw3pxCQ9JLuY77tGsKwA6S1Fcn12hdFS1zb5N4WCamb7dzagG
         OcrzVQbjiOQXk5MzzsuYFMYfzOYIz3ghEqUiO1/WcZiWzKLSLgZaauB6GInYpgep7yrw
         Vytg==
X-Gm-Message-State: AJIora8X/nEFE+jVA5XPOtMjf18JrHUWMD+oT+Z4lv0eo5w9kCI9PHrS
        +jEbfgLNdNW4W3OOu9u+czGx64vPXhbo7d+N
X-Google-Smtp-Source: AGRyM1szrpKQ04HJXTHsJ0vRoWy6DvJYkFZppXH8z8QoaTM7mI1fD693J9v50GHzhx539e5duO2YmA==
X-Received: by 2002:a05:6e02:152c:b0:2db:34fc:a61f with SMTP id i12-20020a056e02152c00b002db34fca61fmr1395111ilu.139.1657268972071;
        Fri, 08 Jul 2022 01:29:32 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k9-20020a6b3c09000000b00669a3f60e99sm18753936iob.31.2022.07.08.01.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 01:29:30 -0700 (PDT)
Message-ID: <0c01efca-d350-a922-2beb-453b24e9af48@gmail.com>
Date:   Fri, 8 Jul 2022 10:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soc: mediatek: mutex: Simplify with
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220623121701.107512-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220623121701.107512-1-angelogioacchino.delregno@collabora.com>
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



On 23/06/2022 14:17, AngeloGioacchino Del Regno wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> While at it, also remove a redundant call to of_address_to_resource(),
> as this was getting the address of the same resource index 0: we can
> as well get the iostart from the 'regs' pointer.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-mutex.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index 60cbafea577e..ca8440fb48cd 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -787,7 +787,7 @@ static int mtk_mutex_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct mtk_mutex_ctx *mtx;
> -	struct resource *regs, addr;
> +	struct resource *regs;
>   	int i;
>   #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>   	int ret;
> @@ -811,11 +811,12 @@ static int mtk_mutex_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	if (of_address_to_resource(dev->of_node, 0, &addr) < 0) {
> -		dev_err(dev, "Failed to get addr\n");
> -		return -EINVAL;
> +	mtx->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
> +	if (IS_ERR(mtx->regs)) {
> +		dev_err(dev, "Failed to map mutex registers\n");
> +		return PTR_ERR(mtx->regs);
>   	}
> -	mtx->addr = addr.start;
> +	mtx->addr = regs->start;
>   
>   #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>   	ret = cmdq_dev_get_client_reg(dev, &mtx->cmdq_reg, 0);
> @@ -823,13 +824,6 @@ static int mtk_mutex_probe(struct platform_device *pdev)
>   		dev_dbg(dev, "No mediatek,gce-client-reg!\n");
>   #endif
>   
> -	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mtx->regs = devm_ioremap_resource(dev, regs);
> -	if (IS_ERR(mtx->regs)) {
> -		dev_err(dev, "Failed to map mutex registers\n");
> -		return PTR_ERR(mtx->regs);
> -	}
> -
>   	platform_set_drvdata(pdev, mtx);
>   
>   	return 0;
