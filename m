Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EF6473636
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbhLMUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239389AbhLMUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:42:14 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED38DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:42:13 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id m6so24794597oim.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0lgHFxH4NOvcyQo5yJWjY3w7PbD1WWXM/YVPa8itvI=;
        b=hU2DJJQ8muOc8zcpqpBRVpXnn9pX7veM6RJmq6sTZk3OkIUkaCMN4tz9FkyjvNJY5d
         1TFPF8+NZIY8Z4fqijcBpoBPUkhUQZqCwz6bTDyMfRicZY64bN6cdWpX6qE+M10kNaOS
         zfR8ymbPwhPQL67MPAImKFbyoHVy3Ig1Ut+H7J/cYJO+FOXmXA86OQrpfruPAIrmt93D
         4SiioiPz8k3Qx8AtQsavZAtV+EBZHUeZWxwDnQ8KHX0w94NilEb0skLdXc4gmwOVEYTV
         MOc9P+qtjzKdZ/SAKSgV8rmzsFLX3NiXliPBjNsvrwpFEUj+D5yjyyoq2pflLQz3aluq
         6oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0lgHFxH4NOvcyQo5yJWjY3w7PbD1WWXM/YVPa8itvI=;
        b=N+rdPag6nHKtG9IDKUCV6meCla3ya5Fp7J91vuHHWWD7qtkW9RV36DvhCrpZz18j3e
         Z3k1DcFV9zZ9P7lIhtc6L1q2xa6kq2MPxsMNASR04Hh1db1FVbajenyvrlWwkQi+8p5D
         v4TjLz/w0S5TUxhuJ+9NA0ZLpNc56R4gTO068HIuTmpOCqbxoB4zxozHGQkshW/iUGhg
         1h6C5wn4BnggbcCyAaccLSdLTYp4TzjgPkQ/oWkBgdHnSmRbPFUfOH+thmgAHAwNGi9c
         Pt7lQ7LY7AeBCGP8WvfKDRM4ufmAlPqVh3rwIdDzoKCEyK1+/t4uaW8r+0/J0Udv2r6O
         Aq0A==
X-Gm-Message-State: AOAM5339bnJwEY0QAKNt0yv7hT6ty8Kjky+b5KGFKTJp7hSJFR/rXoSR
        i3cyAyWg7dVj7ngdv6oALKqaiGMZZb4g+Ds6ReE=
X-Google-Smtp-Source: ABdhPJzZ2ZJAiOrS7pArtgR2E9oKMmLyx7zGubLBF4xGRfAZAMwS15L9gA7Fwyg5UniIYDY9at3fYU8/wzYqStG2A2s=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr28482046oig.5.1639428133344;
 Mon, 13 Dec 2021 12:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20211209015823.409947-1-chi.minghao@zte.com.cn>
In-Reply-To: <20211209015823.409947-1-chi.minghao@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Dec 2021 15:42:02 -0500
Message-ID: <CADnq5_MEf3o6GVEkD5gQYgp4CMwogm=mVZFLquUEbRfjp3wh6Q@mail.gmail.com>
Subject: Re: [PATCH] drm:amdgpu:remove unneeded variable
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
        Zeal Robot <zealci@zte.com.cm>, Oak Zeng <Oak.Zeng@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        chi.minghao@zte.com.cn, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Likun Gao <Likun.Gao@amd.com>,
        John Clements <john.clements@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Dec 9, 2021 at 11:56 AM <cgel.zte@gmail.com> wrote:
>
> From: chiminghao <chi.minghao@zte.com.cn>
>
> return value form directly instead of
> taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cm>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 5 +----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 6 ++----
>  2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> index 5cf142e849bb..fb92f827eeb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> @@ -37,12 +37,9 @@
>  long amdgpu_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>         unsigned int nr = DRM_IOCTL_NR(cmd);
> -       int ret;
>
>         if (nr < DRM_COMMAND_BASE)
>                 return drm_compat_ioctl(filp, cmd, arg);
>
> -       ret = amdgpu_drm_ioctl(filp, cmd, arg);
> -
> -       return ret;
> +       return amdgpu_drm_ioctl(filp, cmd, arg);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..269a7b04b7e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1742,7 +1742,7 @@ static int gmc_v9_0_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         bool value;
> -       int r, i;
> +       int i;
>
>         /* The sequence of these two function calls matters.*/
>         gmc_v9_0_init_golden_registers(adev);
> @@ -1777,9 +1777,7 @@ static int gmc_v9_0_hw_init(void *handle)
>         if (adev->umc.funcs && adev->umc.funcs->init_registers)
>                 adev->umc.funcs->init_registers(adev);
>
> -       r = gmc_v9_0_gart_enable(adev);
> -
> -       return r;
> +       return gmc_v9_0_gart_enable(adev);
>  }
>
>  /**
> --
> 2.25.1
>
