Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC9D5579A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiFWMBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiFWMBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:01:15 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12AB25F5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:59:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id c1so29151866qvi.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=botYHFk9pkVVViz8NkeeS2UKndFI//AAhZq6n6ujwTQ=;
        b=iUN7x5H9h/UPboRJ2yVuFMYrc5GXPnmG6+oxe8JrP6iHpvwclXYw+eATUkdUDrrhmy
         F+swo7MfGnsd0mXYsEuYN400a8XWvq9CAcA2Gz3zIkhvAolLBWoB5cQUNcI7xnbn62lA
         VT2vEOT/FFz+bdTHOwhiDf6haWktICqLrhVqphp8CWiLStZnNbdrwpaTy8GwjhPUj3O3
         uKT7Z4pEIJGbNH5ZAz7htjY8CQHnFb8IT5uM6Zgf4KtUJzk3hMzSHY0bBHOxrETV4Bth
         P3jlnjJJ2Yvaw2GpQGIU9TvAFwoKvdZOz9BICpningWNLRx41Ff0D7QGmusaEdL+efCh
         L5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=botYHFk9pkVVViz8NkeeS2UKndFI//AAhZq6n6ujwTQ=;
        b=Q667T7kXz8EjfSBgQXm/5wGZRwhu7KFuPBRStuRlZ5pEC8HRc8+j/hmTfhpKrFcTNR
         cVuIra05+EQh9By/SsBGtzAS3q9xIKVPxeGDPL3pRjz7BMIpg1lmnAftsEyD3mg+Mbyt
         +dANJjToyU0swFw4nDZCaKqHu7TOdTBsdiZ2mpvACm/ejIdzvyb7yENiAJpIy5YIifbI
         r/r5t3cah+JS3yqaExxUXXG6nYaUk1jNn7Q3+IyCR9mSCRTjgyt9XXxxPDwZcYmBWd7L
         7tcxwXjfoGlkjC0K1tiXfl7Sc039ltY3fGh5MKVMi5yyocPMgkVTdApYOCswF11XRmhc
         RDGQ==
X-Gm-Message-State: AJIora95RU5kcVe07BPVTngBlbuI/X0NNDSS2NMPfoECc5vhA6FapEr2
        F5UpEFQLwx4U685WSWDEikc=
X-Google-Smtp-Source: AGRyM1vN+Queyd3tKVxiIaJHasVG5kCoIJQ5hHezzRWrpbBUyxwbfitmzyNiwtP7ULKQwHBwDkL7Uw==
X-Received: by 2002:a05:6214:62e:b0:470:4608:1801 with SMTP id a14-20020a056214062e00b0047046081801mr15877836qvx.54.1655985593126;
        Thu, 23 Jun 2022 04:59:53 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b002f936bae288sm17305750qtf.87.2022.06.23.04.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 04:59:52 -0700 (PDT)
Message-ID: <d17549d3-a111-53b4-4576-2f5b6581c830@gmail.com>
Date:   Thu, 23 Jun 2022 13:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 -next] soc: mediatek: SVS: Use the new PM macros
Content-Language: en-US
To:     Jin Xiaoyun <jinxiaoyun2@huawei.com>,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        zhengbin13@huawei.com, gaochao49@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622013410.2786760-1-jinxiaoyun2@huawei.com>
 <20220623030931.2816013-1-jinxiaoyun2@huawei.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220623030931.2816013-1-jinxiaoyun2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2022 05:09, Jin Xiaoyun wrote:
> Use DEFINE_SIMPLE_DEV_PM_OPS() instead of the SIMPLE_DEV_PM_OPS()
> macro, along with using pm_sleep_ptr() as this driver doesn't handle
> runtime PM.
> 
> Fix build error:
> drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not used [-Werror=unused-function]
> drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not used [-Werror=unused-function]
> 
> Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> v1->v2:
> - Remove the #ifdef CONFIG_PM guard around the suspend/resume functions
> - Use DEFINE_SIMPLE_DEV_PM_OPS along with using pm_sleep_ptr()
> ---
>   drivers/soc/mediatek/mtk-svs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 606a00a2e57d..fae7376bd083 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -2381,13 +2381,13 @@ static int svs_probe(struct platform_device *pdev)
>   	return ret;
>   }
> 
> -static SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(svs_pm_ops, svs_suspend, svs_resume);
> 
>   static struct platform_driver svs_driver = {
>   	.probe	= svs_probe,
>   	.driver	= {
>   		.name		= "mtk-svs",
> -		.pm		= &svs_pm_ops,
> +		.pm		= pm_sleep_ptr(&svs_pm_ops),

Why do we need that? From my understanding DEFINE_SIMPLE_DEV_PM_OPS() sets 
runtime_suspend_fn, runtime_resume_fn and idle_fn to NULL.

Regards,
Matthias

>   		.of_match_table	= of_match_ptr(svs_of_match),
>   	},
>   };
> --
> 2.25.1
> 
