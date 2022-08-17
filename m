Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935B9596AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiHQH4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiHQH4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:56:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20C77A771
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:56:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s23so6310935wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CcRETYtN4fhauMaZGbGwCRZe38WMqLheltJ1uKiMAEM=;
        b=Tb6VTYbA/7axkgPLKP48Ab3RJm5sF55AwVA7gqX1Azxjc7zsVLnQmKILWa9/3Fnw5q
         OT59iy6UEhNpD/in+jnRA1wKfkTFvepGUjGUzCULHNHiaxDZ/pjCaTFROuUQ8X/6a/Z9
         c3AXpDq51d9kS0l1BDd2qR0lSbWXJ+pp8FHTkE+ugFabfu8+MGw1L8xe/xGbulfPBLnp
         UIHPwSxLTUdcn+o3nALmchARxus1doIWYQs3tEECSTQ0alfoUXSAAFkQf7iTrQSmEtXn
         05wl2RJusYrCzzbgosOGpu2hgDm5Pyoq1HIREqFWMNZq2acvTXfniHNbSb3QqTtDtADH
         KvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CcRETYtN4fhauMaZGbGwCRZe38WMqLheltJ1uKiMAEM=;
        b=O95i9pG/esxM7XsK2uH17DnxmlpvMLZb/oZDUb1qf2UOfjP8VWObK+i5hU8v8ZpQis
         4BUCKWh/zOz87N2TVo7PcwhC8avEkb85iVAokhR7oJZ5Plv5SMyXYj9ObTY2DmSP+wEL
         Mu/+qfDL0MNQescjbTvvlgeC+2gyiGoK7mqxrYGmSmn8CMTIoMmloBOoZfDDQpHhVYPb
         D90W8351Kibz+lf2Js1PTGNYQBddEoL9WVXZu8hep1+aqc8TByizQBHnCYdr2TAZjMjl
         Gh8Wd/zporqtzEzeep5/+g2QlkI+bF7WivBWwVGVVpw29QjG9Tca7xqPQx7XaW7Qr/bf
         urVw==
X-Gm-Message-State: ACgBeo05jrj3gsK+n6rsBiaJzhQtSi7T3+ROLzaaB8vepIoJ8gY4hcjJ
        xmdA696KGPHK5NCQncn7WlbARA==
X-Google-Smtp-Source: AA6agR7cylNCBdJrLWk6b3MPoS6xKKceqNxmNadV5AstoXwgDEqMaxLlNUU/A1ScQUcMAQs6N8XLPg==
X-Received: by 2002:a1c:2944:0:b0:3a5:ead6:3e48 with SMTP id p65-20020a1c2944000000b003a5ead63e48mr1241903wmp.100.1660722991407;
        Wed, 17 Aug 2022 00:56:31 -0700 (PDT)
Received: from [10.35.5.6] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c4f8d00b003a5f3f5883dsm1302212wmq.17.2022.08.17.00.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 00:56:31 -0700 (PDT)
Message-ID: <a51c48a1-8d42-eb10-2350-6962bac8ffdd@sifive.com>
Date:   Wed, 17 Aug 2022 08:56:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH 6/8] pwm: dwc: add timer clock
Content-Language: en-GB
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <20220805165033.140958-7-ben.dooks@sifive.com>
 <20220806100703.uxnf2i4pne2kwk63@pengutronix.de>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <20220806100703.uxnf2i4pne2kwk63@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2022 11:07, Uwe Kleine-König wrote:
