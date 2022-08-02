Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8972C5880CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiHBRKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiHBRKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:10:05 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD73ED42;
        Tue,  2 Aug 2022 10:10:03 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 272H9hY9027057;
        Wed, 3 Aug 2022 02:09:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 272H9hY9027057
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659460184;
        bh=k1P4L4Zq0ArbMha5Otv1LMYgCz4rKgPwbM+pbr8YQ6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mj8pW26hiop37aonULz4iNpt7crATDJ024glucbtq7V9iVhLnokR7PWFPMrQuBR3V
         dBQW7pWTNNzxvo7z4rFuJ+I19AHP9EfQ1T3SkqmNQz1BJJkWeiNGpDOvY8v42ktlmi
         S13VouLCSYhnh7iwjBKA9bCRKzSg3M/uy7tjs3YciFoV1JztuihdzBSDg3WGY3eX61
         GdjE/GU1PAYZHhiFY7ZbZdRZpjcWkO6Smu/Tk42bkUhLzoaqw3o6O9d/RuXMRhJsNN
         HejtzX6Lgu9y6emkUx8FsS22rMYnScmImVzo4kqyJB8USt/IK+WqbADcyT4xCLZVLN
         VGBILg67RFvOg==
X-Nifty-SrcIP: [209.85.221.51]
Received: by mail-wr1-f51.google.com with SMTP id z16so18607749wrh.12;
        Tue, 02 Aug 2022 10:09:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo0MMzC0bZAT+wWKEhq4rxf3CyGonuSVQv2VaolQYIBpulxwqqFy
        D712xHMnm46IUgq/qFkCn2mUzpIsO+vvLc2xxQg=
X-Google-Smtp-Source: AA6agR5khXxw1iz8XVPYejddxFayETHG6E8KkezPucecpO9Q0Y2e4XLetPGSmEc+vpVqZgcbXVRdIGkCdW7pfI+UlLA=
X-Received: by 2002:a5d:54cb:0:b0:220:6426:6219 with SMTP id
 x11-20020a5d54cb000000b0022064266219mr5660179wrv.461.1659460182412; Tue, 02
 Aug 2022 10:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220720232332.2720091-1-justinstitt@google.com>
 <CAKwvOdnSjyOdCZZ9AegCyfns3bvH3fbtbVgdThO2+rJAE=1bag@mail.gmail.com>
 <YtlsY2A2ZWK97Y8O@dev-arch.thelio-3990X> <CAK7LNASi_yrPhf0wv+0nqRcNhhbwUn-PzHvuiV2W1EsTqd_D8Q@mail.gmail.com>
 <CAFhGd8r1_A67aVt_5tMz-1NC51JrCFG=8cDsmTMz1kOricWEOA@mail.gmail.com> <YugYbvRu1xqnx6mC@dev-arch.thelio-3990X>
In-Reply-To: <YugYbvRu1xqnx6mC@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 3 Aug 2022 02:08:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvH=feO_d=0rLGYYQ2YYi=7NRYxGXcYSpYMvqSyOBgew@mail.gmail.com>
Message-ID: <CAK7LNAQvH=feO_d=0rLGYYQ2YYi=7NRYxGXcYSpYMvqSyOBgew@mail.gmail.com>
Subject: Re: [PATCH] Makefile.extrawarn: re-enable -Wformat for clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 3:16 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Aug 01, 2022 at 10:40:29AM -0700, Justin Stitt wrote:
> > > OK, I think that will be good timing.
> > > Please ping me if I forget to pick it up.
> > >
> > Hey Masahiro, just pinging to see the state of this PR.
> >
> > I think we are on pace to re-enable this warning.
> >
> > I believe there exists only _two_ patches left still needing to go
> > through along with this patch:
> > 1) https://lore.kernel.org/all/20220718050356.227647-1-hch@lst.de/
>
> This is now in the block tree, so it should be squared away:
>
> https://lore.kernel.org/YuFhR9OoPvM9VsdT@infradead.org/
>
> Stephen is on vacation so -next hasn't updated for a few days but it
> sounds like Mark is going to provide some coverage:
>
> https://lore.kernel.org/YugAzWWl++ArhhPS@sirena.org.uk/
>
> > 2) https://lore.kernel.org/all/YtnDltqEVeJQQkbW@dev-arch.thelio-3990X/
>
> We need to chase this, as I haven't seen an "applied" email. We have two
> options:
>
> 1. Ask the maintainers to apply the change to their branch directly.
> 2. Ask them for an "Ack" so that we can apply that change along with
>    this one.
>
> It is worth a ping asking which they prefer. The first option is
> simpler, as the change that introduced the warning is only in -next so
> it can just be applied to the same branch; the only concern is making
> sure that change makes -rc1. The second option gives us more flexibility
> with enabling the warning in the event that the change missed being
> added to the main pull request but it will require basing the change on
> a non-rc base, which most maintainers don't really like.
>
> It is ultimately up to Masahiro but my vision is:
>
> 1. Ping the patch, asking how to proceed.
> 2. If the maintainers can pick it up and it will make the merge window,
>    let them apply it then apply this patch to the Kbuild tree for -next.
> 3. If they prefer the "Ack" route, wait until mainline contains the
>    problematic patch then apply the warning fix patch and this patch to
>    the Kbuild tree on top of the problematic merge.
> 4. Wait until all other patches are in mainline (I can watch mainline
>    and build it continuously) then pull request the branch containing
>    whatever changes we need.
>
> Masahiro, does that sound reasonable?
>
> Cheers,
> Nathan


Now applied to linux-kbuild.


If my pull request is rejected because of some warnings,
I may end up with dropping this, though.


-- 
Best Regards
Masahiro Yamada
