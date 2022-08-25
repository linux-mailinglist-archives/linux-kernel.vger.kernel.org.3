Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070CB5A1186
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbiHYNJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbiHYNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:09:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337269F0F7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:09:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d16so19266453wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6fe3qO+g9J+l3GlHLyNAAJaJBk5cDlmle87a/iuxSEg=;
        b=HrYjJQHH4UNfHir+6sbLkd8xKcOuyL9rnFxbzSxD82Vo55TqgER5xIoQCQjLwM+mOM
         ozyno0lTMmEgfM0Gn+LWgzNiIDo9Frkp4xho0pLrq2L89a1SAyNY8HgwnttwGvQPvMgm
         gtewMPDUQDp0txBorhiBcFAPfenSj0K6UoJV9zudWZlTVslpt+v0LleOeJLz1nPxnRys
         AFe19H+UQZ4Q1Mj5ejD261sAGPMd5NIJvCMmdLKfX92tkJvTYg+zVGa5o+FbFtLOzqE6
         iRCDaFDtx4P/LGbWQUtWdSYKJhQi6HeacqvtwGTfxKI/gmAa5srG5NknZXgO4oSYgpPg
         M14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6fe3qO+g9J+l3GlHLyNAAJaJBk5cDlmle87a/iuxSEg=;
        b=lvl+M7KHCi1NSuwvksLtPLodh+Bkbt+JdyX57ZikRcUd52uh06gKtVb0GuDkzjS13a
         R4JJnvXCjCwf90S8ZXkzF1aaW3PAWmVkxPg9QVkd8ubTbZ4N0tjwOCBS4HjqFCDF8Jwo
         NFv6SP9aGWY5pXm0zBvKeHuWBMLNjZbtFZcPLlTeSEiSYlCoHMQWSZpv/i3ib6bsEXZw
         Y/WHgYLNbkkPafP54kiotEQBWqaNnnqtZR4iWd7xa2LtMq50DYctx+JshEnkAuH1kh/L
         P8X4lGlupiNrnDvE8TWiQwFE1swWEaoEXc/7O6qGqoj2f4OQBny7jcZeSyaaRRf2pylO
         QW5A==
X-Gm-Message-State: ACgBeo0buV88KVE0Z43b7rMelvykIhC1cE9fFWdvl8GMnsVq7LQ0LNLo
        vQ2lk2bpBiCXEafnZ4rSDJs=
X-Google-Smtp-Source: AA6agR7UBlXOM+WUEhxxVABpntMRNdTQcy0g5wbICDVhGOTHepjy5kESxjIou7bia/gOsg5yeG8yrw==
X-Received: by 2002:a05:6000:23c:b0:225:1a3a:2524 with SMTP id l28-20020a056000023c00b002251a3a2524mr2156101wrz.489.1661432944741;
        Thu, 25 Aug 2022 06:09:04 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d6352000000b002252751629dsm19455364wrw.24.2022.08.25.06.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:09:03 -0700 (PDT)
Message-ID: <e60c979d-4d54-86a8-8981-9587b3f271a6@gmail.com>
Date:   Thu, 25 Aug 2022 15:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next v2] drm/mediatek: Remove the unneeded result
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220825072335.228921-1-ye.xingchen@zte.com.cn>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220825072335.228921-1-ye.xingchen@zte.com.cn>
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



On 25/08/2022 09:23, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value drm_mode_config_helper_suspend() directly instead of
>   storing it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

I thought I already did this in v1, anyway here we go again:

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> v1 -> v2
> Add all the mailinglists that get_maintainers.pl give.
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 5f02f8d0e4fc..91f58db5915f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -833,11 +833,8 @@ static int mtk_drm_sys_prepare(struct device *dev)
>   {
>   	struct mtk_drm_private *private = dev_get_drvdata(dev);
>   	struct drm_device *drm = private->drm;
> -	int ret;
> -
> -	ret = drm_mode_config_helper_suspend(drm);
>   
> -	return ret;
> +	return drm_mode_config_helper_suspend(drm);
>   }
>   
>   static void mtk_drm_sys_complete(struct device *dev)
