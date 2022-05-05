Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA451CA7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385788AbiEEUYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiEEUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:24:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0114B4BB8C;
        Thu,  5 May 2022 13:20:52 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGgRW-1na0dH2Qr4-00DsuE; Thu, 05 May 2022 22:19:45 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 2B3143C088; Thu,  5 May 2022 22:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651781982; bh=bg+HVLXZ4GeOEztHmsf/QJzV8C4FIObgcJiyzv+H0UM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAx9fB2NHoFbOqmE6IzPcukGKSh96UrYF6rKFC9M4htsjy3UYGxuyQw6ayrvxTE1R
         HbcOqeXamS48kIlbn2I5kDCN6+f+R7SaFOehW4a61Ip56uWYLaDwyN2s4imiUAzFuE
         aezSEmR+YT6F+jpOeNEh8WPL0bXstai+AlPRU1oA=
Date:   Thu, 5 May 2022 22:19:42 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 09/15] kbuild: stop merging *.symversions
Message-ID: <YnQxXsVKDZwj9ML7@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-10-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-10-masahiroy@kernel.org>
X-Provags-ID: V03:K1:kLv07Zu9KjSI8dVtarU8l8sxPufYBTVjB5tuKOltZ/T9hk437XX
 vNQ8NEBvRXubh7ts7FDOU2bMa4E55pDRJDTQNO77MACY5JbN+i20cUNkkZfWpaF6VKXKNsO
 K6ZEEHtGEvsnSVoXklrgpTo5J5l7CIEDsKJ4KoactoMHkKWNef3Lt1Zb6Uqthrmqhijy68i
 o6vPO+d07ACl7HYX2WrsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GEBew1HkSyw=:CtA2dALYABuAeqnB9s6zbz
 WOrkOByaGQn5pcQXLlYJM2W0SjTSxLOzGdZATyfGrSRH7h0O6V/HOp9oWzPg6xX9BKpKjRfOn
 IzWVAC9fLV+eqByCp5JRUpiImfbkHtks/O4PQjJjfjf+mw+CK+der90kd6OzfEP41/QFVd1kP
 iy7yqhYjAG1ixEkux1zPphXuSrfepTDIM5k2rAA/zLwT7Pf0cnlhCESbBcgZL5LjOh2dAYTV9
 IYkDFZq0yo4kBhkGibz85xtPz0L2Echql/qhbkWnZswwoALs6XjTkaYyIu6Jt8Sp0BrNlLwE2
 eGLy710OJ42xqDt1sGCZZczpo+ZjSUC1pbgFG6Lr198tjT/8EZgQZNNsw+caQ8OqUmXJEz89b
 IGxjrPuNhFxo4jLPceIrjw7I/UxkEHOlbvpBXFWHmHCn0LHBHGKwAEohy2mtbu9gErq48ktUG
 9MeCflRvY1pQyEytdMLaCm1jRgvZQTbhPrLP7K8xsjjhgiG8mC422czSvsktOQWd6T8Q+Ui1C
 Q3TZctSJ2xLF0gQMkExGmab4W9imwAAXop4ZuL4Pta0gslhicvoU3LrzpAWW+FScK5zfNp+eQ
 13LkT6YoChWDUfO1PogcQ6bSZlf7PwmjNy0lbIHtliTLRwupX5uEeysoyWib+0CY5ycIMBYBY
 q8ViV1QYV6Ct7wPgJCPvb4hHgOCtAr60Jh40I5rVKat8vlZw8F8wpZF+x6Jo0R/XDUQ4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:38PM +0900 Masahiro Yamada wrote:
> Now modpost reads symbol versions from .*.cmd files.
> 
> These merged *.symversions are not used any more.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v1)
> 
>  scripts/Makefile.build  | 21 ++-------------------
>  scripts/link-vmlinux.sh | 15 ---------------
>  2 files changed, 2 insertions(+), 34 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index ddd9080fc028..dff9220135c4 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -390,17 +390,6 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
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
> @@ -408,11 +397,8 @@ endif
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
> @@ -432,16 +418,13 @@ $(obj)/modules.order: $(obj-m) FORCE
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
> index 2742b7dd089a..07333181938b 100755
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
> @@ -299,7 +285,6 @@ cleanup()
>  	rm -f .btf.*
>  	rm -f .tmp_System.map
>  	rm -f .tmp_initcalls.lds
> -	rm -f .tmp_symversions.lds
>  	rm -f .tmp_vmlinux*
>  	rm -f System.map
>  	rm -f vmlinux
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
