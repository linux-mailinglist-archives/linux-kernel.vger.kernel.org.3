Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C250C77A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiDWFHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiDWFHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:07:01 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E98F8EF4;
        Fri, 22 Apr 2022 22:04:05 -0700 (PDT)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 23N53N9e029383;
        Sat, 23 Apr 2022 14:03:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 23N53N9e029383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650690203;
        bh=vlYfa/Ed5SyrPK+aqkUJKWVbIdAuoiBjMhizL4RTCMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OSG5Sx4X/XgGFoGeBToJiv3vTAl267FySZRt+IuMgL1vgiOmNPOW2HNDSortPhtGy
         ZlqfLve22GDJO7yV+HpjAndZsQi8jF6DV+mXClHbJRMT4qKYL/EuYY+w6lnbS7SrW4
         BnPJadWbW/er2xebiuIJfqk4qmViYdCp8Wvxb8RaSZt9GefFilS4c5BdJ3HJnFW/cs
         admXMp9DvtA8dHQb1nPG32mHGpicIP2wSOyWOy+1t+b2DyUwdmVHnwim1QWo3ELDvk
         6CKA23pSvW3Sw8uiOtLivbwT4Z9EiaeWZe7DTFzTSFfxJHNSVEr4sWSMXdqWPeo8k2
         cy6yEh7OqB75w==
X-Nifty-SrcIP: [209.85.215.178]
Received: by mail-pg1-f178.google.com with SMTP id t13so8923699pgn.8;
        Fri, 22 Apr 2022 22:03:23 -0700 (PDT)
X-Gm-Message-State: AOAM532oHa9K+9CRtYQ7X8bUBRbQdWjq7CrrTFi2uOgE/r0fxwoMnya5
        i8VroyKvmt3mClEB6Oq4Usy5vaXM4pc2Uou6Z2k=
X-Google-Smtp-Source: ABdhPJxPyebHNjZtDP7+smp8la5QAWWihUdVWc67NC4PBGJ1ch9ZVMDOYufQD+Bb/yjDZRkf3wQsnv1CUV3GP8Xjy4M=
X-Received: by 2002:a05:6a00:234f:b0:4fa:f52b:46a1 with SMTP id
 j15-20020a056a00234f00b004faf52b46a1mr8460479pfj.32.1650690202506; Fri, 22
 Apr 2022 22:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <CAK7LNARzPPRnnAayau3bwB_uj17_uirY+F9rAV048oMp-c-WMw@mail.gmail.com>
 <0d290fab-28ca-77f3-a6d2-415d990f0f91@quicinc.com>
In-Reply-To: <0d290fab-28ca-77f3-a6d2-415d990f0f91@quicinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 23 Apr 2022 14:02:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQqw-D+feqrB4F+Gup0jzXHqUmH_3_4n-7xL_M1b7sDQ@mail.gmail.com>
Message-ID: <CAK7LNATQqw-D+feqrB4F+Gup0jzXHqUmH_3_4n-7xL_M1b7sDQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] kbuild: more misc cleanups
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 4:07 AM Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Hi Masahiro,
>
> On 4/15/2022 12:20 AM, Masahiro Yamada wrote:
> > On Thu, Apr 7, 2022 at 12:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >>
> >>
> >> I sent the first batch of cleanups:
> >> https://lore.kernel.org/linux-kbuild/20220405113359.2880241-1-masahiroy@kernel.org/T/#t
> >>
> >> I took 01-06, 09-10.
> >> I dropped 07, 08.
> >>
> >> This is the second batch.
> >>
> >
> > Applied to linux-kbuild.
> >
> >
>
> I didn't see the last patch (kbuild: read *.mod to get objects passed to
> $(LD) or $(AR)) applied. Was the last patch intentionally skipped?


I do not know why but something wrong happened to my git operation.
I will apply it.
Thanks for pointing it out.







> >>
> >>
> >> Masahiro Yamada (7):
> >>    kbuild: reuse suffix-search to refactor multi_depend
> >>    kbuild: make multi_depend work with targets in subdirectory
> >>    kbuild: reuse real-search to simplify cmd_mod
> >>    kbuild: split the second line of *.mod into *.usyms
> >>    kbuild: get rid of duplication in *.mod files
> >>    kbuild: make *.mod not depend on *.o
> >>    kbuild: read *.mod to get objects passed to $(LD) or $(AR)
> >>
> >>   .gitignore                  |  1 +
> >>   Makefile                    |  5 +++--
> >>   scripts/Makefile.build      | 31 ++++++++++++++-----------------
> >>   scripts/Makefile.lib        |  6 +++---
> >>   scripts/adjust_autoksyms.sh |  2 +-
> >>   scripts/gen_autoksyms.sh    | 18 +++++++++++-------
> >>   scripts/mod/sumversion.c    | 11 ++---------
> >>   7 files changed, 35 insertions(+), 39 deletions(-)
> >>
> >> --
> >> 2.32.0
> >>
> >
> >



-- 
Best Regards
Masahiro Yamada
