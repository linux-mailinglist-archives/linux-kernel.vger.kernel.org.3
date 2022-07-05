Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEFB566602
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiGEJZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGEJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:25:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA829D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:25:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q9so16636968wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZW5lLkL4JDDf9YU7h/GJGKjkCyTulUg7IkJ5X2M8OE0=;
        b=CpNzyFgqsQd/DD8PMyj/53gIhGninW9JqnA2U3FFJTOPqE5SM3EkDrAdhwn+7ncT5v
         wKjohAnLgdC+n8Y+UXvJHDf7RYG5VaTRCd4Fc+uRINtx5aikqTNMbIqtV1nzjCPlk6nj
         D/0sZ0VLfEaIsUm3UnmE+bpDGWNXeaH/Lyw8ggXAyVBXoijGMVpfJlbrX4rfqEKD3bb6
         uhQFDW/Q7u7w3Yq0l4IgTZkgzhb28Gyrzno9rxTV0SenCO9ZTDV5UPfBNTAsvX9nsPC0
         qcyL9P/sBnSoRnd8AnS0YlfRh+Al/8plbYVUFILSlTeSfZmrUb+nZ0vZd+kObtXtFkp7
         viYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZW5lLkL4JDDf9YU7h/GJGKjkCyTulUg7IkJ5X2M8OE0=;
        b=KJui6j+DT2q6bbJGfK9OMFlwQEbC3i2iY9JSRvwG4pPXZXxgfHDx8tfiD+DyOTTx1w
         KMHCrNJ+NB04/XYAFSy8ZwZg5tQuGi0IeU/B5fbHc6eUZqE4yfktlt+WsIDdM4p7Jfc1
         btOjgfKO1ZmCoOc6XaJGasJ3sk2n8VHrpUBe40oTFuZbmKndDxZBSWHo6lnxPh5N+VPL
         BDaiAAM7tQSQjIg5+7MjOMwzmLl6Vl6xqVIa2gHOtT5tOGZc/pI/OuP9aBFONY9UVrl1
         G/FO7dUMeOGcbjJUFQ2ImQMLG2QnWSCXsLqEh9vHwsK+foQhAOJsfXvW/XuOkQB+5Y0N
         T1pg==
X-Gm-Message-State: AJIora/aCJV5ac2V05uGa2WWXRg2n0c5/XFjj3Py4LDX8DGBwhD+8Aue
        5ffXqEHEaJMV+Fh43EiXAlBy2Q==
X-Google-Smtp-Source: AGRyM1ulejTrozItdDe8gUaSa6g97LeECzQY32rA9ATM/klopckLROa1qgzi/UICUNSR8vmGdeg9yQ==
X-Received: by 2002:a5d:4f0b:0:b0:21d:705c:caf with SMTP id c11-20020a5d4f0b000000b0021d705c0cafmr3189291wru.55.1657013103855;
        Tue, 05 Jul 2022 02:25:03 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q7-20020a05600000c700b0021d76985929sm484157wrx.80.2022.07.05.02.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:25:03 -0700 (PDT)
Message-ID: <653f63e5-c794-27fb-115a-7b051850991b@linaro.org>
Date:   Tue, 5 Jul 2022 11:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/4] cpufreq: scmi: Support the power scale in micro-Watts
 in SCMI v3.1
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-5-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220622145802.13032-5-lukasz.luba@arm.com>
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

On 22/06/2022 16:58, Lukasz Luba wrote:
> The SCMI v3.1 adds support for power values in micro-Watts. They are not
> always in milli-Watts anymore (ignoring the bogo-Watts). Thus, the power
> must be converted conditionally before sending to Energy Model. Add the
> logic which handles the needed checks and conversions.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/cpufreq/scmi-cpufreq.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index bfd35583d653..513a071845c2 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -100,7 +100,7 @@ static int __maybe_unused
>   scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
>   		   unsigned long *KHz)
>   {
> -	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
> +	enum scmi_power_scale power_scale = perf_ops->power_scale_get(ph);
>   	unsigned long Hz;
>   	int ret, domain;
>   
> @@ -114,8 +114,8 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
>   	if (ret)
>   		return ret;
>   
> -	/* Provide bigger resolution power to the Energy Model */
> -	if (power_scale_mw)
> +	/* Convert the power to uW if it is mW (ignore bogoW) */
> +	if (power_scale == SCMI_POWER_MILLIWATTS)
>   		*power *= MICROWATT_PER_MILLIWATT;
>   
>   	/* The EM framework specifies the frequency in KHz. */
> @@ -255,8 +255,9 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
>   static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
>   {
>   	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
> -	bool power_scale_mw = perf_ops->power_scale_mw_get(ph);
> +	enum scmi_power_scale power_scale = perf_ops->power_scale_get(ph);
>   	struct scmi_data *priv = policy->driver_data;
> +	bool em_power_scale = false;

Just pass 'false' to em_dev_register_perf_domain()

>   	/*
>   	 * This callback will be called for each policy, but we don't need to
> @@ -268,9 +269,13 @@ static void scmi_cpufreq_register_em(struct cpufreq_policy *policy)
>   	if (!priv->nr_opp)
>   		return;
>   
> +	if (power_scale == SCMI_POWER_MILLIWATTS
> +	    || power_scale == SCMI_POWER_MICROWATTS)
> +		em_power_scale = true;
> +
>   	em_dev_register_perf_domain(get_cpu_device(policy->cpu), priv->nr_opp,
>   				    &em_cb, priv->opp_shared_cpus,
> -				    power_scale_mw);
> +				    em_power_scale);
>   }
>   
>   static struct cpufreq_driver scmi_cpufreq_driver = {


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
