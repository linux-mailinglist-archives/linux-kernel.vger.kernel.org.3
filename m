Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5993B5153B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380037AbiD2SfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380024AbiD2SfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:35:14 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C695C664C;
        Fri, 29 Apr 2022 11:31:50 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 23TIVUoD026819;
        Sat, 30 Apr 2022 03:31:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 23TIVUoD026819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651257090;
        bh=jHfLjG5Ne1YIgVeYha0Y78HVPC4COImuukUBIAGiiHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z0GHFxi838FQYwQAEkLx3Vv0GL0YwypEVeLJFMv1sHoZhBKq6WxNLkigcL4jBthmN
         inkUuIfl+2rv0fu/i7apxnOpsytEc33dmB0slG+G7v1BjFuPnszwl9t1ZgAo8fVlYk
         5JgflA9DTQzLF7GKZYx0u2CW+AZe4b3Oboa4hfsGtdaWK/rK+PcDDFctXkejnCyicI
         U1OuvU9WoRKmzqEUCfiqZhEC5JTuhAIj1T/7AwWpUKj6sGHAoefVzDDdHZPOgrDnmm
         QvDurdCB76lbQ4+z6lZGrrZDIBA3BIcWO44ZgnlABWUmO5IlIlph1aR9sdQUmjuT7l
         2NwmAU8koAboQ==
X-Nifty-SrcIP: [209.85.214.179]
Received: by mail-pl1-f179.google.com with SMTP id u9so7223091plf.6;
        Fri, 29 Apr 2022 11:31:30 -0700 (PDT)
X-Gm-Message-State: AOAM531p/10LHzziIzj9r/7uJTjbEIdr+M1Hi8zi1JzGMeQVix2d+ElS
        NjgxO3OKlUzmJVm5zgnknQ9eKqnSsUPdOVT79oI=
X-Google-Smtp-Source: ABdhPJw26k1JhuBLHXAf0Y8KVZv2aa+x79Gha6QDi8b0G3tNpF4WiFfLrSfCSywpziY3RmLYIwJfHQQnCJtIwHzWCkI=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr658922plp.162.1651257089650; Fri, 29 Apr
 2022 11:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <20220424190811.1678416-7-masahiroy@kernel.org> <CAKwvOdmDiD11Az02U1i8OtxL49V3SH1ORRj8C5jy6Btv3LFY_g@mail.gmail.com>
 <CAKwvOdmeOYsBGSZrprdtoxcUmpy1oscnBfLUaSARPNKsH4Aeug@mail.gmail.com>
In-Reply-To: <CAKwvOdmeOYsBGSZrprdtoxcUmpy1oscnBfLUaSARPNKsH4Aeug@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Apr 2022 03:30:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQez0wm4keBfqwn82ynvpYETD4fo9wD6WceBj-65F6dqg@mail.gmail.com>
Message-ID: <CAK7LNAQez0wm4keBfqwn82ynvpYETD4fo9wD6WceBj-65F6dqg@mail.gmail.com>
Subject: Re: [PATCH 06/27] modpost: use bool type where appropriate
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 3:56 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Apr 25, 2022 at 11:34 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > /On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/mod/modpost.c | 60 +++++++++++++++++++++----------------------
> > >  scripts/mod/modpost.h | 10 ++++----
> > >  2 files changed, 35 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > index f9cbb6b6b7a5..52dd07a36379 100644
> > > --- a/scripts/mod/modpost.c
> > > +++ b/scripts/mod/modpost.c
> > > @@ -203,10 +203,10 @@ struct symbol {
> > >         struct symbol *next;
> > >         struct module *module;
> > >         unsigned int crc;
> > > -       int crc_valid;
> > > +       bool crc_valid;
> > >         char *namespace;
> > > -       unsigned int weak:1;
> > > -       unsigned int is_static:1;  /* 1 if symbol is not global */
> > > +       bool weak;
> > > +       bool is_static;         /* true if symbol is not global */
> > >         enum export  export;       /* Type of export */
> > >         char name[];
> > >  };
>
> This will change the sizeof(struct symbol).  I'm guessing we have lots
> of symbols to process? If we have many live at once, perhaps it would
> be better to keep these as bitfields, but additionally move them to
> the end of the struct definition so as to save space?


Not really.
On 64 bit systems, sizeof(struct symbol) is still 40 bytes.

We may save some space by using bit fields and pahole analysis,
but I do not think that is a big deal for userspace programs.

I tend to prioritize code readability.



-- 
Best Regards
Masahiro Yamada
