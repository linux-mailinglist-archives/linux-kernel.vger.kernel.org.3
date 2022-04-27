Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED5D5129B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiD1DFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiD1DFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:05:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E5825587;
        Wed, 27 Apr 2022 20:02:18 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.32]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McY0J-1oIQrJ3lWf-00cumw; Thu, 28 Apr 2022 04:56:12 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 7D1C33C088;
        Thu, 28 Apr 2022 04:56:11 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id D1CB9629; Wed, 27 Apr 2022 22:14:06 +0200 (CEST)
Date:   Wed, 27 Apr 2022 22:14:06 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 22/27] kbuild: generate a list of objects in vmlinux
Message-ID: <YmmkDoPsE5pfSxbG@bergen.fjasle.eu>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-23-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220424190811.1678416-23-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:zsQnuj5QPMduf9Z3utw/5/B4WqdrbKRtjktCwmitc2XZkk62u8q
 LpdWEqyOkLWcMqIRCQ7+JrSakoUJyzstD5TfkJmAe55nhDvUZu7zcnLvjWp8AINUmqs12v+
 Ge/ZVbpBV+87CxfVOKwDSNINol3XF61Mb0HjTdsFvHhkXrEke6ep9h7gl+JHX0UQ3PbUxvc
 ktOX6muIDH3NYCqrIuJ/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GaNRZgc9xEo=:AxQoY+wyOs38HQF/iVPamf
 cvJ5mafdzNYXrJ6e0jyb8NaLrvB6LCPrVPUBk7E2S+uqPF9OH+1i1hiYRvTq4hqm/qBSf9//f
 1dF3AT4ALFFEKSX8Y4XpQKC7uc8m62mV9PzWZe3HAYEGJx5gGLLHj4kumFVjVh0wB0UMaZhp0
 GkCZsQ3PuFc2MBP3QQRohJDCL3UuulLGK3xBoZL9FgmCp1t+rCLdEcEvIG5Ni2H0PD4YWXWvE
 XpkMjfvZtB1GoM1ACAk+Nzz3POVp8JSVSxXaVQWLQElNhxtEzYXzyMDD7zZAhIMyYbYZB18O7
 xlxKEA3MFra0p1ArahhmfCOk2sE4lN+rGue19A9hyoci1eAoqzP4aPOL+lzztoJjN5z38pGf2
 78K05KdnWdeynvFycaimqO4sYfjg2hHvhpVERYjCPjNSzVqUo+0TmuYiMMWFOJTkhLNK6gWmI
 oL4G7yEPaMwdL5juNYRE3zB56CDZZ8zqPhlhvH8z+kWXaA6tB0rdKMBMz07oz2KRUp8ZMqCZ/
 EWTmGWfMFpPRwFRsEHtapXy9HWAVcGQSGPArMrO8qwWtJq3GaFCLKjR1LamJNQe2puGzpn1uF
 ozec0H2QXdsWv8A0XJthpPyR+CsJlxSQAj6G0om7AwPbO+85JiBUAtsq3EgKcxgz0T++nbvgc
 s5LvTH8694Gsaus/7d6KN1lGZKx218HjDYIMaFk2eqCJObWSxxYWijhJZZ+wnLGUnFOM=
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25 Apr 2022 04:08:06 GMT Masahiro Yamada wrote:
> A *.mod file lists the member objects of a module, but vmlinux does
> not have such a file to list out all the member objects.
> 
> Generate this list to allow modpost to know all the member objects.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/link-vmlinux.sh | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 20f44504a644..d2c193f82004 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -310,7 +310,7 @@ cleanup()
>  	rm -f vmlinux
>  	rm -f vmlinux.map
>  	rm -f vmlinux.o
> -	rm -f .vmlinux.d
> +	rm -f .vmlinux*

Wouldn't it be safer to keep the removal of .vmlinux.d for some time 
and just add .vmlinux.objs?  Somehow I do not like the wildcard here.

>  }
>  
>  # Use "make V=1" to debug this script
> @@ -342,6 +342,19 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
>  modpost_link vmlinux.o
>  objtool_link vmlinux.o
>  
> +# Generate the list of objects in vmlinux
> +rm -f .vmlinux.objs
> +for f in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
> +	case ${f} in
> +	*.a)
> +		${AR} t ${f} >> .vmlinux.objs
> +		;;
> +	*)
> +		echo ${f} >> .vmlinux.objs
> +		;;
> +	esac
> +done

just some bike shedding comment:  I would have left out the 'rm -f 
.vmlinux.objs' and moved the redirection to the end of the for loop:

for f in ...
    ...
    ${AR}
    echo
done > .vmlinux.objs

but it probably not worth.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> +
>  # modpost vmlinux.o to check for section mismatches
>  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
>  
> -- 
> 2.32.0

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
