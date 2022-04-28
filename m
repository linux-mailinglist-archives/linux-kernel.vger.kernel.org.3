Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944A3512A02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiD1DfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbiD1De7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:34:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0657DAB3;
        Wed, 27 Apr 2022 20:31:38 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.32]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mw9Lu-1o2pG42aY8-00s6ay; Thu, 28 Apr 2022 05:30:44 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 1FCF23C01C;
        Thu, 28 Apr 2022 05:30:43 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id B89A65F6; Thu, 28 Apr 2022 05:30:42 +0200 (CEST)
Date:   Thu, 28 Apr 2022 05:30:42 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 27/27] kbuild: do not create *.prelink.o for Clang LTO or
 IBT
Message-ID: <YmoKYjwvX49KLNwT@bergen.fjasle.eu>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-28-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220424190811.1678416-28-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:vpoCvagVWixJ1WtlIXCkQBjopiLXqY/cI3W05BJdkTp4F1VwKaF
 fKz47nWVHcIN5znPoZqzbr627szB+zsL5OdIKJSSAnFvTIuQjCmccfXeHFQbOOT5rYrQwfz
 4RcbDvJR6QcU69m/d/H1IFAtiA1uLn7CoQ2GuW7a5OhG+zikAA8AsStMrLBH2hSJtgu+02c
 4Wl3xcjvr1Lcx2MWQPAhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NAY8wEee1Jw=:MPk3f6Uu8OkDerx5TFxCXP
 qoJiFx57v3IK/pP8FB7xDhjRWFDrAQaxCwF5TjA/4GmNdQ5LwgM/JlbbSlRQYhRj1wwlfMh2u
 mrFQEPqOYwcck3EuS/6jNylTCT4sp8/dFznLpmhbYdtrLhU4yIzCrorq7fuz4+vUU+CvBoYr8
 UADOtELYZSfaKhJJAzXNRbkksuH9/ufh9EynoClzPQxvecsrr++aD2gD7F40ua2+kkibUAmzC
 P1nct3uzNhRfJNcSJMR9TztZhgqA80bIj5wJugDTwxo67Sl2qj3Ph5FuCA2hELPtlaPu+RkDc
 A/chVbvyotqIZ3OU+LIE8Gosfsb5JoIbGJj2ZoUWR86d3aWaXZqFVsgbUGDi+RpjRRD4mJcQL
 xVCvnNQj2IasOgdM32umQqsguneH+qHOc8TIqszEcT11s0v1t36XiPc9gSOlSm9byPHjCWAz4
 HZDjnLED1uvxuQeJuCvMIcr9bSOcbuvedMeXXGwnv15Jge+0/FvY00d4QVoDp9lkYdzn0Ct1X
 mixKrEGP0EdolzNt+yrJMc3R4fJGNUbJ/10gNWavIf2+Ej3/vwUroGOyljRm1/MpC4tLzq9Fd
 lxZD+zLM8TzbDDIRLm6OTjDrchtWUpWeyZYJKj3B2o1zp2S7J8rlRcddHOkvJE1IkcCSi4iVl
 FBkMHhwqQKB0OGP8YrTUzPkwwH80YVYFtK0znahVDi8OnGwSwgaPXzpwDH5LjDxxxvVk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Apr 2022 04:08:11 GMT Masahiro Yamada wrote:
> When CONFIG_LTO_CLANG=y, additional intermediate *.prelink.o is 
> created
> for each module. Also, objtool is postponed until LLVM bitcode is
> converted to ELF.
> 
> CONFIG_X86_KERNEL_IBT works in a similar way to postpone objtool until
> objects are merged together.
> 
> This commit stops generating *.prelink.o, so the build flow will look
> the same with/without LTO.
> 
> The following figures show how the LTO build currently works, and
> how this commit is changing it.
> 
> Current build flow
> ==================
> 
>  [1] single-object module
> 
>                                     [+objtool]
>            $(CC)                      $(LD)                $(LD)
>     foo.c --------------------> foo.o -----> foo.prelink.o -----> foo.ko
>                            (LLVM bitcode)        (ELF)       |
>                                                              |
>                                                  foo.mod.o --/
> 
>  [2] multi-object module
>                                     [+objtool]
>            $(CC)         $(AR)        $(LD)                $(LD)
>     foo1.c -----> foo1.o -----> foo.o -----> foo.prelink.o -----> foo.ko
>                            |  (archive)          (ELF)       |
>     foo2.c -----> foo2.o --/                                 |
>                 (LLVM bitcode)                   foo.mod.o --/
> 
>   One confusion is foo.o in multi-object module is an archive despite of
>   its suffix.
> 
> New build flow
> ==============
> 
>  [1] single-object module
> 
>   Since there is only one object, we do not need to have the LLVM
>   bitcode stage. Use $(CC)+$(LD) to generate an ELF object in one
>   build rule. Of course, only $(CC) is used when LTO is disabled.
> 
>            $(CC)+$(LD)[+objtool]           $(LD)
>     foo.c ------------------------> foo.o -------> foo.ko
>                                     (ELF)    |
>                                              |
>                                  foo.mod.o --/
> 
>  [2] multi-object module
> 
>   Previously, $(AR) was used to combine LLVM bitcode into an archive,
>   but there was not a technical reason to do so.
>   This commit just uses $(LD) to combine and convert them into a single
>   ELF object.
> 
>                           [+objtool]
>             $(CC)           $(LD)          $(LD)
>     foo1.c -------> foo1.o -------> foo.o -------> foo.ko
>                               |     (ELF)    |
>     foo2.c -------> foo2.o ---/              |
>                 (LLVM bitcode)   foo.mod.o --/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Kbuild.include    |  4 +++
>  scripts/Makefile.build    | 58 ++++++++++++---------------------------
>  scripts/Makefile.lib      |  7 -----
>  scripts/Makefile.modfinal |  5 ++--
>  scripts/Makefile.modpost  |  9 ++----
>  scripts/mod/modpost.c     |  7 -----
>  6 files changed, 25 insertions(+), 65 deletions(-)
> 
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 3514c2149e9d..455a0a6ce12d 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -15,6 +15,10 @@ pound := \#
>  # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
>  dot-target = $(dir $@).$(notdir $@)
>  
> +###
> +# Name of target with a '.tmp_' as filename prefix. foo/bar.o => foo/.tmp_bar.o
> +tmp-target = $(dir $@).tmp_$(notdir $@)

