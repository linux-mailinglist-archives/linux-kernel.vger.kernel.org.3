Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6FA57B2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiGTI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiGTI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:27:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30966AED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:27:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id z3so1963219plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gXBxRQpMX1ksYgI8KBkW485Tta+lGkkd8IYaTPQBLnE=;
        b=OLdBIlttf2Nvu6WeZXtOMFmF8e9TU7DaUih3ls7ZvqevmhrB1om/FAg3HvVZHFwgAs
         n7RX/kLx7i5w8C1L1QF/69uD/Uv0ZvpE24RfuPjRrhbgV0m/TyPsJ63x4rV+BnkUFBjt
         WNnHb1yWUU9Arzwlt9xuRFbPRwPjM7o4NHAOXTztkzyizSjR7OLnl7m/qhw60UFtJLY+
         Y8BwgNCPHnf3/cCIt1u4yD7dHcvVtXxS7tI8Wki0neIBlGcLM3+6l94w+2DDRKmtcLlO
         hD6XXrzWUA2YoECnxrgVhd/Mdmo0KmuB4DdHx00S8FnV4qxb8saWxBETNQrZgCjjFBZ9
         DBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gXBxRQpMX1ksYgI8KBkW485Tta+lGkkd8IYaTPQBLnE=;
        b=Wb47+PVEbKdp8iG+O6BaWk/st9zeBmcTuXq156/vefUC8fmk3Qqaz3Aitfez3SvlP3
         a3+SXwDFS6bC1zR5Eu91THOFrZSNl2Nvf5ZZzcmZyugXheqyt1THY6KtnujhUvIHwU38
         aTQf+dtpeiXbc6VNKg5C9QULAdcqMvJ8NXi/l2sbXV2sMepSP7h1wvglUBsli7ZVckq1
         zt9wk9+9El3u1HX8xV/h6SaI9u26PQ7HKXQhCi3nCTHZcMc7gUMX6okhddw4kdofGWaV
         nGZzul+ORrR7nG6zzCMMLN1RlxfgrJE1ZAS8IU40A3p0AMtWkgz8XGv+G+sIr2ICSKHv
         YoCw==
X-Gm-Message-State: AJIora/8Bs1SCnuExautPeRxMcxhui3PZgSWiZ3Xs0B4WJMiZVARn01G
        hn84kKIMXViT4tQA+SYDE33tkA==
X-Google-Smtp-Source: AGRyM1sD61HGTvbb4tKezKF1kHI+msPPDI533+jJcAdUGnhAbo1EHZDi23xEXrU0ReVG9nC4fs1Dpw==
X-Received: by 2002:a17:90b:4b01:b0:1f0:1aa7:928 with SMTP id lx1-20020a17090b4b0100b001f01aa70928mr3928702pjb.195.1658305671455;
        Wed, 20 Jul 2022 01:27:51 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id u14-20020a170903124e00b0016bee3caabesm13186021plh.270.2022.07.20.01.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 01:27:50 -0700 (PDT)
Message-ID: <50a432af-eb40-8692-78f3-f200222bb2c7@linaro.org>
Date:   Wed, 20 Jul 2022 13:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] thermal: qcom: tsens: Implement re-initialization
 workaround quirk
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
 <20220701145815.2037993-4-bhupesh.sharma@linaro.org>
 <YtYlcEBszITSZ5on@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <YtYlcEBszITSZ5on@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for your review.

