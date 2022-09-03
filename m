Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7B5ABBFE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 03:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiICBMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 21:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICBMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 21:12:06 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142D5CE32B;
        Fri,  2 Sep 2022 18:12:04 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2831BfNL007480;
        Sat, 3 Sep 2022 10:11:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2831BfNL007480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662167502;
        bh=d1zZMjIp/AEHUFQaxKnZBp8fdpmaAc/pofnE8yjoj0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RvpB/SQMo96ICeGqOoYzZR985R9GyCMDlN+mwMjn5EwdfWIYOitLm0k32VB+6DwDi
         zjcbewmZ76ZIcAbaxfHRsZU75b4hxDgHXYupFt5IEoMzAOg8T6ArhQ+LIuYsPkBgrH
         Ts335P0Eu+WGad8AiBOaeBAKBCVasValNRknV6nUW5by0AInrjF9QdY8kIp+oZ4rKW
         1HkUyONcQaAxT+mYSnqYF0vv19P4OjTt6W263grjTQyDCOr9HGeq/GkOLFh79ylLjr
         3hadkAfYdl0Wukv70mKNGLaHfn2mIJWvq2+jDvIdaxq6n29FEdKX9+UDR5fspzxwpt
         nTPVY6hn2ldXg==
X-Nifty-SrcIP: [209.85.160.50]
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so8917776fac.4;
        Fri, 02 Sep 2022 18:11:41 -0700 (PDT)
X-Gm-Message-State: ACgBeo23/9Bx9fBSgqXY+V8F2t8atsEQ3Ya176aHpL0xOIoKMQYPYwMW
        9CNhLIyeNTvdN/DQ6yAbb7JwJPx0IrmGA7xOeVk=
X-Google-Smtp-Source: AA6agR72d0VE/5+VJ8O5be1iaUMumL9bYP4n7YcvmqeZwMvwba4zChF2mHdngQ3NQeGza6WcSrTPTKGhHRRK+itE67o=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr3025795oil.194.1662167500600; Fri, 02
 Sep 2022 18:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220902130846.654526-1-masahiroy@kernel.org>
In-Reply-To: <20220902130846.654526-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 3 Sep 2022 10:11:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASAJPb06oE7yAhAtAWSB5_So_1PP8L8jgnkpgEb035JoA@mail.gmail.com>
Message-ID: <CAK7LNASAJPb06oE7yAhAtAWSB5_So_1PP8L8jgnkpgEb035JoA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: use objtool-args-y to clean up objtool arguments
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, Sep 2, 2022 at 10:11 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Based on Linus' patch.
>
> Link: https://lore.kernel.org/lkml/CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com/
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.lib       | 31 ++++++++++++++++---------------
>  scripts/Makefile.vmlinux_o | 17 ++++++++---------
>  2 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index b594705d571a..731f735240f8 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -229,25 +229,26 @@ ifdef CONFIG_OBJTOOL
>
>  objtool := $(objtree)/tools/objtool/objtool
>
> -objtool_args =                                                         \
> -       $(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)        \
> -       $(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)              \
> -       $(if $(CONFIG_X86_KERNEL_IBT), --ibt)                           \
> -       $(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)             \
> -       $(if $(CONFIG_UNWINDER_ORC), --orc)                             \
> -       $(if $(CONFIG_RETPOLINE), --retpoline)                          \
> -       $(if $(CONFIG_RETHUNK), --rethunk)                              \
> -       $(if $(CONFIG_SLS), --sls)                                      \
> -       $(if $(CONFIG_STACK_VALIDATION), --stackval)                    \
> -       $(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)          \
> -       $(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)              \
> +objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)            += --hacks=jump_label
> +objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)               += --hacks=noinstr
> +objtool-args-$(CONFIG_X86_KERNEL_IBT)                  += --ibt
> +objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)       += --mcount
> +objtool-args-$(CONFIG_UNWINDER_ORC)                    += --orc
> +objtool-args-$(CONFIG_RETPOLINE)                       += --retpoline
> +objtool-args-$(CONFIG_RETHUNK)                         += --rethunk
> +objtool-args-$(CONFIG_SLS)                             += --sls
> +objtool-args-$(CONFIG_STACK_VALIDATION)                        += --stackval
> +objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)         += --static-call
> +objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)         += --uaccess
> +objtool-args-$(CONFIG_GCOV_KERNEL)                     += --no-unreachable
> +
> +objtool-args = $(objtool-args-y)                                       \
>         $(if $(delay-objtool), --link)                                  \
> -       $(if $(part-of-module), --module)                               \
> -       $(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
> +       $(if $(part-of-module), --module)
>
>  delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
>
> -cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
> +cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool-args) $@)
>  cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
>
>  endif # CONFIG_OBJTOOL
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 81a4e0484457..df928a6717a1 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -35,18 +35,17 @@ endif
>
>  objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
>
> -# Reuse objtool_args defined in scripts/Makefile.lib if LTO or IBT is enabled.
> +# Reuse objtool-args-y defined in scripts/Makefile.lib if LTO or IBT is enabled.
> +# (Expand objtool-args-y to a simple variable to avoid circular reference)
>  #
>  # Add some more flags as needed.
> -# --no-unreachable and --link might be added twice, but it is fine.
> -#
> -# Expand objtool_args to a simple variable to avoid circular reference.
> +# --no-unreachable might be added twice, but it is fine.
> +
> +objtool-args-$(delay-objtool)                  := $(objtool-args-y)

This line is wrong. I will change like follows:

objtool-args-y    := $(if $(delay-objtool), $(objtool-args-y))



> +objtool-args-$(CONFIG_GCOV_KERNEL)             += --no-unreachable
> +objtool-args-$(CONFIG_NOINSTR_VALIDATION)      += --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret))
>
> -objtool_args := \
> -       $(if $(delay-objtool),$(objtool_args)) \
> -       $(if $(CONFIG_NOINSTR_VALIDATION), --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret)) \
> -       $(if $(CONFIG_GCOV_KERNEL), --no-unreachable) \
> -       --link
> +objtool-args = $(objtool-args-y) --link
>
>  # Link of vmlinux.o used for section mismatch analysis
>  # ---------------------------------------------------------------------------
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
