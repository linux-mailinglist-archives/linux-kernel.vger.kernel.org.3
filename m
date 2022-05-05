Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928C051C85F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384287AbiEESuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383956AbiEESuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA7526C9;
        Thu,  5 May 2022 11:46:37 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id e189so5234322oia.8;
        Thu, 05 May 2022 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVyzORSKT8eaHP7gPPygWOO58G/gzdrL4ii4heJM7tI=;
        b=K+IVz58Ahcniss6cK41cHBoVkHAjyaw/E23zsZCOJH70LfVR1q8aB/5wNZQMV2eNFn
         To8MZKFtIW9oFiGl1qKZCxvuJa01Do3hTDtoL2EfnCMG3LkT1Ao3cssbEOaakeeA5KT+
         FGs55BQSeMpB1MCf/7Msf/lIrEoualk5eAcQ3q8KqVL41+oGcjQo+iHDHvvoOsed0AEu
         YynCi0q7lk6sqGQ5pLM+cGvCDP/LVD0jjNjV6tXtFVfl1daT5plE+x5ejoXEdXDX0A0Y
         FIqL2zA3YRAObmRWJ+TU4SCRy0MTuY5SfLXrpi0OXLmXP+ESO4idYAMEc5rbr+66bGt7
         HT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVyzORSKT8eaHP7gPPygWOO58G/gzdrL4ii4heJM7tI=;
        b=B3LfAzhg1QiprvvkXb12Sj9WNQOlmCskL6YwApRI6CC6UEK6CZmzMoHkIDQYbywAWK
         SUJSMBIOWzz43tNoNZkEKdmh9NoWp8KpKWUpXj6wQw2PUqAzNVIPHMV2KcQ8G/OqA/OR
         jrn4OWmiH1nJlMBJge0U4fHU6M2tMRUkTShGPVHNo2Kb7Fwv+G8WAJwExS0/zi7hWfgc
         3JhH3bPfPXvZTcr7u7OvBQu6rgW5s6X3APDA0JN5Xe/u2UfwcU9y0u8bwzR7iBXBCC8V
         4epqwzoUVOtgDbbbmGBAuN2N3fzC+vdBMR4a7T7dtuvssPqR1FZsEY6BGDtDP+IYW/LO
         Q1VA==
X-Gm-Message-State: AOAM530aLSmsSKtP77KieZDynCRSMweDF+NFzsJBmxGPSr4+rJbrs+FR
        QHhpvDPh8M9bccs5Zu4YL0EWTIU1jaXFw+4Od0g=
X-Google-Smtp-Source: ABdhPJy6twYA8xOfy/VSJ3VoU0+N6Qe4iodqV7CKTl8LVfS/WR18bs/60zISOGPFsWPBVg8Zt5Gz6NII8Yvpb+EKgSU=
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id
 o13-20020a0568080f8d00b003251e81ffe5mr3220346oiw.253.1651776396452; Thu, 05
 May 2022 11:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220505194717.065db7ab@canb.auug.org.au> <YnQToaOno0MZzJ5r@dev-arch.thelio-3990X>
In-Reply-To: <YnQToaOno0MZzJ5r@dev-arch.thelio-3990X>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 5 May 2022 14:46:25 -0400
Message-ID: <CADnq5_Ma_4zWHnqjrii97niJ3pvUnUeWDi6EyFt3z5cR=7cXzA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 2:12 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Stephen,
>
> On Thu, May 05, 2022 at 07:47:17PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
>
> <snip long error message>
>
> >
> > Caused by commit
> >
> >   028c3fb37e70 ("drm/amdgpu/mes11: initiate mes v11 support")
> >
> > This build has __BIG_ENDIAN set.
> >
> > I have applied the following patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 5 May 2022 19:14:25 +1000
> > Subject: [PATCH] mark CONFIG_DRM_AMDGPU as depending on CONFIG_CPU_LITTLE_ENDIAN
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/gpu/drm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index e88c497fa010..2aaa9ef1168d 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -244,6 +244,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
> >  config DRM_AMDGPU
> >       tristate "AMD GPU"
> >       depends on DRM && PCI && MMU
> > +     depends on CPU_LITTLE_ENDIAN
> >       select FW_LOADER
> >       select DRM_DISPLAY_DP_HELPER
> >       select DRM_DISPLAY_HDMI_HELPER
> > --
> > 2.35.1
>
> This fixup makes CONFIG_DRM_AMDGPU unselectable on any architecture that
> does not have CONFIG_CPU_LITTLE_ENDIAN, such as x86_64. I was rather
> surprised when my AMD test system did not reach the login screen and
> there were no error messages in dmesg, only to find that
> CONFIG_DRM_AMDGPU had disappeared from my build.
>
> If this is not fixed by the time you do next-20220506, would you
> consider swapping the logic like so? This should allow all implicitly
> little endian architectures to work (at least, I tested it with x86_64),
> while preventing errors for CONFIG_CPU_BIG_ENDIAN configurations.

This is fixed.  Will push out a new branch shortly.

Alex

>
> Cheers,
> Nathan
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 2aaa9ef1168d..a57843733a96 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -244,7 +244,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
>  config DRM_AMDGPU
>         tristate "AMD GPU"
>         depends on DRM && PCI && MMU
> -       depends on CPU_LITTLE_ENDIAN
> +       depends on !CPU_BIG_ENDIAN
>         select FW_LOADER
>         select DRM_DISPLAY_DP_HELPER
>         select DRM_DISPLAY_HDMI_HELPER
