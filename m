Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0FB4B022A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiBJB0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:26:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiBJB0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:26:25 -0500
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15D520192;
        Wed,  9 Feb 2022 17:26:06 -0800 (PST)
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-06.nifty.com with ESMTP id 21A0UaTB024452;
        Thu, 10 Feb 2022 09:30:36 +0900
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21A0U6Su029232;
        Thu, 10 Feb 2022 09:30:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21A0U6Su029232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644453007;
        bh=6klY6ywSHDTIAmjF9MCEJbiIQSicqR7O8sRNcdznk98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r6P2WkeMfp/H3RXMD6DzcwlV9NwBjLEOXZoRASN2wuKbY0r2MfWcnjJFQYO20li4Z
         r36l9GLY/xAc5J2Xai+1gb4fws1qxfu6BuO6/WQ6/VZxkBr7BlJBPFIAD3WZ16h6Os
         fHszajb7da46jy/QH+686vigTFIWspGksiC8RALLtvMu8fDo7Ryii78/iCBfiU6KxS
         k+FpDbGKEhCCv3GsUK9BVUV+Bnm56NcYqRWxiA2HEKFs43S7TNz1xxJxtw9O2fVQW+
         tL5oQWFHYzyB1WUnCogTyewfahMWeYZvoPuSpXdt16dfW5Su55XpePvQsJx2gZVbi0
         hCyQOR7VmrG8g==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id i186so7397347pfe.0;
        Wed, 09 Feb 2022 16:30:07 -0800 (PST)
X-Gm-Message-State: AOAM530EGvzi3pUqKjkE+P0rwz+KbuwTG/klEVo0NQnuSx5mgV0BomEF
        Z3Rswc2r6BXOW5rgZciOVW2dA1qmkXKp+ZzZsyQ=
X-Google-Smtp-Source: ABdhPJy9PxQxyofxPgV6A6DkaBe7h5z+1tcTNPVaCvhahGvMNZ8PUFa33IO9YCS+eHepbhDA9aj4Q/bzp9Ylq1Q/eNY=
X-Received: by 2002:a05:6a00:240a:: with SMTP id z10mr4954154pfh.68.1644453006311;
 Wed, 09 Feb 2022 16:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20220112224342.958358-1-quic_eberman@quicinc.com>
 <20220201213542.2808035-1-quic_eberman@quicinc.com> <CAKwvOdmZHmihbf_mLyi=Ncf7FZjjSxxTsHZeaqxk4LKhMHs_iA@mail.gmail.com>
 <CAKwvOdn0oi+3yEECXLaSzoAdW19SCvpn_8t6yB2wpJE+Fpoy5w@mail.gmail.com>
In-Reply-To: <CAKwvOdn0oi+3yEECXLaSzoAdW19SCvpn_8t6yB2wpJE+Fpoy5w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Feb 2022 09:29:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARSJcbk+9tfotXj7OR4AjpHcYZVPCuJyaM0BJJXpPvgPA@mail.gmail.com>
Message-ID: <CAK7LNARSJcbk+9tfotXj7OR4AjpHcYZVPCuJyaM0BJJXpPvgPA@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: Add environment variables for userprogs flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Elliot Berman <quic_eberman@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 7:53 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Feb 1, 2022 at 1:38 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Feb 1, 2022 at 1:36 PM Elliot Berman <quic_eberman@quicinc.com> wrote:
> > >
> > > Allow additional arguments be passed to userprogs compilation.
> > > Reproducible clang builds need to provide a sysroot and gcc path to
> > > ensure same toolchain is used across hosts. KCFLAGS is not currently
> >
> > ^ ensure the same (maybe Masahiro can fix that up locally when applying)
>
> Masahiro,
> What are your thoughts on this patch?  I think this would help Android
> define a musl or bionic sysroot for CC_CAN_LINK and ultimately
> UAPI_HEADER_TEST support.

Sorry for delay.


Applied with two fixups in the commit log:

 ensure same -> ensure the same
 Clang 13+ might detect  ->  Clang might detect













