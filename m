Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1767E50D9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiDYGxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiDYGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:53:50 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9D372E0E;
        Sun, 24 Apr 2022 23:50:45 -0700 (PDT)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MuF4v-1o1vTi2ySb-00uXUa; Mon, 25 Apr 2022 08:50:43 +0200
Received: by mail-wr1-f51.google.com with SMTP id x18so19417170wrc.0;
        Sun, 24 Apr 2022 23:50:43 -0700 (PDT)
X-Gm-Message-State: AOAM531qquoFZpNNmgpU9hlQVwGxWR2i/DYAjGaEIEGAqHWxb/uINC+k
        oNd9BmePSv7vkaBHsPhVG6MwqRu0sslqBhxGo30=
X-Google-Smtp-Source: ABdhPJxPmwV5WfcLnmUcvdXXaS8GyG1IsSnRTeCouUj2lCvJavpxFpqEWw5tHbS8gyEonBI8l0BcoD/6n15ffRVK4JY=
X-Received: by 2002:a5d:49cb:0:b0:20a:cee3:54fc with SMTP id
 t11-20020a5d49cb000000b0020acee354fcmr8897626wrs.12.1650869443104; Sun, 24
 Apr 2022 23:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220422151725.1336997-1-mailhol.vincent@wanadoo.fr>
 <YmXMiTXEvFXZ/swU@dev-arch.thelio-3990X> <CAMZ6Rq+3XOze01dZZRTe+V44N2uo5J_=rtd9bKH7d7Fq9sNxVw@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+3XOze01dZZRTe+V44N2uo5J_=rtd9bKH7d7Fq9sNxVw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 08:50:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a31WAyh_vLqNwvv2GMcZ8SQp7gC=OV8c=Nc9pBtOSR8-g@mail.gmail.com>
Message-ID: <CAK8P3a31WAyh_vLqNwvv2GMcZ8SQp7gC=OV8c=Nc9pBtOSR8-g@mail.gmail.com>
Subject: Re: [PATCH] checksyscalls: ignore -Wunused-macros
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UaCMRLV59oKpIUu2ubDKLDGAgKT/RVqgR8o7Sf6wAJ/o26k9drx
 WATwG6fvMDAyx288U/tjPp5okwmDteAFpSxMDG3S1dSCJ5yDePznIVqIXpkC1FmgOAbevrJ
 dnLwwIGZh5sxeHIDpm//TWSO85V5MYVnMfN/KpK9+LswndgTOQWNueoxackeKNH4IRWfahd
 PF+b8jqKnmbCSW3e9MS1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jMQQiCIRwX8=:wKorjLd+Zoo+h0Kv890um+
 WjBeDynLgYmGe5x5ReBXQO/w+F6WshAK6vXNlK2/UHeiG2nSjluBH4X28x1VmPEBy1O7I7N2a
 lO+Vuy2EisyyRIBhUpNXHzKPlSA/A3SLHyHHbcyjj8hRTgtmoEag9iBWhk7VY0/dtq9CDFWrM
 OkORDMPW4IQOlVts47wjV6tfd5wG1LWaixW4OacmFxnT/Ewy/KZvXD/q2tl0fQwCROTbZxqhe
 VWsshz0zFqevDI4t073M1FcDhcmgbWFwPd4IgiEQCQm4Onv7CdnLcTg66ktXZFVVoLR4JzuPz
 K5WaJQBmjS4U/efocBwYW8JFKsZ22e6uHN/yhN3n9QPVdehhYseod24oRuj0gfPaIN1iW0r5j
 8tTb/v0wwDHgaWF4KAeJLyC+OIQw96RqIXEyf3pYeX0miTjy5afPvPEHj5U/vgiMRNTRIIjG3
 2JxWK2eOJkmstit8OSIf4ACG0lqUWa4yYvdlsf5Ez5D34qEjCTkOM6SHsi9Ctu8ekwRI38Hd/
 ae83ypvhaCCKF0YakZoa2IsaquRVxLEy/bSiYZtzrnd8tf4REGpMZ4+EU9x0VuqhNX232HTbN
 jhUDMR+2ALf9pEX+chA+E3kDW7c5r2lFORRDtvevKEk2au1baecut64vtft05qnr9A2ZqD1e0
 aUbltgMrAFl+na9BpQnOc8aR+98v4rlCFvVbPLU7LpTGvMnK3V3m1/lMCQHCEROxymnxjYUC3
 wu2K6A09ax/MqZGP7oaOjZItUaKdbGRdmxGVYzOU1VLC3rcsPh7u1chG+UxhJh5QBHUC/B8ka
 xScis/z4WdVg1FTv0S6ay5gV6rqYyeZBEu5q43QI1nrIPRkD+4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 8:17 AM Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> On Mon. 25 Apr 2022 at 07:17, Nathan Chancellor <nathan@kernel.org> wrote:
> > Hi Vincent,
> >
> > On Sat, Apr 23, 2022 at 12:17:25AM +0900, Vincent Mailhol wrote:
> > > The macros defined in this file are for testing only and are purposely
> > > not used. When compiled with W=2, both gcc and clang yield some
> > > -Wunused-macros warnings. Ignore them.
> > >
> > > Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > The change itself looks fine but a couple of comments:
> >
> > 1. Nick and I do not pick up patches, we rely on others to do so.
> >    Additionally, this is not really something within our domain, despite
> >    what get_maintainer.pl might say. This change should be sent to
> >    either
> >
> >    Masahiro Yamada <masahiroy@kernel.org>
> >    linux-kbuild@vger.kernel.org
> >
> >    or
> >
> >    Andrew Morton <akpm@linux-foundation.org>
> >
> >    so that it can be applied by one of them.
>
> Ack. As you pointed out, I indeed just followed get_maintainer.pl.
> I will resend a v2 to the people you pointed out (and exclude you).
>
> > 2. I am not sure that silencing warnings from W=2 is that useful, as
> >    they are unlikely to be real issues. Not to discourage you by any
> >    means but it might be more useful to focus on cleaning up warnings
> >    from W=1 and getting those promoted to regular build warnings.
>
> Normally I agree, but there is one reason to fix this W=2: this
> warning appears when building other files.
>
> Example:
> | $ make W=2 drivers/net/dummy.o
> |   CALL    scripts/checksyscalls.sh
> | <stdin>:21: warning: macro "__IGNORE_stat64" is not used [-Wunused-macros]
> | <stdin>:22: warning: macro "__IGNORE_lstat64" is not used [-Wunused-macros]
> | <stdin>:75: warning: macro "__IGNORE_llseek" is not used [-Wunused-macros]
> | <stdin>:159: warning: macro "__IGNORE_madvise1" is not used [-Wunused-macros]
> (rest of the output redacted).
>
> When I run W=2, I want to only see the warnings of the file I am
> working on. So I find it useful to fix the W=2 warnings which
> show up when building other files to not get spammed by
> irrelevant issues and to simplify the triage.
>
> My initial message lacked the rationale. I will add additional
> explanations in the v2 of this patch.

I agree this is worth fixing if we want to make W=2 have any meaning at all.

Your approach is probably fine. We could try to improve this by comparing
against the list from include/uapi/asm-generic/unistd.h instead of the i386
list. I suppose that would involve rewriting the script into a simpler one,
but I'm not sure if anyone has an interest in working on this.

       Arnd
