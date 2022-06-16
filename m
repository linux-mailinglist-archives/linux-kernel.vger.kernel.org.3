Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B733E54DA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358878AbiFPGGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348986AbiFPGGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:06:11 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508FC2B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:06:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s37so580518pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tFNNWBV1JwdjHL2prY8/fO/Im7Us5TFxYzhpaCO//zQ=;
        b=wTvGlVeyaYvcuomaOTVvYAp9OewZ3hUW5qJ+0r60n/Vot9b6CEqm1hQ+cc4rdV9szQ
         2vQNXNm9zAGFnYgFwkA2gWaZP7uzsNNYDSy2lIHG332A1usd/oIS9eYjgSTLDzmTVtut
         6xAVBoqkqt0Sw7YF5rC8Ciw6rOClp8lm5u2seYN6B5QX+dZ/g+ZS/4NSQA4VevYK1NDf
         Ja2FiUbjGEFpt394//5TIMECzEl8RLHR9pMHWztahRRH1/preISjHonaa8lAvsc/scBK
         DAWIL3dTz0IO7yeR4UID3hw2eGJsxDEWvwYAaUzy1GvsAJlkhdbRwCZ8CkoA6UFUd5hi
         xOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tFNNWBV1JwdjHL2prY8/fO/Im7Us5TFxYzhpaCO//zQ=;
        b=B1f3Vzi3WC3ZaMj5RyRJOfkZAw1tkgQXZmwo5dL/I3wAba/GFatX6MsWzoC5tXDfhK
         ULes/8KHkjtrGjtyx4ngBgjhMKNpxVuf3dPbDO/WgX2hKKpou7EWdJaupy3PNbVEoqpV
         5fdFeEv3BR7KkUuFReb781tM7emjLSXulaaJx1XWrDKbqR1Swu3+Zs3KhjZox4T04H2r
         NtYg121poLmsAWClpAzz/gOzcyJkWd3pYZzI/ogHrR20muPt1ssawkNfzgsmGvYnBU8C
         ER5jughvoeLCSnHUioRc+/4KpknFaIWpUygHdousi53gkMw2cw3AzhmoSQr+bgnLnH65
         ZRoA==
X-Gm-Message-State: AJIora975QaZ2wLPpcs11Ba2hNp4bKRM17wchyrEYLPqAxGRFeIE1v8o
        2SoN8DhNjt9j4s71UbWGsBPMeg==
X-Google-Smtp-Source: AGRyM1t56y1brgraV4Sa61pENGIETGkOWiC7Z2PTRF71blSxFIFMKJWRHUd4QMe92IHZyNkvMjWcBQ==
X-Received: by 2002:a05:6a00:198e:b0:51c:3511:4aff with SMTP id d14-20020a056a00198e00b0051c35114affmr3268042pfl.20.1655359567572;
        Wed, 15 Jun 2022 23:06:07 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id fa17-20020a17090af0d100b001eae908b67dsm726639pjb.15.2022.06.15.23.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 23:06:07 -0700 (PDT)
Date:   Thu, 16 Jun 2022 11:36:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liang He <windhl@126.com>
Cc:     vireshk@kernel.org, shiraz.linux.kernel@gmail.com, soc@kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: arm: mach-spear: Add missing of_node_put() in
 time.c
Message-ID: <20220616060605.jtbgai74w4f7ddyh@vireshk-i7>
References: <20220615123912.3965902-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615123912.3965902-1-windhl@126.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-22, 20:39, Liang He wrote:
> In spear_setup_of_timer(), of_find_matching_node() will return a
> node pointer with refcount incrementd. We should use of_node_put()
> in each fail path or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/arm/mach-spear/time.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index d1fdb6066f7b..a1b6635b4ecb 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -217,16 +217,20 @@ void __init spear_setup_of_timer(void)
>  
>  	irq = irq_of_parse_and_map(np, 0);
>  	if (!irq) {
> +		of_node_put(np);
>  		pr_err("%s: No irq passed for timer via DT\n", __func__);
>  		return;
>  	}
>  
>  	gpt_base = of_iomap(np, 0);
>  	if (!gpt_base) {
> +		of_node_put(np);
>  		pr_err("%s: of iomap failed\n", __func__);
>  		return;
>  	}
> -
> +	
> +	of_node_put(np);
> +	
>  	gpt_clk = clk_get_sys("gpt0", NULL);
>  	if (IS_ERR(gpt_clk)) {
>  		pr_err("%s:couldn't get clk for gpt\n", __func__);

Since this routine already have error labels, for consistence it would be better
to add another one "err_put_np" and use goto to that ?

-- 
viresh
