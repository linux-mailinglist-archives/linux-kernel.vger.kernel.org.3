Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E977651626E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 09:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbiEAHQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiEAHQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 03:16:33 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6640905;
        Sun,  1 May 2022 00:13:08 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2417CZFw016137;
        Sun, 1 May 2022 16:12:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2417CZFw016137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651389156;
        bh=rzhEXT1X31fguWPQ7004i1oNVrShnmVqk67uWBhXjuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQ6U/BcBVcmkkA+pt5kpHxVkA8QvRIy8atOf+erkx1AY3ba6oPdzqfxmRTAmrfkWp
         /8zBFjzNKEhvzxnFFs0+WsdYnzkhqy0t6Payc06i6101hXsdBmT2K3uWQiznZRpAXE
         sK+UgqdgV9gJG01wf8cwmWYsYSfrjRENDr1CJNVdVGAnhcDGeCDSO9hNN/5gUCTEhv
         xIR9V3u3p4KoY7ehsPYyg84ZHsnQow46pJxJZqSRrLOCCdVIhEJc5gq8lyJyiaqX5T
         kZAzz1gBJAqKzIt4A6H8kvfjnmHmN9VTC7dUAjpZXp2yQ/N8BI59/bB7P97S6tuQPz
         0tfhY7hIN/rXQ==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id k1so1743807pll.4;
        Sun, 01 May 2022 00:12:36 -0700 (PDT)
X-Gm-Message-State: AOAM531foUVDGSrk281pVvbHdsLpJLwqwGcSDqAZZKLCbnmX6JCpbhYe
        m3pEi8RSqk6uFvOesKzKyn32ctn+ImyEfIBn8aU=
X-Google-Smtp-Source: ABdhPJzihF+mJLqLHkUCAj8G8hH6nzYJWYdq/igi1VnQjZ+WPaiZsgRFpa495cT/OJZe9DwpW5onI0gGGBCz+yrlSJ0=
X-Received: by 2002:a17:903:1205:b0:15e:8cbc:fd2b with SMTP id
 l5-20020a170903120500b0015e8cbcfd2bmr6318169plh.99.1651389155207; Sun, 01 May
 2022 00:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org>
 <YmhRz1SEjpEU8Nty@fjasle.eu> <CAK7LNAS4X2d+7JgRSMizMsKFAKmF1OLXyJ0YAvzdgBuSB+UnfQ@mail.gmail.com>
In-Reply-To: <CAK7LNAS4X2d+7JgRSMizMsKFAKmF1OLXyJ0YAvzdgBuSB+UnfQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 May 2022 16:11:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR6_L17MfymVd9dDtcqBJ_E53tk5TGfsJvcro6+dLL6Jw@mail.gmail.com>
Message-ID: <CAK7LNAR6_L17MfymVd9dDtcqBJ_E53tk5TGfsJvcro6+dLL6Jw@mail.gmail.com>
Subject: Re: [PATCH 00/27] kbuild: yet another series of cleanups (modpost and LTO)
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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

On Wed, Apr 27, 2022 at 12:18 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Apr 27, 2022 at 5:11 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Mon, Apr 25, 2022 at 04:07:44AM +0900 Masahiro Yamada wrote:
> > > This is the third batch of cleanups in this development cycle.
> > >
> > > This weekend, I wrote up the code I have been planning.
> > >
> > > After a bunch of modpost refactoring, I got rid of the ugly code
> > > in Makefiles.
> > >
> > > With this, Kbuild will get back much simpler and cleaner.
> > >
> >
> > Hi Masahiro,
> >
> > I tried applying the patch set onto your kbuild and
> > kbuild-fixes-v5.18, but it didn't apply.  Can you give me
> > a hint on your commit base?
>
>
> This series is based on  linux-kbuild/kbuild branch
> 7c39c50dcb74 ("scripts: dummy-tools, add pahole")
>
>
> Anyway, this series is too big.
> For convenience, I pushed this to a topic branch.
>
> Please try:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
>  lto-cleanup
>
>
>
>
>
> > Kind regards,
> > Nicolas
> >
> > >
> > > Masahiro Yamada (27):
> > >   modpost: use snprintf() instead of sprintf() for safety
> > >   modpost: do not write out any file when error occurred
> > >   modpost: remove stale comment about sym_add_exported()
> > >   modpost: add a separate error for exported symbols without definition
> > >   modpost: retrieve the module dependency and CRCs in check_exports()
> > >   modpost: use bool type where appropriate
> > >   modpost: import include/linux/list.h
> > >   modpost: traverse modules in order
> > >   modpost: add sym_add_unresolved() helper
> > >   modpost: traverse unresolved symbols in order
> > >   modpost: use doubly linked list for dump_lists
> > >   modpost: move struct namespace_list to modpost.c
> > >   modpost: traverse the namespace_list in order
> > >   modpost: dump Module.symvers in the same order of modules.order
> > >   modpost: move static EXPORT_SYMBOL check to check_exports()
> > >   modpost: make multiple export error
> > >   modpost: make sym_add_exported() always allocate a new symbol
> > >   modpost: make sym_add_exported() a void function
> > >   modpost: use hlist for hash table implementation
> > >   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
> > >   kbuild: record symbol versions in *.cmd files
> > >   kbuild: generate a list of objects in vmlinux
> > >   modpost: retrieve symbol versions by parsing *.cmd files
> > >   modpost: generate linker script to collect symbol versions
> > >   kbuild: embed symbol versions at final link of vmlinux or modules
> > >   kbuild: stop generating *.symversions
> > >   kbuild: do not create *.prelink.o for Clang LTO or IBT

01-05 and 12 applied.

I will send v2 for the rest.




-- 
Best Regards
Masahiro Yamada