> >
> > > used for any user programs compilation, so add new USERCFLAGS and
> > > USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.
> > >
> > > Clang 13+ might detect GCC installation on hosts which have it installed
> > > to a default location in /. With addition of these environment
> > > variables, you can specify flags such as:
> > >
> > > $ make USERCFLAGS=--sysroot=/path/to/sysroot
> > >
> > > This can also be used to specify different sysroots such as musl or
> > > bionic which may be installed on the host in paths that the compiler
> > > may not search by default.
> > >
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> >
> > Thanks for the patch!
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > > ---
> > >
> > > Changes since v2:
> > >  - Incorporated Nick's suggestions:
> > >    - Addressed docs and commit text comments
> > >    - Introduced KBUILD_USERHOSTCFLAGS as suggested
> > >
> > >  Documentation/kbuild/kbuild.rst    | 11 +++++++++++
> > >  Documentation/kbuild/makefiles.rst |  2 ++
> > >  Makefile                           | 10 ++++++----
> > >  init/Kconfig                       |  8 ++++----
> > >  usr/include/Makefile               |  3 +++
> > >  5 files changed, 26 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> > > index 2d1fc03d346e..ef19b9c13523 100644
> > > --- a/Documentation/kbuild/kbuild.rst
> > > +++ b/Documentation/kbuild/kbuild.rst
> > > @@ -77,6 +77,17 @@ HOSTLDLIBS
> > >  ----------
> > >  Additional libraries to link against when building host programs.
> > >
> > > +.. _userkbuildflags:
> > > +
> > > +USERCFLAGS
> > > +----------
> > > +Additional options used for $(CC) when compiling userprogs.
> > > +
> > > +USERLDFLAGS
> > > +-----------
> > > +Additional options used for $(LD) when linking userprogs. userprogs are linked
> > > +with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
> > > +
> > >  KBUILD_KCONFIG
> > >  --------------
> > >  Set the top-level Kconfig file to the value of this environment
> > > diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> > > index b008b90b92c9..11a296e52d68 100644
> > > --- a/Documentation/kbuild/makefiles.rst
> > > +++ b/Documentation/kbuild/makefiles.rst
> > > @@ -982,6 +982,8 @@ The syntax is quite similar. The difference is to use "userprogs" instead of
> > >
> > >         When linking bpfilter_umh, it will be passed the extra option -static.
> > >
> > > +       From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
> > > +
> > >  5.4 When userspace programs are actually built
> > >  ----------------------------------------------
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 45278d508d81..1d0172449355 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -431,11 +431,12 @@ HOSTCC    = gcc
> > >  HOSTCXX        = g++
> > >  endif
> > >
> > > -export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> > > -                             -O2 -fomit-frame-pointer -std=gnu89
> > > -export KBUILD_USERLDFLAGS :=
> > > +KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> > > +                        -O2 -fomit-frame-pointer -std=gnu89
> > > +KBUILD_USERCFLAGS  := $(KBUILD_USERHOSTCFLAGS) $(USERCFLAGS)
> > > +KBUILD_USERLDFLAGS := $(USERLDFLAGS)
> > >
> > > -KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> > > +KBUILD_HOSTCFLAGS   := $(KBUILD_USERHOSTCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> > >  KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
> > >  KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
> > >  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
> > > @@ -530,6 +531,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
> > >  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
> > >  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> > >  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> > > +export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
> > >
> > >  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
> > >  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index f2ae41e6717f..164706c38e8b 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -62,13 +62,13 @@ config LLD_VERSION
> > >
> > >  config CC_CAN_LINK
> > >         bool
> > > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
> > > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag))
> > > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
> > > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
> > >
> > >  config CC_CAN_LINK_STATIC
> > >         bool
> > > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
> > > -       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
> > > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
> > > +       default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
> > >
> > >  config CC_HAS_ASM_GOTO
> > >         def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> > > diff --git a/usr/include/Makefile b/usr/include/Makefile
> > > index 1c2ae1368079..0322e567dc1e 100644
> > > --- a/usr/include/Makefile
> > > +++ b/usr/include/Makefile
> > > @@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
> > >  # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
> > >  UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
> > >
> > > +# USERCFLAGS might contain sysroot location for CC.
> > > +UAPI_CFLAGS += $(USERCFLAGS)
> > > +
> > >  override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
> > >
> > >  # The following are excluded for now because they fail to build.
> > > --
> > > 2.25.1
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Best Regards
Masahiro Yamada
