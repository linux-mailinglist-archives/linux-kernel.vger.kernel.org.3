Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCD5A3963
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiH0SEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0SEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:04:24 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D098FE348;
        Sat, 27 Aug 2022 11:04:22 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 27RI48vF012106;
        Sun, 28 Aug 2022 03:04:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 27RI48vF012106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661623449;
        bh=+t7EtxGCSgWaf/15zG80Wd4faeh1P608OjCZhiU1OWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PsyVmRCyEnBANFUvtL8zNzHjF6em4cSGTA1k1OCklFQfYpP5vk3xavt0CvpjjpBbp
         oh41z88nJrSKXclcwYZt6c/PjgdC4CANE5e3ZsmGyBqZuBo98lN7Ix9+Fy1rMzRcvZ
         71vRvyXQquWj1AZE7Nvo0dXNO9KHSuJ/N/e7YmDwMv8a4A8PBMY+G/I3V/AsAOX2fY
         jRCHYDvfISEJxpI4Za3cnufsOr7pLOqBG0GwctidjNxawYGvFhOvSfsdCh/rHcTWFH
         T9fjmIs5KuEIVYBwStgbIh677BM4mMI8L0mD4mrMvvS9Ey9G5MlEqj6KTYDYRjV67z
         GfOS6R2SynzDQ==
X-Nifty-SrcIP: [209.85.167.176]
Received: by mail-oi1-f176.google.com with SMTP id j5so5860975oih.6;
        Sat, 27 Aug 2022 11:04:08 -0700 (PDT)
X-Gm-Message-State: ACgBeo0gq+0UTRkEVTx/b7GGVwlt2Qr8BeX6Ov9StG7TqA2815oIc7E1
        kCKO2WHSwWzYNHSI9M2Rb/ta0H0ORt8f0XK+DYo=
X-Google-Smtp-Source: AA6agR6nS67u95EJCrpvrOyfbJAowDY/4L331ZWG72SiLtv2sLKoZPeZUyymBbkbfUYl0nKn8fhha6UeZAntXg/KzqA=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr3913921oil.194.1661623447851; Sat, 27
 Aug 2022 11:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220827164056.3365356-1-masahiroy@kernel.org> <58a90319-668f-7c87-4168-e0df10644aa7@csgroup.eu>
In-Reply-To: <58a90319-668f-7c87-4168-e0df10644aa7@csgroup.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Aug 2022 03:03:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJiQc5HMdsct1S5z15-b1fzc5-Y2xtBs6oT17Na79H_w@mail.gmail.com>
Message-ID: <CAK7LNATJiQc5HMdsct1S5z15-b1fzc5-Y2xtBs6oT17Na79H_w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: clean up binutils version check
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sun, Aug 28, 2022 at 2:37 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 27/08/2022 =C3=A0 18:40, Masahiro Yamada a =C3=A9crit :
> > The checkbin in arch/powerpc/Makefile errors out if ld <=3D 2.24.
> > So, the requirement on PPC is binutils >=3D 2.25. It is cleaner to
> > specify it in scripts/min-tool-version.sh. If binutils < 2.25 is
> > used, the toolchain check will fail in the Kconfig stage going
> > forward.
> >
> > Since binutils >=3D 2.25 is already required, another version test
> > for --save-restore-funcs on PPC64 is always met.
> >
> > PPC is the last user of ld-ifversion. With all the callers removed,
> > the macro definition in scripts/Makefile.compiler can go away.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >   arch/powerpc/Makefile       | 21 ---------------------
> >   arch/powerpc/lib/Makefile   |  8 --------
> >   scripts/Makefile.compiler   |  4 ----
> >   scripts/min-tool-version.sh |  8 +++++++-
> >   4 files changed, 7 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 02742facf895..fb607758eeca 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -46,13 +46,7 @@ UTS_MACHINE :=3D $(subst $(space),,$(machine-y))
> >   ifdef CONFIG_PPC32
> >   KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> >   else
> > -ifeq ($(call ld-ifversion, -ge, 22500, y),y)
> > -# Have the linker provide sfpr if possible.
> > -# There is a corresponding test in arch/powerpc/lib/Makefile
> >   KBUILD_LDFLAGS_MODULE +=3D --save-restore-funcs
> > -else
> > -KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> > -endif
> >   endif
> >
> >   ifdef CONFIG_CPU_LITTLE_ENDIAN
> > @@ -395,8 +389,6 @@ vdso_prepare: prepare0
> >               $(build)=3Darch/powerpc/kernel/vdso include/generated/vds=
o64-offsets.h)
> >   endif
> >
> > -archprepare: checkbin
> > -
> >   archheaders:
> >       $(Q)$(MAKE) $(build)=3Darch/powerpc/kernel/syscalls all
> >
> > @@ -411,16 +403,3 @@ else
> >       $(eval KBUILD_CFLAGS +=3D -mstack-protector-guard-offset=3D$(shel=
l awk '{if ($$2 =3D=3D "TASK_CANARY") print $$3;}' include/generated/asm-of=
fsets.h))
> >   endif
> >   endif
> > -
> > -PHONY +=3D checkbin
> > -# Check toolchain versions:
> > -# - gcc-4.6 is the minimum kernel-wide version so nothing required.
> > -checkbin:
> > -     @if test "x${CONFIG_LD_IS_LLD}" !=3D "xy" -a \
> > -             "x$(call ld-ifversion, -le, 22400, y)" =3D "xy" ; then \
> > -             echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
> > -             echo 'in some circumstances.' ; \
> > -             echo    '*** binutils 2.23 do not define the TOC symbol '=
 ; \
