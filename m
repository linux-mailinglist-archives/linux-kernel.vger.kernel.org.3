Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1A532BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiEXOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiEXOF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:05:28 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BB65D21;
        Tue, 24 May 2022 07:05:23 -0700 (PDT)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 24OE4iXJ011130;
        Tue, 24 May 2022 23:04:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 24OE4iXJ011130
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653401085;
        bh=GIeMujM+pUP1MJNVxgK1MKIIGnfPc7jabWPZWh7CtfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OfanboZnQIRqiaa90eG/xbMlUGJnKg2OYG3VCQz3bJIa6NwuVUuHLgcUe8fN1Y0bl
         HXe61/ei4427Gv/ffM81AMB35a8bl+eZMBSBy7tWBA1Z+xGsH2xUbM1d1bDwbxiRjv
         HUDtzs/iH5gytH+c3uKIVBIQNBkkFuaq588SGp4Ll4Yy5EQlpo2VIvjhbVwoMyL2o+
         nm1z3p24Hhf4WMWsB7G2rl+nPp7mF6Pr/kJr+E6/YDuSXnHRQ5SW85OTasCbEjxuZC
         c7O4v7wTULDN0vB9ot/IXV2y1znowFfrFjQ62NtcGyjAugPdu2dsSKir2VB+T59Fhm
         56TooWqwdln5Q==
X-Nifty-SrcIP: [209.85.216.44]
Received: by mail-pj1-f44.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so2210532pjb.0;
        Tue, 24 May 2022 07:04:45 -0700 (PDT)
X-Gm-Message-State: AOAM532moMTbQKFVz1Q3ttLWGYpGFQyrmD5ThgLkG79sOUBnTKsMQD0l
        7BW2NB++T4qJ1ys1ya9CBHd3u3jV3/jp0bCBgM8=
X-Google-Smtp-Source: ABdhPJwrSmsLIXLWVG69kzBfVEdq4XEfu2FldJ479zNamn32Kh+gwANUkb0kNpP6O4ACTQc2gRmeVz+31/vCBr7f46s=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr27265256plp.162.1653401084217; Tue, 24
 May 2022 07:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220523200222.711011-1-keescook@chromium.org> <CAK7LNASWUH-ZYU76Xj3YPc1na6ALo0dULSR0UNWe=_L9GcVXjQ@mail.gmail.com>
In-Reply-To: <CAK7LNASWUH-ZYU76Xj3YPc1na6ALo0dULSR0UNWe=_L9GcVXjQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 23:03:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQmfxpSe_HVh=Gvk2gHqJMvH_HAodAvxSJqfn24Etxi-A@mail.gmail.com>
Message-ID: <CAK7LNAQmfxpSe_HVh=Gvk2gHqJMvH_HAodAvxSJqfn24Etxi-A@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Require utsrelease.h before scripts target
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <lkp@intel.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees

On Tue, May 24, 2022 at 5:20 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 5:02 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > The "utsrelease.h" target was in parallel with the "scripts" target,
> > which meant -j1 or unlucky parallel builds from a distclean state would
> > fail to build the GCC plugins.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/linux-mm/202205230239.EZxeZ3Fv-lkp@intel.com
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Link: https://lore.kernel.org/lkml/YouX6g1T7w3FDeM8@cmpxchg.org
> > Fixes: 61f60bac8c05 ("gcc-plugins: Change all version strings match kernel")
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: linux-kbuild@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>


This will work but I do not want to complex the build order.

I'd like to suggest to use KERNELVERSION.

Please consider this as an alternative.
https://lore.kernel.org/lkml/20220524135541.1453693-1-masahiroy@kernel.org/T/#u






> > ---
> >  Makefile                     | 2 +-
> >  scripts/gcc-plugins/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 91c91fcf3c24..c04420d5aa3d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1175,7 +1175,7 @@ include/config/kernel.release: FORCE
> >  # Carefully list dependencies so we do not try to build scripts twice
> >  # in parallel
> >  PHONY += scripts
> > -scripts: scripts_basic scripts_dtc
> > +scripts: include/generated/utsrelease.h scripts_basic scripts_dtc
> >         $(Q)$(MAKE) $(build)=$(@)
> >
> >  # Things we need to do before we recursively start building the kernel
> > diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> > index 6f0aecad5d67..c29334669a16 100644
> > --- a/scripts/gcc-plugins/Makefile
> > +++ b/scripts/gcc-plugins/Makefile
> > @@ -64,5 +64,5 @@ $(foreach m, $(notdir $(plugin-multi)), $(eval $(obj)/$m: $(addprefix $(obj)/, $
> >  quiet_cmd_plugin_cxx_o_c = HOSTCXX $@
> >        cmd_plugin_cxx_o_c = $(HOSTCXX) $(plugin_cxxflags) -c -o $@ $<
> >
> > -$(plugin-objs): $(obj)/%.o: $(src)/%.c FORCE
> > +$(plugin-objs): $(obj)/%.o: $(src)/%.c $(objdir)/include/generated/utsrelease.h FORCE
>
>
> This change is unneeded.
>
> The header dependencies are automatically generated
> by the -MMD option.
>
>      plugin_cxxflags = -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
>
>
>
>
>
>
> >         $(call if_changed_dep,plugin_cxx_o_c)
> > --
> > 2.32.0
> >
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
