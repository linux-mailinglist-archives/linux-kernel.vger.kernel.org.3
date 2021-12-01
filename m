Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309254655DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352596AbhLAS4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:56:31 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:46619 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352471AbhLAS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:56:29 -0500
Received: by mail-ot1-f41.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so6322610oto.13;
        Wed, 01 Dec 2021 10:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+BZDZsgAgoGT/8BaQzMCOkNKs0q4W/LrbxamWfBJ+w=;
        b=UL38YIKaKuWb5UUExYM3ZnxNWznnBweCN6wk89S8TMSKVYB227TFtayRRqJ81dSiTr
         CCLgdouu1WNeO3yoVJnAIN+7QmPfdKQn8a94XKGMpF1cDzNi8WLE9ryfkEfdfmhZgTrB
         iQbQq35ETyChhrOlHwZh+kNq3mNwlGKzy2IBIKJu8Prfd6A1uD2MAosfcf01rU0CZZP0
         /SbUbqjf3ExDxsVKhL0oPdL8KJZmJIbx88ykahD+if3xnvwIJ/5nOz6Egq5H4MK/FKfs
         woGLjdKeDXf4UsR0t0FT5/Eu+vXSg2IaCmnd/WW9slSVsxQ5AjdzJPLETD55AeFg5vvT
         b7lg==
X-Gm-Message-State: AOAM532qovosPkTZgk9dzT90fLiIKaa0Mlq0L6AFsYUE9Idu5+zsNZ/o
        tpyVMNpXRBIwqi19dhW7q8bE9u86X7eFqbC+fGg=
X-Google-Smtp-Source: ABdhPJwjfiFXre36JnoEUclMhCl4E6JoSplcuNULllw5JNmg0Et+wJUDZeu++Gfhazz24KLzXl7JI6jBSbXNtr1NvI8=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr7271539otj.16.1638384787711;
 Wed, 01 Dec 2021 10:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
 <20211129091039.s7bqq43o4ktuub6t@vireshk-i7> <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
 <20211201072304.5j44qi6bbgdx3hhv@vireshk-i7>
In-Reply-To: <20211201072304.5j44qi6bbgdx3hhv@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Dec 2021 19:52:56 +0100
Message-ID: <CAJZ5v0jD4COsK61-R8mWxc1EWE_y9tBCADDYKKt6Xf-0FLjoDA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix get_cpu_device() failed in add_cpu_dev_symlink()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 8:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-11-21, 12:42, Rafael J. Wysocki wrote:
> > This is the real hot-add path which isn't tested on a regular basis.
>
> Ahh, I thought this is a simple offline/online thing. Makes sense now.
>
> > > Anyway the patch is okay,
> >
> > It would be good to add a Fixes: tag to it, though.  Any idea about
> > the commit this should point to?
>
> This is broken since a very long time then, we need to get this into all stable
> kernels we care about.
>
> As Xiongfeng pointed out, 2f0ba790df51 ("cpufreq: Fix creation of symbolic links
> to policy directories") looks to be a good candidate.

Applied as 5.16-rc material, thanks!
