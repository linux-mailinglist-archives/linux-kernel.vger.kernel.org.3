Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8C4F51E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241322AbiDFCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343513AbiDEVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:08:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C805BD1C;
        Tue,  5 Apr 2022 13:31:05 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.95]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5mWp-1o5B8m2oLj-017DNW; Tue, 05 Apr 2022 22:30:23 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 018F03C088; Tue,  5 Apr 2022 22:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1649190622; bh=DX62SSsISLuuln7TZSR9FaC5LWO7vlCWQ0XdkzidmXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nAxX3OTmG7kkIlLeMHsrIB1FhgH9Gr/1Q9S0VFOdeRZshR2vAZu2bhFoN2dYjnRA+
         7FJLUakzGS/RbWlcmOj/OamKH7wR2clnFGKXebTmNkoOqtlSFfEGFo5xWz3gcVDF/G
         ADMZYRx4oj4TRatIru+axnwN71ww/ABxgEcN6IY0=
Date:   Tue, 5 Apr 2022 22:30:21 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <n.schier@avm.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v2 08/10] kbuild: split the second line of *.mod into
 *.usyms
Message-ID: <Ykym3cR3Dl+oCfk5@fjasle.eu>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
 <20220405113359.2880241-9-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405113359.2880241-9-masahiroy@kernel.org>
X-Provags-ID: V03:K1:FIvsU+foxbUbH0O99T+Jc+XwRBNoie17D5nAmMlxPXsVB+HFqKH
 TyEFkYt/nB5RoRTCHHOHTdKT3lBBhiXfCIZnidFakE7G6WWjjJEf7BOztuApjJXaaJvSpm0
 kdToF7XB2iNjcNV5i8iN4ZjJlRBFuss2Sq/qtK+Gpo/42XJmF1wTQAUP7ZWnGhf81uyRB6G
 M+3pl3Ghj/M4eAY26P0Uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:73c8PWeDCdo=:NuwPumFewg4g3gQG2fWV9l
 PlsHe/4JN8M5fosbJHvWFA4OP3JE+tZHUMELAhZUXstYtz+akcU9+2RoXxiqNhDYIk2d6SUCu
 LQW+S/xKF3/syoCSmPimHoOYD2jnnRa/IERod2WsjGuAu3s9cH0ltJsyGHqDUekUo6NcKe2nr
 8/0LOPUuMsVka6p44dLyJnD7TaeP2TDwMILYPZDD58jjIisgq7ir0QgUrzqjhPgUOWD96808d
 fyudldRp21MR4SOz7lj9/4izpJATFCUoInFDu3ukD/wdBMYCNeE0gbiq+xhyBLQU9bkcdRdCb
 UchK+esrZjodwjOBJbs1XPUeaWkuN+0JLv7EkfmaAIQaYsjXBGMXSLvM6w0KkO0oC1eR+DvVV
 zNHa/mKsdz8eoEXy8yBwvFSCHxrP6/3heQeJkSpeco3HzlgFiMt/2ZtQ1iKoKGzeDzcWqsKEF
 Y4TWkDQ4CcKpMiQrogbLuzAdXFDMI9GJnjoOGjbkksgY9bMz344JftdBdHXNz79NYMOWqlLWw
 OmXuwu5xwN8fyKPZA+GTCfc2rogsZTkjDi2FAC0cKIC1u+bZguknAehv8M32wBZ0RGmC1QsPj
 QnFC7h2q+W90RBbutEnbm7a6nix4h0fQZvff3/XunTdeAeAt8z/5ED3SMNHXHh2N3V8AKwtD3
 zMwb3YeWKAGPpSTCkBeNwk5FRFOY/1SvxfhX9dx1RxuAnBgW/oUybLzCsx9HDgbsqqQ0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:33:56PM +0900 Masahiro Yamada wrote:
> The *.mod files have two lines; the first line lists the member objects
> of the module, and the second line, if CONFIG_TRIM_UNUSED_KSYMS=y, lists
> the undefined symbols.
> 
> These two are orthogonal. For further cleanups, lets' split the second

s/lets'/let's/  ?

