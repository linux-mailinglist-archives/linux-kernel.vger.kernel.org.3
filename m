Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4208447F3AB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 16:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhLYPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 10:48:47 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:26869 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhLYPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 10:48:46 -0500
X-Greylist: delayed 22857 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Dec 2021 10:48:45 EST
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 1BPFmWFT021234;
        Sun, 26 Dec 2021 00:48:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1BPFmWFT021234
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1640447312;
        bh=03xS2HVdAB9EiMZDshhI21mW5C2Pm7Qs7DxysGJI8Ns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2jhUS8DPhSxnJ+s7GGqEEC4Oz8NQBvgDD7lVFM2V8cV+9A2IJXCE5/KWVi5W7BrRI
         w1Bvw4jRB3bd0oRInQ8pVtN/Gf+QdSvKk7oFF8olfFQWRV9s+WG+3dqvA/JWmYQBgo
         QKnOp1244Ofd7fOi+51Qg/Y0VMlLkIjNcdpcvA/8h5SYcqPiliNrH1l5vLBdO8uM1i
         5Nfd4X3UUBL92Ujim2b91N04Val5rhwJC7LbpYO8xOjL2BRneQiYoYZ1+mHb++AoPv
         IwSyTcnbwuKOchkPUTlXT5usrj6Z8+qcDSlxA8oInSWzCEbiunqG7klqp1w14ns3sQ
         KLuwrSbg5ewJQ==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so14197993pjj.2;
        Sat, 25 Dec 2021 07:48:32 -0800 (PST)
X-Gm-Message-State: AOAM5310D62Kc4ufpBl6zlfv+Ija/3WrkkWzlPlue6ljaC8j2U052PdN
        9zYC2g+dpfbreV6BOhGF8/8ZQm52FlBdmB8AclA=
X-Google-Smtp-Source: ABdhPJzsd1BZ8HohGChxlc+ZpM1d343iVtn3YQJvq+RUaXn2xUQjEzz04ZLTd2Yk6URXqzpAk1oJVPMPdnHCcBrw6PA=
X-Received: by 2002:a17:902:b206:b0:149:3b5d:2b8b with SMTP id
 t6-20020a170902b20600b001493b5d2b8bmr10489460plr.162.1640447311652; Sat, 25
 Dec 2021 07:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <CAK7LNARjb4=9JOVDdfUg1sxLG4OH-Eko44iEewbr+0Wd+CNf1Q@mail.gmail.com>
 <CAMj1kXG7PFpj1Oz1osVCBW1NhCHQT+Oc=0WMLYSeRtC1QK4e8Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG7PFpj1Oz1osVCBW1NhCHQT+Oc=0WMLYSeRtC1QK4e8Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Dec 2021 00:47:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjF13vTrxMn9OTH4rmmrg6m-7aWjH6n3zV9APZwvus9w@mail.gmail.com>
Message-ID: <CAK7LNATjF13vTrxMn9OTH4rmmrg6m-7aWjH6n3zV9APZwvus9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/crypto: blake2s: include as built-in
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 7:26 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 25 Dec 2021 at 10:28, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Thu, Dec 23, 2021 at 11:11 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > In preparation for using blake2s in the RNG, we change the way that it
> > > is wired-in to the build system. Instead of kconfig mazes and ifdefs, we
> > > use weak symbols, so that an arch version can override the generic
> > > version. Then we include the generic version in lib-y, so that it can be
> > > removed from the image if the arch version doesn't fallback to it (as is
> > > the case on arm though not x86).
> >
> >
> > As I replied in another email, this does not work like that.
> >
> > Since 7273ad2b08f8ac9563579d16a3cf528857b26f49,
> > libs-y are all linked when CONFIG_MODULES=y.
> >
> >
> >
> > So, what this patch is doing are:
> >
> >  - Add __weak to the generic function
> >  - Make modules into built-in.
> >
> >
> > Both generic functions and ARM-specific ones
> > will remain in vmlinux.
> >
> > __weak makes it difficult to track which function is
> > actually used.
> > Using #ifdef CONFIG_* (as the current code does)
> > is better.
> >
> >
> >
> > >
> > > diff --git a/Makefile b/Makefile
> > > index d85f1ff79f5c..892ea632ea63 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -668,7 +668,7 @@ drivers-y   := drivers/ sound/
> > >  drivers-$(CONFIG_SAMPLES) += samples/
> > >  drivers-$(CONFIG_NET) += net/
> > >  drivers-y      += virt/
> > > -libs-y         := lib/
> > > +libs-y         := lib/ lib/crypto/
> >
> >
> > If this is merged, someone will try to
> > add random patterns.
> > libs-y         := lib/ lib/crypto/ lib/foo/bar/ lib/foo/ba/baz
> >
> >
> >
> > lib-y and libs-y are a bad idea in the first place
> > and should not be extended any more.
> >
> > Since this patch is not working as the commit description
> > claims, and it is going in the bad direction, so
> >
> > NACK
> >
>
> So we are no longer permitted to use static libraries to provide
> routines that should only be pulled into vmlinux on demand? Has this
> also changed for things like string routines etc?

Utility functions such as string routines are intended to be used
anywhere on demand, not only in vmlinux but also in loadable
modules.

Therefore, such functions are very likely to be EXPORT_SYMBOL'ed.
As a matter of fact, most of the files listed in lib-y
contain EXPORT_SYMBOL.

Historically, static libraries did not work well with EXPORT_SYMBOL.

Originally, lib-y dropped functions that had no callsite in vmlinux, but
it was a wrong behavior. We must always keep exported functions, which
might be used by modules, even if not by vmlinux.

7f2084fa55e6cb61f61b4224d4a8bafaeee55f9f
added a workaround so that all of EXPORT_SYMBOL
are considered "referenced".

Since then, most of lib-y objects were linked anyway,
given the following:

- Most of *.c files listed in lib-y contain at least one EXPORT_SYMBOL
- In static library, if any one of symbol is referenced, the entire object
  is linked

So, lib-y was not helpful for reducing the kernel image size.

The exceptional cases are CONFIG_MODULES=n
or CONFIG_TRIM_UNUSED_KSYMS=y, but neither of
them is a common use-case.

To remove unused functions,
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION (per-symbol
removal) seems to be a more sensible solution to me.



-- 
Best Regards
Masahiro Yamada
