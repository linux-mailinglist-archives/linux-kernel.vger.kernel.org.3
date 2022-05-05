Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484E51CA86
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385811AbiEEU17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384858AbiEEU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:27:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98CC5F8E0;
        Thu,  5 May 2022 13:24:13 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.98.182]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mz9EL-1o0vC22a9b-00wFu7; Thu, 05 May 2022 22:22:53 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 9326E3C088; Thu,  5 May 2022 22:22:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651782169; bh=gLnf95DDjaMYGCRgX6K1aWAnNa4DMAQkns7Hsushh60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5JqnzKqtCgrYbwEuOhr7agnhA9+gQXyvraZM/aNsViPYwCcmXRoB0dY8HOQW2LE5
         kRtHvppRbVwP87SX7/jDtlvgKxxbcffwdHVginnFLXVfXr1beojclNn2h078mxS1z1
         9QMmT/PWzqeujd3d3jGPQuxQtQuuSt//isIYhAZI=
Date:   Thu, 5 May 2022 22:22:49 +0200
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
Subject: Re: [PATCH v3 10/15] genksyms: adjust the output format to modpost
Message-ID: <YnQyGUlhvUIZwoNy@fjasle.eu>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
 <20220505072244.1155033-11-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-11-masahiroy@kernel.org>
X-Provags-ID: V03:K1:RUI2NxERijqBLuHI7G+nXGlaQN7ojuvdXw0yIKPmaAmlM/WXDvD
 z+undfnS5/BQmDavRN0dHs0z6ogRT8PP96LkZFU2gGTqewRhjkyZjh4El221JnzIHz6JwSJ
 FIhTrT6LlR9hlmohtlQUd6uMFu6QJ7kd2iTahnc9SV5tIegCWreRierRRGI87knT1tQKDev
 5SuWioT/YknSjZKC8ulFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jxZ5y2jNwbs=:j0VaPvAClzfPiR1zMMPS2V
 4Blib3kzqTqZt1lgsARx53lSLe9k1NMGOsYT5OVcHQu4avv8lOHyCqM9ge5kRBsupEaTAiEDp
 YZvw50YwnVmqQi2z5eHO7+xqfM2iaEAj8EwyYJV5eiCo34hRU0J2uw6Ci3L0x4cOjIIPgx9/1
 zrcgC0WyzTJt9xSdNOKt0ektBE71fExhkTfIvbB1iEOfhOHXpF8jd0Ymtb0E8gOpN5eWtnVnB
 wG6sDDKzE74ixKhLuiFNjzicAIlE4GuGpkzVaBidxwpjMmDm2UeZrWYuJPKY7s/x3CCknfg/8
 WZn/PYyJjRa3LU9540K7cbgLBLPtalY1P8OwfhLXDst1Rjrb4WzFa3YuV+2aw6QjxcQr99jxo
 YrA1gYvz6DCU9L+AZTrv+JYfyE7wGJqgW+qy11WUnp1Gobv3OoFfQOBFfqELZonNPBSZ4eE4U
 XtlQV1ubC6gXN8m7nhZY3WwKKOswQGQ+cfwMy9MkT95n+ctFcpxNJrqVNM4T+3z6t8srLnLiu
 0/Mwgj0E1+RWwtUWEpRSSLSBj7QOBfYMDywGzq5JMDZQbXNiB5yMXV7TM7WvPZVi2iO3EYdQQ
 6TMgU4M620I5XBRPj1A7DVrOvt4A/uVy2Y44MtohxyNtOCaq4srTazIQazf69a2RHeiYwmpaJ
 gyM61KOlwm1QMxusvpBmDh/WQ4qBNSIr1JDl4Ir2cAq1H3uxxCTd6skGJOE975VRrmMw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 04:22:39PM +0900 Masahiro Yamada wrote:
> Make genksyms output symbol versions in the format modpost expects,
> so the 'sed' is unneeded.
> 
> This commit makes *.symversions completely unneeded.
> 
> I will keep *.symversions in .gitignore and 'make clean' for a while.
> Otherwise, some people might be upset with 'git status'.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>   - New patch
> 
>  scripts/Makefile.build      | 6 ------
>  scripts/genksyms/genksyms.c | 3 +--
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index dff9220135c4..461998a2ad2b 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -165,16 +165,10 @@ ifdef CONFIG_MODVERSIONS
>  # o modpost will extract versions from that file and create *.c files that will
>  #   be compiled and linked to the kernel and/or modules.
>  
> -genksyms_format := __crc_\(.*\) = \(.*\);
> -
>  gen_symversions =								\
>  	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
>  		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
> -		    > $@.symversions;						\
> -		sed -n 's/$(genksyms_format)/$(pound)SYMVER \1 \2/p' $@.symversions \
>  			>> $(dot-target).cmd;					\
> -	else									\
> -		rm -f $@.symversions;						\
>  	fi
>  
>  cmd_gen_symversions_c =	$(call gen_symversions,c)
> diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
> index 6e6933ae7911..f5dfdb9d80e9 100644
> --- a/scripts/genksyms/genksyms.c
> +++ b/scripts/genksyms/genksyms.c
> @@ -680,8 +680,7 @@ void export_symbol(const char *name)
>  		if (flag_dump_defs)
>  			fputs(">\n", debugfile);
>  
> -		/* Used as a linker script. */
> -		printf("__crc_%s = 0x%08lx;\n", name, crc);
> +		printf("#SYMVER %s 0x%08lx\n", name, crc);
>  	}
>  }
>  
> -- 
> 2.32.0

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
