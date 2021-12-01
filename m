Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A54645D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbhLAEYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 23:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhLAEYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:24:43 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A05C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:21:23 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 71so22206079pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c4ffdchtUCqUkidwG/gnpdUo9VMAIoRHb8PtUKp2boM=;
        b=ktaGgbqZ+hapx21vXWP4VFwyvJ+emehaz+t9f6YPaKTG8Zap7AosMdBV04z0jZHs42
         p1xoOMLPKx0Bz9yT/onlcatnHUpBH9ojkYiboAXZ18hXR9ChJA3x5v1JI2nUVo8jAbg3
         VySkim3xjlwK7KboOBEjISM3fkFa3Q3qumQ1YeEWzbLALPZYYny1zebs/CQJkALkyytp
         AELaN4mr+BZx+rPVMlzFHx1op7f5tIBJGSjwF8A4zTvJOyXA3f1wvvhFwkDKuN7oZjvO
         y3H4Aa6BUQNL1P6OeIQmADb6a/RNcHhObc+Xfha6WtZ7LwufkAKJWqLK2l/U8stHHihj
         kICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c4ffdchtUCqUkidwG/gnpdUo9VMAIoRHb8PtUKp2boM=;
        b=sWFGATcTjHj+gr2gw39XyNjWVqzqHJDts97DyQrQqpyReQiHr78YjYPTgrhqQRkCIp
         2VwNTUF0t4zUUedyehZzJzSn4yuQax9aJS3Vx6MalN40DPMmlD4pkx/jdoVLKAs337Ao
         5yQKtFJHFPKQeitJlP6kUYXYCeKUOdbt+++5RsNmgatzi2WA1kdxMlHHt3+dSttk58sL
         TXLQyWf6i/ovfxOwXuYLlJSuDrzRe8l5KjzB4ibqmotEY4T0jjk5T9ubuiSlbH3GbdOg
         iSySs9D5wyFAmAl8G28Mq+7qCHauZS520KqTyFRexy66Vm/y/fIe57ecMhwuDFQX/15x
         9tEg==
X-Gm-Message-State: AOAM530fzu+RCscGQk+xLV2h0CRj/mZuf4mtYYPTs5BjBduDZ7WjZmRO
        2v0L3qC9bQ7z7ln1F48m2QPAlA==
X-Google-Smtp-Source: ABdhPJwgHynih3Z/75kZx+h/ReorYXwsGxIrdDa8KvVUzFpl8YR6uurJncGVp0qciy5VsJ5fM4r0IQ==
X-Received: by 2002:a05:6a00:1395:b0:49f:b2c0:cff8 with SMTP id t21-20020a056a00139500b0049fb2c0cff8mr3489223pfg.17.1638332483086;
        Tue, 30 Nov 2021 20:21:23 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id j16sm25225081pfj.16.2021.11.30.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 20:21:22 -0800 (PST)
Date:   Wed, 1 Dec 2021 09:51:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     rafael.j.wysocki@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] doc/cpufreq: Update core.rst
Message-ID: <20211201042118.ra4rmkeivffg2kap@vireshk-i7>
References: <20211130151526.949-1-tangyizhou@huawei.com>
 <20211130151526.949-3-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130151526.949-3-tangyizhou@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-21, 23:15, Tang Yizhou wrote:
> As the definition of struct cpufreq_freqs has changed, update core.rst
> with the new first member of struct cpufreq_freqs.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  Documentation/cpu-freq/core.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/core.rst b/Documentation/cpu-freq/core.rst
> index 33cb90bd1d8f..4ceef8e7217c 100644
> --- a/Documentation/cpu-freq/core.rst
> +++ b/Documentation/cpu-freq/core.rst
> @@ -73,12 +73,12 @@ CPUFREQ_POSTCHANGE.
>  The third argument is a struct cpufreq_freqs with the following
>  values:
>  
> -=====	===========================
> -cpu	number of the affected CPU
> +======	======================================
> +policy	a pointer to the struct cpufreq_policy
>  old	old frequency
>  new	new frequency
>  flags	flags of the cpufreq driver
> -=====	===========================
> +======	======================================
>  
>  3. CPUFreq Table Generation with Operating Performance Point (OPP)
>  ==================================================================

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
