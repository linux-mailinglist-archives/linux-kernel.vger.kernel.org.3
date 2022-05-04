Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2B51AEFB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377997AbiEDU12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiEDU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:27:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD15D4F44C;
        Wed,  4 May 2022 13:23:38 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.211]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPowd-1nQ1aU0uUl-00MqjQ; Wed, 04 May 2022 22:23:05 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 665993C01C;
        Wed,  4 May 2022 22:23:01 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 36837724; Wed,  4 May 2022 22:22:59 +0200 (CEST)
Date:   Wed, 4 May 2022 22:22:59 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 21/26] genksyms: adjust the output format for .cmd
 files
Message-ID: <YnLgo+y5tR86hBL5@bergen.fjasle.eu>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
 <20220501084032.1025918-22-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220501084032.1025918-22-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:My2Sy57WDCTl+dHhJAdllzvu0KkMWTC94Kpwc583XPVyqzWdbyt
 rx4oxJ1qrfOO0hffaL2uuG2tVwm7cooY3DxFloeuGV+7r+Gm3RuyzkQcbhqSiIbGLshkAcz
 borSfPWEKWusn7FdJ36OJgN/ciUOVOY0cnd3ekHolVw6mDyOaPrC+KqOImrOCCkhTNJQzEq
 G+W3FukXpmdW6p46olmlQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6vHfwB7BZzQ=:ociXP/tp4QcKx+kYpZn9fE
 I0EIbmMcEF/uIT1iUypRY5Umi8DuiREmdU/PM7s/dxgGURy8mO2MQBB/lIwjwecLVOOZRrwhu
 Oc6Mgp1fu/Ys8Rdc0ZfWUHyWlNNv6kvBzD17T7lyekl3lNR0HK5qqbdoA05EwZSheTxC8m/q+
 POxjwvoJwSwlpGVl1w4bD9U5TNE7VCtcBYmY42+8KPDi0XyZCfYvN7TAhwD2nKN1Hhot/Vajy
 j3eFbCB1CTsNKxK+wvPL3JBb8XalwWAnRp1g4S00osQ0t2Dc9Xlo/AlTq76Q+h24lXsDY33ZC
 454NqWT91OM5mLYpgBEIh3OuKJd2cnkQNN3JKoq3sVBU1ZmSOcKPzGCtkcWZHtsfegcziElGi
 ZF/8aHkiL4mlF4egeoVmNxul2v7VsqBnmiHEyMMp3FeuVOrd9bcNz0Bpjf1+jd8iaHo2c3eMJ
 L4/0UllON57/Zzid5itSQCQHQ6TYHz0X8R0fG7Z2fOfpax/YRI+K1CJCAU1rZXJyOeaBFk9xv
 UNlVNBcdVoDD25CxW0QbPbEeI+c/YZ739HGFhB+uaZkMTmQ7loPlpdGzUHvQvc9e6aY7cqiuJ
 n43D0He7j9y26k/mz8+BF4yHOWoUIJKjf/M2DUZiuLETJB0L+FRLJi78flR5Wf67+3Sx7Sm0o
 2yTlh3EkmB4rWLh/mc7fTwdJXedvveXcdTYgFWnlHpX/nYdp5PwVGPhYjyI9TMILD0j4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sø. 01. mai 2022 kl. 17.40 Masahiro Yamada wrote:
> genksyms output symbol versions in the linker script format.

output -> outputs ?

> The output format depends on CONFIG_MODULE_REL_CRCS.

Looking at the patch itself, I think the sentence above should be 
inverted, as all rel_crc special handling is removed.  Or did I get it 
wrong?

Kind regards,
Nicolas

> 
> Now, symbol versions are passed to modpost as plain text data,
> we can simplify the genksyms code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - New patch
> 
>  scripts/Makefile.build      |  9 ---------
>  scripts/genksyms/genksyms.c | 17 ++++-------------
>  2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 10092efb61ac..1f480e4ff70a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -128,7 +128,6 @@ $(obj)/%.i: $(src)/%.c FORCE
>  
>  genksyms = scripts/genksyms/genksyms		\
>  	$(if $(1), -T $(2))			\
> -	$(if $(CONFIG_MODULE_REL_CRCS), -R)	\
>  	$(if $(KBUILD_PRESERVE), -p)		\
>  	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
>  
> @@ -166,18 +165,10 @@ ifdef CONFIG_MODVERSIONS
>  # o modpost will extract versions from the .cmd file and create linker
>  #   scripts used to link the kernel and/or modules.
>  
> -genksyms_format_rel_crc := [^_]*__crc_\([^ ]*\) = \.; LONG(\([^)]*\)).*
> -genksyms_format_normal := __crc_\(.*\) = \(.*\);
> -genksyms_format := $(if $(CONFIG_MODULE_REL_CRCS),$(genksyms_format_rel_crc),$(genksyms_format_normal))
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
> index 4827c5abe5b7..ec5ad4405483 100644
> --- a/scripts/genksyms/genksyms.c
> +++ b/scripts/genksyms/genksyms.c
> @@ -33,7 +33,7 @@ char *cur_filename;
>  int in_source_file;
>  
>  static int flag_debug, flag_dump_defs, flag_reference, flag_dump_types,
> -	   flag_preserve, flag_warnings, flag_rel_crcs;
> +	   flag_preserve, flag_warnings;
>  
>  static int errors;
>  static int nsyms;
> @@ -680,11 +680,7 @@ void export_symbol(const char *name)
>  		if (flag_dump_defs)
>  			fputs(">\n", debugfile);
>  
> -		/* Used as a linker script. */
> -		printf(!flag_rel_crcs ? "__crc_%s = 0x%08lx;\n" :
> -		       "SECTIONS { .rodata : ALIGN(4) { "
> -		       "__crc_%s = .; LONG(0x%08lx); } }\n",
> -		       name, crc);
> +		printf("#SYMVER %s 0x%08lx\n", name, crc);
>  	}
>  }
>  
> @@ -745,7 +741,6 @@ static void genksyms_usage(void)
>  	      "  -q                    Disable warnings (default)\n"
>  	      "  -h                    Print this message\n"
>  	      "  -V                    Print the release version\n"
> -	      "  -R                    Emit section relative symbol CRCs\n"
>  #endif				/* __GNU_LIBRARY__ */
>  	      , stderr);
>  }
> @@ -766,14 +761,13 @@ int main(int argc, char **argv)
>  		{"preserve", 0, 0, 'p'},
>  		{"version", 0, 0, 'V'},
>  		{"help", 0, 0, 'h'},
> -		{"relative-crc", 0, 0, 'R'},
>  		{0, 0, 0, 0}
>  	};
>  
> -	while ((o = getopt_long(argc, argv, "s:dwqVDr:T:phR",
> +	while ((o = getopt_long(argc, argv, "s:dwqVDr:T:ph",
>  				&long_opts[0], NULL)) != EOF)
>  #else				/* __GNU_LIBRARY__ */
> -	while ((o = getopt(argc, argv, "s:dwqVDr:T:phR")) != EOF)
> +	while ((o = getopt(argc, argv, "s:dwqVDr:T:ph")) != EOF)
>  #endif				/* __GNU_LIBRARY__ */
>  		switch (o) {
>  		case 'd':
> @@ -813,9 +807,6 @@ int main(int argc, char **argv)
>  		case 'h':
>  			genksyms_usage();
>  			return 0;
> -		case 'R':
> -			flag_rel_crcs = 1;
> -			break;
>  		default:
>  			genksyms_usage();
>  			return 1;
> -- 
> 2.32.0

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
