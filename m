Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FB4F51CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847330AbiDFCR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbiDEUVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:21:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BBE6D3AB;
        Tue,  5 Apr 2022 13:02:18 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.95]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MowbA-1oLKrN1jnq-00qRec; Tue, 05 Apr 2022 22:01:47 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 9FC753C088; Tue,  5 Apr 2022 22:01:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1649188905; bh=eY863nX6Wwm9mRLnYYO3fHmkdfyGXTQ/xmghOew0Aq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRzP/jC2U0TBV/y9qU7jvuyjvnYNFoVu+PaxXKHDnOPeAyPjiDMxtTbOpIXIPNOLm
         Bw/nf5iOaa2bfd+QbCcESV5xXACBvrQsPqWBFhetN/pl+VIkWEKVeo+lcfu505zarQ
         fVylTX0MSNyHbU9BEa5rF/WZBqw9gKHXCScljF/s=
Date:   Tue, 5 Apr 2022 22:01:45 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 02/10] kbuild: do not remove empty *.symtypes
 explicitly
Message-ID: <YkygKePc7rP7PqRL@fjasle.eu>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
 <20220405113359.2880241-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405113359.2880241-3-masahiroy@kernel.org>
X-Provags-ID: V03:K1:bDL5eBqGX7rbdQEDVAOTpQN78dDLoeQsBTsbAxRMYGrqncp4UpA
 0tp2HUnKCSpKwCO7lsFf2K4SW0yy4YVH78zKlJXTSFMFKQNna44o6tjHosimqiHWvJmM/yf
 k+UorR/A6X4f+0ofsvF9Nx/RYaTYeuVTXLUJGowtsCwygdWBrS8V2q7jcWY50WW0vM3hb3q
 msLviDTyn3rZ6WPpybHew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kfo+ApJN/Xg=:9W8ueTzpf48J6m6653QZmS
 Kh2OoumupOQD/q95qodTclT3jX4k1SqZAbncIHkLcX4auc+uiXPGukTkWd2k1D5DrF+WNd7My
 1bnDhOTM4SdRtAF4RiPHZZr83AeDIZZqS03rwS+FKioXxCggL1/ekAN2oZULyboyRlg9rtEVt
 ld55iQu1FNN8lRqgqMMQAK5I5VvlrclrTMPNi5zBQshz9WwurhvWd0/Hv5wEPHfVficIjsl10
 dHVaNqC+GlGuVn1wN5si+IZg+UVcvxTs5yoJVDoVeiOfrk5zrdjRSdb/zz85BImuc39A69r25
 SuGjM6gDPi7epOtUv4BwZ243nVX5gR8GaWYQyjmqT3H5D5rs/Tw2pKiIgWb4v3vz3WXNtnbCW
 nZr6MJsJnD0l0iB4dqehH8tw3cJTMaFDLHSL0bmaJBUx8UIxzW3IFqbVxpMTbpSvPOVTijMX+
 dXpADCeJnOwW0tt8a6XN+KzAF2bbQWX8EsAV3M/YVJAjdlukuxZOBGnFzaRWKLxs34h7Y6cE9
 4tv0ijHJ62G1fcJggmqmc8qjb6H8bNG0w8LXrqLISm17ibYgK97+1htFTdXDrWsyo1dTNKteh
 NqAQ//D5L3gPPSc5NfSwk5Q/J9nk2WvnmINGbc9vQIgo8Zu7fepauRaMmC5qgssHsWzdwZIwc
 FsN9LoYdJKQhdFPLzPS2FORaXrwdoNLC14ltH5PZyCny6gppIvWRh0xgREezuCb2LORc=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:33:50PM +0900 Masahiro Yamada wrote:
> Presumably, 'test -s $@ || rm -f $@' intends to remove the output when
> the genksyms command fails.
> 
> It is unneeded because .DELETE_ON_ERROR automatically removes the output
> on failure.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> 
> Changes in v2:
>   - Fix accidental drop of '> /dev/null'
> 
>  scripts/Makefile.build | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 31e0e33dfe5d..3ef2373f0a57 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -135,9 +135,7 @@ genksyms = scripts/genksyms/genksyms		\
>  cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
>  
>  quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
> -cmd_cc_symtypes_c =                                                         \
> -    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
> -    test -s $@ || rm -f $@
> +      cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@) >/dev/null
>  
>  $(obj)/%.symtypes : $(src)/%.c FORCE
>  	$(call cmd,cc_symtypes_c)
> @@ -348,9 +346,7 @@ cmd_gensymtypes_S =                                                         \
>      $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
>  
>  quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
> -cmd_cc_symtypes_S =                                                         \
> -    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
> -    test -s $@ || rm -f $@
> +      cmd_cc_symtypes_S = $(call cmd_gensymtypes_S,true,$@) >/dev/null
>  
>  $(obj)/%.symtypes : $(src)/%.S FORCE
>  	$(call cmd,cc_symtypes_S)
> -- 
> 2.32.0
> 
> 

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
