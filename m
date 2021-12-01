Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE57A464765
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhLAGvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbhLAGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:51:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8B8C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 22:48:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so549975pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 22:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=04FoBAqU3rykJdDXK2QYj+TKaga8jHHwzh19PUhIDZo=;
        b=EfkqHnLlh2HHvz1rIBB7mjriPxzwYNM05JsHHHqKz/0YA48LHr8RB/KYGtg3a09ypR
         rT0cKagzzdarcXiatPQbUwLclaFQuGvaFDZAB8C6tG3uCrIpni34GgYL49UtJOhB+kIL
         eFgKGZ0nZeG6l8MuReqAGT8JPRxGbkZXjPP0W/1m5Glxcl0KIsIACCQSWFEJgEmodK1C
         V2sNkY/2GA+3he73p17gscknGc3Ym7CSrO3UVqpoAECAurZNkoT3KLiaaUr3mj1R9nFP
         GCDJ3Mc26qqt1P4iVu3zfyu32C3MWkll7K6w0b8Cazq0jZOEumypaE7HT7mnXfqABQ/c
         ipzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=04FoBAqU3rykJdDXK2QYj+TKaga8jHHwzh19PUhIDZo=;
        b=5YVMZhmPNIz74S63il5JtCJzSFb1O/iqPRCZqx+far610dloUYPGY9OG80zo9sWgUw
         jBMdywbJrf5PBaw+3S9/UaD7z748bJ72KsOpefWeVN8XiOKnOFMdlHuoKVg91aF9vHR+
         8q9HiKR7LnQA8Ui8t+3+btXNWwOLnLkDMjRCn55UDn5VIcOFhAUuXwDTEjq1GB65Bt8O
         ZHrJleFrTfjWpwkZfl/b6ylS1n2jiWAOzGV4+2QY/UoP7PFo9kDWTrTJ4yxg2sTtNhdQ
         Tgk7pgiZhCoOZWK7yYKulyDHs9USRpdkOTP2GT2x0rSFm5j8W8/Mz5/RlFc9aAYK4F9p
         ak1A==
X-Gm-Message-State: AOAM5321UGjBG0TyFHMg7RfXZ2SyIPUd2hQrG26zvdmisnd7fWNd3YCb
        V+AoMEbbXEAt9xRv/2jfskb1pQ==
X-Google-Smtp-Source: ABdhPJyp3Ts+VctkMrUe2l6YVh6ilpldTirBr8fpz56S1Ge70kuQeVJj2qPGUQuF6ZtdaW5l6dJUww==
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr5035994pjb.93.1638341281916;
        Tue, 30 Nov 2021 22:48:01 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id k8sm23232960pfu.75.2021.11.30.22.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:48:01 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:17:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Tang Yizhou <tangyizhou@huawei.com>
Cc:     rafael.j.wysocki@intel.com, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: Fix a comment in cpufreq_policy_free
Message-ID: <20211201064759.2ak656yyr7wgxtj7@vireshk-i7>
References: <20211130151526.949-1-tangyizhou@huawei.com>
 <20211130151526.949-2-tangyizhou@huawei.com>
 <20211201042245.amxgyevar6gjbkfb@vireshk-i7>
 <5a895a87-4eee-3dfd-5b86-af436929a068@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a895a87-4eee-3dfd-5b86-af436929a068@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-12-21, 14:39, Tang Yizhou wrote:
> On 2021/12/1 12:22, Viresh Kumar wrote:
> > On 30-11-21, 23:15, Tang Yizhou wrote:
> >> The comment is inconsistent with the block_notifier_call_chain() call,
> >> so fix it.
> >>
> >> Signed-off-by: Tang Yizhou <tangyizhou@huawei.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index e338d2f010fe..8f753675e4a2 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1296,7 +1296,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >>  
> >>  	if (policy->max_freq_req) {
> >>  		/*
> >> -		 * CPUFREQ_CREATE_POLICY notification is sent only after
> >> +		 * CPUFREQ_REMOVE_POLICY notification is sent only after
> > 
> > No, the earlier comment is correct. It says when the CREATE notification was
> > sent and so we need to do the remove here before removing max_freq_req.
> 
> I see. I was confused at the first time. Perhaps it is better to both comment when
> CPUFREQ_CREATE_POLICY and CPUFREQ_REMOVE_POLICY notification is sent.

I am fine with elaborating the comment, sure. Please send another patch for
that.

-- 
viresh
