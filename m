Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77CA55FE03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiF2LA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiF2LA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:00:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CC3C734
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:00:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n1so21835987wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xGLyHh+8Mbf3/i/p0tGrUiVabNI3mp8YOPBN1Q5tKu8=;
        b=GdzGE2XFNE7YJK5ZCHvfLcGKwcL706RxrQqunB/BY7BN0UqlMiLNKOe2zxEi3M0zQG
         Sxjo6mIJ2Gp3YS0mACIuQkm2gxcnHjh3bZAF3VxAB8RArqfJri99f0L4pBJxsX8eYBNj
         OaPc7xN+zRrzRPkjHGgTqe0Xjeoe1xchJgqyVjPC/YbH4gq29Jy3ljwMXij1mFZleYpY
         xG5WwiIqC73Q35tU5tJJ1vSZGYJ8CEGFgYrT8MI7jtXOqBdWm5CEKjpnzIwVTPA+4NYG
         6Spky0UTeSDkkzS9kEOYIIro0h3f3Y6WYBdCGcYvklkZV47KzTLH5ulbvyeVfGg+CWVX
         GzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xGLyHh+8Mbf3/i/p0tGrUiVabNI3mp8YOPBN1Q5tKu8=;
        b=LdkGcTcW8lKG4wJD0MjdSj3UfVNVnS8cwfNYFrq9yJiGRzuT0axXF8MB3Mn5/dj2H8
         fn5nnupnVLNy2n8ZJASYmK+zEzkHDRwnm9ehPTA33OX51IbDdeqNB4z6rSLbYw2FFLdy
         edXfAquC3tpQ0fZ035LrTlanVtxSE7oWs4IWgHTy7jeHvICfmcMNmQz2Q2bF1ahEBjpM
         H3g8mgovsRBb8V3YND0+vWk4bZFRGtYBQweP8nWfZfiqIdM6RvEjohCjlEN6EzChJixj
         +rAhmeySqEFvrfu7Kfcr5e+BDXy++QCtKWi8wOEqHFD1ye5mqNdEJ82DG6uYn7nUpVc7
         Ngmg==
X-Gm-Message-State: AJIora/pdiuIMcx3OrX2WvtlLHeZSiWwRQ0kqoGY3BVnwck5YRHaZHzF
        irT+PW6tn7HFVDDA32kSUHM3Cw==
X-Google-Smtp-Source: AGRyM1sXOvu7BWkXbVkxcM2Z3K2+CaIXfm93SpksVZR0kqbEytL1fxmvD4PEGj9wntgztWrybr0smA==
X-Received: by 2002:adf:e30f:0:b0:21b:a39c:cb40 with SMTP id b15-20020adfe30f000000b0021ba39ccb40mr2439283wrj.180.1656500425448;
        Wed, 29 Jun 2022 04:00:25 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id m2-20020adffa02000000b0021d163daeb0sm8581792wrr.108.2022.06.29.04.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:00:24 -0700 (PDT)
Message-ID: <2fdd0847-5102-ea9f-cfbb-f3dd378d3a8a@linaro.org>
Date:   Wed, 29 Jun 2022 12:00:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: add control, dapm widgets and
 map
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
 <20220629090644.67982-4-srinivas.kandagatla@linaro.org>
 <YrwwPbm0sL1RGwjO@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YrwwPbm0sL1RGwjO@sirena.org.uk>
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

Thanks Mark,

On 29/06/2022 11:58, Mark Brown wrote:
> On Wed, Jun 29, 2022 at 10:06:43AM +0100, Srinivas Kandagatla wrote:
> 
>> +static int wsa_dev_mode_put(struct snd_kcontrol *kcontrol,
>> +			    struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
>> +	struct wsa883x_priv *wsa883x = snd_soc_component_get_drvdata(component);
>> +
>> +	if (wsa883x->dev_mode == ucontrol->value.enumerated.item[0])
>> +		return 0;
>> +
>> +	wsa883x->dev_mode = ucontrol->value.enumerated.item[0];
>> +
>> +	return 0;
>> +}
> 
> This isn't returning 1 when the value changes so will miss generating
> events, please test the driver with mixer-test.
Yes my bad..

> 
>> +	switch (event) {
>> +	case SND_SOC_DAPM_POST_PMU:
>> +		if (wsa883x->dev_mode == RECEIVER) {
>> +			snd_soc_component_write_field(component, WSA883X_CDC_PATH_MODE,
>> +						      WSA883X_RXD_MODE_MASK,
>> +						      WSA883X_RXD_MODE_HIFI);
>> +			snd_soc_component_write_field(component, WSA883X_SPKR_PWM_CLK_CTL,
>> +						      WSA883X_SPKR_PWM_FREQ_SEL_MASK,
>> +						      WSA883X_SPKR_PWM_FREQ_F600KHZ);
>> +			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
>> +						       WSA883X_DRE_PROG_DELAY_MASK, 0x0);
>> +		} else if (wsa883x->dev_mode == SPEAKER) {
> 
> This looks like it'd be better written as a switch statement.
Sounds good,

> 
>> +static const struct snd_kcontrol_new wsa883x_snd_controls[] = {
>> +	SOC_SINGLE_RANGE_TLV("PA Gain", WSA883X_DRE_CTL_1, 1,
>> +			     0x0, 0x1f, 1, pa_gain),
> 
> Volume controls should end in Volume, mixer-test should also have caught
> this.
Okay, will fix all these in next spin.