> > -             echo -n '*** Please use a different binutils version.' ; =
\
> > -             false ; \
> > -     fi
> > diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> > index 8560c912186d..5eb3971ccb9c 100644
> > --- a/arch/powerpc/lib/Makefile
> > +++ b/arch/powerpc/lib/Makefile
> > @@ -38,14 +38,6 @@ obj-$(CONFIG_PPC32)        +=3D div64.o copy_32.o cr=
tsavres.o
> >
> >   obj-$(CONFIG_FUNCTION_ERROR_INJECTION)      +=3D error-inject.o
> >
> > -# See corresponding test in arch/powerpc/Makefile
> > -# 64-bit linker creates .sfpr on demand for final link (vmlinux),
> > -# so it is only needed for modules, and only for older linkers which
> > -# do not support --save-restore-funcs
> > -ifeq ($(call ld-ifversion, -lt, 22500, y),y)
> > -extra-$(CONFIG_PPC64)        +=3D crtsavres.o
> > -endif
> > -
> >   obj-$(CONFIG_PPC_BOOK3S_64) +=3D copyuser_power7.o copypage_power7.o =
\
> >                              memcpy_power7.o restart_table.o
> >
> > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > index 94d0d40cddb3..63e7d79dd877 100644
> > --- a/scripts/Makefile.compiler
> > +++ b/scripts/Makefile.compiler
> > @@ -68,7 +68,3 @@ cc-ifversion =3D $(shell [ $(CONFIG_GCC_VERSION)0 $(1=
) $(2)000 ] && echo $(3) || e
> >   # ld-option
> >   # Usage: KBUILD_LDFLAGS +=3D $(call ld-option, -X, -Y)
> >   ld-option =3D $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(=
2),$(3))
> > -
> > -# ld-ifversion
> > -# Usage:  $(call ld-ifversion, -ge, 22252, y)
> > -ld-ifversion =3D $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && echo =
$(3) || echo $(4))
> > diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> > index 250925aab101..7df9f2150ea1 100755
> > --- a/scripts/min-tool-version.sh
> > +++ b/scripts/min-tool-version.sh
> > @@ -14,7 +14,13 @@ fi
> >
> >   case "$1" in
> >   binutils)
> > -     echo 2.23.0
> > +     if [ "$SRCARCH" =3D powerpc ]; then
>
> Isn't this limitation only for ppc64le ?
>
> Refer commit 60e065f70bdb ("powerpc: Reject binutils 2.24 when building
> little endian")


I do not see any CONFIG check in the current checkbin.

Refer commit a3ad84da0760 ("powerpc/toc: Future proof
kernel toc")




--=20
Best Regards
Masahiro Yamada
