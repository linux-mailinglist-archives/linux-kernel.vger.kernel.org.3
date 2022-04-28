Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142D85129EA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiD1DY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiD1DYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:24:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA16AA63;
        Wed, 27 Apr 2022 20:21:03 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.32]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1x6X-1nr2Kj3Je5-012Dp4; Thu, 28 Apr 2022 05:15:08 +0200
Received: from bergen.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 5E5083C01C;
        Thu, 28 Apr 2022 05:15:07 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Date:   Thu, 28 Apr 2022 05:15:05 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 26/27] kbuild: stop generating *.symversions
Message-ID: <YmoGuY82c/gGI/sU@bergen.fjasle.eu>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-27-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220424190811.1678416-27-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:gbHouD07L/PQUpTRm4orTLoT+o2OS/usSaPG2jhdtKV8sV7qETK
 9BfS/o5MzfNuuQc/BllWsHldXuTWCCDhW5cTPQpiiOGx/bjigUCXGTZ6fihetoDlczKHs2q
 Kx9nFh16eeBhmOUkZr15LBaDWLP6iGr3Ykhfu+6Rr7i0tk0tX29eA2RegKIFSh9Dx22vYV+
 biqB67Muvia256YiieAbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p+yQQ+jwB00=:pnfBz+gG1Ny95WMEQBA6K2
 Mt2Wm7T9s4cB4AxS55ybu6zCLqauWxf2v9i9xPs422LUIb66LfLWGuEeBumwexXv0zap04dZP
 OECEoV2CAXVFtrYigKxQVzsZRcVwZWOJwk+70Dh+y13UvcZDtV1bAyLHv7LUP69ng6PQUCEAZ
 kwkkpGELmYuhHm26xaNvANEDKxUVvv4MWyKI+SHddRigJdBGejKehBHv9XRq1kP708t1CdZtt
 FE/Uhh289nUMJy17HO1F2VbKxfSTWjCjEmHy+ctBvGO45yxNVl4lQH6qSKzPogp2udHYj4LrD
 n22LWWMmR0nFit1Z/DQ/WJM1CULpjVCqVIjHeO9zH1Lgz/eHw40HjtF0LVgKz583R5cu4KjRE
 aVL2NI4DhPqEeG4r3s8Pwli4uyrqhM/8JioG9iE1GPvH6UrB0iBr6snHZFI7PaFAkBoc3cp7z
 ZFPtDoJS6qKtQap2nYfF/O65lRNVxhXzqn7jFxbPXD/ZrYKlZgKkDE5XzriE0BWqUYHSo4OMN
 fZ7LbayX4LbXGdjqTK0Z644FyilmnmYXeYFgifRipIYbGI/AGT6ci6hHcfERhkp5MsK/ehAt1
 1sfBvEx4NusP/eGa0dGpJ+x1Fu2UOKqxF8tcYD4EDWwv/Mbt/cKrTkmsIqIE7ltwb/xmvVHe3
 hsGV+VHduQjq26076m5Onyq0ru91q3/h/lqc/qct4i05gHlTgVRy2374yGOmrvOz4FkU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Apr 2022 04:08:10 GMT Masahiro Yamada wrote:
> Now *.symversions is unneeded. Clean up the Makefile and script.
> 
> I will keep *.symversions in .gitignore and 'make clean' for a while
> to avoid flooding the output from 'git status'.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.build  | 28 ++++------------------------
>  scripts/link-vmlinux.sh | 19 -------------------
>  2 files changed, 4 insertions(+), 43 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index aadc16e04632..7f199b0a5170 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -170,12 +170,9 @@ ifdef CONFIG_MODVERSIONS
>  # to the kernel and/or modules at the end.
>  gen_symversions =								\
>  	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
> -		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
> -		    > $@.symversions;						\
>  		echo >> $(dot-target).cmd ;					\
> -		sed 's/\(.*\) = \(.*\);/$(pound)\1=\2/' $@.symversions >> $(dot-target).cmd ; \
> -	else									\
> -		rm -f $@.symversions;						\
> +		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) | \
> +		sed 's/\(.*\) = \(.*\);/$(pound)\1=\2/' >> $(dot-target).cmd ; \

