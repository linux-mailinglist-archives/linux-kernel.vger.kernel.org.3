Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4660757B47D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiGTK2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiGTK2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:28:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A5C2CDFD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:28:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d16so25460188wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=HDPGW+0VbU3HlGqsVgCK1SSNUaqROvFzsq51vzca6Qw=;
        b=KrPJmTtMuvZR7p6XRqQ/OrPLQA7Zzg3FcZINYhW2sciW/ZPl/VlBV5i6Wg1VVk1KMb
         6lFWLqiLIcmuXtIwXaDp8Cy7prJnf303iyzNVbmvvLCl0RHLIalMJxeycb7UhFk4PTsL
         PbWa+gwT+nfPXG+BHHgGrBgE859UslhzNc0d4nVszRb7+ClQRwS/ycBKtbkmw1hB8vNf
         +ONm+9s1+1m5MpwvOs5sphs8g83uJc4c6hlKENogyJ5Do+rDBAHjV4JtoZ6njYaO7m7a
         zjq04NqUOr/uL1gmTlnszNwIoGYruLGFM3ti+dsKGC9EhWtkt+/gnbrDcRaEeez3gGSd
         HHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HDPGW+0VbU3HlGqsVgCK1SSNUaqROvFzsq51vzca6Qw=;
        b=KXDyTmFlZFvn3+NGEIQi/NstcOQtouK5MqMgQH39VnZWezd7GCkFt2gopKJlm4jn/j
         qDIYc4dr/7a4TszM3cNeYU8wzpF1JvIq9V1Dwn9UJboril7LKXgH0PV/DK1JgrxBnLZl
         LIeJ3GVfbvvzMUVjT0R1//K2MPDL2LEquA/1WaZOTznXOGOuSyh03Cp2GU1RyE3Wzssw
         UV6MBkXXoAEskfiXlqbtkJSWpYYIrVfVthsnk54Nvxhrn24frTsMR6NXJgjq0nASiaJF
         4qwNvXMAIfkpCpfTaSl8jE8tAAdA1SuGwAXFPDZZH9UEVcJxNHpdWxm7XLCINHszXxy6
         733A==
X-Gm-Message-State: AJIora9zmriEPdsm4/6HqrPYxLVpJfnjkbDj3jsWGTTi54XgkvJYqUNP
        Y/b3f3UgP2T0F4uAx29FPwrhNA==
X-Google-Smtp-Source: AGRyM1vh2LF8NITrJVM5B8R6LREdsrVgV6SJqBUhJgCSK1MiAprdXWFnFxJAT4Imf0CwVtLf+pQQsQ==
X-Received: by 2002:a5d:56d1:0:b0:21d:78ad:c8bf with SMTP id m17-20020a5d56d1000000b0021d78adc8bfmr30739964wrw.175.1658312880843;
        Wed, 20 Jul 2022 03:28:00 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b579:e7b5:219d:267c? ([2a05:6e02:1041:c10:b579:e7b5:219d:267c])
        by smtp.googlemail.com with ESMTPSA id v130-20020a1cac88000000b003a03be171b1sm1980057wme.43.2022.07.20.03.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 03:28:00 -0700 (PDT)
Message-ID: <0861a79e-f2b0-143e-b09e-9b088a4568a7@linaro.org>
Date:   Wed, 20 Jul 2022 12:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 2/5] drivers: thermal: tsens: Add support for combined
 interrupt
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714101451.198211-1-robimarko@gmail.com>
 <20220714101451.198211-2-robimarko@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220714101451.198211-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 14/07/2022 12:14, Robert Marko wrote:
> Despite using tsens v2.3 IP, IPQ8074 and IPQ6018 only have one IRQ for
> signaling both up/low and critical trips.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Bjorn, are these changes ok for you ?

