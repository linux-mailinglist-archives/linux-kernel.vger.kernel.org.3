Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3716D47F6EB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbhLZNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:07:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C04CC06173E;
        Sun, 26 Dec 2021 05:07:09 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id m21so52686835edc.0;
        Sun, 26 Dec 2021 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2+ZyCKMgaCn+yHM6iaIMiaErSxz8x8VEPA7/E0hwSA=;
        b=l2yDrf+QDS8RAWsZgi9vW77rfw+j+Rdb9oMINXHtP6SqPqkVii8HAI2Ih4tFLZdmTK
         6zz96U+qc9gKteY8tlKffzB/EuF07UbiQS9DleCs3TGoSeVdsHgmRrA1PjjVJtHkhVp4
         L72e9nigt/e1MBR7oIjEIaSENoOV+TEiVwCcNOGxrGXCIWebAu4+cmOJK9b8J9GiDPU5
         Xz+mIBaqi9mz7TvVbd7viX5hmTttoLWCCj3xvYzIJ3BHfbYRZpgJdcWEv0EzWULNevSV
         oXyFa/fX7sbi/4B0g1tqB7H9E7lMIhWfdE0fbkaTJy6bauH18GMFUbuGgG8wOInTBwAT
         PVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2+ZyCKMgaCn+yHM6iaIMiaErSxz8x8VEPA7/E0hwSA=;
        b=iWOHwXztvj4aOzOU2dTBMzQO4Ursqyycdn6pVzG75LiWysuyz5VTo+ZmoL7ZGIlFog
         eLhEgkeWE3buVGCylEnL0W3hGp1P5Am/aWqchLMl7oOANDgBFXGUj5YEWLCnHLc3znFc
         qu9OULf9Dth0PUVTUKgk1/J4JW6DGaOSN2yO9G7aN+SXj6jyzfHjh185Uwuch18Qh93N
         oUG/MNFxrH9prO+GOkMCXeLZhnD4CckxeqCbVWTcrrN0nxx86yXM7nq6JXyLkyVS33nk
         9TwXkSnSVl+ZF10Fg/GANewG1e7rjLJdVOJSQZaVj9mLhCbPAZfhI184OhP3kiiU07rp
         BlBw==
X-Gm-Message-State: AOAM530RjN6In5QD+JvPBE7f4PzSMTIKP4FopBXGSRKmPvaArewI0Rln
        5FShRp/4m9D6ARQNQi2xG8PUZIyLh6duvrlaof0=
X-Google-Smtp-Source: ABdhPJzUou2795TF47OxmF5US3Gh4JD147IGIAJSe1uBVIvJQ0UC3+hhhkzQQqz6jlb3Zk+gNB9FWmbxuZro6bk+Vj0=
X-Received: by 2002:a17:906:7953:: with SMTP id l19mr11214698ejo.71.1640524027713;
 Sun, 26 Dec 2021 05:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20201121030156.22857-1-s-anna@ti.com>
In-Reply-To: <20201121030156.22857-1-s-anna@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Sun, 26 Dec 2021 14:06:56 +0100
Message-ID: <CAH9NwWfFMv0TrHLbAhL6Ykn78jNZDs8e=c30U-QC0mG3jcY5mw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] remoteproc sysfs fixes/improvements
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Am Sa., 21. Nov. 2020 um 04:05 Uhr schrieb Suman Anna <s-anna@ti.com>:
>
> Hi All,
>
> This is a refresh of the unaccepted patches from an old series [1].
> Patches 2 and 3 from that series were merged and these are rebased and
> revised versions of the same patches. I had forgotten about these patches,
> and am resurrecting these again. Patches are on top of latest 5.10-rc4.
>
> The features being introduced here will be needed by the recently posted PRU
> remoteproc driver [2] in addition to the existing Wkup M3 remoteproc driver.
> Both of these drivers follow a client-driven boot methodology, with the latter
> strictly booted by another driver in kernel. The PRU remoteproc driver will be
> supporting both in-kernel clients as well as control from userspace orthogonally.
> The logic though is applicable and useful to any remoteproc driver not using
> 'auto-boot' and using an external driver/application to boot the remoteproc.
>
> regards
> Suman
>
> [1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20180915003725.17549-1-s-anna@ti.com/
> [2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201119140850.12268-1-grzegorz.jaszczyk@linaro.org/
>
> Suman Anna (3):
>   remoteproc: Fix unbalanced boot with sysfs for no auto-boot rprocs
>   remoteproc: Introduce deny_sysfs_ops flag
>   remoteproc: wkup_m3: Set deny_sysfs_ops flag
>
>  drivers/remoteproc/remoteproc_sysfs.c | 28 ++++++++++++++++++++++++++-
>  drivers/remoteproc/wkup_m3_rproc.c    |  1 +
>  include/linux/remoteproc.h            |  2 ++
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> --
> 2.28.0
>

Is there any update on this patch series?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
