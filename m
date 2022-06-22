Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D9554BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357933AbiFVNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357786AbiFVNz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:55:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF634676
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:55:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g27so16888364wrb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DiNCujgxYWYbz+UJ9ltziyWRFBz53VugMgkXPVyjSK4=;
        b=hXlFgbhirmJiWHqqoRtimtjAjho/OAKlPLMalXL7BtlrRx8PkIhLF7xBBR5FV7SJmn
         cqV5tB9SoymSQw7M+XYn5GL9fKXQsMfsZTbHWhdwSx4lCrY0F/wlAeqWai/KpXN+45A6
         AokbjafQRmysNsE2/q2eJQwvHEKu1WDbab/J693X1FpSpGHBhCM4PBPmtBVUXdsUISb0
         tJ+XhClEg93gx8J5mN88Y9EAfZCLB6h3vHWMG4EGjmyM7GoO5pZe9X36WkBKAXnPLYYz
         Aorax0XZAoRwQDAmpIMB0Ac8Fc90KQYp9doswcAV66yhQWjtut1Tq/B28pBSk+Riq9xM
         5mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DiNCujgxYWYbz+UJ9ltziyWRFBz53VugMgkXPVyjSK4=;
        b=nD3GUPyazd2m33ithDnQE2NcysAoD7791mpAszqnp2ZTaWLvngKdAXhLD2eeLwgh+P
         MeAbkzUVIrFJ853Yn/cFhrLAjqXUapnLTL0wzTlwJTgFgBP7ytbts956yCaV2/y2AU4b
         4hgPAaqdKkwECQvsaa/lVO/R6eI2UPorq4uiqUFACKUr/gO7FcGlrMdyDivxrYTfazvn
         b+f1kDJC3LPTXGIKpDx/QQNqz1TfJP00sPqBEuDLMbbtExizWapJvwf3x+jqKX5fL656
         tcTalQ0r/Kd2/UYTy2gOeZj4SpuLgPtneLbE/Fvv28xXLzRBDHxxyl5JfeK8/SfIqKI5
         JV3g==
X-Gm-Message-State: AJIora/T8xwaJODkJ+dplMOTgq1Cyv7FuQ+M+9Num9jt1jNBQOUGdiya
        8jZjxanOsYOH1KRPy6Tosxk=
X-Google-Smtp-Source: AGRyM1uSVoTrSb3lxzWtryBVzIlHC0hkxQGNcIYONajc9TiRn89bRMchU8vB48sqgrJYnhsmfPKn5w==
X-Received: by 2002:a5d:5888:0:b0:218:733:4cd9 with SMTP id n8-20020a5d5888000000b0021807334cd9mr3680712wrf.619.1655906116801;
        Wed, 22 Jun 2022 06:55:16 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c4e0500b0039aef592ca0sm21879131wmq.35.2022.06.22.06.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 06:55:15 -0700 (PDT)
Message-ID: <8f7868b7-ecac-0dcf-7a37-25ab57b51bf7@gmail.com>
Date:   Wed, 22 Jun 2022 15:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] soc: mediatek: SVS: Make svs_resume and svs_suspend
 defined when CONFIG_PM_SLEEP is y
Content-Language: en-US
To:     Jin Xiaoyun <jinxiaoyun2@huawei.com>,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        zhengbin13@huawei.com, gaochao49@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220622013410.2786760-1-jinxiaoyun2@huawei.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220622013410.2786760-1-jinxiaoyun2@huawei.com>
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



On 22/06/2022 03:34, Jin Xiaoyun wrote:
> The svs_resume and svs_suspend is defined through SIMPLE_DEV_PM_OPS. If CONFIG_PM_SLEEP

SIMPLE_DEV_PM_OPS is deprecated. The correct fix is to use 
DEFINE_SIMPLE_DEV_PM_OPS().

Regards,
Matthias

> is not defined, SIMPLE_DEV_PM_OPS is equivalent to an empty function. In this case,
> the defination of svs_resume and svs_suspend is meaningless.
> 
> Fix build error:
> drivers/soc/mediatek/mtk-svs.c:1515:12: error: ‘svs_resume’ defined but not used [-Werror=unused-function]
> drivers/soc/mediatek/mtk-svs.c:1481:12: error: ‘svs_suspend’ defined but not used [-Werror=unused-function]
> 
> Signed-off-by: Jin Xiaoyun <jinxiaoyun2@huawei.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 606a00a2e57d..8440058784dc 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1478,6 +1478,7 @@ static int svs_start(struct svs_platform *svsp)
>   	return 0;
>   }
> 
> +#ifdef CONFIG_PM_SLEEP
>   static int svs_suspend(struct device *dev)
>   {
>   	struct svs_platform *svsp = dev_get_drvdata(dev);
> @@ -1537,6 +1538,7 @@ static int svs_resume(struct device *dev)
> 
>   	return 0;
>   }
> +#endif
> 
>   static int svs_bank_resource_setup(struct svs_platform *svsp)
>   {
> --
> 2.25.1
> 