This matches the dot-target definition above, otherwise $(@D).tmp_$(@F) 
would be an alternative.

> +
>  ###
>  # The temporary file to save gcc -MMD generated dependencies must not
>  # contain a comma
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 7f199b0a5170..fe4d3a908dd0 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -88,10 +88,6 @@ endif
>  targets-for-modules := $(foreach x, o mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
>  				$(patsubst %.o, %.$x, $(filter %.o, $(obj-m))))
>  
> -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> -targets-for-modules += $(patsubst %.o, %.prelink.o, $(filter %.o, $(obj-m)))
> -endif
> -
>  ifdef need-modorder
>  targets-for-modules += $(obj)/modules.order
>  endif
> @@ -153,8 +149,16 @@ $(obj)/%.ll: $(src)/%.c FORCE
>  # The C file is compiled and updated dependency information is generated.
>  # (See cmd_cc_o_c + relevant part of rule_cc_o_c)
>  
> +is-single-obj-m = $(if $(part-of-module),$(if $(filter $@, $(obj-m)),y))

Perhaps using $(and ..,..,y) instead if $(if ..,$(if ..,y))?

is-single-obj-m = $(and $(part-of-module),$(filter $@, $(obj-m)),y)

> +
> +ifdef CONFIG_LTO_CLANG
> +cmd_ld_single = $(if $(is-single-obj-m), ; $(LD) $(ld_flags) -r -o $(tmp-target) $@; mv $(tmp-target) $@)
> +endif
> +
>  quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
> -      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< $(cmd_objtool)
> +      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
> +		$(cmd_ld_single) \
> +		$(cmd_objtool)
>  
>  ifdef CONFIG_MODVERSIONS
>  # When module versioning is enabled the following steps are executed:
> @@ -228,21 +232,16 @@ cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(o
>  
>  endif # CONFIG_STACK_VALIDATION
>  
> -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> -
> -# Skip objtool for LLVM bitcode
> -$(obj)/%.o: objtool-enabled :=
> -
> -else
>  
>  # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
>  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
>  
> -$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
> -	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
> +is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
>  
> -endif
> +delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
> +
> +$(obj)/%.o: objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))