> line out to separate *.usyms files, which are generated only when
> CONFIG_TRIM_UNUSED_KSYMS=y.
> 
> Previously, the list of undefined symbols ended up with a very long
> line, but now symbols are split by new lines.
> 
> Use 'sed' like we did before commit 7d32358be8ac ("kbuild: avoid split
> lines in .mod files").
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - new
> 
>  .gitignore                  |  1 +
>  Makefile                    |  2 +-
>  scripts/Makefile.build      | 17 +++++++++--------
>  scripts/adjust_autoksyms.sh |  2 +-
>  scripts/gen_autoksyms.sh    | 18 +++++++++++-------
>  scripts/mod/sumversion.c    | 11 ++---------
>  6 files changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 7afd412dadd2..265959544978 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -45,6 +45,7 @@
>  *.symversions
>  *.tab.[ch]
>  *.tar
> +*.usyms
>  *.xz
>  *.zst
>  Module.symvers
> diff --git a/Makefile b/Makefile
> index d9336e783be3..82ee893909e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1848,7 +1848,7 @@ clean: $(clean-dirs)
>  		-o -name '*.ko.*' \
>  		-o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
>  		-o -name '*.dwo' -o -name '*.lst' \
> -		-o -name '*.su' -o -name '*.mod' \
> +		-o -name '*.su' -o -name '*.mod' -o -name '*.usyms' \
>  		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
>  		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
>  		-o -name '*.asn1.[ch]' \
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 63625877aeae..d934bdf84de4 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -85,7 +85,8 @@ ifdef need-builtin
>  targets-for-builtin += $(obj)/built-in.a
>  endif
>  
> -targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
> +targets-for-modules := $(foreach suffix, mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
> +				$(patsubst %.o, %.$(suffix), $(filter %.o, $(obj-m))))
>  
>  ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
>  targets-for-modules += $(patsubst %.o, %.prelink.o, $(filter %.o, $(obj-m)))
> @@ -260,9 +261,6 @@ endif
>  ifdef CONFIG_TRIM_UNUSED_KSYMS
>  cmd_gen_ksymdeps = \
>  	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
> -
> -# List module undefined symbols
> -undefined_syms = $(NM) $< | $(AWK) '$$1 == "U" { printf("%s%s", x++ ? " " : "", $$2) }';
>  endif
>  
>  define rule_cc_o_c
> @@ -309,14 +307,17 @@ endif
>  
>  multi-m-prereqs = $(sort $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)))
>  
> -cmd_mod = { \
> -	echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=.o)); \
> -	$(undefined_syms) echo; \
> -	} > $@
> +cmd_mod = echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=.o)) > $@
>  
>  $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
>  	$(call if_changed,mod)
>  
> +# List module undefined symbols
> +cmd_undefined_syms = $(NM) $< | sed -n 's/^  *U //p' > $@
> +
> +$(obj)/%.usyms: $(obj)/%$(mod-prelink-ext).o FORCE
> +	$(call if_changed,undefined_syms)
> +
>  quiet_cmd_cc_lst_c = MKLST   $@
>        cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
>  		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> index 59fdb875e818..f1b5ac818411 100755
> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -35,7 +35,7 @@ case "$KBUILD_VERBOSE" in
>  esac
>  
>  # Generate a new symbol list file
> -$CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh "$new_ksyms_file"
> +$CONFIG_SHELL $srctree/scripts/gen_autoksyms.sh --modorder "$new_ksyms_file"
>  
>  # Extract changes between old and new list and touch corresponding
>  # dependency files.
> diff --git a/scripts/gen_autoksyms.sh b/scripts/gen_autoksyms.sh
> index 120225c541c5..faacf7062122 100755
> --- a/scripts/gen_autoksyms.sh
> +++ b/scripts/gen_autoksyms.sh
> @@ -2,13 +2,10 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  
>  # Create an autoksyms.h header file from the list of all module's needed symbols
> -# as recorded on the second line of *.mod files and the user-provided symbol
> -# whitelist.
> +# as recorded in *.usyms files and the user-provided symbol whitelist.
>  
>  set -e
>  
> -output_file="$1"
> -
>  # Use "make V=1" to debug this script.
>  case "$KBUILD_VERBOSE" in
>  *1*)
> @@ -16,6 +13,15 @@ case "$KBUILD_VERBOSE" in
>  	;;
>  esac
>  
> +read_modorder=
> +
> +if [ "$1" = --modorder ]; then
> +	shift
> +	read_modorder=1
> +fi
> +
> +output_file="$1"
> +
>  needed_symbols=
>  
>  # Special case for modversions (see modpost.c)
> @@ -41,10 +47,8 @@ cat > "$output_file" << EOT
>  
>  EOT
>  
> -[ -f modules.order ] && modlist=modules.order || modlist=/dev/null
> -
>  {
> -	sed 's/ko$/mod/' $modlist | xargs -n1 sed -n -e '2p'
> +	[ -n "${read_modorder}" ] && sed 's/ko$/usyms/' modules.order | xargs cat
>  	echo "$needed_symbols"
>  	[ -n "$ksym_wl" ] && cat "$ksym_wl"
>  } | sed -e 's/ /\n/g' | sed -n -e '/^$/!p' |
> diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
> index 905c0ec291e1..0125698f2037 100644
> --- a/scripts/mod/sumversion.c
> +++ b/scripts/mod/sumversion.c
> @@ -387,7 +387,7 @@ static int parse_source_files(const char *objfile, struct md4_ctx *md)
>  /* Calc and record src checksum. */
>  void get_src_version(const char *modname, char sum[], unsigned sumlen)
>  {
> -	char *buf, *pos, *firstline;
> +	char *buf;
>  	struct md4_ctx md;
>  	char *fname;
>  	char filelist[PATH_MAX + 1];
> @@ -397,15 +397,8 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
>  
>  	buf = read_text_file(filelist);
>  
> -	pos = buf;
> -	firstline = get_line(&pos);
> -	if (!firstline) {
> -		warn("bad ending versions file for %s\n", modname);
> -		goto free;
> -	}
> -
>  	md4_init(&md);
> -	while ((fname = strsep(&firstline, " "))) {
> +	while ((fname = strsep(&buf, " \n"))) {
>  		if (!*fname)
>  			continue;
>  		if (!(is_static_library(fname)) &&
> -- 
> 2.32.0
> 
> 

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
