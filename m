Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483EF4E6D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 05:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358259AbiCYEoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 00:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353888AbiCYEoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:44:08 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ECAB0A6F;
        Thu, 24 Mar 2022 21:42:34 -0700 (PDT)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 22P4gGEm025906;
        Fri, 25 Mar 2022 13:42:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 22P4gGEm025906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648183336;
        bh=tioTynSbcFVi4zvlE7kGZ4a4gI0WQMbOohNPEixclco=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IxWTMImPuNVfos1zK+f8Gw01/9T9NZGfceowzjO2R8CofrLVL/2bOArFRjwv5+3sL
         VW5BR3LmTZUg2xxMncE//aO/wHk2foSEd+fT1W52loEjOFFyLzyGOFgt/A8lgc6Bte
         rF6GeZ+IhrJENoeup/n9V+AMHSeIK/UvjwgR6rtPAtcPMZi93c3VOADwncv8RNblsS
         IxYiVWLJ256M9CzxL7oYX7VHfuVR76PYO/lTmAHEqQ7+24sDXtX8Rhq0HMv7sesf6e
         pyWWtSrhx0FgypCRIdiD7rCx1WnwYWgSL1D3jZnpcaBDUutCza7UuWvik3dmvsDaEt
         zm4MvQ97HlOSQ==
X-Nifty-SrcIP: [209.85.216.46]
Received: by mail-pj1-f46.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so2448205pjb.3;
        Thu, 24 Mar 2022 21:42:16 -0700 (PDT)
X-Gm-Message-State: AOAM533RfjP6p3AIfZVtJuZbUoj7kzcf3SBj+Qym1MwNsGooynz1eZBV
        0JFF+5+JiRVPxXkUs+TdYG5dPZmQcJvEmnQbngw=
X-Google-Smtp-Source: ABdhPJxIORFt/7+zBH/lcr870qUzEEKcaNpdUeZVFBzirKVURwe0sGEmH9x44WaQssNlcdgzuVUaEkLg0C46kedGsvM=
X-Received: by 2002:a17:90a:8405:b0:1bc:d521:b2c9 with SMTP id
 j5-20020a17090a840500b001bcd521b2c9mr22361849pjn.119.1648183335511; Thu, 24
 Mar 2022 21:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQ2HET1QHG17m1vdCGMoRm6Lj=sAe+cj2Via_LHx3xBPg@mail.gmail.com>
In-Reply-To: <CAK7LNAQ2HET1QHG17m1vdCGMoRm6Lj=sAe+cj2Via_LHx3xBPg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Mar 2022 13:41:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNATY5hfuMr4XnQKSg6yX+yGnE7TU93BAgbq67vWC1uyzAQ@mail.gmail.com>
Message-ID: <CAK7LNATY5hfuMr4XnQKSg6yX+yGnE7TU93BAgbq67vWC1uyzAQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild -std=gnu11 updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the email subject,

    Kbuild -std=gnu11 updates for v5.17-rc1

contains a typo.
It should be for "v5.18-rc1" , of course.





On Fri, Mar 25, 2022 at 11:37 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Linus,
>
> This is a small patch set for -std=gnu11 migration.
> As you requested, I separated this out.
> I will send the second pull request later for the rest
> of kbuild updates.
>
> Thank you.
>
>
>
>
>
> The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:
>
>   Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> kbuild-gnu11-v5.18
>
> for you to fetch changes up to 1e24078113ae69c741cb1b03375a9f1490db7308:
>
>   Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS (2022-03-13 17:31:44 +0900)
>
> ----------------------------------------------------------------
> Kbuild -std=gnu11 updates for v5.18
>
> Linus pointed out the benefits of C99 some years ago, especially variable
> declarations in loops [1]. At that time, we were not ready for the
> migration due to old compilers.
>
> Recently, Jakob Koschel reported a bug in list_for_each_entry(), which
> leaks the invalid pointer out of the loop [2]. In the discussion, we
> agreed that the time had come. Now that GCC 5.1 is the minimum compiler
> version, there is nothing to prevent us from going to -std=gnu99, or even
> straight to -std=gnu11.
>
> Discussions for a better list iterator implementation are ongoing, but
> this patch set must land first.
>
> [1] https://lore.kernel.org/all/CAHk-=wgr12JkKmRd21qh-se-_Gs69kbPgR9x4C+Es-yJV2GLkA@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/86C4CE7D-6D93-456B-AA82-F8ADEACA40B7@gmail.com/
>
> ----------------------------------------------------------------
> Arnd Bergmann (3):
>       Kbuild: add -Wno-shift-negative-value where -Wextra is used
>       Kbuild: move to -std=gnu11
>       Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
>
> Mark Rutland (1):
>       Kbuild: use -Wdeclaration-after-statement
>
>  Documentation/process/programming-language.rst                    | 6 +++---
>  Documentation/translations/it_IT/process/programming-language.rst | 4 ++--
>  Documentation/translations/zh_CN/process/programming-language.rst | 3 +--
>  Documentation/translations/zh_TW/process/programming-language.rst | 3 +--
>  Makefile                                                          | 7 ++++---
>  arch/arm64/kernel/vdso32/Makefile                                 | 3 ++-
>  drivers/gpu/drm/i915/Makefile                                     | 1 +
>  drivers/staging/greybus/tools/Makefile                            | 3 ++-
>  fs/btrfs/Makefile                                                 | 1 +
>  scripts/Makefile.extrawarn                                        | 1 +
>  scripts/mod/modpost.c                                             | 4 +++-
>  11 files changed, 21 insertions(+), 15 deletions(-)
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
