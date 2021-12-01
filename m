Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D074647D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347205AbhLAHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347164AbhLAHXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:23:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0079AC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:19:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so20323712pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1B2ct62NazJMbAXHxh400qw9MwmW02j5UQGS1Hs0m4A=;
        b=IUHgkIdQuK7nrhV0XqmC6Bd5ppQxTxTnAKDeS6OLAzQL/Qj051LcjQTCG+IDhECMN6
         XLLxuPXcgSZAXKGj27RGc1kv4BCs4wYWTnXQflmhx5KTIWEbcex0Sbnl20dcwM+eeL/C
         4HDpSRRBbth0WgC9B9ghevbNo3i78wMvHgyCeCfCO6TDAZ8hA0iHtN3WnzvDVW15xFFG
         YRqFHThy7xvKPosDowpOnD7fy1Po9AjhzD33ns0p1lZAkkBE7mpveDoSbpDIpDTBmSow
         qflwWY6n7dzMB66DXkezF0Wty5Ad57/+yUtnbWt1aeUQ5FNkbhwUebmxUZiW1XJYBwSx
         3i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1B2ct62NazJMbAXHxh400qw9MwmW02j5UQGS1Hs0m4A=;
        b=5r7AqPLtGnNvm1SpX2R2OzZ0fZfbLkCWG1OhxOgK3FFMxEiCwvLvtxupFuyaPFjW/o
         +m2K42LsPwUJze1iMjiActFkXfzLX5Uk8jyGmhTJO7fiQdcTqqSvP3pRsSH5OswaOzaI
         rBn7yXpZ37dDbAGPRVjobYhOXltae4XtwyTF2fva+juJhOurjh2rxFl4Ym735JCS4Toc
         lBaBZU3SUMwovcKIVsSy/ChW4prI0TfgJug1nGVfsUQDC4I4oN5TyKsabP2fxfe9rmmd
         OE/G8RYSpqavn5DnLMR6vc9wMkcQECUu+hZEcXP9T5ixzrqO+tuisWn0MgliCdK6YSMg
         GKVQ==
X-Gm-Message-State: AOAM531MALWs5FCRBrfMZXNuNUUmyQR6OKGff9NOVUZDHGUuDyRQH/4p
        ZiteLG15gt6+4VjMc40SEj8v9Q==
X-Google-Smtp-Source: ABdhPJxKihGgZWgRgZzW1cJ5ymXPwndt5ax5EBlxemirEF7kLkKXcFjKs8aor0ysefg64QKD8Kaxgw==
X-Received: by 2002:a17:902:aa89:b0:144:ea8e:1bd7 with SMTP id d9-20020a170902aa8900b00144ea8e1bd7mr5388942plr.65.1638343179555;
        Tue, 30 Nov 2021 23:19:39 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id s21sm23322991pfk.3.2021.11.30.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 23:19:39 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:49:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     rafael.j.wysocki@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengbin13@huawei.com
Subject: Re: [PATCH v3 1/2] cpufreq: Fix a comment in cpufreq_policy_free
Message-ID: <20211201071937.e6uso2qwzgtbfest@vireshk-i7>
References: <20211201074021.18097-1-tangyizhou@huawei.com>
 <20211201074021.18097-2-tangyizhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201074021.18097-2-tangyizhou@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 15:40, Tang Yizhou wrote:
> Make the comment of blocking_notifier_call_chain() easier to
> understand.
> 
> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e338d2f010fe..db0b4b4258d5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1296,8 +1296,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  
>  	if (policy->max_freq_req) {
>  		/*
> -		 * CPUFREQ_CREATE_POLICY notification is sent only after
> -		 * successfully adding max_freq_req request.
> +		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
> +		 * notification, since CPUFREQ_CREATE_POLICY notification was
> +		 * sent after adding max_freq_req earlier.
>  		 */
>  		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>  					     CPUFREQ_REMOVE_POLICY, policy);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