same here?  $(and) versus $(if ..,$(if ..,y))

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
>  cmd_gen_ksymdeps = \
> @@ -271,24 +270,6 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
>  	$(call if_changed_rule,cc_o_c)
>  	$(call cmd,force_checksrc)
>  
> -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> -# Module .o files may contain LLVM bitcode, compile them into native code
> -# before ELF processing
> -quiet_cmd_cc_prelink_modules = LD [M]  $@
> -      cmd_cc_prelink_modules =						\
> -	$(LD) $(ld_flags) -r -o $@					\
> -		--whole-archive $(filter-out FORCE,$^)			\
> -		$(cmd_objtool)
> -
> -# objtool was skipped for LLVM bitcode, run it now that we have compiled
> -# modules into native code
> -$(obj)/%.prelink.o: objtool-enabled = y
> -$(obj)/%.prelink.o: part-of-module := y
> -
> -$(obj)/%.prelink.o: $(obj)/%.o FORCE
> -	$(call if_changed,cc_prelink_modules)
> -endif
> -
>  cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
>  	$(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
>  
> @@ -298,7 +279,7 @@ $(obj)/%.mod: FORCE
>  # List module undefined symbols
>  cmd_undefined_syms = $(NM) $< | sed -n 's/^  *U //p' > $@
>  
> -$(obj)/%.usyms: $(obj)/%$(mod-prelink-ext).o FORCE
> +$(obj)/%.usyms: $(obj)/%.o FORCE
>  	$(call if_changed,undefined_syms)
>  
>  quiet_cmd_cc_lst_c = MKLST   $@
> @@ -420,16 +401,11 @@ $(obj)/modules.order: $(obj-m) FORCE
>  $(obj)/lib.a: $(lib-y) FORCE
>  	$(call if_changed,ar)
>  
> -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> -quiet_cmd_link_multi-m = AR [M]  $@
> -cmd_link_multi-m =						\
> -	rm -f $@; 						\
> -	$(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
> -else
>  quiet_cmd_link_multi-m = LD [M]  $@
> -      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@)
> -endif
> +      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
>  
> +$(multi-obj-m): objtool-enabled := $(delay-objtool)
> +$(multi-obj-m): part-of-module := y
>  $(multi-obj-m): %.o: %.mod FORCE
>  	$(call if_changed,link_multi-m)
>  $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 0453a1904646..f75138385449 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -225,13 +225,6 @@ dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre.tmp -nostdinc                    \
>  		 $(addprefix -I,$(DTC_INCLUDE))                          \
>  		 -undef -D__DTS__
>  
> -ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
> -# With CONFIG_LTO_CLANG, .o files in modules might be LLVM bitcode, so we
> -# need to run LTO to compile them into native code (.lto.o) before further
> -# processing.
> -mod-prelink-ext := .prelink
> -endif
> -
>  # Useful for describing the dependency of composite objects
>  # Usage:
>  #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index d429e3f9ae1d..51d384a0e4f9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -9,7 +9,7 @@ __modfinal:
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
>  
> -# for c_flags and mod-prelink-ext
> +# for c_flags
>  include $(srctree)/scripts/Makefile.lib
>  
>  # find all modules listed in modules.order
> @@ -55,9 +55,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
>  	$(cmd);                                                              \
>  	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
>  
> -
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -$(modules): %.ko: %$(mod-prelink-ext).o %.mod.o $(if $(CONFIG_MODVERSIONS), %.symver.lds) scripts/module.lds $(if $(KBUILD_BUILTIN),vmlinux) FORCE
> +$(modules): %.ko: %.o %.mod.o $(if $(CONFIG_MODVERSIONS), %.symver.lds) scripts/module.lds $(if $(KBUILD_BUILTIN),vmlinux) FORCE
>  	+$(call if_changed_except,ld_ko_o,vmlinux)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 48585c4d04ad..f2ce411acd59 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -41,9 +41,6 @@ __modpost:
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
>  
> -# for mod-prelink-ext
> -include $(srctree)/scripts/Makefile.lib
> -
>  MODPOST = scripts/mod/modpost								\
>  	$(if $(CONFIG_MODVERSIONS),-m)							\
>  	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
> @@ -118,8 +115,6 @@ $(input-symdump):
>  	@echo >&2 '         Modules may not have dependencies or modversions.'
>  	@echo >&2 '         You may get many unresolved symbol warnings.'
>  
> -modules := $(sort $(shell cat $(MODORDER)))
> -
>  # KBUILD_MODPOST_WARN can be set to avoid error out in case of undefined symbols
>  ifneq ($(KBUILD_MODPOST_WARN)$(filter-out $(existing-input-symdump), $(input-symdump)),)
>  MODPOST += -w
> @@ -128,9 +123,9 @@ endif
>  # Read out modules.order to pass in modpost.
>  # Otherwise, allmodconfig would fail with "Argument list too long".
>  quiet_cmd_modpost = MODPOST $@
> -      cmd_modpost = sed 's/\.ko$$/$(mod-prelink-ext)\.o/' $< | $(MODPOST) -T -
> +      cmd_modpost = sed 's/ko$$/o/' $< | $(MODPOST) -T -
>  
> -$(output-symdump): $(MODORDER) $(input-symdump) $(modules:.ko=$(mod-prelink-ext).o) FORCE
> +$(output-symdump): $(MODORDER) $(input-symdump) FORCE
>  	$(call if_changed,modpost)
>  
>  targets += $(output-symdump)
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index ef779ada04c6..d8de62506939 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2081,10 +2081,6 @@ static char *remove_dot(char *s)
>  		size_t m = strspn(s + n + 1, "0123456789");
>  		if (m && (s[n + m] == '.' || s[n + m] == 0))
>  			s[n] = 0;
> -
> -		/* strip trailing .prelink */
> -		if (strends(s, ".prelink"))
> -			s[strlen(s) - 8] = '\0';
>  	}
>  	return s;
>  }
> @@ -2108,9 +2104,6 @@ static void read_symbols(const char *modname)
>  		/* strip trailing .o */
>  		tmp = NOFAIL(strdup(modname));
>  		tmp[strlen(tmp) - 2] = '\0';
> -		/* strip trailing .prelink */
> -		if (strends(tmp, ".prelink"))
> -			tmp[strlen(tmp) - 8] = '\0';
>  		mod = new_module(tmp);
>  
>  		if (modversions)
> -- 
> 2.32.0

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
