Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176184F51D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848413AbiDFCWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbiDEUpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:45:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9AD9EB5;
        Tue,  5 Apr 2022 13:22:23 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.95]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxV4T-1nvrQ50Jpp-00xpap; Tue, 05 Apr 2022 22:16:20 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 13DF73C088; Tue,  5 Apr 2022 22:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1649189778; bh=GPfCvVD2BrdOXMdNnxNrFcntwH8cnF/qTfQuCuV8YzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCVPqPQLOy4IRjuET4veOmGPaRaH8zVgC8X5Q//kiDNo254elLsNsrH/jF+A4SfDu
         fJZol9+js3503xEoh7PNBYfKbO4LsyncqVXwuiW/p1Pz591LUO4stHSWT9jb6f0fpS
         LwxB4TC/8gRUaXeB6joOFiKkqPwVjCg78ukR8ZIw=
Date:   Tue, 5 Apr 2022 22:16:16 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 07/10] kbuild: get rid of duplication in the first
 line of *.mod files
Message-ID: <YkyjkAWb56wqL3iK@fjasle.eu>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
 <20220405113359.2880241-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405113359.2880241-8-masahiroy@kernel.org>
X-Provags-ID: V03:K1:rFb6rOPGOYf54rAUdi4Z7QmLIEC3PNtz5bjBHKiS5S9kz/rp0KY
 IFv++Z8xORrnNoHxVlKCCwBFePfvbMorNonoqK+eS37J6mA0sVrUMi5KhrL+g8s38nFS+it
 jaAii3I6IpoNQwagGGA/fzFzKXA4tIs3r2YX7NcLWQV/jDfiPZzrKBJHQo4UaW/xEY0twmi
 fVbOPGXwmVOOeNcIh86/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ac6prOacJsQ=:p+T22kYzZjC80rzUVrllUV
 ji899ZO6uA6RoUtAgYk8IZZV1v6/Il8KGEN8e1kPelzhvp6QSHSRdBmykibXrRbBFG41xQeP1
 gOjOlFnoKvE7DNqn7H0cwQVD6g0lHHsU2mElvBL73v8gU7JruB4viokTp2JJjTcX1ejdRnMQ4
 M/5/8h3Fy6ECkDYQeiMf8/wxuFx/JsVCFil1toUGlGuRs8q/30p1U6Z1hbyLlMewwea18iHfg
 uHrl4pFb88gS3XRed7Q4/v4gPqWTzGyE1BIvN2eGWDi331J77VZ0uBH8aa0aZS9tmXB98nnt0
 ldp3yfFeiCgviIYH9Via4XmsR4B+fWm6TA/xIUXmLlwGppE55kirdoi28QXbGmE9HSG6qaSAb
 8uS8DyYwVOQgkAJ4i1XVphUoxtTWnolRaDqAx6aZqlV/D/I1+zVX0qp2jKWBTpYeV1+OHnJVu
 2Jg1sHE6Wu8EGeI5ecf1DWG+x6wjRCJRa2WO24akBRPI8daVDSwHUM/0qloUUYNVTMK3iDF/S
 xwwW6M2fK8SjcZsMHPdCq49U+gAcVvolTnWUlMaMal+KjhzlbOq6Senx5Z6+RQA29+228MMsz
 iQIwXFYA3/PjoT5sfioSIV59SueftRAJuzL/y3ryNYg6tKaVvKT8TWnns0PD47pvP+JH8I0T8
 +ttgm0pPp5/hNHiseCnlEYdpfkKs+A1zEelJuK9dmu69yeipd5yzJp2yYIk1nWq4+mJY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:33:55PM +0900 Masahiro Yamada wrote:
> The first line of *.mod lists the member objects of the module.
> This list may contain duplication if the same object is added multiple
> times, like this:
> 
>   obj-m := foo.o
>   foo-$(CONFIG_FOO1_X) += foo1.o
>   foo-$(CONFIG_FOO1_Y) += foo1.o
>   foo-$(CONFIG_FOO2_X) += foo2.o
>   foo-$(CONFIG_FOO2_Y) += foo2.o
> 
> This is probably not a big deal. As far as I know, the only small
> problem is scripts/mod/sumversion.c parses the same file over again.
> This can be avoided by adding $(sort ...). It has a side-effect that
> sorts the objects alphabetically, but it is not a big deal, either.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - new
> 
>  scripts/Makefile.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3ef2373f0a57..63625877aeae 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -307,8 +307,10 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
>  	$(call if_changed,cc_prelink_modules)
>  endif
>  
> +multi-m-prereqs = $(sort $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)))
> +
>  cmd_mod = { \
> -	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
> +	echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=.o)); \

I'd rather expected to see $(or) here, too, as in commit 5c8166419acf ("kbuild:
replace $(if A,A,B) with $(or A,B)").

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  	$(undefined_syms) echo; \
>  	} > $@
>  
> -- 
> 2.32.0
> 
> 

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
