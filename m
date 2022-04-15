Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84254502625
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350999AbiDOHYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350990AbiDOHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:24:32 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF1B18B6;
        Fri, 15 Apr 2022 00:22:02 -0700 (PDT)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 23F7LTtM029671;
        Fri, 15 Apr 2022 16:21:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 23F7LTtM029671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650007290;
        bh=wd8+cujQkK0MJ7tfckG82Kp7Cfc2ifRfBWP99JwxnIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LpwgG5iCO1G7osKv3qk0w9Omia/Zj7pDWm2EZbDvZ2ipelKI/T4wEIGMbHRnyezIj
         y35PYTgUtahsEhrx4UrNJZEzLmCAAVQEMVCDFKfQoFwIIrBky2b+4DXShvuZx8SgcG
         vhxpL0c4+OeCNDyUNffbD1sV8Du8O1ZYG+sn64J10bx/QpRdxoglChCiH27wKC+7B7
         HdA4Vf7V/Pa9vkyGwXeGaBsORaxB3hGOFuhs083T9/NAZLDxAzxNnbNt+uw3OVS7jt
         fCnoxaAm0sjU2kZ2dD/UOeOegmdbVuiqIAk+LI+GstBD3VZI39XRvDchPUFZEpq596
         haF0PpATj0VnQ==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso792058pjj.3;
        Fri, 15 Apr 2022 00:21:30 -0700 (PDT)
X-Gm-Message-State: AOAM5302b7DGeraePttIFue10OYZcxQuWBcMzO6gk9iO1Wumj4DOHcBp
        0bseoBH5HELlLRJZqkjF0lFfZi1qoLFTiYFiwj4=
X-Google-Smtp-Source: ABdhPJyIDPLfjh3agb8s/IMCRg2ix009jKo7OEAsiqNKg8NvXdfE+zQL7rEjxuel14k7bA7B+QQK+c7o0SpJliy1LHM=
X-Received: by 2002:a17:902:7083:b0:158:41f2:3a83 with SMTP id
 z3-20020a170902708300b0015841f23a83mr28402621plk.99.1650007289324; Fri, 15
 Apr 2022 00:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org>
In-Reply-To: <20220406153023.500847-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 15 Apr 2022 16:20:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzPPRnnAayau3bwB_uj17_uirY+F9rAV048oMp-c-WMw@mail.gmail.com>
Message-ID: <CAK7LNARzPPRnnAayau3bwB_uj17_uirY+F9rAV048oMp-c-WMw@mail.gmail.com>
Subject: Re: [PATCH 0/7] kbuild: more misc cleanups
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 12:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> I sent the first batch of cleanups:
> https://lore.kernel.org/linux-kbuild/20220405113359.2880241-1-masahiroy@kernel.org/T/#t
>
> I took 01-06, 09-10.
> I dropped 07, 08.
>
> This is the second batch.
>

Applied to linux-kbuild.


>
>
> Masahiro Yamada (7):
>   kbuild: reuse suffix-search to refactor multi_depend
>   kbuild: make multi_depend work with targets in subdirectory
>   kbuild: reuse real-search to simplify cmd_mod
>   kbuild: split the second line of *.mod into *.usyms
>   kbuild: get rid of duplication in *.mod files
>   kbuild: make *.mod not depend on *.o
>   kbuild: read *.mod to get objects passed to $(LD) or $(AR)
>
>  .gitignore                  |  1 +
>  Makefile                    |  5 +++--
>  scripts/Makefile.build      | 31 ++++++++++++++-----------------
>  scripts/Makefile.lib        |  6 +++---
>  scripts/adjust_autoksyms.sh |  2 +-
>  scripts/gen_autoksyms.sh    | 18 +++++++++++-------
>  scripts/mod/sumversion.c    | 11 ++---------
>  7 files changed, 35 insertions(+), 39 deletions(-)
>
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
