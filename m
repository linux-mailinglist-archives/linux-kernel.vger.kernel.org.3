Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B223B4F5D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiDFMLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiDFMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:11:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C7E51FD5D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:03:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so3091066wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AsNQPl7XwXuX2WAvg4rLC1LCZqhZGP7Ik6P3va1VwEg=;
        b=K3EdZM8mcFbYT7dtM+CtBrf3JsqmnVU8klaSh8QuC87mQ6I2UZBbBWDVsLyDXivLin
         +jsd4iv86dMV/fc20qaYKCgbYC4D3b82pRJUIRZg+fnLTxPsbS2fM3vi3r2RX3avdCOg
         RSZzsX884aDRmw+Kcw7u7J5IUlp1d90ao9b/1/wmYiRWgrMYW8LIBS2mdrtILsaCCH7F
         QiWAEtxRv1+LQFpBTGK8MW89ti5EE4bAKjuH2OdImw/z+o3RsxKAS/8v9kXsKXUN4LKn
         Mj3X0fshu+zxYBctBjVgmHfyuzKnK7YXxI2/wYgHMkxxRQvOQefR3wV1Y1+lCRgEeZUX
         rX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AsNQPl7XwXuX2WAvg4rLC1LCZqhZGP7Ik6P3va1VwEg=;
        b=pGWYFJEVMYsz4X56rnT4NM33p1R4dI0l08DmGL6mQPWHvnmWnlgfceUDDDs6gzq8ri
         VBFz4IL1lpfWpNqYd8GvXZuuWK+h01np372Kz5sWKumxgHLOMqPlCSGDCtxzrrpvFCgc
         3bRz1vEvJyYlCiT2Mvx6eJmVsda7JuVudq7U2oxKa6a2ZIs7O+4e9AJOZWOfZJKu4lrs
         aM/PuujPgLwjfQebWH4teAhx0WPlGAKfAk6iGlbaD5a2zLRQ/N8e5O9Y4fHvaCRzfV9X
         BElSft+gswj/ObRNqXn7k+Z230WWnZ6sVIqI9aX4QyxrJfpr92bUSwcuWpsHY09ebeCP
         kn3w==
X-Gm-Message-State: AOAM530PxvLqQyU0CZhIrSu/yxSaTK8Dy20Fv2ooHcK/M3N1IN8HMSiO
        6rkQSaLnbku0Lp2CyKRCkPBHeQ==
X-Google-Smtp-Source: ABdhPJyEGfgOxaVvfj11uScInCMKRFZYCH/NJehxzp/gPbS+4SSjoS2Lxm7d1aUTKXwLeNu/zYb4ng==
X-Received: by 2002:a7b:c922:0:b0:383:e7e2:4a1a with SMTP id h2-20020a7bc922000000b00383e7e24a1amr6487169wml.51.1649232188901;
        Wed, 06 Apr 2022 01:03:08 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id e9-20020a5d5009000000b002060f7faa02sm8276556wrt.116.2022.04.06.01.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:03:08 -0700 (PDT)
Message-ID: <6419fd7b-8213-3a51-268b-a9602c770991@linaro.org>
Date:   Wed, 6 Apr 2022 10:03:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] clocksource/drivers/renesas-ostm: Add support for RZ/V2L
 SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 09:24, Lad Prabhakar wrote:
> The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so instead
> of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> ARCH_R9A07G054.
> 
> With the above change OSTM will be enabled on RZ/V2L SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   drivers/clocksource/renesas-ostm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
> index 21d1392637b8..8da972dc1713 100644
> --- a/drivers/clocksource/renesas-ostm.c
> +++ b/drivers/clocksource/renesas-ostm.c
> @@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
>   
>   TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
>   
> -#ifdef CONFIG_ARCH_R9A07G044
> +#ifdef CONFIG_ARCH_RZG2L

I'm not finding this option anywhere


>   static int __init ostm_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
