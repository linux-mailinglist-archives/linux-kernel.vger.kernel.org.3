Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE153781D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiE3JHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiE3JHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:07:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF84D260
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:07:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x12so9598864pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FCiLa5AkDku+8YLr7wCTc9q2xNjYqTpfalfh6wTNH74=;
        b=n46vXm0FgONZSQiqOdJlkxZ4MesZEUtUDgf4bbK/8O+FjdkmmMgT5DTT3CL3HDXH6E
         D8tgRNhjGgHQJfUD2nWsFPwy2aKKq9RHCsDH3CIQRId5QTqxZz3zeB8wCAd2a6BHo5AZ
         dT0CnIP0OYB7CQHzxoaB+A2AH4ZdsyzOmJfkPwbklmuftv1NKElxR6NuBBOZhZXVwo58
         MfZRicunWOZuRqs+rbBfLvcOLPPVPXXgbZsczBCjTI4B+rfLvziWtFCqBnttjwKEwfAw
         uZWr1BO6HS/r3w10yTXJ3FbOUzaiS89GA6vN0wD3LV50rmaHW1VwYdDJ7Ozqvo8GZDmk
         +Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FCiLa5AkDku+8YLr7wCTc9q2xNjYqTpfalfh6wTNH74=;
        b=nEF+/3kutE7xQfCfywU73E0aoIRW52hFAoItqtQJbZMh3KMVOt3KkAC3ycCHSkOYJR
         9qcNa0YL+K1WOo90fwI6QkgCeYebLnFWGFD6LhlxqKvxNfQn/FlifZpsMvT65/fbfsw8
         dx/gC8cj2Kf6aieqrkUCNSFABG4Ra1EvdXovLWhch59QLWtR6A3Nr76oKFIklQFdGqYd
         5NXXJ/cdQajvu6lf8qRVzJT0JYcM+UfJKhylFPYcWz+ajEQHOu45tcwuYpNHCjxXYTC8
         vs+kZ7PZkhVXxJlEEtjHyaCKQMux1d44/J459Y1r2YGWoLnYkG0RBX+pjeCDHTRDP5WY
         h0Zg==
X-Gm-Message-State: AOAM5312tihjaEZtSfbUCfcxBc1i1A57+vRNOodGWoyKbMo0+rNXKjPk
        dkRRCPb428GzekedOWHNRKnVJg==
X-Google-Smtp-Source: ABdhPJzoe9FuX+oleaoLGawpWPqdWSMzzj1F6HBxpWQSYqB1rNNrIO7XBlMHgvEOAaaiQSnqHNHfvw==
X-Received: by 2002:a63:c00c:0:b0:3f6:103:5bc1 with SMTP id h12-20020a63c00c000000b003f601035bc1mr47658474pgg.404.1653901660989;
        Mon, 30 May 2022 02:07:40 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a00231200b005104c6d7941sm8397202pfh.31.2022.05.30.02.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 02:07:40 -0700 (PDT)
Date:   Mon, 30 May 2022 14:37:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Dietmar.Eggemann@arm.com,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: CPPC: Fix unused-function warning
Message-ID: <20220530090738.7ycfr7g52b54jzj3@vireshk-i7>
References: <20220530081236.40728-1-pierre.gondois@arm.com>
 <20220530082025.vqzk37dvyzxiq7dv@vireshk-i7>
 <3a26ce90-5d2d-0164-3799-85a9dc1abee6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a26ce90-5d2d-0164-3799-85a9dc1abee6@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-22, 10:44, Pierre Gondois wrote:
> 
> 
> On 5/30/22 10:20, Viresh Kumar wrote:
> > On 30-05-22, 10:12, Pierre Gondois wrote:
> > > Building the cppc_cpufreq driver with for arm64 with
> > > CONFIG_ENERGY_MODEL=n triggers the following warnings:
> > >   drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
> > > [-Werror=unused-function]
> > >     550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
> > >         |            ^~~~~~~~~~~~~~~~~
> > >   drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
> > > [-Werror=unused-function]
> > >     481 | static int cppc_get_cpu_power(struct device *cpu_dev,
> > >         |            ^~~~~~~~~~~~~~~~~~
> > > 
> > > Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
> > > Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > > ---
> > >   drivers/cpufreq/cppc_cpufreq.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > > index d092c9bb4ba3..ecd0d3ee48c5 100644
> > > --- a/drivers/cpufreq/cppc_cpufreq.c
> > > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > > @@ -478,7 +478,7 @@ static inline unsigned long compute_cost(int cpu, int step)
> > >   			step * CPPC_EM_COST_STEP;
> > >   }
> > > -static int cppc_get_cpu_power(struct device *cpu_dev,
> > > +static __maybe_unused int cppc_get_cpu_power(struct device *cpu_dev,
> > >   		unsigned long *power, unsigned long *KHz)
> > >   {
> > >   	unsigned long perf_step, perf_prev, perf, perf_check;
> > > @@ -547,8 +547,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
> > >   	return 0;
> > >   }
> > > -static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
> > > -		unsigned long *cost)
> > > +static __maybe_unused int cppc_get_cpu_cost(struct device *cpu_dev,
> > > +		unsigned long KHz, unsigned long *cost)
> > >   {
> > >   	unsigned long perf_step, perf_prev;
> > >   	struct cppc_perf_caps *perf_caps;
> > 
> > Should we actually run cppc_cpufreq_register_em() for
> > !CONFIG_ENERGY_MODEL ? Why?
> > 
> 
> Hello Viresh,
> It seems that when CONFIG_ENERGY_MODEL=n, the compiler is already
> considering cppc_cpufreq_register_em() as an empty function.
> 
> Indeed, CONFIG_ENERGY_MODEL=n makes em_dev_register_perf_domain()
> an empty function, so cppc_cpufreq_register_em() is only made of
> variable definitions. This compiler optimization also explains
> why cppc_get_cpu_power() and cppc_get_cpu_cost() trigger the
> -Wunused-function warning.
> 
> Putting cppc_cpufreq_register_em() inside an
> #ifdef CONFIG_ENERGY_MODEL
> guard seems also valid to me. To avoid too many empty definitions
> of cppc_cpufreq_register_em(), I guess it should be inside an
> #if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
> guard instead.
> Please let me know what you prefer.

In that case we shouldn't do:

cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;

as well, as that is extra work for the cpufreq core, which won't be
used at all.

So instead of __maybe_unused, lets put all dependent stuff within
CONFIG_ENERGY_MODEL ?

-- 
viresh
