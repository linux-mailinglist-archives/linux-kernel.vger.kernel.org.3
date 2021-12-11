Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73A4713F0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhLKNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 08:13:25 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:28312 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhLKNNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 08:13:24 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 1BBDD6ts025477
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 22:13:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1BBDD6ts025477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639228387;
        bh=uGXjkP6JbBSWuzRp21ftt5varmKFjiNrC53PYDwq2Bw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgkGnN7K85ujBLSNy8DTSRFk605z1vqdkcGX+FfKcfwiGSZIBdf6WzM6+4oVA7IZA
         vfbCpV9awCHdj7anLp+sCGDklwxQPuyLNJhRdv/nnxBCQd8jM5IrhW89U8JfSDV0Hi
         dhdBApPIzQz15CCYd8otiDCN7+Aa10NzjSxQ/V7//Nn/o5RyeIkY95stVFuOHIjZ+i
         26AqNd9x4CIl/4CQAsqTnDzeL+vlJLYpco+XhuakrBGhJyh7vxj/qOTYuDrVFqqpq6
         X4yuBWpDX5ZNr/5I3incKm9hAF7wQDTxxwK6JGwRroonO+xk4Gft8B1LtvKRKLV1TX
         SKARqX4BfkfWg==
X-Nifty-SrcIP: [209.85.216.50]
Received: by mail-pj1-f50.google.com with SMTP id gt5so8729776pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 05:13:06 -0800 (PST)
X-Gm-Message-State: AOAM533w3kgBWvPdidj028Z7ReQhmxHW/EmccTYV9EfqGJXK9JeWE64P
        la0MaO/qru8fv14PXj0SS51a6aZ7iNi2tW8IP0E=
X-Google-Smtp-Source: ABdhPJyj2s2VI5D55eBJcUlv+D1zOZ0GEudG/LGvpH9+KO2/uhmtFUqUzDZCzdK7a0f07QucSSIn18UGLUl55KXPM1U=
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr30490290pju.77.1639228386048;
 Sat, 11 Dec 2021 05:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20211013021011.515750-1-masahiroy@kernel.org> <CAEbi=3eqaH7wFKqssKUyWDz2UfJpFSh2VerAwyYp55xWpirVZg@mail.gmail.com>
In-Reply-To: <CAEbi=3eqaH7wFKqssKUyWDz2UfJpFSh2VerAwyYp55xWpirVZg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 11 Dec 2021 22:12:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZuEHPagj-Oc6tAq8ZsiiJi93=o3hzAEvEmGiXAT+R3w@mail.gmail.com>
Message-ID: <CAK7LNAQZuEHPagj-Oc6tAq8ZsiiJi93=o3hzAEvEmGiXAT+R3w@mail.gmail.com>
Subject: Re: [PATCH] nds32: remove unused BUILTIN_DTB from arch/nds32/Makefile
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Alan Kao <alankao@andestech.com>, kclin@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 2:05 AM Greentime Hu <green.hu@gmail.com> wrote:
>
> Masahiro Yamada <masahiroy@kernel.org> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
13=E6=97=A5 =E9=80=B1=E4=B8=89 10:10 =E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > This is not used or exported.
> >
> > BUILTIN_DTB is locally defined and used in arch/nds32/boot/dts/Makefile=
.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/nds32/Makefile | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
> > index c17fc3a755c3..ee26e4df2fd0 100644
> > --- a/arch/nds32/Makefile
> > +++ b/arch/nds32/Makefile
> > @@ -31,12 +31,6 @@ core-y                               +=3D arch/nds32=
/kernel/ arch/nds32/mm/
> >  core-$(CONFIG_FPU)              +=3D arch/nds32/math-emu/
> >  libs-y                         +=3D arch/nds32/lib/
> >
> > -ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
> > -BUILTIN_DTB :=3D y
> > -else
> > -BUILTIN_DTB :=3D n
> > -endif
> > -
> >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> >  KBUILD_CFLAGS   +=3D $(call cc-option, -EL)
> >  KBUILD_AFLAGS   +=3D $(call cc-option, -EL)
>
> loop in KC and Alan.

Applied to linux-kbuild because this is needed for my next work.

(nds32 seems to be unmaintained)


--=20
Best Regards
Masahiro Yamada