I was wondering, whether we should integrate the 'sed' part into 
genksyms and make it output the lines as we need them.
If genksyms fails, we now don't see any error code and make will 
silently continue as the pipe hides genksyms' exit code, right?

>  	fi
>  
>  cmd_gen_symversions_c =	$(call gen_symversions,c)
> @@ -391,17 +388,6 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
>  $(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
>  $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
>  
> -# combine symversions for later processing
> -ifeq ($(CONFIG_LTO_CLANG) $(CONFIG_MODVERSIONS),y y)
> -      cmd_update_lto_symversions =					\
> -	rm -f $@.symversions						\
> -	$(foreach n, $(filter-out FORCE,$^),				\
> -		$(if $(shell test -s $(n).symversions && echo y),	\
> -			; cat $(n).symversions >> $@.symversions))
> -else
> -      cmd_update_lto_symversions = echo >/dev/null
> -endif
> -
>  #
>  # Rule to compile a set of .o files into one .a file (without symbol table)
>  #
> @@ -409,11 +395,8 @@ endif
>  quiet_cmd_ar_builtin = AR      $@
>        cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
>  
> -quiet_cmd_ar_and_symver = AR      $@
> -      cmd_ar_and_symver = $(cmd_update_lto_symversions); $(cmd_ar_builtin)
> -
>  $(obj)/built-in.a: $(real-obj-y) FORCE
> -	$(call if_changed,ar_and_symver)
> +	$(call if_changed,ar_builtin)
>  
>  #
>  # Rule to create modules.order file
> @@ -433,16 +416,13 @@ $(obj)/modules.order: $(obj-m) FORCE
>  #
>  # Rule to compile a set of .o files into one .a file (with symbol table)
>  #
> -quiet_cmd_ar_lib = AR      $@
> -      cmd_ar_lib = $(cmd_update_lto_symversions); $(cmd_ar)
>  
>  $(obj)/lib.a: $(lib-y) FORCE
> -	$(call if_changed,ar_lib)
> +	$(call if_changed,ar)
>  
>  ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
>  quiet_cmd_link_multi-m = AR [M]  $@
>  cmd_link_multi-m =						\
> -	$(cmd_update_lto_symversions);				\
>  	rm -f $@; 						\
>  	$(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
>  else
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 66a115f204eb..e2900d3bd215 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -56,20 +56,6 @@ gen_initcalls()
>  		> .tmp_initcalls.lds
>  }
>  
> -# If CONFIG_LTO_CLANG is selected, collect generated symbol versions into
> -# .tmp_symversions.lds
> -gen_symversions()
> -{
> -	info GEN .tmp_symversions.lds
> -	rm -f .tmp_symversions.lds
> -
> -	for o in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
> -		if [ -f ${o}.symversions ]; then
> -			cat ${o}.symversions >> .tmp_symversions.lds
> -		fi
> -	done
> -}
> -
>  # Link of vmlinux.o used for section mismatch analysis
>  # ${1} output file
>  modpost_link()
> @@ -88,10 +74,6 @@ modpost_link()
>  		gen_initcalls
>  		lds="-T .tmp_initcalls.lds"
>  
> -		if is_enabled CONFIG_MODVERSIONS; then
> -			gen_symversions
> -		fi
> -
>  		# This might take a while, so indicate that we're doing
>  		# an LTO link
>  		info LTO ${1}
> @@ -306,7 +288,6 @@ cleanup()
>  	rm -f .btf.*
>  	rm -f .tmp_System.map
>  	rm -f .tmp_initcalls.lds
> -	rm -f .tmp_symversions.lds
>  	rm -f .tmp_vmlinux*
>  	rm -f System.map
>  	rm -f vmlinux
> -- 
> 2.32.0

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
