Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F18582B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiG0Q1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiG0Q0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:26:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3974D4C1;
        Wed, 27 Jul 2022 09:23:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id oy13so32417241ejb.1;
        Wed, 27 Jul 2022 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++nWJk4Cva+vsdrhaueMv6rlXc4xrPaOvWuiySUp564=;
        b=N6N1V+wZjLgUfbcM4Y+kxoXzi6s6DdSLzlDU5SNNa3b/KrkQR3nNblpl10rgwsfLe8
         aOHBitqkf952yxl59Bd4AhbLjwF5U3ITnJAIodStpw0LttES8jr2VpDIBJmPrafv383d
         6belogoHYAfyk3NtAJIC+cBoBVwqwGtL76YdC8CEwNwJKvPTeqzvk7xtUK3zP8nSmrG+
         k1bqmbCxrVKpWpKoXwyyUfj7MyoqrX9liYhOPFEdj3hlto919ik/j8ExouVjbxhW0FPr
         LhXxVn9ni42GRAnc0alEF4hj3ZgmnS4URS5kY333h3LVar31rtaWYoVIECLaibFoUrY8
         jCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++nWJk4Cva+vsdrhaueMv6rlXc4xrPaOvWuiySUp564=;
        b=QfgsD7mO61gNO6+VYbRTvuJ8sP17+dB/aP6mxsWOJOUfqUd/JTImaMRrAHqVJFGgxb
         X1eKfmxgC0sLWmPgO+SXc95IatX2I6k/sicnv7PeRyhAcouRJOaocvFp+3rEFutpCIUE
         SaYvA4u0Czkmp2McODCYVLjRxcAJCm3Nju08W8r0jkZq1chkvW7hOUBDC1gIQVfouDJ2
         FwMxHnSaLiRv9LK0iz/KUR1EiwItkmgzQKCrxuLkU60IcTxASvdVYMQZLsEI5edlWhFM
         RzriBnujxzBjWQPmUhyrFgVtt+6jOsCHP6j7w/WEOoJO67rn6eBAoy+ZYW/9TZV0UaX2
         1E/w==
X-Gm-Message-State: AJIora8LOwIG8+OQynKgyXHjXkUNjJnI/cxc02LmV9a/H/rJnNqngZZc
        lkPtiaSLgca1Go01goKQ6qELGCjF/9OChpX3LGYH97WX
X-Google-Smtp-Source: AGRyM1tZ/A8JpWOGX4VcAQo8Th3v85UKE/GuWnHTam94qRdbRNe3aCZcC8GzLjx7RgWZ0kF6BIznJOAIWh8jNnDFcJs=
X-Received: by 2002:a17:907:a427:b0:72b:8cc5:5487 with SMTP id
 sg39-20020a170907a42700b0072b8cc55487mr18060749ejc.354.1658939020893; Wed, 27
 Jul 2022 09:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220725211612.7e3331ff@canb.auug.org.au> <f10da3c3-f688-b948-c058-28a448bec0d5@amd.com>
In-Reply-To: <f10da3c3-f688-b948-c058-28a448bec0d5@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 27 Jul 2022 12:23:29 -0400
Message-ID: <CADnq5_MQQJdZ9o6b9OXah+399zY6wCs8WX=g0cF4fXo=sR5kmw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 12:21 PM Rodrigo Siqueira Jordao
<Rodrigo.Siqueira@amd.com> wrote:
>
>
>
> On 2022-07-25 07:16, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crtc.c:297:26: error: 'amdgpu_dm_crtc_late_register' undeclared here (not in a function); did you mean 'amdgpu_umc_ras_late_init'?
> >    297 |         .late_register = amdgpu_dm_crtc_late_register,
> >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >        |                          amdgpu_umc_ras_late_init
> >
> > Caused by commit
> >
> >    a6c0b96cb899 ("drm/amd/display: Create a file dedicated for CRTC")
> >
> > I have applied the following hack for today (just to make it build).
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 25 Jul 2022 20:48:29 +1000
> > Subject: [PATCH] fixup for "drm/amd/display: Create a file dedicated for CRTC"
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > index 16b624828e0d..3eb6ea3709bc 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> > @@ -293,7 +293,7 @@ static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
> >       .enable_vblank = dm_enable_vblank,
> >       .disable_vblank = dm_disable_vblank,
> >       .get_vblank_timestamp = drm_crtc_vblank_helper_get_vblank_timestamp,
> > -#if defined(CONFIG_DEBUG_FS)
> > +#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
>
> I guess we had a merge issue here?
>
> If you check the original patch [1,2], you will see:
>
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +       .late_register = amdgpu_dm_crtc_late_register,
> +#endif
>
> Anyway, maybe you want to use the above code to keep both branches in sync.
>
> 1.
> https://lore.kernel.org/amd-gfx/20220715181705.1030401-10-Rodrigo.Siqueira@amd.com/
> 2.
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c#L297
>

There was a conflict with another patch in drm-misc that changed this
code.  I'ved fixed it up properly in my drm-next branch.

Alex

> Thanks
> Siqueira
>
> >       .late_register = amdgpu_dm_crtc_late_register,
> >   #endif
> >   };
>
