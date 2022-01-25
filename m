Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339BC49B3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444929AbiAYMRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346245AbiAYMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:12:33 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB1AC061762
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:12:31 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id m6so61019293ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZRe44cSDLUnR3rrUKljaQ4wjqngbVG3XfPyQtdqwGc=;
        b=FJTICMIuNIJV9FDFXdSuOzkZ+2CoUGA8deDdbNHBF5B2pCgMrnfG2maOGU3qZ56U0b
         4DaQKZPkiiSOGFHm4CBR3ytn2Y2N/iPL/WMfkrHoryVT0KMEpFkNptuz87MdZ5OOswB3
         GIzKp+WbFFGpkAgvw929gx/pESiJ3bxdIC3XG79XGA6UkO7ca0TXduVD5uGjwldiXqOW
         GDeP7aDCdq4eMcPbvh6RWe05mqG+Cwu/bi43w0elRCWYV/ox4HghwCn3ddIK12twxxbW
         onwpgL7YBtyxTDIw8FTM+tguy4VxtY6d/ZlieDLw1YsHr93zxAVvPhhHRaTRyzM++CeR
         5bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZRe44cSDLUnR3rrUKljaQ4wjqngbVG3XfPyQtdqwGc=;
        b=u2QZbRRMzS+WIkeqwQdM5v84XfzLSBNTV71MwOFArOx8UL6/XcZ2Q17gE11jfsKKij
         VLDzwfFMEZIx67wO+0emG9/pxYr9PsbH5YGEFmDesn2Q/I1karU5BWE5QN/69TommbW2
         ZBTmmi+AzcS19CjyYOeXa5p8BVj88xhJDy6NPm0S4HD/imL51oPdH5qVFzVTJOwLfSJv
         8qk7Ny64aHKFO0wViDS5xw7Cjuef2GpaHfO7wqM+vsBx1Vs/tfgbUIAqN01hOmLRXg60
         r9GQrOD0doAZ+fykIQrt1UO2HK6inIQx23aqAjzAy4GSuYfHupE7CDAbtFgthxooauQD
         tNQA==
X-Gm-Message-State: AOAM532Yd8gm0ABavcmleunQyZvQmKJ/+t+Wr0onyDVmJqqpuSgno+58
        RRJcOJfxSa+jFFrRcwMzC9ySv0uX+bpbV+7uG1kEuA==
X-Google-Smtp-Source: ABdhPJwTxaJHvVMo77snJVzlI//AOnGblDhhxemPpL6/uW3sPDc6KY3631DUGFvKmWWVBfqMHz73t7qghqsuY+HCeVQ=
X-Received: by 2002:a25:8e89:: with SMTP id q9mr32229518ybl.520.1643112750404;
 Tue, 25 Jan 2022 04:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20220124183937.101330125@linuxfoundation.org> <CA+G9fYshfJ-WCB141=ha8uf0-FhE9Pim6hd5BWAVxDpvHhTR0w@mail.gmail.com>
In-Reply-To: <CA+G9fYshfJ-WCB141=ha8uf0-FhE9Pim6hd5BWAVxDpvHhTR0w@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jan 2022 17:42:18 +0530
Message-ID: <CA+G9fYvPfpq+ptuzEW7S4S3o_vGxVGus4n0xAFxLoMzaH+Jnxw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/186] 4.14.263-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 16:58, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 25 Jan 2022 at 00:34, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.14.263 release.
> > There are 186 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 26 Jan 2022 18:39:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.263-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Following patch caused build failures on arm imx_v6_v7_defconfig
>
> > Lucas Stach <l.stach@pengutronix.de>
> >     drm/etnaviv: limit submit sizes

The following patch might be missing,

commit 05916bed11b6d4c61b473a76220151a7d0547164
Christian Gmeiner <christian.gmeiner@gmail.com>
 drm/etnaviv: add uapi for perfmon feature



>
>  build/clang-nightly-imx_v6_v7_defconfig
>  build/gcc-11-imx_v6_v7_defconfig
>  build/gcc-10-imx_v6_v7_defconfig
>  build/clang-11-imx_v6_v7_defconfig
>  build/clang-12-imx_v6_v7_defconfig
>  build/clang-13-imx_v6_v7_defconfig
>
> Error:
> -------
> make --silent --keep-going --jobs=8 ARCH=arm
> CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
> arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
>
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c: In function
> 'etnaviv_ioctl_gem_submit':
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:345:37: error: 'struct
> drm_etnaviv_gem_submit' has no member named 'nr_pmrs'; did you mean
> 'nr_bos'?
>       args->nr_bos > SZ_64K || args->nr_pmrs > 128) {
>                                      ^~~~~~~
>                                      nr_bos
> make[5]: *** [scripts/Makefile.build:329:
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.o] Error 1
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
>  --
> Linaro LKFT
> https://lkft.linaro.org
