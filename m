Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8B5A695B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiH3ROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiH3ROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:14:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005CBBC11B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:14:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso1953066pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=yqwQGcOiqv9Oi1t+L3v3Q5Co30u0asuBLGn0BCOeI10=;
        b=HsdlDvSALrhcgvRVY7eRsX9p0+Sb4CQCqYDsLlgAQmIoB6enB2VpDR7Sv0b4R8KLB9
         /AfR2dcMhoO4luVlM9Fb00EPf4VTRNzJwtH6JJKxRdVbVaYIPQo6LQEaRAH8zpnO8+sn
         DUJ/6NgRP+LoDueVaiXbmGAZB6JrZtmhA37rdbWo2Yx6OFzZ0p5GgbsGl3NskNAEEAIQ
         v3woILYZhH1un6xNWxdVFcI5k0dlXEhXTw2VguD3W1CikI/1+G400f/vY9J4A6C03zok
         gYIIJ9y2IU+ZdswKN6IuxSHf1b72aH8bij2OkyM+/7Qscu2KseipPTV2A0Oq3NTrhm14
         wA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=yqwQGcOiqv9Oi1t+L3v3Q5Co30u0asuBLGn0BCOeI10=;
        b=TtZTc9pZjv4wmBMMqQxUdxg0QVblwND5s47iBWsFR7t9vX26wWJHEtEGdVAMiMTvMA
         fsON2dh45KAS+qAmzWOWkxH1GVPA+ZSI8UfodarxYY/nYb/CfHuk3bSeXaWxzQbA4Gya
         zKZYM+GqeR8lZ1FDTK5guPYDN7gUjW/22jmA2xufbQRZMzjbqzRfWQ/lHKO35U6GYWvn
         zEi84cR98vIMkZXewEyHvVKXaZQ90IE+xuydYdFDJxw8GN4Uzz6wk+NHnr8ZopH57Yj7
         frwTjt2orY+1K0ZuiB7GgY38z2W1/w//+YsjoRE45QGHWSoDUpFhx3e5LQVKxjjzMRNJ
         2CeQ==
X-Gm-Message-State: ACgBeo06+vfYjvX5UsnsmEqJJL5bjyK147uCK9lAfgL+cBbgBiwwUvHR
        TADHfhh+KhUpGwO4jp/SASykbg==
X-Google-Smtp-Source: AA6agR4tRqvAI8GMS6qqXAmTyWvwhqsPOiJoYVO7VTKjMyVcd8T6063qBktpVC7Fa1cnldZcn5P5Qw==
X-Received: by 2002:a17:902:aa41:b0:173:1571:4025 with SMTP id c1-20020a170902aa4100b0017315714025mr22293757plr.110.1661879646107;
        Tue, 30 Aug 2022 10:14:06 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:5362:9d7f:2354:1d0a:78e3? ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id jn13-20020a170903050d00b001753eb66692sm98782plb.250.2022.08.30.10.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:14:05 -0700 (PDT)
Message-ID: <caa29b74-e473-8afe-49c2-451238e2ea4b@linaro.org>
Date:   Tue, 30 Aug 2022 22:44:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/4] thermal: qcom: tsens: Add driver support for
 re-initialization quirk
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220804054638.3197294-1-bhupesh.sharma@linaro.org>
 <20220804054638.3197294-4-bhupesh.sharma@linaro.org>
 <20220829221422.2r6axgaica67lbpv@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220829221422.2r6axgaica67lbpv@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/22 3:44 AM, Bjorn Andersson wrote:
> On Thu, Aug 04, 2022 at 11:16:37AM +0530, Bhupesh Sharma wrote:
>> Since for some Qualcomm tsens controllers, its suggested to
>> monitor the controller health periodically and in case an
>> issue is detected, to re-initialize the tsens controller
>> via trustzone, add the support for the same in the
>> qcom tsens driver.
>>
>> Note that once the tsens controller is reset using scm call,
>> all SROT and TM region registers will enter the reset mode.
>>
>> While all the SROT registers will be re-programmed and
>> re-enabled in trustzone prior to the scm call exit, the TM
>> region registers will not re-initialized in trustzone and thus
>> need to be handled by the tsens driver.
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Amit Kucheria <amitk@kernel.org>
>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   drivers/thermal/qcom/tsens-v2.c |   3 +
>>   drivers/thermal/qcom/tsens.c    | 197 ++++++++++++++++++++++++++++++++
>>   drivers/thermal/qcom/tsens.h    |  12 ++
>>   3 files changed, 212 insertions(+)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index b293ed32174b..f521e4479cc5 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -88,6 +88,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>   
>>   	/* TRDY: 1=ready, 0=in progress */
>>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>> +
>> +	/* FIRST_ROUND_COMPLETE: 1=complete, 0=not complete */
>> +	[FIRST_ROUND_COMPLETE] = REG_FIELD(TM_TRDY_OFF, 3, 3),
>>   };
>>   
>>   static const struct tsens_ops ops_generic_v2 = {
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index e49f58e83513..c2d085fb5447 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/err.h>
>>   #include <linux/io.h>
>> +#include <linux/qcom_scm.h>
>>   #include <linux/module.h>
>>   #include <linux/nvmem-consumer.h>
>>   #include <linux/of.h>
>> @@ -594,6 +595,113 @@ static void tsens_disable_irq(struct tsens_priv *priv)
>>   	regmap_field_write(priv->rf[INT_EN], 0);
>>   }
>>   
>> +static int tsens_reenable_hw_after_scm(struct tsens_priv *priv)
> 
> As written, this is a void function.

