Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B54F99FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiDHP6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiDHP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:58:39 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB2FDF3D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:56:35 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so6376473otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgPFew/129J9uUrYqgZcVA+g7qNHsWob0wEdFbRdpLU=;
        b=dktOw19q9ZbYejGac9aUvdm7bnjZO6AVQ9nVh7HYnAnDGbZlxD+btfMrdrWirobS88
         OfBJr4SOeGf7ASzNiaXh3mN79WPPil6Ob2DuXBqxXgJMZH48aNxvRGHb5b1SluttE4RZ
         77iMMPzO7WtymN5YLYlbS3iVXWDnNyfzvDHJStRQL33gyQLOprl6NjKepSdRDSiPXUmU
         1jJizhER3IGFh/+FrDPao35luJJyGYEL53f7TCMTuIQ+mcUA/DObmR2IOCcSYYOAE726
         GMdR+PSEAT7TZEMDfSEhb9gooThqU5UnXh0Hne6kqF3hyNtPveqNs7sQi5Jl/oqaYClP
         vWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgPFew/129J9uUrYqgZcVA+g7qNHsWob0wEdFbRdpLU=;
        b=RI75Men7g30IHLL0wqagw6AaKOox0WtFVqL2MK7mvgsh2y4LrobO5beDU9kTV+7KGi
         ON7/oAxuPGPG59rAGaO557A7sPiZOnVzYMsPB2f/ZgOok+WL/I4jx5N/XMyPTazwQ9kM
         RJEaRWgeahtpangTuHwKZFb46kdrlgUlAJA1fovMlY/d1UZ8KN0VbzMhIfvG1YvALd3v
         9XKuNH9OPxpm52tOzB2vLsVtszSzIK3BrSb0oaKWgA8p2EJRWBQ7gKaKnAJ9ljlPhfEN
         zlCO0s5Z+beYGbMPW88kgPJF86B1msT9NbTAM2UXr3rC46KDt8ni9wRgj/VgDnyMVZxV
         NgRA==
X-Gm-Message-State: AOAM531JNd3qmB7JMs9bSl4Xg+xvx60u5i5LiAkxEVlCH++jg/UWjD1Z
        xgO/VaFWn+Ct8CwCqP4q8RnNUCwrdpn0iDcwf5o/UU5OYw4=
X-Google-Smtp-Source: ABdhPJyuyaJRBQCOjtaH0m0rI1qNrPzvqTn/RpB560wfXhQSx2kwk8zS8cWzYR3Xe6H+fvl1IN49y2SVV0Rc1dw4VrQ=
X-Received: by 2002:a9d:4702:0:b0:5cd:481a:148a with SMTP id
 a2-20020a9d4702000000b005cd481a148amr7010989otf.200.1649433394746; Fri, 08
 Apr 2022 08:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220408154447.3519453-1-richard.gong@amd.com>
 <BL1PR12MB51576654D3EEB10F5DF862A7E2E99@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CADnq5_PmxGxrJG5uZkkFXQ1YbJbDZTvAqb2oYqdCE=NtqBojqw@mail.gmail.com>
In-Reply-To: <CADnq5_PmxGxrJG5uZkkFXQ1YbJbDZTvAqb2oYqdCE=NtqBojqw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Apr 2022 11:56:23 -0400
Message-ID: <CADnq5_M2HBGhVod+ECmPbtBN6FGizjGkgU-m-mtGSqGjMh8b9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable ASPM for legacy products that don't
 support ASPM
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Gong, Richard" <Richard.Gong@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 11:54 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Apr 8, 2022 at 11:47 AM Limonciello, Mario
> <Mario.Limonciello@amd.com> wrote:
> >
> > [Public]
> >
> >
> >
> > > -----Original Message-----
> > > From: Gong, Richard <Richard.Gong@amd.com>
> > > Sent: Friday, April 8, 2022 10:45
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>;
> > > airlied@linux.ie; daniel@ffwll.ch
> > > Cc: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > > kernel@vger.kernel.org; Limonciello, Mario <Mario.Limonciello@amd.com>;
> > > Gong, Richard <Richard.Gong@amd.com>
> > > Subject: [PATCH] drm/amdgpu: disable ASPM for legacy products that don't
> > > support ASPM
> > >
> > > Active State Power Management (ASPM) feature is enabled since kernel
> > > 5.14.
> > > However there are some legacy products (WX3200 and RX640 are examples)
> > > that
> > > do not support ASPM. Use them as video/display output and system would
> > > hang
> > > during suspend/resume.
> > >
> > > Add extra check to disable ASPM for old products that don't have
> > > ASPM support.
>
> The patch description is incorrect.  ASPM works just fine on these
> GPUs.  It's more of an issue with whether the underlying platform
> supports ASPM or not.  Rather than disabling a chip family, I would
> prefer to add a check for problematic platforms and disable ASPM on
> those platforms.

For example, see intel_core_rkl_chk() in smu7_hwmgr.c.  We disable
PCIe DPM on RKL platforms due to compatibility issues with that
particular platform.

Alex

>
> Alex
>
> > >
> > > Signed-off-by: Richard Gong <richard.gong@amd.com>
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1885
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index bb1c025d9001..8987107f41ee 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2012,6 +2012,10 @@ static int amdgpu_pci_probe(struct pci_dev
> > > *pdev,
> > >       if (amdgpu_aspm == -1 && !pcie_aspm_enabled(pdev))
> > >               amdgpu_aspm = 0;
> > >
> > > +     /* disable ASPM for the legacy products that don't support ASPM */
> > > +     if ((flags & AMD_ASIC_MASK) == CHIP_POLARIS12)
> > > +             amdgpu_aspm = 0;
> > > +
> >
> > I think it's problematic to disable it for the entire driver.  There might be multiple
> > AMDGPUs in the system, and others may support ASPM.
> >
> > Can it be done just as part of probe for Polaris?
> >
> > >       if (amdgpu_virtual_display ||
> > >           amdgpu_device_asic_has_dc_support(flags & AMD_ASIC_MASK))
> > >               supports_atomic = true;
> > > --
> > > 2.25.1
