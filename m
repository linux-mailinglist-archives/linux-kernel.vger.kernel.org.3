Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3265151F318
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiEIDwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiEIDkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:40:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4A262103
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:36:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k1so12670272pll.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JQ5hWsounMpf58DHcH0GLKrQSLqO2OdQzcem2B4+ChU=;
        b=QkF9M8J123UteR1cPxuEawzImVx/iLdvIryVF9OwDpcPLWaPm82wa1yD3XJwXIQ8bc
         JgAUvGxNueEjxQfFn8SAxLGZ+evF351ZGLIRh/hxEMh1SFIht86dRGKTn1Ps5UvHDtUO
         oy+vqQjHwapTDEzUg+VRkeDQYNRAdp1/2X9udHLwt0Rxla4648nfPRi5AVaM/V5pO/Z/
         An094rUi2hY0/JxXSUdNKQnsJ7da2J5ljxaYVJljw6xtkApiPAw+dOR78oKmdF1QqiIA
         LTyVkYUmAVOVx1XaJHWU7fSIlwSKueBNcS88V3FNIfQEhkamsHjpQZekP6XFbNdl5Zr9
         rMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JQ5hWsounMpf58DHcH0GLKrQSLqO2OdQzcem2B4+ChU=;
        b=wexOa2A3gpjLHsWhWzSaevAyrfobt0qt4PxnOuKnWkksCf0Hjl5baLC9+VRRUkCnA1
         CaDMVhs8FyAZH4juKkKol/ywhaH0h+zbrojKS/qhoQtTMSpBw8s8wOFYZext8e2q2cA1
         lDiyxQGQ0tOmGgQcbFz8/qDapqKpZIFOvI1c2vcbtFf8u8PDwae8mpvhv6OH1uf5ZB50
         fj/E6raEna9enQUFrUYLsu52UI9yxNZU56Rp6kg/75sHLl/oXvVsDhldxLoLbgOKV2wb
         yFPlKS0OPokjoVyFpTazr7cQ0StxOycncGNSJBKBGkHRhfYGTxGK4laKUDSjXuh3Nlt0
         5EiQ==
X-Gm-Message-State: AOAM531RamapyGb643+e0rTDygcR8IO6+6BrBle/XhQxl+2Wll1MuSpc
        py94IRxaqkqF4drMAgD/YHavlA==
X-Google-Smtp-Source: ABdhPJyYXA+HSxshWIHyeWTIGwpaZOw21UOu7nN+qsNb530j9mXYoo+2hFP4+z4p+EG/f+8DEUXFPA==
X-Received: by 2002:a17:90b:606:b0:1d9:5dd5:1489 with SMTP id gb6-20020a17090b060600b001d95dd51489mr24257701pjb.171.1652067418724;
        Sun, 08 May 2022 20:36:58 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a0002c200b0050dc7628143sm7265847pft.29.2022.05.08.20.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 20:36:57 -0700 (PDT)
Date:   Mon, 9 May 2022 09:06:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix typo when cpufreq device remove
Message-ID: <20220509033655.f2fsbis72hrjft6q@vireshk-i7>
References: <20220506170832.33386-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506170832.33386-1-schspa@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-05-22, 01:08, Schspa Shi wrote:
> This should check cpufreq_driver->exit pointer before call this function
> 
> Fixes: 91a12e91dc39 ("cpufreq: Allow light-weight tear down and bring up of
> CPUs")
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 43dfaa8124e2..0f59c8ec2b39 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1661,7 +1661,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>  
>  	if (cpumask_empty(policy->real_cpus)) {
>  		/* We did light-weight exit earlier, do full tear down now */
> -		if (cpufreq_driver->offline)
> +		if (cpufreq_driver->exit)
>  			cpufreq_driver->exit(policy);
>  
>  		cpufreq_policy_free(policy);

NAK.

The code is doing fine and there is a comment above it on why it is
doing it this way.

-- 
viresh
