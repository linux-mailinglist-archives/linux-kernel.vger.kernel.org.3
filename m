Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8C486879
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241820AbiAFR3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:29:38 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:35527 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiAFR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:29:36 -0500
Received: by mail-qt1-f173.google.com with SMTP id c10so1256960qte.2;
        Thu, 06 Jan 2022 09:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZvOVyvHa+NSE4rPQu9G15aq3roh0PFjTN6noXXuPx0=;
        b=2wzMuK4UfF5jlFvxFh/U9Qtfy8GMQd3sSrDowM5otwkqNGAip9NaZ8Mqk480osoGic
         5AhmDBRjuz9FmWjHRfZ1OrTWMozmGBFGHPLLDwPTn4qtUBYUXi/Lwak/IH4XWBfHDJTe
         vjRRkO77PmjPlFR+mcPhdRFye6c326qQSCu3tDsHYTxvH/PMsuvrmBm2fzdBm+3yt5Vh
         LeZQlK3E+AuhFNUoi17EC8AedeVRXjm7Qw/JoiyYTTUSlMORioB73d1JnYLJBxoH09pt
         fUfjstMNIfk1rxcN18nPZPu+m3ivNavnCGkscOGFSogq6s3ZiXTZtIJkgfnMkLDj0DLR
         p7bQ==
X-Gm-Message-State: AOAM531Hlf8P8QHA99P0azCgmvSiPjp06YdcxcLBgR2vAtpbBnGHMlcV
        vTCerHmxbG3zHisIEPPRtr3Smue26FOO4wCv1WJWgtK0
X-Google-Smtp-Source: ABdhPJymUr7GPHJZodzyR7v7RfmRC8PjBzeTOopN/4j7fx3SK+CbzJnjUNhcG4AdREO3l2e4gg5Ui0cJEHZxh1gq4HY=
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr52183191qta.305.1641490165166;
 Thu, 06 Jan 2022 09:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20220106021605.93341-1-yang.lee@linux.alibaba.com> <YdaJ9GFoz4AlIgQv@amd.com>
In-Reply-To: <YdaJ9GFoz4AlIgQv@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Jan 2022 18:29:14 +0100
Message-ID: <CAJZ5v0gew-=d=oep-MzUnP_b74FcZ4e94Lg=mXQzeVX8zDCV+w@mail.gmail.com>
Subject: Re: [PATCH -next] cpufreq: amd-pstate: Fix struct amd_cpudata
 kernel-doc comment
To:     Huang Rui <ray.huang@amd.com>, Yang Li <yang.lee@linux.alibaba.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 7:20 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Thu, Jan 06, 2022 at 10:16:05AM +0800, Yang Li wrote:
> > Add the description of @req and @boost_supported in struct amd_cpudata
> > kernel-doc comment to remove warnings found by running scripts/kernel-doc,
> > which is caused by using 'make W=1'.
> >
> > drivers/cpufreq/amd-pstate.c:104: warning: Function parameter or member
> > 'req' not described in 'amd_cpudata'
> > drivers/cpufreq/amd-pstate.c:104: warning: Function parameter or member
> > 'boost_supported' not described in 'amd_cpudata'
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>
> Acked-by: Huang Rui <ray.huang@amd.com>

Applied, thanks!
