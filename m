Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382D573D60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiGMTxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiGMTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:53:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C691086
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:53:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dn9so21698570ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/Aa2i/NI4m1X4kDhlcdt3Xuwk3YVyAJSEMRolDuwOA=;
        b=qiaNyi8gZbGRch/EC5OIQUoxCWCSrVioaObBXX79HXG2BJYmQfyYBkJp8dltsZ6qHB
         7BYRLE1rgxaG/xHfdYJEows6S6wzSvLzSyU8rzJD1WMoSq070XIxwgMpQ9rJKYJ6vG2q
         fJ201m2Z8ViUVWCmPsMieh9XzhEwQTOYUvr7D/cYC5c7g3l7WBHvs1dWlDNZM1LL87I6
         Nr9RzTTN+m3JHMGJMeVRhSHYjiWzhBrPooLBFzhckw8XTr/ZR3+hd9Fa2UdEU4y7swvi
         NI0tBE574JkpgAXpXwXtX5QjtZzYS4oZD0kiMHZ/Um5fHa8RMHfsIq8+kQ405nIQQERm
         tG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/Aa2i/NI4m1X4kDhlcdt3Xuwk3YVyAJSEMRolDuwOA=;
        b=Qj7jc5E6s3RyX8PWB9dnJKyZXYYDRLN2V1xeN+8Z6UTWfxO7R0q8SJlTtszE9Nc/tF
         A9JEuzg0fh4m+wD6fg3oxrdWY2M1cDem/opJfWUgQjzwv6QTLEKKJUvD+Dc0q3N0tCsu
         GDqNf4xWoXMGZV8D99jsriHfwIcF9vBv1/X1CBNJUShdeIQu3H+YccQGwAgeanq6Z8Kv
         9iXyRDfC7klfuMyFE201agylwpJ1oCTvgGxJITBefoqFmL6M3FTC5srXrujM2Nto5eZP
         NPy+cB+UYvvbDi00aXmcZaRDqKAE6I61oPoE8L3LRaNTfB9pijk9u1L/03yKeWE0+GDR
         xwJQ==
X-Gm-Message-State: AJIora+1S9kZdTIDDVDjG8QWin2CkxizX2n0USP1MAXpwa59QliTaRrt
        ohPFFahGo+UIXe0fBJ2UGWal3FOx/Sh2l113u7M=
X-Google-Smtp-Source: AGRyM1uBA9rYKWyS3Q9KrdsjlMnntUrL2Kqp2HZq2hLys6YhMbT1RuIVmkQvn48D4AnLbW4aesEal694MksFCwDvDQk=
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id
 hb35-20020a170907162300b0072b64e3878amr5085294ejc.185.1657742013675; Wed, 13
 Jul 2022 12:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net> <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
In-Reply-To: <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 13 Jul 2022 15:53:21 -0400
Message-ID: <CADnq5_Ma2oe-6+WG4ZRAm97G7TyS0Nuhdxt=7oqdNLcMP5nKeg@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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

On Wed, Jul 13, 2022 at 3:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jul 12, 2022 at 10:07 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Same problems as every week.
> >
> > Building powerpc:allmodconfig ... failed
>
> Ok, this has been going on since -rc1, which is much too long.
>
> From your patch submission that that was rejected:
>
> > The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
> > 64-bit outline-only KASAN support") which adds support for KASAN. This
> > commit in turn enables DRM_AMD_DC_DCN because KCOV_INSTRUMENT_ALL and
> > KCOV_ENABLE_COMPARISONS are no longer enabled. As result, new files are
> > compiled which lack the selection of hard-float.
>
> And considering that neither the ppc people nor the drm people seem
> interested in fixing this, and it doesn't revert cleanly I think the
> sane solution seems to be to just remove PPC64 support for DRM_AMD_DC
> entirely.

Does this patch fix it?
https://patchwork.freedesktop.org/patch/493799/

Alex

>
> IOW, does something like this (obviously nor a proper patch, but you
> get the idea) fix the ppc build for you?
>
>   @@ -6,7 +6,7 @@ config DRM_AMD_DC
>           bool "AMD DC - Enable new display engine"
>           default y
>           select SND_HDA_COMPONENT if SND_HDA_CORE
>   -       select DRM_AMD_DC_DCN if (X86 || PPC64) &&
> !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
>   +       select DRM_AMD_DC_DCN if X86 && !(KCOV_INSTRUMENT_ALL &&
> KCOV_ENABLE_COMPARISONS)
>           help
>             Choose this option if you want to use the new display engine
>             support for AMDGPU. This adds required support for Vega and
>
> > OF: amba_device_add() failed (-19) for /amba/smc@10100000
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at lib/refcount.c:28 of_platform_bus_create+0x33c/0x3dc
> > refcount_t: underflow; use-after-free.
>
> This too has been going on since -rc1, but it's not obvious what caused it.
>
> At a guess, looking around the amba changes, I'm assuming it's
>
>   7719a68b2fa4 ("ARM: 9192/1: amba: fix memory leak in amba_device_try_add()")
>
> Does reverting that commit make it go away?
>
>                     Linus