> ---
> Changes in v6:
> * Check critical IRQ handler return, simplify up/low return
> ---
>   drivers/thermal/qcom/tsens-8960.c |  1 +
>   drivers/thermal/qcom/tsens-v0_1.c |  1 +
>   drivers/thermal/qcom/tsens-v1.c   |  1 +
>   drivers/thermal/qcom/tsens-v2.c   |  1 +
>   drivers/thermal/qcom/tsens.c      | 38 ++++++++++++++++++++++++++-----
>   drivers/thermal/qcom/tsens.h      |  2 ++
>   6 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 67c1748cdf73..ee584e5b07e5 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -269,6 +269,7 @@ static const struct tsens_ops ops_8960 = {
>   static struct tsens_features tsens_8960_feat = {
>   	.ver_major	= VER_0,
>   	.crit_int	= 0,
> +	.combo_int	= 0,
>   	.adc		= 1,
>   	.srot_split	= 0,
>   	.max_sensors	= 11,
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index f136cb350238..6effb822bf3c 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -539,6 +539,7 @@ static int calibrate_9607(struct tsens_priv *priv)
>   static struct tsens_features tsens_v0_1_feat = {
>   	.ver_major	= VER_0_1,
>   	.crit_int	= 0,
> +	.combo_int	= 0,
>   	.adc		= 1,
>   	.srot_split	= 1,
>   	.max_sensors	= 11,
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 573e261ccca7..a4f561a6e582 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -302,6 +302,7 @@ static int calibrate_8976(struct tsens_priv *priv)
>   static struct tsens_features tsens_v1_feat = {
>   	.ver_major	= VER_1_X,
>   	.crit_int	= 0,
> +	.combo_int	= 0,
>   	.adc		= 1,
>   	.srot_split	= 1,
>   	.max_sensors	= 11,
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index b293ed32174b..129cdb247381 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -31,6 +31,7 @@
>   static struct tsens_features tsens_v2_feat = {
>   	.ver_major	= VER_2_X,
>   	.crit_int	= 1,
> +	.combo_int	= 0,
>   	.adc		= 0,
>   	.srot_split	= 1,
>   	.max_sensors	= 16,
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 7963ee33bf75..5c7f9ec6ab1c 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -532,6 +532,27 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
>   
> +/**
> + * tsens_combined_irq_thread - Threaded interrupt handler for combined interrupts
> + * @irq: irq number
> + * @data: tsens controller private data
> + *
> + * Handle the combined interrupt as if it were 2 separate interrupts, so call the
> + * critical handler first and then the up/low one.
> + *
> + * Return: IRQ_HANDLED
> + */
> +static irqreturn_t tsens_combined_irq_thread(int irq, void *data)
> +{
> +	irqreturn_t ret;
> +
> +	ret = tsens_critical_irq_thread(irq, data);
> +	if (ret != IRQ_HANDLED)
> +		return ret;
> +
> +	return tsens_irq_thread(irq, data);
> +}
> +
>   static int tsens_set_trips(void *_sensor, int low, int high)
>   {
>   	struct tsens_sensor *s = _sensor;
> @@ -1083,13 +1104,18 @@ static int tsens_register(struct tsens_priv *priv)
>   				   tsens_mC_to_hw(priv->sensor, 0));
>   	}
>   
> -	ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
> -	if (ret < 0)
> -		return ret;
> +	if (priv->feat->combo_int) {
> +		ret = tsens_register_irq(priv, "combined",
> +					 tsens_combined_irq_thread);
> +	} else {
> +		ret = tsens_register_irq(priv, "uplow", tsens_irq_thread);
> +		if (ret < 0)
> +			return ret;
>   
> -	if (priv->feat->crit_int)
> -		ret = tsens_register_irq(priv, "critical",
> -					 tsens_critical_irq_thread);
> +		if (priv->feat->crit_int)
> +			ret = tsens_register_irq(priv, "critical",
> +						 tsens_critical_irq_thread);
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 1471a2c00f15..4614177944d6 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -495,6 +495,7 @@ enum regfield_ids {
>    * struct tsens_features - Features supported by the IP
>    * @ver_major: Major number of IP version
>    * @crit_int: does the IP support critical interrupts?
> + * @combo_int: does the IP use one IRQ for up, low and critical thresholds?
>    * @adc:      do the sensors only output adc code (instead of temperature)?
>    * @srot_split: does the IP neatly splits the register space into SROT and TM,
>    *              with SROT only being available to secure boot firmware?
> @@ -504,6 +505,7 @@ enum regfield_ids {
>   struct tsens_features {
>   	unsigned int ver_major;
>   	unsigned int crit_int:1;
> +	unsigned int combo_int:1;
>   	unsigned int adc:1;
>   	unsigned int srot_split:1;
>   	unsigned int has_watchdog:1;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
