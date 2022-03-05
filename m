Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31064CE770
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 23:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiCEWb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 17:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiCEWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 17:31:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2DB7E5A5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 14:31:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so17699039wrg.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 14:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WN/8oa0ECQ317FTuXc12JsnMJ1M8B3vTeW8JzZ7b04U=;
        b=Gy6w8PV/6XWXN0NHtwD1ap4hzzQK+Fi7nuTaVaJjlo0TK9OHnJ5GzLF2j3NyNCnYXr
         7RdqsRSFSwS339B02o1TGCuhg6XlMRHz3JqyiVSlaORKVEMldvoAkWL75re9Egys6S/I
         kf2E1X6kM0M1+nYexmXSLVGBgRcn7E1RgeJO4tyR9evcDV5G9gbLAgGwZa4ZdJaxlw9M
         mvF7JNfWRlPhO8mssbwAoyz7WoNj9yRhSnQ7n9jEdoC9La9bJA2KBm9w6zQ79gNidygG
         E53UZh5XS9tAucZzkmnYXY3DJZczLqvDiq1xPNLnDWfusDzXOQDDDE9hc5rFfiyK2Z7Y
         Ne4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WN/8oa0ECQ317FTuXc12JsnMJ1M8B3vTeW8JzZ7b04U=;
        b=1felDEOg/FzHKyxdYHbJ7qOOKUuFI4DKqIia8RWNDyAxMm0OsZbtaE/lK/D9JPiYcG
         azKy8PIcx8wjetM14tqwRreYeNrLwRMvWum2DqLTuF1O/ZpDNxKbuTtAfvSDzkZzUVZX
         d5W9EjJ2XGaujr0qEHGQy9kuySC32ImdavWEYnoQA1VW4hU8yELEynXrePn+zxT/8Fv8
         rYYTy7tJ/gLsqfE+zG8gfO+pCtzmpZ/KdhyzMQFiwns/5PeqEmFLSrp6MCPo9H7qICes
         rQwqhomHmAGaFD9M7F5Y7fvfYWBKqRPeiLyQ9oGaaspzBpXa6mmYOINGIaRbUJRoFbCg
         Thuw==
X-Gm-Message-State: AOAM533cOLEBbylVrMl9gMntk/gvhGVZClPXFmTkbd3sWszfnZVHGqK/
        olj7GdKGFFpAmiZK8iiEij3oCg==
X-Google-Smtp-Source: ABdhPJybp6uFYCOvTZuQ/nnp/9mhCRqc9ASjaSZfSM9VFVaIz0woYtX3LUBufvtgCqKJtCtBI1jtEg==
X-Received: by 2002:a5d:43ca:0:b0:1f0:7925:b6c1 with SMTP id v10-20020a5d43ca000000b001f07925b6c1mr3470841wrr.241.1646519461832;
        Sat, 05 Mar 2022 14:31:01 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:7ea6:4388:1d58:effb? ([2a01:e34:ed2f:f020:7ea6:4388:1d58:effb])
        by smtp.googlemail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm17709966wmb.48.2022.03.05.14.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 14:31:01 -0800 (PST)
Message-ID: <708ef23d-0c4a-47b5-dfe1-c55df9ccbf4b@linaro.org>
Date:   Sat, 5 Mar 2022 23:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clocksource/timer-imx-tpm: define tpm_read_sched_clock()
 conditionally for arm
Content-Language: en-US
To:     trix@redhat.com, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220305205605.707937-1-trix@redhat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220305205605.707937-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

thanks for your patch.

It was already fixed by:

https://lore.kernel.org/r/20220303184212.2356245-1-nathan@kernel.org


On 05/03/2022 21:56, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> On aarch64 allyesconfig there is this error
> timer-imx-tpm.c:78:20: error: 'tpm_read_sched_clock'
>    defined but not used [-Werror=unused-function]
>     78 | static u64 notrace tpm_read_sched_clock(void)
>        |                    ^~~~~~~~~~~~~~~~~~~~
> 
> tpm_read_sched_clock() is only used conditionally
> for arm.  So also define conditionally for arm.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/clocksource/timer-imx-tpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
> index 60cefc247b715..bd64a8a8427f3 100644
> --- a/drivers/clocksource/timer-imx-tpm.c
> +++ b/drivers/clocksource/timer-imx-tpm.c
> @@ -73,12 +73,12 @@ static unsigned long tpm_read_current_timer(void)
>   {
>   	return tpm_read_counter();
>   }
> -#endif
>   
>   static u64 notrace tpm_read_sched_clock(void)
>   {
>   	return tpm_read_counter();
>   }
> +#endif
>   
>   static int tpm_set_next_event(unsigned long delta,
>   				struct clock_event_device *evt)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
