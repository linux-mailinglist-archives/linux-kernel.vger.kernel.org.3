Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A785E57E055
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbiGVK4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiGVK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:56:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9FAAF736
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:56:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z13so5965443wro.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r7CWCdwIAMzDd3zoduua/9CISn6ZHCpk120R6GZupfU=;
        b=daCf6gqnNfKXGOXG4U9K3VJ1SMpSgDsL69EeAz7wKLtPUeX2UIMuxZF1AKdICoKVO2
         Wtfi+lXpQfgPTi4QRU30iiEHASaSDAu90vak0bNCm+rNiUFwVXJfztELV4aU5LmrsyCE
         0kfXC4zCzwhRNiTA74e8TjqFM3Z18MTECotY2xDUGLWLRXxcx/3v1f4ekDUNeVfpuaxR
         jnmT2aqK0GX3bqNkDtM+KxRDO94NteoUx/8AvajB34y2K2jQDlQEJVNrt1B9Bh8+F11J
         zujgDxizv3ziw8jwQ5QuMc25fsK4NTv6NC1IzD8LVKPqoyL958NGDMdQazL1OJa24xJW
         yHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r7CWCdwIAMzDd3zoduua/9CISn6ZHCpk120R6GZupfU=;
        b=kW0yDq0+dgpQvcW9XEuYQ80XGyZcGfvMpH/ofhKHdkoJK9HeTwjvRDWNyMz0uwC/Xg
         NrUKraf1+zTqV/4pHr76CHKdhjeWgoBTbec2kBf0Tw4yMVQ5hqvYLWTRn4KA0vcYoGkE
         Efvuf65HwcY4MV+NIcQ1WfE3CdPv//zaX+bs7B/OPQrhydNmes0Z8z6gHGFXBoBdSIQd
         FVF+qDQH3B1acK7H/9fZECe2emZvOl31/KIPu0R4SAEmKVxSzY39FYbcuTDoZsDmxkt4
         41sEGGqqa0UvyoBcghIu2ZeeogafvysV80seGmIrwnalPnRTQeAY2yNJgfxSi5+IEGbv
         z1Lg==
X-Gm-Message-State: AJIora+MlrRkUlbtk8FUxc/Y19XX/PhBjIKHe2eBYypgWGBmgq+PnwCB
        aQ7vm+dr1T8DuQVvP2CX36s=
X-Google-Smtp-Source: AGRyM1vJqtnKC90hkOZHXGT5hyEFdcFIdaWrKndcd9fIZrAoauNgfrmdJBWpPy399943yQyhMvu/xw==
X-Received: by 2002:adf:f602:0:b0:21d:6662:f9e4 with SMTP id t2-20020adff602000000b0021d6662f9e4mr2268740wrp.353.1658487378481;
        Fri, 22 Jul 2022 03:56:18 -0700 (PDT)
Received: from [192.168.0.51] ([37.223.147.254])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b0039c5ab7167dsm8151740wmq.48.2022.07.22.03.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 03:56:17 -0700 (PDT)
Message-ID: <f6edd39f-3bca-d412-1140-e0a5b05200e4@gmail.com>
Date:   Fri, 22 Jul 2022 12:56:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] soc: mediatek:fix the compile warning which
 about svs_resume() and svs_suspend() When the static function are not be
 used,there gonna be a WARNNING for it. Ignore these will make the compile to
 sucess and should not effect any other thing.
Content-Language: en-US
To:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ye xingchen <ye.xingchen@zte.com.cn>
References: <20220722054609.1501177-1-ye.xingchen@zte.com.cn>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220722054609.1501177-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye Xingchen,

On 22/07/2022 07:46, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Reported-by: Zeal Robot<ye.xingchen@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thanks for your patch. Unfortunately that got already fixed in my tree with this 
patch:
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.19-next/soc&id=c749d676a33d99ee4c40d69ac2bf280270d890ad

Regards,
Matthias

> ---
>   drivers/soc/mediatek/mtk-svs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index dee8664a12fd..f411fcda8c6d 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1478,7 +1478,7 @@ static int svs_start(struct svs_platform *svsp)
>   	return 0;
>   }
>   
> -static int svs_suspend(struct device *dev)
> +__maybe_unused static int svs_suspend(struct device *dev)
>   {
>   	struct svs_platform *svsp = dev_get_drvdata(dev);
>   	struct svs_bank *svsb;
> @@ -1512,7 +1512,7 @@ static int svs_suspend(struct device *dev)
>   	return 0;
>   }
>   
> -static int svs_resume(struct device *dev)
> +__maybe_unused static int svs_resume(struct device *dev)
>   {
>   	struct svs_platform *svsp = dev_get_drvdata(dev);
>   	int ret;
