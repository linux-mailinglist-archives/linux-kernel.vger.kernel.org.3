Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580A4532527
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiEXIWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiEXIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:22:42 -0400
X-Greylist: delayed 51355 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 May 2022 01:22:40 PDT
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DEB6D1B8;
        Tue, 24 May 2022 01:22:38 -0700 (PDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 24O8M68k006098;
        Tue, 24 May 2022 17:22:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 24O8M68k006098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653380526;
        bh=q6za3m9RvzaPHhFEyPx6fRCSS/LSE+ziJO/OmsbOCfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dl4+r03MQKiOYWwkQd6/wGRucqQOHUjMMP1K09kq9aDCZdWfaAVzjAixKYMEBzeDf
         VXUFTEtIrRdwbhgbm1bXfrunAYFEfkpyHrIyVnRaIKB6BUipVsA3LtAOcMvEj2Klw5
         9lZNCmy3vO5Uf8zoX1sBvCQ7arLqs8T40s2a7m3kgwdxv8h+a1wYM5gqo2d7OE44u3
         pWz7tx6XVmKNpxzoQYmH/CRxuBlsjUBYEd70DqwlkiwB3Nemb9RJb0q8kLc4JMmsy4
         /3KSe+gncDh6z8ZwD2qaoRysEMq+wPnT8nN1FHyYmNrMTCpaDvDPrZ1HgYcDKA0fvS
         bmCd27m/fkaiw==
X-Nifty-SrcIP: [209.85.210.177]
Received: by mail-pf1-f177.google.com with SMTP id h13so9553008pfq.5;
        Tue, 24 May 2022 01:22:06 -0700 (PDT)
X-Gm-Message-State: AOAM53391RVzmNfnsdzrtR9XT3EIN0gha+5NOhJV/LvuSIhT7QuGadBE
        rXj7VZY+4E7Erkvs0LndnddIx3AVLgYWLZx+53c=
X-Google-Smtp-Source: ABdhPJy/EXBCdolgpL2fr/ku8aEoHDny91aiZJzwlxFQUWE7v6lP7QfKeByb4K/TLGui8Li/7KWEbwkpmOaJDujAqEQ=
X-Received: by 2002:a63:9043:0:b0:3f9:6c36:3de3 with SMTP id
 a64-20020a639043000000b003f96c363de3mr15921286pge.616.1653380525571; Tue, 24
 May 2022 01:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220523200222.711011-1-keescook@chromium.org>
In-Reply-To: <20220523200222.711011-1-keescook@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 May 2022 17:20:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWUH-ZYU76Xj3YPc1na6ALo0dULSR0UNWe=_L9GcVXjQ@mail.gmail.com>
Message-ID: <CAK7LNASWUH-ZYU76Xj3YPc1na6ALo0dULSR0UNWe=_L9GcVXjQ@mail.gmail.com>
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

On Tue, May 24, 2022 at 5:02 AM Kees Cook <keescook@chromium.org> wrote:
>
> The "utsrelease.h" target was in parallel with the "scripts" target,
> which meant -j1 or unlucky parallel builds from a distclean state would
> fail to build the GCC plugins.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-mm/202205230239.EZxeZ3Fv-lkp@intel.com
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/YouX6g1T7w3FDeM8@cmpxchg.org
> Fixes: 61f60bac8c05 ("gcc-plugins: Change all version strings match kernel")
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Makefile                     | 2 +-
>  scripts/gcc-plugins/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 91c91fcf3c24..c04420d5aa3d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1175,7 +1175,7 @@ include/config/kernel.release: FORCE
>  # Carefully list dependencies so we do not try to build scripts twice
>  # in parallel
>  PHONY += scripts
> -scripts: scripts_basic scripts_dtc
> +scripts: include/generated/utsrelease.h scripts_basic scripts_dtc
>         $(Q)$(MAKE) $(build)=$(@)
>
>  # Things we need to do before we recursively start building the kernel
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index 6f0aecad5d67..c29334669a16 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -64,5 +64,5 @@ $(foreach m, $(notdir $(plugin-multi)), $(eval $(obj)/$m: $(addprefix $(obj)/, $
>  quiet_cmd_plugin_cxx_o_c = HOSTCXX $@
>        cmd_plugin_cxx_o_c = $(HOSTCXX) $(plugin_cxxflags) -c -o $@ $<
>
> -$(plugin-objs): $(obj)/%.o: $(src)/%.c FORCE
> +$(plugin-objs): $(obj)/%.o: $(src)/%.c $(objdir)/include/generated/utsrelease.h FORCE


This change is unneeded.

The header dependencies are automatically generated
by the -MMD option.

     plugin_cxxflags = -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \






>         $(call if_changed_dep,plugin_cxx_o_c)
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
