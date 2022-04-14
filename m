Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ECE501804
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347148AbiDNP7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349684AbiDNPkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:16 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA881117;
        Thu, 14 Apr 2022 08:19:27 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 23EFJ9P0009346;
        Fri, 15 Apr 2022 00:19:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 23EFJ9P0009346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649949550;
        bh=XPLvg0xD6eFIIDd3CQ6jmzggfMRcYlU0deeya24rkks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sld9SLgesc7VNKrWrEHfazd04aip0hDyZzcvdu4Ib+XS2hqXQIJa2zT898kNCkndd
         u+gZG24HlPqh+XA4WdmKxOw6FQvJo+QbvGLKn2fkt+66N3o2JQdD+qAU6pELNmQAdn
         274y5Tf0t/hdOzyn3l3vDmF5BtYjKNf3j4YcXfnHruJg2907af+YLWVyppo4eTEVKG
         n4OHTDgeHZETgJjjVY59OdQS3RS3SfvkPRH7qVmuzsd1qQRSLTHEljBtmcUiYAA8yu
         N78/4FHfpXZqvPZCuuCl/WRk/1M6pzBERHwHYEF21GZte9dqF0qx+dWZNrLD2q0aNq
         J2aLWwidlH9QQ==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id s14so4896855plk.8;
        Thu, 14 Apr 2022 08:19:10 -0700 (PDT)
X-Gm-Message-State: AOAM530zPfWgSTG1+gP6OBPFA5f0tHkB++yDHp5MkIgeOC7vXfpI+s4n
        5OWFVvQpQ55j9Na7M7SaO6lU0n+Y+xgNP0Ptoek=
X-Google-Smtp-Source: ABdhPJybgowAcKO6+UUwxv7i58osxALPzH60enIMNcIs2qt6jotYnP6KDZEPI72UGVdUgtyUHQCtD2pMuGlmPPUe0b0=
X-Received: by 2002:a17:90a:b396:b0:1cd:44cc:15a9 with SMTP id
 e22-20020a17090ab39600b001cd44cc15a9mr4166506pjr.77.1649949549457; Thu, 14
 Apr 2022 08:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220414091419.7654-1-jslaby@suse.cz> <CAK7LNATn2QrFn0fTixnbtZ-VOtWid2PvFKPmjfX+z_UtZgTMgA@mail.gmail.com>
 <ace87421-eefb-f4f6-307f-cd2990fb25eb@suse.cz> <810ab2b8-4138-1506-fc90-ae5c6ab0522e@suse.cz>
In-Reply-To: <810ab2b8-4138-1506-fc90-ae5c6ab0522e@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 Apr 2022 00:18:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATgfosGQ6LRmu8DUxwnWL=Dyu1cOUUq1GBRtP6+BppNbw@mail.gmail.com>
Message-ID: <CAK7LNATgfosGQ6LRmu8DUxwnWL=Dyu1cOUUq1GBRtP6+BppNbw@mail.gmail.com>
Subject: Re: [PATCH] scripts: dummy-tools, add pahole
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 6:44 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 14. 04. 22, 11:42, Jiri Slaby wrote:
> > On 14. 04. 22, 11:33, Masahiro Yamada wrote:
> >> On Thu, Apr 14, 2022 at 6:14 PM Jiri Slaby <jslaby@suse.cz> wrote:
> >>>
> >>> CONFIG_PAHOLE_VERSION is a part of a config since the commit below. And
> >>> when multiple people update the config, this value constantly changes.
> >>> Even if they use dummy scripts.
> >>>
> >>> To fix this:
> >>> * add a pahole dummy script returning v99.99 -> 9999
> >>> * call it in Makefile taking CROSS_COMPILE into account.
> >>>
> >>> The latter happens only if $(CROSS_COMPILE)pahole really exists. This is
> >>> because a cross pahole likely exists only in dummy tools now, not in
> >>> real cross tools.
> >>
> >>
> >> I do not think this is the right thing to do.
> >>
> >> (As I said somewhere, I am opposed to checking pahole version in
> >> Kconfig).
> >
> > If you ask me, I am all for removal as this causes pain. But it's there,
> > so I cannot do anything about that.
> >
> >> Also, $(CROSS_COMPILE)pahole looks insane.
> >>
> >> You can create a dummy pahole in your local system.
> >>
> >> $ echo 'echo v99.99' > $HOME/bin/dummy-pahole
> >> $ chmod +x  $HOME/bin/dummy-pahole
> >> $ make CROSS_COMPILE=scripts/dummy-tools  PAHOLE=dummy-pahole  menuconfig
> >
> > Well, the question is how do I that for every kernel developer in SUSE?
>
> IOW it'd be quite easier if the scripts/dummy-tools/pahole part of the
> patch was in the tree. (I don't insist on the Makefile change.)


I do not mind  scripts/dummy-tools/pahole
although you need to do
make CROSS_COMPILE=scripts/dummy-tools
PAHOLE=scripts/dummy-tools/pahole  menuconfig




> > thanks,--
> js
> suse labs



-- 
Best Regards
Masahiro Yamada
