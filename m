Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579E058C54D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbiHHJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiHHJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:11:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECECCE30
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:11:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z6so4286142lfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=capmqUg3G2WGPZIJLVN0uL7EfqUKEp7KJ1xrI9gIScY=;
        b=mkrFcP1IBKQ/4uTvXD8INz59IvBi/jIPA9T3Kb0PTch8u/9Hr3RKgGHHDtzGdBClqW
         msaVM3Zg0f84JVBbl6vSlBST7PhqkSRuNuhYL6b8HVuDGCT5Rn0gn4M21+KDcmIYkabk
         UeG2sWRVfOOgZHnIrfHG3uWb2m7T6K6Lc6KzHmiAfvSaIrwlwfqZTmpMKyEdGG6B9Vyy
         X4PYwt00A7pjVoSJMTbEON9JYJgHOVkC+l3MkrdYgUk+LpQlg4wTi8BQmhO0/payfY94
         HypMkBcl5QEMgkcgGywtuHThIbzc8k+bjflGldAG3nGhnGYneSCYpN58VSGWv2GI4h8Y
         Lttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=capmqUg3G2WGPZIJLVN0uL7EfqUKEp7KJ1xrI9gIScY=;
        b=W+eRzt+KKesj+1VjFdlEzZDaf0Z9r8uP/cc9H5nuOwVO2OZ2G84I16cw6naSi0JYhN
         8USTZm57q/OgYVhcygO9gIWDpK0SewMw56hG1lOXTixP1me/ZiRAWCuUar74xqVbLrXU
         EPCXDkAem+tcQRt2AoYaLYeaafiWzJCcWfIRwvteHgszNOb6lKuu9uI2yZ32rIpBc97d
         PshTSocoL/orr29LBOaBYjBg64KjQcxJ/U+gwiUaZYuTX+RBnHvZPRzB13+F9JUIBfLl
         dFPLDCjly5+J1pCBx9CkKJ3NikJn4Z512bETOvSrzps7kXfTolNqT1IbsHrTDcSiVwpa
         hPvw==
X-Gm-Message-State: ACgBeo1SLjgVhNIyObvs5VWFDQCpwy3Ni8eY0FoES54DM7cx4K6n9Z34
        dZ7Qqnx/on2t6AgxwmjxQEZ1Br/mKU/K1H09
X-Google-Smtp-Source: AA6agR5o3GE4sOi7zvF2niOzM96s9c5dBH+V9xgSaAGhu6wEDIByw9G0WGSzZNsuMtQYObK4wIc+Yg==
X-Received: by 2002:a05:6512:12c7:b0:48b:37af:15d3 with SMTP id p7-20020a05651212c700b0048b37af15d3mr6714608lfg.290.1659949864073;
        Mon, 08 Aug 2022 02:11:04 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t16-20020a2e9d10000000b0025e6a598019sm1299772lji.131.2022.08.08.02.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:11:03 -0700 (PDT)
Message-ID: <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
Date:   Mon, 8 Aug 2022 12:11:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 13/28] mfd: sec: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-14-paul@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220807145247.46107-14-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
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

On 07/08/2022 17:52, Paul Cercueil wrote:
> Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
> to handle the .suspend/.resume callbacks.
> 
> These macros allow the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards.
> 
> The advantage is then that these functions are now always compiled
> independently of any Kconfig option, and thanks to that bugs and
> regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The address does not work. Please don't add it to commit log.

> Cc: linux-samsung-soc@vger.kernel.org

This is also not really needed in commit log... it's just a mailing list...

I actually never understood why people want to add to commit log, so to
something which will last 10 years, Cc-ing other folks, instead of
adding such tags after '---'. Imagine 10 years from now:

1. What's the point to be cced on this patch after 10 years instead of
using maintainers file (the one in 10 years)? Why Cc-ing me in 10 years?
If I am a maintainer of this driver in that time, I will be C-ced based
on maintainers file. If I am not a maintainer in 10 years, why the heck
cc-ing me based on some 10-year old commit? Just because I was a
maintainer once, like 10 years ago?

2. Or why cc-ing such people when backporting to stable?

It's quite a lot of unnecessary emails which many of us won't actually
handle later...

I sincerely admit I was once also adding such Cc-tags. But that time my
employer was counting lines-of-patch (including commit log)... crazy, right?


> ---
>  drivers/mfd/sec-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index 1fb29c45f5cf..a467de2b2fea 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -455,7 +455,6 @@ static void sec_pmic_shutdown(struct i2c_client *i2c)
>  	regmap_update_bits(sec_pmic->regmap_pmic, reg, mask, 0);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int sec_pmic_suspend(struct device *dev)

Did you test W=1 with !CONFIG_PM_SLEEP? No warnings?


Best regards,
Krzysztof