Ok.

>> +{
>> +	/*
>> +	 * Re-enable watchdog, unmask the bark and
>> +	 * disable cycle completion monitoring.
>> +	 */
>> +	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
>> +	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
>> +	regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
>> +	regmap_field_write(priv->rf[CC_MON_MASK], 1);
>> +
>> +	/* Re-enable interrupts */
>> +	tsens_enable_irq(priv);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tsens_health_check_and_reinit(struct tsens_priv *priv,
>> +					 int hw_id)
>> +{
>> +	int ret, trdy, first_round, sw_reg;
>> +	unsigned long timeout;
>> +
>> +	/* First check if TRDY is SET */
>> +	ret = regmap_field_read(priv->rf[TRDY], &trdy);
>> +	if (ret)
>> +		goto err;
>> +
>> +	if (!trdy) {
> 
> if (trdy)
> 	return 0;
> 
> Would save you one level of indentation.
> 
>> +		ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE], &first_round);
>> +		if (ret)
>> +			goto err;
>> +
>> +		if (!first_round) {
> 
> if (first_round)
> 	return 0;
> 
> Would save you another level of indentation.
> 
>> +			WARN_ON(!mutex_is_locked(&priv->reinit_mutex));
> 
> At least for now the function is only called within a small locked
> region, so it's going to be locked here. But I'm wondering if there's
> any relationship between the lock state of reinit_mutex and the values
> of TRDY and FIRST_ROUND_COMPLETE.
> 
> Seems like it's possible to hit this function repeatedly and have it
> exit early because of TRDY and FIRST_ROUND_COMPLETE values and then one
> day if will reach here and trip.
> 
> So how about starting the function with this check, to make it more
> likely to be hit in our testing?
> 
>> +
>> +			/* Wait for 2 ms for tsens controller to recover */
>> +			timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
>> +			do {
>> +				ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE],
>> +						&first_round);
>> +				if (ret)
>> +					goto err;
>> +
>> +				if (first_round) {
>> +					dev_dbg(priv->dev, "tsens controller recovered\n");
>> +					return 0; /* success */
>> +				}
>> +			} while (time_before(jiffies, timeout));
> 
> I see no delays in this loop, so we're presumably going to spin here
> tightly for 2ms.
> 
> I think you could write this loop as:
> 
> 	ret = regmap_field_read_poll_timeout(priv->rf[FIRST_ROUND_COMPLETE],
> 					     &first_round, first_round, 100, 2000);
> 	if (ret == 0) {
> 		dev_dbg(priv->dev, "tsens controller recovered\n");
> 		return 0;
> 	}
> 
>> +
>> +			spin_lock(&priv->reinit_lock);
>> +
>> +			/*
>> +			 * Invoke SCM call only if SW register write is
>> +			 * reflecting in controller. Try it for 2 ms.
>> +			 * In case that fails mark the tsens controller
>> +			 * as unrecoverable.
>> +			 */
>> +			timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
>> +			do {
>> +				ret = regmap_field_write(priv->rf[INT_EN], CRITICAL_INT_EN);
>> +				if (ret)
>> +					goto err;
> 
> You're holding reinit_lock here.
> 
>> +
>> +				ret = regmap_field_read(priv->rf[INT_EN], &sw_reg);
>> +				if (ret)
>> +					goto err;
> 
> And here.
> 
>> +			} while ((sw_reg & CRITICAL_INT_EN) && (time_before(jiffies, timeout)));
> 
> And again, this is a tight loop. Please add a usleep_range(100, 1000),
> perhaps inbetween the write and read?
> 
>> +
>> +			if (!(sw_reg & CRITICAL_INT_EN)) {
>> +				ret = -ENOTRECOVERABLE;
>> +				goto err;
> 
> Again, reinit_lock is held here.
> 
>> +			}
>> +
>> +			/*
>> +			 * tsens controller did not recover,
>> +			 * proceed with SCM call to re-init it.
>> +			 */
>> +			ret = qcom_scm_tsens_reinit();
>> +			if (ret) {
>> +				dev_err(priv->dev, "tsens reinit scm call failed (%d)\n", ret);
>> +				goto err;
> 
> And here.
> 
>> +			}
>> +
>> +			/*
>> +			 * After the SCM call, we need to re-enable
>> +			 * the interrupts and also set active threshold
>> +			 * for each sensor.
>> +			 */
>> +			ret = tsens_reenable_hw_after_scm(priv);
> 
> As written tsens_reenable_hw_after_scm() doesn't return any value, so
> skip the error handling.
> 
>> +			if (ret) {
>> +				dev_err(priv->dev,
>> +					"tsens re-enable after scm call failed (%d)\n", ret);
>> +				goto err;
> 
> And here...
> 
>> +			}
>> +
>> +			/* Notify reinit wa worker */
>> +			queue_work(system_highpri_wq, &priv->reinit_wa_notify);
>> +
>> +			spin_unlock(&priv->reinit_lock);
>> +		}
>> +	}
>> +
>> +err:
>> +	return ret;
>> +}
>> +
>>   int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>>   {
>>   	struct tsens_priv *priv = s->priv;
>> @@ -607,6 +715,21 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>>   	if (tsens_version(priv) == VER_0)
>>   		goto get_temp;
>>   
>> +	/*
>> +	 * For some tsens controllers, its suggested to
>> +	 * monitor the controller health periodically
>> +	 * and in case an issue is detected to reinit
>> +	 * tsens controller via trustzone.
> 
> Please use your 80 chars.

Ack to all the above. Will send a fixed v4 shortly.

Thanks.