> Hello Ben,
> 
> On Fri, Aug 05, 2022 at 05:50:31PM +0100, Ben Dooks wrote:
>> Add a configurable clock base rate for the pwm as when being built
>> for non-PCI the block may be sourced from an internal clock.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v2:
>>    - removed the ifdef and merged the other clock patch in here
>> ---
>>   drivers/pwm/pwm-dwc.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
>> index d5f2df6fee62..5c319d0e3d52 100644
>> --- a/drivers/pwm/pwm-dwc.c
>> +++ b/drivers/pwm/pwm-dwc.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> +#include <linux/clk.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pwm.h>
>> @@ -35,7 +36,6 @@
>>   #define DWC_TIMERS_COMP_VERSION	0xac
>>   
>>   #define DWC_TIMERS_TOTAL	8
>> -#define DWC_CLK_PERIOD_NS	10
>>   
>>   /* Timer Control Register */
>>   #define DWC_TIM_CTRL_EN		BIT(0)
>> @@ -54,6 +54,8 @@ struct dwc_pwm_ctx {
>>   struct dwc_pwm {
>>   	struct pwm_chip chip;
>>   	void __iomem *base;
>> +	struct clk *clk;
>> +	unsigned int clk_ns;
>>   	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
>>   };
>>   #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
>> @@ -96,13 +98,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
>>   	 * periods and check are the result within HW limits between 1 and
>>   	 * 2^32 periods.
>>   	 */
>> -	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
>> +	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
>>   	if (tmp < 1 || tmp > (1ULL << 32))
>>   		return -ERANGE;
>>   	low = tmp - 1;
>>   
>>   	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
>> -				    DWC_CLK_PERIOD_NS);
>> +				    dwc->clk_ns);
> 
> You're loosing precision here as clk_ns is already the result of a
> division. We're having
> 
> 	dwc->clk_ns = 1000000000 / clk_get_rate(dwc->clk);
> 
> from dwc_pwm_plat_probe() (in the platform case).
> 
> Consider clk_rate = 285714285 and state->period - state->duty_cycle =
> 300000. Then you get tmp = 100000 while the exact result would be:
> 
> 	300000 * 285714285 / 1000000000 = 85714.2855
> 
> Note that even doing
> 
> 	dwc->clk_ns = DIV_ROUND_CLOSEST(1000000000, clk_get_rate(dwc->clk))
> 
> only somewhat weakens the problem, with the above numbers you then get
> 75000.
> 
> Also note that rounding closest is also wrong in the calculation of tmp
> because the driver is supposed to implement the biggest period not
> bigger than the requested period and for that period implement the
> biggest duty cycle not bigger than the requested duty cycle.
> 
> Can the hardware emit 0% relative duty cycle (e.g. by disabling)?

Not sure, we do have an IP build option to look at for 0/100% but
this is not enabled for the PCI case.

Given everything else, I would rather fix the division and accuracy
issues once we've got the changes under review sorted.

> 
>>   	if (tmp < 1 || tmp > (1ULL << 32))
>>   		return -ERANGE;
>>   	high = tmp - 1;
>> @@ -177,12 +179,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>>   
>>   	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
>>   	duty += 1;
>> -	duty *= DWC_CLK_PERIOD_NS;
>> +	duty *= dwc->clk_ns;
>>   	state->duty_cycle = duty;
>>   
>>   	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
>>   	period += 1;
>> -	period *= DWC_CLK_PERIOD_NS;
>> +	period *= dwc->clk_ns;
>>   	period += duty;
>>   	state->period = period;
>>   
>> @@ -205,6 +207,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
>>   	if (!dwc)
>>   		return NULL;
>>   
>> +	dwc->clk_ns = 10;
>>   	dwc->chip.dev = dev;
>>   	dwc->chip.ops = &dwc_pwm_ops;
>>   	dwc->chip.npwm = DWC_TIMERS_TOTAL;
>> @@ -336,6 +339,14 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
>>   		return dev_err_probe(dev, PTR_ERR(dwc->base),
>>   				     "failed to map IO\n");
>>   
>> +	dwc->clk = devm_clk_get(dev, "timer");
>> +	if (IS_ERR(dwc->clk))
>> +		return dev_err_probe(dev, PTR_ERR(dwc->clk),
>> +				     "failed to get timer clock\n");
>> +
>> +	clk_prepare_enable(dwc->clk);
> 
> If you used devm_clk_get_enabled() you wouldn't need to care separately
> for enabling. (If you stick to separate calls, please add error checking
> for clk_prepare_enable().)

ok, will use.

>> +	dwc->clk_ns = 1000000000 / clk_get_rate(dwc->clk);
> 
> s/1000000000/NSEC_PER_SEC/

ok, fixed.

>> +
>>   	ret = pwmchip_add(&dwc->chip);
>>   	if (ret)
>>   		return ret;
>> @@ -347,6 +358,7 @@ static int dwc_pwm_plat_remove(struct platform_device *pdev)
>>   {
>>   	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
>>   
>> +	clk_disable_unprepare(dwc->clk);
>>   	pwmchip_remove(&dwc->chip);
> 
> This is wrong, you must not disable the clock before calling
> pwmchip_remove() as the PWM is supposed to stay functional until
> pwmchip_remove() returns.

I've moved to devm_clk_get_enabled and devm_pwmchip_add()

> 
>>   	return 0;
>>   }
> 

