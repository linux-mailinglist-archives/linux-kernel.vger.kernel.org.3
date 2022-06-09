Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAE354540A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbiFISWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiFISWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:22:08 -0400
X-Greylist: delayed 137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 11:22:06 PDT
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F6261808;
        Thu,  9 Jun 2022 11:22:06 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 259ILeBc006422;
        Fri, 10 Jun 2022 03:21:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 259ILeBc006422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654798902;
        bh=LJxtddDBXsjMYUL3pGSS5tmHKgRvI6z/bgDNxm6WRn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pw51riWI/3vLXCmz12G2F1QJdPsdTMrSqhRVxYQU6LSvhqG/LUcbMb3ZIOT9xaYpI
         l+MNI0bLP1T10yifBY4DSSJgfWTXTC8Rl/aA1OCKSmLmqHK+lwbZXLPlevo/m4/g92
         sa+FceO6TPtq/wUrVer2rh8TNb1OkDXy/0Ws2u6B5Tg0zqyM6iCpR6xFZtqLDrOHv8
         TXa6dbasMOC2BVIElR4H86jcOSf7F6yUezSZGyXi1mtfsd575VHEFMGMwkG97xUy/V
         7C6foJVZdT75BxqvoYQ5Hoqj3yLzMTt5H1W2RXfCL+MnfSepYrqjApLQGJtyd/Pssy
         vKNkUGqNg5BGQ==
X-Nifty-SrcIP: [209.85.221.54]
Received: by mail-wr1-f54.google.com with SMTP id a15so25004389wrh.2;
        Thu, 09 Jun 2022 11:21:41 -0700 (PDT)
X-Gm-Message-State: AOAM533Zft/cbv58hS6qi1gJAGnIicbqeijlOKoufZj8VD2N46gp1dHm
        1uqvg/SM1+zAfslJ2n3qzASGijitWUVlOJz8TkQ=
X-Google-Smtp-Source: ABdhPJxaWmtRJLw5nnCMAcH4th8qdNiNm5VSCrjWi029K8m8/ByjE9CXdA0nfBaA2HBFVO9hj8duYh0pZONdMUuQV+s=
X-Received: by 2002:a5d:584f:0:b0:219:e106:3e02 with SMTP id
 i15-20020a5d584f000000b00219e1063e02mr1818472wrf.461.1654798900049; Thu, 09
 Jun 2022 11:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <165451871967.1941436.17828809503267245815.stgit@warthog.procyon.org.uk>
 <CAK7LNAS-0kQOvt=7TNn0osf9JO5hZhSp9PaFFBsSx++2Pevc9g@mail.gmail.com>
 <22a067fe-795f-d3ae-fac6-7baa75393349@digikod.net> <75918f49-5670-766a-09a2-f29aef95f2ca@digikod.net>
In-Reply-To: <75918f49-5670-766a-09a2-f29aef95f2ca@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jun 2022 03:21:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKRK9e6=ND8o22YtV0mHs4OhH4qE49t4=UDLAgih+uEQ@mail.gmail.com>
Message-ID: <CAK7LNAQKRK9e6=ND8o22YtV0mHs4OhH4qE49t4=UDLAgih+uEQ@mail.gmail.com>
Subject: Re: [PATCH] certs: Convert spaces in certs/Makefile to a tab
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 2:17 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
>
> On 09/06/2022 19:12, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> > On 06/06/2022 18:49, Masahiro Yamada wrote:
> >> On Mon, Jun 6, 2022 at 9:32 PM David Howells <dhowells@redhat.com> wro=
te:
> >>>
> >>> There's a rule in certs/Makefile for which the command begins with ei=
ght
> >>> spaces.  This results in:
> >>>
> >>>          ../certs/Makefile:21: FORCE prerequisite is missing
> >>>          ../certs/Makefile:21: *** missing separator.  Stop.
> >>>
> >>> Fix this by turning the spaces into a tab.
> >>>
> >>> Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are
> >>> valid")
> >>> Signed-off-by: David Howells <dhowells@redhat.com>
> >>> cc: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>> cc: Jarkko Sakkinen <jarkko@kernel.org>
> >>> cc: keyrings@vger.kernel.org
> >>
> >>
> >> Not only 8-space indentation, but also:
> >>
> >>    - config_filename does not exist
> >>    - $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX) is always empty
> >>    - $(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) is always empty
> >
> > These are imported helpers (not only used for this hash list BTW), henc=
e
> > not defined in this Makefile.
>
> Well, they were defined in scripts/Kbuild.include but they are gone
> since your commit b8c96a6b466c ("certs: simplify $(srctree)/ handling
> and remove config_filename macro").
>
> I guess it just happens during the merge. We need to fix that.
>




Right, it seems your patch was flying for a long time.





$ git show --pretty=3Dfuller   addf466389d9d78f255e8b15ac44ab4791029852
commit addf466389d9d78f255e8b15ac44ab4791029852
Author:     Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
AuthorDate: Mon Jul 12 19:03:10 2021 +0200
Commit:     Jarkko Sakkinen <jarkko@kernel.org>
CommitDate: Mon May 23 18:47:49 2022 +0300

    certs: Check that builtin blacklist hashes are valid




It was committed 8 months after the patch submission.

The base code changed during the gap.




--
Best Regards
Masahiro Yamada
