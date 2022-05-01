Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4551645D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbiEAM27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 08:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiEAM24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 08:28:56 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C298EE017;
        Sun,  1 May 2022 05:25:27 -0700 (PDT)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 241COxAn017333;
        Sun, 1 May 2022 21:25:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 241COxAn017333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651407900;
        bh=s9WJsNSqpPu5bcg8syEMbH4y6ywS2B+iJi17yrfL59w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZwU0SrYVAmuqx7ZPBWALLSvJ72XApDjVU/+M8tiMYdoaqL9sEVG/VtUU40ufqmHi8
         XskoLhhYh+2LRs43jkgv0YVcQOHUuhgZpaAFUzYUBvvTDiPWt/pQvknK21V9xOvX0R
         DnokeReLawxxnt9Ki9WL90W8Iu2NR3BCO0XCbHWXOPQ3wgrfHNDZbPE+1QZYPREIiS
         liBuVeUSTyMQXz7/8xDoHfABVegTw7FWscZ7kl0wrkANh82Co7tO9kxNAq2+4aJa/f
         vJJnrGmUOl/2XZdYADC/w51+LrTbPLPpS02d8A8Fpq9zWcjpfyLKl/gvjbFnurl3eW
         C9c4eKUdZLDAQ==
X-Nifty-SrcIP: [209.85.215.179]
Received: by mail-pg1-f179.google.com with SMTP id bg9so9845821pgb.9;
        Sun, 01 May 2022 05:25:00 -0700 (PDT)
X-Gm-Message-State: AOAM5303c3JgWrB+bjObd2EfsYwyucbyozqUnAo4jAviLnxhUaj+HWYe
        bY+IiuVT4BusS/bLp9IZvPGVL7QBcdJ6tZnzERE=
X-Google-Smtp-Source: ABdhPJweSJ5bmDryx8QPRvubCmslr51jm3f8PW+XSTdkqy/t55C0Hk6kBtzuRE4UIvahL2188zio4+mAtCSuUoYGj7k=
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id
 p2-20020a056a000a0200b004fdf9dd5494mr7285242pfh.68.1651407899203; Sun, 01 May
 2022 05:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220501084032.1025918-1-masahiroy@kernel.org>
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 May 2022 21:23:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYKttAZMnirt-aVSJqbgY1Cagj3URstv-9zs+-RKDi8g@mail.gmail.com>
Message-ID: <CAK7LNASYKttAZMnirt-aVSJqbgY1Cagj3URstv-9zs+-RKDi8g@mail.gmail.com>
Subject: Re: [PATCH v2 00/26] kbuild: yet another series of cleanups (modpost
 and LTO)
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 1, 2022 at 5:42 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> This is the third batch of cleanups in this development cycle.
>
> Major changes in v2:
>
>  - V1 did not work with CONFIG_MODULE_REL_CRCS.
>    I fixed this for v2.
>
>  - Reflect some review comments in v1
>
>  - Refactor the code more
>
>  - Avoid too long argument error
>


This series is available at:

git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
lto-cleanup-v2







>
> Masahiro Yamada (26):
>   modpost: use bool type where appropriate
>   modpost: change mod->gpl_compatible to bool type
>   modpost: import include/linux/list.h
>   modpost: traverse modules in order
>   modpost: add sym_add_unresolved() helper
>   modpost: traverse unresolved symbols in order
>   modpost: use doubly linked list for dump_lists
>   modpost: traverse the namespace_list in order
>   modpost: dump Module.symvers in the same order of modules.order
>   modpost: move static EXPORT_SYMBOL check to check_exports()
>   modpost: make multiple export error
>   modpost: make sym_add_exported() always allocate a new symbol
>   modpost: split new_symbol() to symbol allocation and hash table
>     addition
>   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
>   kbuild: record symbol versions in *.cmd files
>   kbuild: generate a list of objects in vmlinux
>   modpost: extract symbol versions from *.cmd files
>   modpost: generate linker script to collect symbol versions
>   kbuild: embed symbol versions at final link of vmlinux or modules
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format for .cmd files
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error
>   modpost: simplify the ->is_static initialization
>   modpost: use hlist for hash table implementation
>
>  .gitignore                  |   1 +
>  Makefile                    |   1 +
>  scripts/Kbuild.include      |   4 +
>  scripts/Makefile.build      | 118 +++------
>  scripts/Makefile.lib        |   7 -
>  scripts/Makefile.modfinal   |   6 +-
>  scripts/Makefile.modpost    |  10 +-
>  scripts/genksyms/genksyms.c |  17 +-
>  scripts/link-vmlinux.sh     |  34 +--
>  scripts/mod/file2alias.c    |   2 -
>  scripts/mod/list.h          | 265 +++++++++++++++++++
>  scripts/mod/modpost.c       | 501 ++++++++++++++++++++++--------------
>  scripts/mod/modpost.h       |  24 +-
>  scripts/mod/sumversion.c    |   8 +-
>  14 files changed, 650 insertions(+), 348 deletions(-)
>  create mode 100644 scripts/mod/list.h
>
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
