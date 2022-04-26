Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706EE50F37A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbiDZIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbiDZIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:16:01 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F316D3A1;
        Tue, 26 Apr 2022 01:12:52 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e9027efe6aso11325700fac.10;
        Tue, 26 Apr 2022 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=+WJUPUHsdpMeeurhKG6V5IgBDct7VAf5h6R/Zg7kLjs=;
        b=QNgYv/aRwdb01laGIduEyJZz4sGtxsKQ3QSTutna/F9VTa75Wo6/krtD66xm5G4//q
         7vVOlXMlUIE48I2TEihRUARi12u9LtgC7hcZKQq0MCpu/iIyrAcZatnQFte5usZydyFb
         JTw+TeYgN1xl9WrAjbTgp8nrRBpccM5l3GJs0guBK47DMbuP8v9YhMgZnjljXSTaDjFT
         SqbwYa0VYnR3bnrUf9PAZfDy2KbgE/bCcU7j2cZtgdc7cDn9jHNee7HcJGGcftLrU45Q
         OOeKgmrJhY4nN5QFClkcd+9L2/9N6vcOgUiGHrOFK+dDjVK57z9Lh1YkDdFQakLV4B72
         HlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=+WJUPUHsdpMeeurhKG6V5IgBDct7VAf5h6R/Zg7kLjs=;
        b=LzPdxNl/caBo2wZqkj5lCAnj3Ugph4REnVKl8JDHClqpDTzH8AHcqCHbCnDEJ6CTOH
         A7fB30unNRDJ9yWy/QPtp7mVp8lizTHVXLHdhGaJP2+HJPDYUaEebbR5s7LxJyJMssJb
         6kO7yjzsRABoBb3L0ZyoI/PGgQpVKg3nXoga30hpKNIdpp9ae5Zg0lXRXsY+HJ2MywEK
         SXNAwEP89h8uOZ46aT4uAeMLfrA/QFAbo/2Gi3NMVK/snIS8gt+u8epsIvfhRaseAcdY
         CZDnFUufffN2SHJ97XczvnToatdbhv9Rjd2di5MO5LlaqOW4+6XEIY5NBj+14hNBPA/K
         0IOw==
X-Gm-Message-State: AOAM530uU/yj69lcMLwJ0VdFil8H9SM7ozaDuc9ocwUY1kSY8zs6X+W2
        6nVZpaNfh7fiTZILnXo/DnGmJk1aqj8=
X-Google-Smtp-Source: ABdhPJy/GUvwnPAt8MwxopeV+IfD9cgC1SRZSVlfvC1wdeY7xDuKMYfo5/cJs8nCB63WrWN7X+kwdA==
X-Received: by 2002:a05:6870:55aa:b0:e1:f826:c241 with SMTP id n42-20020a05687055aa00b000e1f826c241mr13205097oao.84.1650960771803;
        Tue, 26 Apr 2022 01:12:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a4a6c0c000000b0035e679ef74asm2439760ooc.25.2022.04.26.01.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:12:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dabd968c-1a03-b67e-0457-3583383f0d2e@roeck-us.net>
Date:   Tue, 26 Apr 2022 01:12:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>, wim@linux-watchdog.org,
        tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650957029-910-5-git-send-email-liuxp11@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 4/4] watchdog: iTCO_wdg: Make code more clearly with
 macro definition
In-Reply-To: <1650957029-910-5-git-send-email-liuxp11@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 00:10, Liu Xinpeng wrote:
> Using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS reduces redundant code.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Also, Tzung-Bi never sent a Reviewed-by: tag. As with the other patches,
this is completely inappropriate. Really, who gave you that idea ?
You adding such tags without receiving them means we can never trust
your patches again since you are making things up.

Guenter

> ---
>   drivers/watchdog/iTCO_wdt.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 3f2f4343644f..8d24cf4f4ca3 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -635,22 +635,18 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
>   
>   	return 0;
>   }
> +#endif /* CONFIG_PM_SLEEP */
>   
>   static const struct dev_pm_ops iTCO_wdt_pm = {
> -	.suspend_noirq = iTCO_wdt_suspend_noirq,
> -	.resume_noirq = iTCO_wdt_resume_noirq,
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(iTCO_wdt_suspend_noirq,
> +				      iTCO_wdt_resume_noirq)
>   };
>   
> -#define ITCO_WDT_PM_OPS	(&iTCO_wdt_pm)
> -#else
> -#define ITCO_WDT_PM_OPS	NULL
> -#endif /* CONFIG_PM_SLEEP */
> -
>   static struct platform_driver iTCO_wdt_driver = {
>   	.probe          = iTCO_wdt_probe,
>   	.driver         = {
>   		.name   = DRV_NAME,
> -		.pm     = ITCO_WDT_PM_OPS,
> +		.pm     = &iTCO_wdt_pm,
>   	},
>   };
>   

