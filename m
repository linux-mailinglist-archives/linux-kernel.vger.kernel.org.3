Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F74DB700
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349679AbiCPRVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiCPRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:21:28 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEBE5AA49
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:20:13 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h63so3131249iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZHu31H02wKCvXtiv1u3NIdRpK08igoxIqxArOW7UWyU=;
        b=rZiKWOUZzSymkN+Yq4KLAQtJfCVFW/+Xjr+qxaZLzj8ouud7dnx2bV8X8EQoXNSBx2
         Jhlrltfnf9Yx8RJlkCyRT4kFyK4cEJqv24EFOdqxN3cbCxJ48jvTBJWzifhR4d25wAfW
         usl3o2rg+mhnn35fUhyy5R+9fkAHWaGNLnRVnAXneLbyhzQ5VSaKUF2gvX1vqnXd0Xca
         0OMuhAb5sRnzgy63RV1t7idRVETz9qiNRYDvpDj/HQcRIj9KZMHbP5zyFFEglQgmlEgp
         OCmBzrLw77ObeFFeY8pZgIVP+BwJmPPwcj4BYC9kJD87mZhP0537wG+zyzigtoJ2s+Gb
         kU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZHu31H02wKCvXtiv1u3NIdRpK08igoxIqxArOW7UWyU=;
        b=Gzny4Rz+DknKOvpr8G9UTaDpIRaGPYKQoM0CiQdQEi84JWZ7Ngk5SreufdGJ1sbJU4
         moZhSmVGDQ3u3r9iO7iayVQ3HBiZ6XPT9oo1gJhpiwI+F9qN/fPq6IXU+6WFdJW2MzkT
         ca0xftvr/ipR2wrC/gNLmfQzraO1pB+PNgPDqOIdxIPKYSz16umzHhiGNSeZkepyDdNd
         LnT1behG8ZIwv+AUZtkeUkmqPFUR3LWI78uQVyyNjsKe+4+kmDhJE8jF25Ygh/HO5w11
         qeTjRK5isuFoC3B6C/BZawCdRF41bV+Z77HIin4wdMAuVu40t+Xd077uPHVWmjYoXrZc
         KWPw==
X-Gm-Message-State: AOAM532KQdR+GpUFemzyhCLRjm+YQ7l/Hf6Gng15no1Fj60O3S/iJgZp
        E4041SrDB/BLLwrzPx63u9wD0iVnAloaQdTI
X-Google-Smtp-Source: ABdhPJyZrc94uhg5ZCgdSfeLCguT5+TqrzVKMhco+wETb+0v8fLCrj1k85w00vM79bnWWKdgvyh9eQ==
X-Received: by 2002:a05:6638:24ca:b0:319:d811:b3b5 with SMTP id y10-20020a05663824ca00b00319d811b3b5mr243642jat.235.1647451213288;
        Wed, 16 Mar 2022 10:20:13 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e18-20020a5d85d2000000b00649254a855fsm1257054ios.26.2022.03.16.10.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 10:20:12 -0700 (PDT)
Message-ID: <a1074d55-c5ee-ced5-b9f7-0e1d023e1fea@linaro.org>
Date:   Wed, 16 Mar 2022 12:20:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [greybus-dev] Re: [PATCH v5] staging: greybus: introduce
 pwm_ops::apply
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alex Elder <elder@ieee.org>
Cc:     Song Chen <chensong_2000@189.cn>, johan@kernel.org,
        elder@kernel.org, thierry.reding@gmail.com, lee.jones@linaro.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <1647397285-30061-1-git-send-email-chensong_2000@189.cn>
 <49f18070-0215-8475-907b-487d1e01c15c@ieee.org>
 <20220316162903.kwkfefyznvopvr5g@pengutronix.de>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220316162903.kwkfefyznvopvr5g@pengutronix.de>
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

