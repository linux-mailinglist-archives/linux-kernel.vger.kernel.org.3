Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0C4DD97D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiCRMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiCRMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:16:56 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D55DF1EBA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:15:37 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i2so4612729ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=vfOVKzjXEJgbasTjmTrxtQ69SXV3NL2wUbcICFdrT0Q=;
        b=Mp8xNUnf83O5UYm8HTwhZw+W8dX1ciFYSag/WGoXxhkPD7uDumvEh2gYMaggbJsjlE
         SS4056+GwHrKQyAY9SS15Iwwe65HKU/VmwlJIBuDswLhvXwh/sm6WDe1XjKJxTzKn5nk
         74HQnq0MWfj4i2kLZnNHPsleSR9V7o2XKStbKUD2qLe4Mou8VqiK+yZHwcztCS2ocldZ
         hn9xhi5G0YfgaNNuydrzT+gAs3+90qnF6jyppovYY4VlNP1y/o/Yr39zSwDQFNbl73RW
         TQxweW8oXAeaaiGUxcgNmRYYaXfWwPdjNt+B8Sf6gg7ADxDbO5dr4kDG0GJVobuGP5ej
         uYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vfOVKzjXEJgbasTjmTrxtQ69SXV3NL2wUbcICFdrT0Q=;
        b=sKRn4XG0AD5asaXQ9G9cwaJ342hwhyulGDV3X6CxbLMoasy3nvU+J4mrv4XkBJ9NkC
         6JqLfXj86VmdO98O9xb8aZ5zaSI/6CqL6aPdCcLg7O2iAIBkYke/zN8ef+vOLECIXdql
         eV1vnSKdyZcYikgmW4FWMemaiiY/9M4+Ob9sbu5cIoJp5YeeQeKApNXnuIZkoxcZxpQP
         UO1W0evNwl6vGFD19GuONhKkIT3UQCVSYw7Ir7h3cWKcmzwp+4t4XGIYapb6yuIX9RcQ
         /9qD5tjOaaTDeOVFRxFQinA9r8DpHJymqZYxSKOqJlbhs12s0ScEnbsr6otSKBFh0YN9
         04Xw==
X-Gm-Message-State: AOAM531d3Voi9mIKEYAZyizczpihTYYVBSHzixDmfdTA0C29GEwUrYnX
        DBfQZGhw26r55X8hgeqYydJ+0kdtduwFzknb
X-Google-Smtp-Source: ABdhPJy4jNJGr92YWGl0Z7hprUxfmBOjlbNFBAjBrGpbebIFPWycBIChT+nePxjFSYCqEThHJqi7hw==
X-Received: by 2002:a05:6e02:1581:b0:2c2:5aef:db32 with SMTP id m1-20020a056e02158100b002c25aefdb32mr4607238ilu.158.1647605736347;
        Fri, 18 Mar 2022 05:15:36 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id k2-20020a056e02156200b002c7881bf27asm4984760ilu.27.2022.03.18.05.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 05:15:35 -0700 (PDT)
Message-ID: <a4b3ad02-f1c7-c13b-7740-d5b9982bd7c7@linaro.org>
Date:   Fri, 18 Mar 2022 07:15:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6] staging: greybus: introduce pwm_ops::apply
Content-Language: en-US
To:     Song Chen <chensong_2000@189.cn>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, elder@ieee.org
References: <1647597432-27586-1-git-send-email-chensong_2000@189.cn>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <1647597432-27586-1-git-send-email-chensong_2000@189.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/22 4:57 AM, Song Chen wrote:
> Introduce newer .apply function in pwm_ops to replace legacy operations
> including enable, disable, config and set_polarity.
> 
> This guarantees atomic changes of the pwm controller configuration.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>

I had another comment suggestion but you've been through enough.
Thanks for working this to completion.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> ---
> v2:
> 1, define duty_cycle and period as u64 in gb_pwm_config_operation.
> 2, define duty and period as u64 in gb_pwm_config_request.
> 3, disable before configuring duty and period if the eventual goal
>     is a disabled state.
> 
> v3:
> Regarding duty_cycle and period, I read more discussion in this thread,
> min, warn or -EINVAL, seems no perfect way acceptable for everyone.
> How about we limit their value to INT_MAX and throw a warning at the
> same time when they are wrong?
> 
> v4:
> 1, explain why legacy operations are replaced.
> 2, cap the value of period and duty to U32_MAX.
> 
> v5:
> 1, revise commit message.
> 
> v6:
> 1, revise commit message.
> 2, explain why capping the value of period and duty to U32_MAX in
>     comment.
> ---
>   drivers/staging/greybus/pwm.c | 64 ++++++++++++++++++++++-------------
>   1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index 891a6a672378..ad20ec24031e 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -204,43 +204,59 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>   	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
>   }
>   
> -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			 int duty_ns, int period_ns)
> +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			const struct pwm_state *state)
>   {
> +	int err;
> +	bool enabled = pwm->state.enabled;
> +	u64 period = state->period;
> +	u64 duty_cycle = state->duty_cycle;
>   	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   
> -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
> -};
> +	/* Set polarity */
> +	if (state->polarity != pwm->state.polarity) {
> +		if (enabled) {
> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> +			enabled = false;
> +		}
> +		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
> +		if (err)
> +			return err;
> +	}
>   
> -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> -			       enum pwm_polarity polarity)
> -{
> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> +	if (!state->enabled) {
> +		if (enabled)
> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> +		return 0;
> +	}
>   
> -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
> -};
> +	/*
> +	 * Set period and duty cycle
> +	 *
> +	 * PWM privodes 64-bit period and duty_cycle, but greybus only accepts
> +	 * 32-bit, so their values have to be limited to U32_MAX.
> +	 */
> +	if (period > U32_MAX)
> +		period = U32_MAX;
>   
> -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> +	if (duty_cycle > period)
> +		duty_cycle = period;
>   
> -	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
> -};
> +	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
> +	if (err)
> +		return err;
>   
> -static void gb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> +	/* enable/disable */
> +	if (!enabled)
> +		return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
>   
> -	gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> -};
> +	return 0;
> +}
>   
>   static const struct pwm_ops gb_pwm_ops = {
>   	.request = gb_pwm_request,
>   	.free = gb_pwm_free,
> -	.config = gb_pwm_config,
> -	.set_polarity = gb_pwm_set_polarity,
> -	.enable = gb_pwm_enable,
> -	.disable = gb_pwm_disable,
> +	.apply = gb_pwm_apply,
>   	.owner = THIS_MODULE,
>   };
>   

