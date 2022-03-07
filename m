Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0624CF3E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiCGIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiCGIrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:47:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C1263538
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:46:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q14so6427478wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 00:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WQB8Wj8L2naBf99gAuyw+5VYV82BNeXK+2ElJRbWO5s=;
        b=mFke2k3O5n2KTc+OBpSwEGYxGgXKklKBN1I7HJNehUDSEQDOLPuvhG6WYa4jPUWSaB
         /Qc2aYNubYEebqhM4q80rAJQc0hQeeMehWol8JFOfDp0o4nGAM8wU0ZQYCNevtniMC8/
         E1CwvTwI+JzsusxsubfnfYR3n5efnrFVR/OtCVB+7Zi2UsQOMD706qgJ6u3PJt/5s4+4
         Gp79oyuxv4jdVk78kP58UV3grp76skMsBgymyPcyQy2bTEXRerBgIFcAz8+p/IpPTDNN
         QXzErHXq4OcBWvqJHQm1NARbJHpFftY3LGImleS2tvtr56DIVmVWexf8wt+7GYtV+6rB
         ZgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=WQB8Wj8L2naBf99gAuyw+5VYV82BNeXK+2ElJRbWO5s=;
        b=3eowBJkXQ/WV7zlTR6vA0qftyKglgXOGKpKEp3w3Q1tm+Z4mcq5vUffb8LZHMclR5r
         p/QGxb4Xx8CF4xGKdSUFxX+3e1T0RJNigUFV7Itgwvv68hb1JKxdxyajPUB9qpLCmiP4
         /OXoMwU82s9qk7BSJF/O9wqMDBhTBQfPhk/9V70hQGn183xVWt1JcQssSN9eGV/9K/FT
         ABBmiNfl5qhzqW8fa1pkB2Am9BG9fQQjaF8e+t0kNfNQ3UJuGZVUxbdSuUeYbR6sCInC
         9Uk5nP5hK3Lt6vuhU+UUPFsEZVodxzqMrPd3A/FpLLQSc7HoRsnUFI5HbbQewsOjiRtP
         YYCg==
X-Gm-Message-State: AOAM533vZa0x/Q8MePhlomStm1oHFHW4utIn9jBROlujWmBoWcX5bZsh
        aPa785viEG8h7RS/kGm40ZRO5g==
X-Google-Smtp-Source: ABdhPJybKFvjFWhNXd7UECd+xULEdoPrtBag7Uk01fy8gziWwt4F73T11HzmlUw4rbLsGhxf0KElsw==
X-Received: by 2002:a5d:52d2:0:b0:1ef:e22d:18ba with SMTP id r18-20020a5d52d2000000b001efe22d18bamr7382573wrv.30.1646642806566;
        Mon, 07 Mar 2022 00:46:46 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:1451:71b4:fefe:6096? ([2001:861:44c0:66c0:1451:71b4:fefe:6096])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b00384b71a50d5sm12647353wme.24.2022.03.07.00.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 00:46:46 -0800 (PST)
Message-ID: <72059eeb-dec6-286d-7006-0a1d4d947d4f@baylibre.com>
Date:   Mon, 7 Mar 2022 09:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] i2c: meson: Fix wrong speed use from probe
Content-Language: en-US
To:     Lucas Tanure <tanure@linux.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220301072600.12352-1-tanure@linux.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220301072600.12352-1-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 08:26, Lucas Tanure wrote:
> Having meson_i2c_set_clk_div after i2c_add_adapter
> causes issues for client drivers that try to use
> the bus before the requested speed is applied.
> 
> The bus can be used just after i2c_add_adapter, so
> move i2c_add_adapter to the final step as
> meson_i2c_set_clk_div needs to be called before
> the bus is used.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>   drivers/i2c/busses/i2c-meson.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index ef73a42577cc..07eb819072c4 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -465,18 +465,18 @@ static int meson_i2c_probe(struct platform_device *pdev)
>   	 */
>   	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
>   
> -	ret = i2c_add_adapter(&i2c->adap);
> -	if (ret < 0) {
> -		clk_disable_unprepare(i2c->clk);
> -		return ret;
> -	}
> -
>   	/* Disable filtering */
>   	meson_i2c_set_mask(i2c, REG_SLAVE_ADDR,
>   			   REG_SLV_SDA_FILTER | REG_SLV_SCL_FILTER, 0);
>   
>   	meson_i2c_set_clk_div(i2c, timings.bus_freq_hz);
>   
> +	ret = i2c_add_adapter(&i2c->adap);
> +	if (ret < 0) {
> +		clk_disable_unprepare(i2c->clk);
> +		return ret;
> +	}
> +
>   	return 0;
>   }
>   

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
