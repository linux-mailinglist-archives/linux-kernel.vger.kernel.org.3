Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E49549BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiFMSkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343893AbiFMSkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:40:04 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA40D35DFC;
        Mon, 13 Jun 2022 08:29:29 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25DFTBPr014866;
        Tue, 14 Jun 2022 00:29:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25DFTBPr014866
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1655134152;
        bh=U8e6xBBpGNq52HU5UCv+aLe6rXlJafZA9BHju3EnG0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S099LBHFLevAqisrzBFoHtirHccwg1PjI1CDo6+ebI9+hqvyVkQdpDEim/VpdRi2z
         /bpPNrKWLL5+W8C1eavYKq9eDQdCdFr2vwdV5bEFtJHCARyz9WyO326GUe2fNCeeaE
         we88Hp79ThHEvpIl4yarZqY/swmq5SWtP53KlL6i7PuwLz08jx81k/deX/SXYPUILb
         i1Enx3VcaCc4teHtGpMyo8P48fInZnEMs0X1ZUn5PGRgMEQw5bQr/Il/SXSkP8QV+o
         5mDsmIZMcKbObVVT3rm1KY0xGuCovMfTDBAL98hXVXEeHv03HVhutOrJZihrUzBF8C
         WdXIe07T+A5Qw==
X-Nifty-SrcIP: [209.85.128.53]
Received: by mail-wm1-f53.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so2416891wml.2;
        Mon, 13 Jun 2022 08:29:12 -0700 (PDT)
X-Gm-Message-State: AOAM533AF09pieQk0lgAlDSNH6GjYyiiXwQYsL9kZqCDlLsbXPnL/fns
        mU1HNDqCKY0qGUhc6nLRoI0l2Lf6tqLSXzNxK2I=
X-Google-Smtp-Source: ABdhPJwR2BO70ewcMkpasiG+oq3cRiDpOY3zt44AL5wd2UEyJV0VTm5/CIVcKEFhTBdJDJCNhGeMLpZK8RPebsKjGaE=
X-Received: by 2002:a7b:c346:0:b0:397:626d:d2c4 with SMTP id
 l6-20020a7bc346000000b00397626dd2c4mr15731645wmj.172.1655134150862; Mon, 13
 Jun 2022 08:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220611172233.1494073-1-masahiroy@kernel.org>
 <20220611172233.1494073-3-masahiroy@kernel.org> <e7850717-dad6-daef-c96c-2a74248e98f6@digikod.net>
In-Reply-To: <e7850717-dad6-daef-c96c-2a74248e98f6@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Jun 2022 00:28:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASR6Hwj-Q+z6GCGTOz0gXv5XXTV8phqe7duGm+uuo3eDQ@mail.gmail.com>
Message-ID: <CAK7LNASR6Hwj-Q+z6GCGTOz0gXv5XXTV8phqe7duGm+uuo3eDQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] certs: move scripts/check-blacklist-hashes.awk to certs/
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 9:36 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
>
> On 11/06/2022 19:22, Masahiro Yamada wrote:
> > This script is only used in certs/Makefile, so certs/ is a better
> > home for it.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >   MAINTAINERS                                   | 1 -
> >   certs/Makefile                                | 2 +-
> >   {scripts =3D> certs}/check-blacklist-hashes.awk | 0
> >   3 files changed, 1 insertion(+), 2 deletions(-)
> >   rename {scripts =3D> certs}/check-blacklist-hashes.awk (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1fc9ead83d2a..7c2a7c304824 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4627,7 +4627,6 @@ L:      keyrings@vger.kernel.org
> >   S:  Maintained
> >   F:  Documentation/admin-guide/module-signing.rst
> >   F:  certs/
> > -F:   scripts/check-blacklist-hashes.awk >   F:       scripts/sign-file=
.c
> >   F:  tools/certs/
> >
> > diff --git a/certs/Makefile b/certs/Makefile
> > index a8d628fd5f7b..df7aaeafd19c 100644
> > --- a/certs/Makefile
> > +++ b/certs/Makefile
> > @@ -13,7 +13,7 @@ CFLAGS_blacklist_hashes.o :=3D -I $(obj)
> >
> >   quiet_cmd_check_and_copy_blacklist_hash_list =3D GEN     $@
> >         cmd_check_and_copy_blacklist_hash_list =3D \
> > -     $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_=
SYSTEM_BLACKLIST_HASH_LIST) >&2; \
> > +     $(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_S=
YSTEM_BLACKLIST_HASH_LIST) >&2; \
> >       cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
> >
> >   $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORC=
E
> > diff --git a/scripts/check-blacklist-hashes.awk b/certs/check-blacklist=
-hashes.awk
> > similarity index 100%
> > rename from scripts/check-blacklist-hashes.awk
> > rename to certs/check-blacklist-hashes.awk
>
> It looks more appropriate and consistent to me to keep it in scripts/,
> close to other cert scripts. Is there some precedent to move such script?


I always did that.   For example,

  f6f57a46435d7253a52a1a07a58183678ad266a0
  78a20a012ecea857e438b1f9e8091acb290bd0f5
  28ba53c07638f31b153e3a32672a6124d0ff2a97
  4484aa800ac588a1fe2175cd53076c21067f44b4
  340a02535ee785c64c62a9c45706597a0139e972


Tools can stay in scripts/ if and only if:

  - it is used globally during kernel builds

  - it is still needed after the kernel builds.
     "make clean" removes most of the build artifacts
      but keeps ones under scripts/.




scripts/insert-sys-cert is apparently unneeded for building the kernel.
If the intended use is to manipulate vmlinux later,
that is the legitimate reason to stay in scripts/.
(but even better place might be tools/)


certs/signing_key.pem is needed even after kernel builds.
So, it should have been kept under scripts/ instead of certs/.





--
Best Regards
Masahiro Yamada
