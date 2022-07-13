Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A444573E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiGMVBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiGMVBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:01:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703F331349
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:01:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e15so15685526edj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbIu/poYX3pcBRKw4rWzgBK7lbECGzr212jL4ni35Ho=;
        b=AtG4IkPgTHTpMOC2ZaVbLGwklzeeYCkSobIUg+wLPqmDM/EP68Zf2UaEi3lCCa3HSF
         elEUtK4updH7BuSxzT3/RHGXRG2/7d7ChVwuh0HliLbnqLLDBeVj4Q+MITKt1hxGA6WH
         uUAOMlXj+leugjBrhlUgu0zzMeN/vO6lHDahiSxdq8MSGtyi8J3xnogdpunfORYkp7l6
         XmM+jftVjFwUOHdTYwSxxzzrRgNA77x5d99SUwyjFmf88troHfbTAo0YYSloa9rwCTVE
         fF4128kbfxA2Gd3LuXZHCEYX2O6giQlNMMCqwgiz3cUHz8ZXIJ3LN4FgS6dwyGC/zlpf
         vZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbIu/poYX3pcBRKw4rWzgBK7lbECGzr212jL4ni35Ho=;
        b=ZVQVTqx2KE5e2XVFzojOHMpdoVHPGaZoQiljf6PGIDvNY1Iu6UTXqTycSWWp3MChKi
         NJCbwjlVNzsZlhoYZAwELhffA7y9B96387ocu3KLFuz+JDdVExClh/sPm2mbTkdN5IdR
         lF6k2Hulo63ltzMbn4VfpimGW0f5jKsvJdC2c0oHGlgB0bcPuBjaP+A7n/OZNexquJ/J
         Pz2NtQfzb131f360tfIvk+FUmIO+hKlqTbeyY6ulk7dwnMUyC9H8lZBMoCqWSDAEbAUw
         ZArEim8rFMd3/HzciUHKOG/AnS2+L59zCx052uMidlMY2sdbAw2XqY0/VlpvCoilfWlc
         sLfg==
X-Gm-Message-State: AJIora+MnqyFyvOiBWe9/a7XP5g1j6hm8shuE2By3Bztt34BcWdfUCyf
        c0CB7zVFpSzFlwJ56q91Hw/WfU/ZRN3cA1IhXTo=
X-Google-Smtp-Source: AGRyM1u+KjIBAW04aIMbzYtbKQ1e5saRu8r0r/mIv48udUXeFG75Z/LC+D2+ip4Z1OCCCzpQDRSSeUjdCCLnrqqrQtg=
X-Received: by 2002:a05:6402:13:b0:439:ffe8:bec9 with SMTP id
 d19-20020a056402001300b00439ffe8bec9mr7648986edu.297.1657746069894; Wed, 13
 Jul 2022 14:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
In-Reply-To: <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 13 Jul 2022 17:00:58 -0400
Message-ID: <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, Jul 13, 2022 at 4:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/13/22 12:36, Linus Torvalds wrote:
> > On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Same problems as every week.
> >>
> >> Building powerpc:allmodconfig ... failed
> >
> > Ok, this has been going on since -rc1, which is much too long.
> >
> >>From your patch submission that that was rejected:
> >
> >> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
> >> 64-bit outline-only KASAN support") which adds support for KASAN. This
> >> commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
> >> KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
> >> compiled which lack the selection of hard-float.
> >
> > And considering that neither the ppc people nor the drm people seem
> > interested in fixing this, and it doesn't revert cleanly I think the
> > sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
> > entirely.
> >
> > IOW, does something like this (obviously nor a proper patch, but you
> > get the idea) fix the ppc build for you?
> >
> >    @@ -6,7 +6,7 @@ config DRM_AMD_DC
> >            bool "AMD DC - Enable new display engine"
> >            default y
> >            select SND_HDA_COMPONENT if SND_HDA_CORE
> >    -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
> > !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
> >    +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
> > KCOV_ENABLE_COMPARISONS)
> >            help
> >              Choose this option if you want to use the new display engine
> >              support for AMDGPU. This adds required support for Vega and
> >
>
> It does, but I can't imagine that the drm or ppc people would be happy
> about it.

If you want to apply Guenter's patch original patch:
https://patchwork.freedesktop.org/patch/490184/
That's fine with me.  It just kind of slipped off my radar.  We can
dig deeper on a better fix next cycle.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Guenter
