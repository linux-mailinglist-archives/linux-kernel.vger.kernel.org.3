Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F4F5A380F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 16:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiH0OIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0OIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 10:08:19 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34634C63D;
        Sat, 27 Aug 2022 07:08:17 -0700 (PDT)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27RE7wOu030481;
        Sat, 27 Aug 2022 23:07:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27RE7wOu030481
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661609279;
        bh=rDdXeC6ksXnnkis/qhKihUlu0s9cxqurOTuBcsF8uWk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kB/lLvLKiWp6aor1SzHSpNb3CXqldiPR5pXqvPcZTIuEgLQ5e/l2a+/i/v3Fb3WVx
         QrjbRYkJaI3kUefcql6YXxSSZJ6kYOa515r6CPjbuieLMehk343C8VtGMy1G7qKSKA
         lqH3DjdeX079Zz8Z+sraaDS+SjbjyxfO1r/SHEADAJtozGviDm0PuVznrh7xdo7+ro
         m3+d28cSwRBLoSd7V0QDEf6wvxoy+kmK6gc9xaGnbPS3LuOWCbX7ZEAwtRouYS8ins
         wVwecgBppwQsw/V/nGEkZXr+U8qGj5xioqM00LdV35avgRDM/BLf1j7UV/UplO0Zrd
         Yco6WNrRtHt8w==
X-Nifty-SrcIP: [209.85.160.46]
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11c5ee9bf43so5510199fac.5;
        Sat, 27 Aug 2022 07:07:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo1eERXUbkOz/jyhlfZo7UV73JqSDofjV6tVkFHsK4IK9/nOecxj
        +Yi9yVMSNWxMWAKB7A+CRi+9EcHEKElWd0A6RcE=
X-Google-Smtp-Source: AA6agR5fJD/Xapf90KSFwv8M9XMZ8ikXGsv8r4iY/lMSPUKVUay0NL70sR1gmsF1lexfUYKLBj8R7YAhDoCeUvAY1Xg=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr3979227oab.194.1661609277673; Sat, 27
 Aug 2022 07:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220825091517.30842-1-lukas.bulwahn@gmail.com> <CAKwvOdkY=ye4PKi8KwP-ux73pwZs+J_Oq3wR7ep8S81=aCWtqA@mail.gmail.com>
In-Reply-To: <CAKwvOdkY=ye4PKi8KwP-ux73pwZs+J_Oq3wR7ep8S81=aCWtqA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 27 Aug 2022 23:07:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT918p5v0Ak8p3a3yQKk7tYUphv=h8p9xkXa411iY_EjA@mail.gmail.com>
Message-ID: <CAK7LNAT918p5v0Ak8p3a3yQKk7tYUphv=h8p9xkXa411iY_EjA@mail.gmail.com>
Subject: Re: [PATCH] scripts: remove obsolete gcc-ld script
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 2:20 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Jiri in case this needs to be carried downstream.
>
> On Thu, Aug 25, 2022 at 2:15 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Since commit 8564ed2b3888 ("Kbuild, lto: Add a gcc-ld script to let run gcc
> > as ld") in 2014, there was not specific work on this the gcc-ld script
> > other than treewide clean-ups.
> >
> > There are no users within the kernel tree, and probably no out-of-tree
> > users either, and there is no dedicated maintainer in MAINTAINERS.
> >
> > Delete this obsolete gcc-ld script.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> No callers in-tree; happy to bring it back though should there later
> be. Thanks for the patch.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> > If there are no objections, I would like to get this patch included
> > through the kbuild tree.
> >
> > Masahiro-san, please pick this patch.
> >
> >  scripts/gcc-ld | 30 ------------------------------
> >  1 file changed, 30 deletions(-)
> >  delete mode 100755 scripts/gcc-ld
> >
> > diff --git a/scripts/gcc-ld b/scripts/gcc-ld
> > deleted file mode 100755
> > index 997b818c3962..000000000000
> > --- a/scripts/gcc-ld
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -#!/bin/sh
> > -# SPDX-License-Identifier: GPL-2.0
> > -# run gcc with ld options
> > -# used as a wrapper to execute link time optimizations
> > -# yes virginia, this is not pretty
> > -
> > -ARGS="-nostdlib"
> > -
> > -while [ "$1" != "" ] ; do
> > -       case "$1" in
> > -       -save-temps|-m32|-m64) N="$1" ;;
> > -       -r) N="$1" ;;
> > -       -[Wg]*) N="$1" ;;
> > -       -[olv]|-[Ofd]*|-nostdlib) N="$1" ;;
> > -       --end-group|--start-group)
> > -                N="-Wl,$1" ;;
> > -       -[RTFGhIezcbyYu]*|\
> > ---script|--defsym|-init|-Map|--oformat|-rpath|\
> > --rpath-link|--sort-section|--section-start|-Tbss|-Tdata|-Ttext|\
> > ---version-script|--dynamic-list|--version-exports-symbol|--wrap|-m)
> > -               A="$1" ; shift ; N="-Wl,$A,$1" ;;
> > -       -[m]*) N="$1" ;;
> > -       -*) N="-Wl,$1" ;;
> > -       *)  N="$1" ;;
> > -       esac
> > -       ARGS="$ARGS $N"
> > -       shift
> > -done
> > -
> > -exec $CC $ARGS
> > --
> > 2.17.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers




Applied to linux-kbuild.
Thanks.


-- 
Best Regards
Masahiro Yamada