On 7/19/22 9:00 AM, Bjorn Andersson wrote:
> On Fri 01 Jul 09:58 CDT 2022, Bhupesh Sharma wrote:
> 
>> Since for some QCoM tsens controllers, its suggested to
>> monitor the controller health periodically and in case an
>> issue is detected, to re-initialize the tsens controller
>> via trustzone, add the support for the same in the
>> qcom tsens driver.
>>
>> Note that Once the tsens controller is reset using scm call,
>> all SROT and TM region registers will enter the reset mode.
>>
>> While all the SROT registers will be re-programmed and
>> re-enabled in trustzone prior to the scm call exit, the TM
>> region registers will not re-initialized in trustzone and thus
>> need to be handled by the tsens driver.
>>
>> Cc: Amit Kucheria <amitk@kernel.org>
>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-msm@vger.kernel.org
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   drivers/thermal/qcom/tsens-v2.c |   3 +
>>   drivers/thermal/qcom/tsens.c    | 237 +++++++++++++++++++++++++++++++-
>>   drivers/thermal/qcom/tsens.h    |   6 +
>>   3 files changed, 239 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 61d38a56d29a..9bb542f16482 100644
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
>> index 97f4d4454f20..28d42ae0eb47 100644
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
>> @@ -21,6 +22,8 @@
>>   #include "../thermal_hwmon.h"
>>   #include "tsens.h"
>>   
>> +LIST_HEAD(tsens_device_list);
>> +
>>   /**
>>    * struct tsens_irq_data - IRQ status and temperature violations
>>    * @up_viol:        upper threshold violated
>> @@ -594,19 +597,159 @@ static void tsens_disable_irq(struct tsens_priv *priv)
>>   	regmap_field_write(priv->rf[INT_EN], 0);
>>   }
>>   
>> +static int tsens_reenable_hw_after_scm(struct tsens_priv *priv)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&priv->ul_lock, flags);
>> +
>> +	/* Re-enable watchdog, unmask the bark and
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
>> +	spin_unlock_irqrestore(&priv->ul_lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>>   int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>>   {
>> -	struct tsens_priv *priv = s->priv;
>> +	struct tsens_priv *priv = s->priv, *priv_reinit;
>>   	int hw_id = s->hw_id;
>>   	u32 temp_idx = LAST_TEMP_0 + hw_id;
>>   	u32 valid_idx = VALID_0 + hw_id;
>>   	u32 valid;
>> -	int ret;
>> +	int ret, trdy, first_round, tsens_ret, sw_reg;
>> +	unsigned long timeout;
>> +	static atomic_t in_tsens_reinit;
> 
> This is a global state, I suggest you move it to the top of the file to
> make that obvious.

Sure.

>>   	/* VER_0 doesn't have VALID bit */
>>   	if (tsens_version(priv) == VER_0)
>>   		goto get_temp;
>>   
>> +	/* For some tsens controllers, its suggested to
>> +	 * monitor the controller health periodically
>> +	 * and in case an issue is detected to reinit
>> +	 * tsens controller via trustzone.
>> +	 */
>> +	if (priv->needs_reinit_wa) {
> 
> I would suggest that you move all this entire block to a separate
> function, maybe something:
> 
> int tsens_health_check_and_reinit()

Ok. Will fix in v2.

>> +		/* First check if TRDY is SET */
>> +		timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
>> +		do {
>> +			ret = regmap_field_read(priv->rf[TRDY], &trdy);
>> +			if (ret)
>> +				goto err;
>> +			if (!trdy)
>> +				continue;
>> +		} while (time_before(jiffies, timeout));
> 
> This looks like a regmap_field_read()

Not sure, I completely understand this comment. Can you please elaborate?

>> +
>> +		if (!trdy) {
>> +			ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE], &first_round);
>> +			if (ret)
>> +				goto err;
>> +
>> +			if (!first_round) {
>> +				if (atomic_read(&in_tsens_reinit)) {
>> +					dev_dbg(priv->dev, "tsens re-init is in progress\n");
>> +					ret = -EAGAIN;
> 
> Is it preferred to return -EAGAIN here, over just serializing this whole
> thing using a mutex?

Right, using a mutex to serialize here makes sense. Will fix in v2.

>> +					goto err;
>> +				}
>> +
>> +				/* Wait for 2 ms for tsens controller to recover */
>> +				timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
>> +				do {
>> +					ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE],
>> +								&first_round);
>> +					if (ret)
>> +						goto err;
>> +
>> +					if (first_round) {
>> +						dev_dbg(priv->dev, "tsens controller recovered\n");
>> +						goto sensor_read;
>> +					}
>> +				} while (time_before(jiffies, timeout));
>> +
>> +				/*
>> +				 * tsens controller did not recover,
>> +				 * proceed with SCM call to re-init it
>> +				 */
>> +				if (atomic_read(&in_tsens_reinit)) {
>> +					dev_dbg(priv->dev, "tsens re-init is in progress\n");
>> +					ret = -EAGAIN;
>> +					goto err;
>> +				}
>> +
>> +				atomic_set(&in_tsens_reinit, 1);
> 
> Afaict nothing prevents two different processes to run the remainder of
> the recovery in parallel. I think you need some locking here.

