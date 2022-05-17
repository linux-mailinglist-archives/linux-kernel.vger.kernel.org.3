Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16B8529DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbiEQJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244777AbiEQJTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:19:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EBF2CE24
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:18:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so995836wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dF32UB4o24SEGA28gcaOp4TCwrJXmpV9PUTvVLdg0J4=;
        b=BZwlrbpmJ8zOdGxjTeCtczfI1ZQYklBVK8c74MaVj1WY7Y9o4Aqd5kP2tukaQ//Ajn
         L9FoT95VSj7Sz1ZIjxgaID8c7SLDINhsjeco4wxhWbi9KlANWpFAiaNajD4UnlSPvANy
         GixXJY6sCLTLXVIMJLw82bL8A4Q1zlgGWikn8SRbn4R0BgaFXxzvHEcr5q4trKK+xo9K
         zyi8q1Gtzgm42QpK2FUXsRx8F/lGCaAu4zLfURfBL2odsfy3MjAMKAxGsluxwPaH9/Yd
         kuZQfnCpfsyXZkoOfnEy930Zh+sTpqqmCoCHhAvE6I/iExZzyWApPBnrw1gZYJXDMwTk
         5LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dF32UB4o24SEGA28gcaOp4TCwrJXmpV9PUTvVLdg0J4=;
        b=H5oKR8Xa9BgO88CuMfpE0tcuDC3xXeDyuGOWQH4hir4qp/hoN3VkWMDUsvAdcPDOoF
         cUgTcMSIxo4idX2xsTJgXhY8k6fSr+uNWSAQ0eCc1siLnRAJ4sqVAjxF1BK4DNLwcCr2
         cgnXrJ96jcKtLPVC8Wo0o3d3qC8EfFYTY3hwCeIqLGcJQbck3sXHU9HVVd0Byld0aggT
         apGWzLByVXtb3DP7witdaBYhoNNF+8oKqNzsUyi0Lytix/RN7Ctg+fJwdcEl03Zx2H+p
         4u0BcPpAZBYU9VujBYPue2zeldu2IAGJU1u1PPv/EIkKbBAihA8UKh6gcH5WEF8GrKE+
         mWWA==
X-Gm-Message-State: AOAM530n0zNafhKbjDWiYra7ApeCagJNoamvr0e2BaOPLwEBQHROOYdX
        CIn4fsegcj7eMusQA3q3aMY=
X-Google-Smtp-Source: ABdhPJz9/ND0sjG0FG/5GKRjuvvp1OlseQo5NsUhcDFerQCp7aM3NgAUNbyM6QtWMQSe0E0mLLpHDg==
X-Received: by 2002:a7b:ce8f:0:b0:394:46ae:549e with SMTP id q15-20020a7bce8f000000b0039446ae549emr20844385wmj.54.1652779136830;
        Tue, 17 May 2022 02:18:56 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p26-20020adfa21a000000b0020c61af5e1fsm11469542wra.51.2022.05.17.02.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 02:18:56 -0700 (PDT)
Message-ID: <ad736290-2e01-f867-d2ec-867a4385005a@gmail.com>
Date:   Tue, 17 May 2022 11:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 3/5] soc: mediatek: pwrap: Move and check return value
 of platform_get_irq()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com
References: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
 <20220516124659.69484-4-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220516124659.69484-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2022 14:46, AngeloGioacchino Del Regno wrote:
> Move the call to platform_get_irq() earlier in the probe function
> and check for its return value: if no interrupt is specified, it
> wouldn't make sense to try to call devm_request_irq() so, in that
> case, we can simply return early.
> 
> Moving the platform_get_irq() call also makes it possible to use
> one less goto, as clocks aren't required at that stage.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 852514366f1f..332cbcabc299 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -2204,6 +2204,10 @@ static int pwrap_probe(struct platform_device *pdev)
>   	if (!wrp)
>   		return -ENOMEM;
>   
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
>   	platform_set_drvdata(pdev, wrp);
>   
>   	wrp->master = of_device_get_match_data(&pdev->dev);
> @@ -2316,7 +2320,6 @@ static int pwrap_probe(struct platform_device *pdev)
>   	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
>   		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>   
> -	irq = platform_get_irq(pdev, 0);

For better readability of the code I'd prefer to keep platform_get_irq next to 
devm_request_irq. I understand that you did this change so that you don't have 
to code
if (irq < 0) {
     ret = irq;
     goto err_out2;
}

Or do I miss something?

Regards,
Matthias

>   	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
>   			       IRQF_TRIGGER_HIGH,
>   			       "mt-pmic-pwrap", wrp);
