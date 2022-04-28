Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477065129C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiD1DIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiD1DIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:08:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9F333;
        Wed, 27 Apr 2022 20:05:11 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.32]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAwoL-1nZEGc2gll-00BNsv; Thu, 28 Apr 2022 05:04:31 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A0BF03C01C;
        Thu, 28 Apr 2022 05:04:29 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 0BE665F6; Thu, 28 Apr 2022 05:04:29 +0200 (CEST)
Date:   Thu, 28 Apr 2022 05:04:28 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 25/27] kbuild: embed symbol versions at final link of
 vmlinux or modules
Message-ID: <YmoEPLkuIZaH4mbW@bergen.fjasle.eu>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-26-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220424190811.1678416-26-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:sPLxvyHC97PIhMYAbJr9xnxLkwIAWVPwIXXY+1JKXyagvq11wpe
 YITP+rn1r8efMaix5XiulPZqywP1aAyspZ2bulc3gZMRAK7NtQlP+bm8+GFgmm72VM50wcd
 B0ilI4C3aZ11rPzIdZfoXvPzsLiw3T3OpL0QzYdcnGfTIrj59cKwBxtQ9hsl5H4HksEn3rs
 EO/67yMACQup0ChHYiiBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MD7ME2icglw=:uT6jCIwnSgZRDqtOBwb0dB
 kRDhk8bIARrgrpoJJ+tIOxn9S0YmQXm+B66WPJtIiN55E3/hUKMNIznw89b+skKK2MfshQGam
 2NvcZrGqKdcFwAi7thjcqvdfeZBbYEA4AOUlquIGo363fkThfsqEi6iJfbgHY3cT/JsnkjlCC
 7eLl906mw1z3/bPVJQgRFr8fY0+XAHE5CRpp2Zh9nTbuYfpMbTzQV2li4dQ3MEfddoCO5+pP+
 AGkdg+DVk1p4d8t+0fj+0hiNxkomYTy6Y6Hv70+gAvj1ghG01rnN/4v9kp+q0tQByw9VPoejk
 1FP63fERbivVd9u+jSyXIao5zSUDQP3wW2ealPXjHIyv6qe+fLnPkwXjNTHCK2uDwPfjrrNrz
 wL5R4AjPor0kwG7CF0TKzX+f9JttrXa/u/oq+PxMd10ZzfdyKdGrjXjy8N1st18Kb3mlZmstz
 5g2plKlEfr1hb6Djcdwtl4KTAOH/sADrvuMpWhnbmU94aaypxxgRBeLelGyuU72jIhPMGibQS
 tad+/vA+95axaCN8Yg3mJq7snA04ewQG6uhIwum5/SMDR82kxMlS6jBJNBhaZYhQl4WmaxESy
 zFfi4Lm3BDoq6Fh+PRkYYYm79pjqlGKSbpb7V5ZyiBfBto7yD4bqRY1su3k/ZM/MMjxiFZoRN
 nkb3L0g/zjXzo+dsm4TWWKh7d/X+fIlk23TIpSAXvHNhsqvLewYbkjIu66OgjEZbxKXo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Apr 2022 04:08:09 GMT Masahiro Yamada wrote:
> Do not update objects with version CRCs while the directory 
> descending.
> 
> Do it at the final link stage.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> ---
> 
>  scripts/Makefile.build    | 19 +++----------------
>  scripts/Makefile.modfinal |  3 ++-
>  scripts/link-vmlinux.sh   |  4 +++-
>  3 files changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index e03e85c90b26..aadc16e04632 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -162,12 +162,9 @@ ifdef CONFIG_MODVERSIONS
>  # o if <file>.o doesn't contain a __ksymtab version, i.e. does
>  #   not export symbols, it's done.
>  # o otherwise, we calculate symbol versions using the good old
> -#   genksyms on the preprocessed source and postprocess them in a way
> -#   that they are usable as a linker script
> -# o generate .tmp_<file>.o from <file>.o using the linker to
> -#   replace the unresolved symbols __crc_exported_symbol with
> -#   the actual value of the checksum generated by genksyms
> -# o remove .tmp_<file>.o to <file>.o
> +#   genksyms on the preprocessed source and dump them into .cmd file.
> +#   modpost will parse .cmd files to retrieve versions to create linker
> +#   scripts that are fed to the final linking of vmlinux or modules.
>  
>  # Generate .o.symversions files for each .o with exported symbols, and link these
>  # to the kernel and/or modules at the end.
> @@ -183,12 +180,6 @@ gen_symversions =								\
>  
>  cmd_gen_symversions_c =	$(call gen_symversions,c)
>  
> -cmd_modversions =								\
> -	if [ -r $@.symversions ]; then						\
> -		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
> -			-T $@.symversions;					\
> -		mv -f $(@D)/.tmp_$(@F) $@;					\
> -	fi
>  endif
>  
>  ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
> @@ -268,7 +259,6 @@ define rule_cc_o_c
>  	$(call cmd,checkdoc)
>  	$(call cmd,gen_objtooldep)
>  	$(call cmd,gen_symversions_c)
> -	$(if $(CONFIG_LTO_CLANG),,$(call cmd,modversions))
>  	$(call cmd,record_mcount)
>  endef
>  
> @@ -277,7 +267,6 @@ define rule_as_o_S
>  	$(call cmd,gen_ksymdeps)
>  	$(call cmd,gen_objtooldep)
>  	$(call cmd,gen_symversions_S)
> -	$(call cmd,modversions)
>  endef
>  
>  # Built-in and composite module parts
> @@ -291,8 +280,6 @@ ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
>  quiet_cmd_cc_prelink_modules = LD [M]  $@
>        cmd_cc_prelink_modules =						\
>  	$(LD) $(ld_flags) -r -o $@					\
> -               $(shell [ -s $(@:.prelink.o=.o.symversions) ] &&		\
> -                       echo -T $(@:.prelink.o=.o.symversions))		\
>  		--whole-archive $(filter-out FORCE,$^)			\
>  		$(cmd_objtool)
>  
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 7f39599e9fae..d429e3f9ae1d 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -34,6 +34,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o +=							\
>  	$(LD) -r $(KBUILD_LDFLAGS)					\
>  		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
> +		$(addprefix -T, $(filter %.symver.lds, $(real-prereqs)))\
>  		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  
> @@ -56,7 +57,7 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
>  
>  
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -$(modules): %.ko: %$(mod-prelink-ext).o %.mod.o scripts/module.lds $(if $(KBUILD_BUILTIN),vmlinux) FORCE
> +$(modules): %.ko: %$(mod-prelink-ext).o %.mod.o $(if $(CONFIG_MODVERSIONS), %.symver.lds) scripts/module.lds $(if $(KBUILD_BUILTIN),vmlinux) FORCE
>  	+$(call if_changed_except,ld_ko_o,vmlinux)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index d2c193f82004..66a115f204eb 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -90,7 +90,6 @@ modpost_link()
>  
>  		if is_enabled CONFIG_MODVERSIONS; then
>  			gen_symversions
> -			lds="${lds} -T .tmp_symversions.lds"
>  		fi
>  
>  		# This might take a while, so indicate that we're doing
> @@ -196,6 +195,9 @@ vmlinux_link()
>  	fi
>  
>  	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
> +	if is_enabled CONFIG_MODVERSIONS; then
> +		ldflags="${ldflags} ${wl}--script=vmlinux.symver.lds"
> +	fi
>  
>  	# The kallsyms linking does not need debug symbols included.
>  	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> -- 
> 2.32.0

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