On 3/16/22 11:29 AM, Uwe Kleine-König wrote:
> On Wed, Mar 16, 2022 at 10:14:30AM -0500, Alex Elder wrote:
>> On 3/15/22 9:21 PM, Song Chen wrote:
>>> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
>>> index 891a6a672378..3add3032678b 100644
>>> --- a/drivers/staging/greybus/pwm.c
>>> +++ b/drivers/staging/greybus/pwm.c
>>> @@ -204,43 +204,54 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>>>    	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
>>>    }
>>> -static int gb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>> -			 int duty_ns, int period_ns)
>>> +static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>> +			const struct pwm_state *state)
>>>    {
>>> +	int err;
>>> +	bool enabled = pwm->state.enabled;
>>> +	u64 period = state->period;
>>> +	u64 duty_cycle = state->duty_cycle;
>>
>> The use of local variables here is inconsistent, and that
>> can be confusing.  Specifically, the "enabled" variable
>> represents the *current* state, while the "period" and
>> "duty_cycle" variables represent the *desired* state.  To
>> avoid confusion, if you're going to use local variables
>> like that, they should all represent *either* the current
>> state *or* the new state.  Please update your patch to
>> do one or the other.
> 
> IMHO that it overly picky. I'm ok with the usage as is.

I see the "enabled" flag is used in a way that I didn't
notice before.  Changing its name to "disabled" (to mean
"we have disabled the device within this function already")
would allow it to be used in the same way, but would make
it more obvious it's not just a copy of "old" device state.

>>>    	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>> -	return gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_ns, period_ns);
>>> -};
>>> +	/* set polarity */
>>> +	if (state->polarity != pwm->state.polarity) {
>>> +		if (enabled) {
>>> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>>> +			enabled = false;
>>> +		}
>>> +		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>> -static int gb_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
>>> -			       enum pwm_polarity polarity)
>>> -{
>>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>> +	if (!state->enabled) {
>>> +		if (enabled)
>>> +			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
>>> +		return 0;
>>
>> If you are disabling the device, you return without updating the
>> period and duty cycle.  But you *do* set polarity.  Is that
>> required by the PWM API?  (I don't actually know.)  Or can the
>> polarity setting be simply ignored as well if the new state is
>> disabled?
> 
> All is well here. A disabled PWM is expected to emit the inactive level.
> So polarity matters, duty and period don't.

Thanks for clarifying that.  I did not know what was expected.

>> Also, if the polarity changed, the device will have already been
>> disabled above, so there's no need to do so again (and perhaps
>> it might be a bad thing to do twice?).
> 
> That won't happen, because if the device was disabled for the polarity
> change, enabled = false. In fact that is the purpose of the local
> variable.

Now I see, yes, the local variable gets changed when the
disable occurred above.

>>> +	}
>>> -	return gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, polarity);
>>> -};
>>
>> Since you're clamping the values to 32 bits here, your comment
>> should explain why (because Greybus uses 32-bit values here,
>> while the API supports 64 bit values).  That would be a much
>> more useful piece of information than "set period and duty cycle".
>>
>>> +	/* set period and duty cycle*/
>>
>> Include a space before "*/" in your comments.
> 
> ack
> 
>>> +	if (period > U32_MAX)
>>> +		period = U32_MAX;
>>> -static int gb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>> -{
>>> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>>> +	if (duty_cycle > period)
>>> +		duty_cycle = period;
>>> -	return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
>>> -};
>>> +	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
>>> +	if (err)
>>> +		return err;
>>
>> What if the new state set usage_power to true?  It would
>> be ignored here.  Is it OK to silently ignore it?  Even
>> if it is, a comment about that would be good to see, so
>> we know it's intentional.
> 
> ignoring usage_power is OK. All but a single driver do it that way.

I don't actually see anything that sets usage_power to true,
although "pwm-pca9685.c" tests its value.

I guess it's an advisory parameter that's passed to the apply
callback function.  It's described as optional, but--not being
a "PWM person"--this isn't obvious to me.  Maybe the comments
describing the field or the apply callback could define the
semantics a little better at some point.

					-Alex

> 
> Best regards
> Uwe
> 
> 
> _______________________________________________
> greybus-dev mailing list -- greybus-dev@lists.linaro.org
> To unsubscribe send an email to greybus-dev-leave@lists.linaro.org