Ack.

>> +
>> +				/*
>> +				 * Invoke scm call only if SW register write is
>> +				 * reflecting in controller. Try it for 2 ms.
>> +				 */
>> +				timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
>> +				do {
>> +					ret = regmap_field_write(priv->rf[INT_EN], BIT(2));
> 
> Do we know what BIT(2) is and would we be allowed to give it a define?

Sure, I will add a define here.

>> +					if (ret)
>> +						goto err_unset;
>> +
>> +					ret = regmap_field_read(priv->rf[INT_EN], &sw_reg);
>> +					if (ret)
>> +						goto err_unset;
>> +
>> +					if (!(sw_reg & BIT(2)))
>> +						continue;
> 
> Why not:
> 
> } while (sw_reg & BIT(2) && time_before(jiffies, timeout));

Sure.

>> +				} while (time_before(jiffies, timeout));
>> +
>> +				if (!(sw_reg & BIT(2))) {
>> +					ret = -ENOTRECOVERABLE;
>> +					goto err_unset;
>> +				}
>> +
>> +				ret = qcom_scm_tsens_reinit(&tsens_ret);
>> +				if (ret || tsens_ret) {
>> +					dev_err(priv->dev, "tsens reinit scm call failed (%d : %d)\n",
>> +							ret, tsens_ret);
>> +					if (tsens_ret)
>> +						ret = -ENOTRECOVERABLE;
> 
> If that's the api for the SCM, feel free to move the -ENOTRECOVERABLE to
> the scm function.

Ok, let me check and fix this in v2.

>> +
>> +					goto err_unset;
>> +				}
>> +
>> +				/* After the SCM call, we need to re-enable
>> +				 * the interrupts and also set active threshold
>> +				 * for each sensor.
>> +				 */
>> +				list_for_each_entry(priv_reinit,
>> +						&tsens_device_list, list) {
>> +					ret = tsens_reenable_hw_after_scm(priv_reinit);
>> +					if (ret) {
>> +						dev_err(priv->dev,
>> +							"tsens re-enable after scm call failed (%d)\n",
>> +							ret);
>> +						ret = -ENOTRECOVERABLE;
>> +						goto err_unset;
>> +					}
>> +				}
>> +
>> +				atomic_set(&in_tsens_reinit, 0);
>> +
>> +				/* Notify reinit wa worker */
>> +				list_for_each_entry(priv_reinit,
> 
> Do you need to loop twice over the tsens instances?
> 
>> +						&tsens_device_list, list) {
>> +					queue_work(priv_reinit->reinit_wa_worker,
>> +							&priv_reinit->reinit_wa_notify);
>> +				}
>> +			}
>> +		}
>> +	}
>> +
>> +sensor_read:
>>   	/* Valid bit is 0 for 6 AHB clock cycles.
>>   	 * At 19.2MHz, 1 AHB clock is ~60ns.
>>   	 * We should enter this loop very, very rarely.
>> @@ -623,6 +766,12 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>>   	*temp = tsens_hw_to_mC(s, temp_idx);
>>   
>>   	return 0;
>> +
>> +err_unset:
>> +	atomic_set(&in_tsens_reinit, 0);
>> +
>> +err:
>> +	return ret;
>>   }
>>   
>>   int get_temp_common(const struct tsens_sensor *s, int *temp)
>> @@ -860,6 +1009,14 @@ int __init init_common(struct tsens_priv *priv)
>>   		goto err_put_device;
>>   	}
>>   
>> +	priv->rf[FIRST_ROUND_COMPLETE] = devm_regmap_field_alloc(dev,
>> +								priv->tm_map,
>> +								priv->fields[FIRST_ROUND_COMPLETE]);
>> +	if (IS_ERR(priv->rf[FIRST_ROUND_COMPLETE])) {
>> +		ret = PTR_ERR(priv->rf[FIRST_ROUND_COMPLETE]);
>> +		goto err_put_device;
>> +	}
>> +
>>   	/* This loop might need changes if enum regfield_ids is reordered */
>>   	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
>>   		for (i = 0; i < priv->feat->max_sensors; i++) {
>> @@ -1097,6 +1254,43 @@ static int tsens_register(struct tsens_priv *priv)
>>   	return ret;
>>   }
>>   
>> +static void tsens_reinit_worker_notify(struct work_struct *work)
>> +{
>> +	int i, ret, temp;
> 
> priv->num_sensors is unsigned, so i could be too.

Ok.

>> +	struct tsens_irq_data d;
>> +	struct tsens_priv *priv = container_of(work, struct tsens_priv,
>> +					       reinit_wa_notify);
>> +
>> +	for (i = 0; i < priv->num_sensors; i++) {
>> +		const struct tsens_sensor *s = &priv->sensor[i];
>> +		u32 hw_id = s->hw_id;
>> +
>> +		if (!s->tzd)
>> +			continue;
>> +		if (!tsens_threshold_violated(priv, hw_id, &d))
>> +			continue;
>> +
>> +		ret = get_temp_tsens_valid(s, &temp);
>> +		if (ret) {
>> +			dev_err(priv->dev, "[%u] %s: error reading sensor\n",
>> +				hw_id, __func__);
> 
> Please express yourself in the message, instead of using __func__.

This was a reuse from the existing tsens irq handler code, but I agree.
Let me fix it in v2.

>> +			continue;
>> +		}
>> +
>> +		tsens_read_irq_state(priv, hw_id, s, &d);
>> +
>> +		if ((d.up_thresh < temp) || (d.low_thresh > temp)) {
>> +			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
>> +				hw_id, __func__, temp);
>> +			thermal_zone_device_update(s->tzd,
>> +						   THERMAL_EVENT_UNSPECIFIED);
> 
> This is just 86 chars long, no need to wrap the line.

Sure.

>> +		} else {
>> +			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
> 
> Double space after ':'

Again this is a reuse from the existing tsens irq handler code, but I 
agree. Let me fix it in v2.

>> +				hw_id, __func__, temp);
>> +		}
>> +	}
>> +}
>> +
>>   static int tsens_probe(struct platform_device *pdev)
>>   {
>>   	int ret, i;
>> @@ -1139,6 +1333,19 @@ static int tsens_probe(struct platform_device *pdev)
>>   	priv->dev = dev;
>>   	priv->num_sensors = num_sensors;
>>   	priv->needs_reinit_wa = data->needs_reinit_wa;
>> +
>> +	if (priv->needs_reinit_wa && !qcom_scm_is_available())
>> +		return -EPROBE_DEFER;
>> +
>> +	if (priv->needs_reinit_wa) {
>> +		priv->reinit_wa_worker = alloc_workqueue("tsens_reinit_work",
>> +							 WQ_HIGHPRI, 0);
> 
> Do you really need your own work queue for this, how about just
> scheduling the work on system_highpri_wq?

Ok, let me use 'system_highpri_wq' in v2.

Regards,
Bhupesh
