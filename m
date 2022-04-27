Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E54510F12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357328AbiD0DCW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Apr 2022 23:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiD0DCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:02:19 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFEB16E6B4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:59:10 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f7d19cac0bso4248537b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vL0sN0rEAukjQ21K/pOOPY/pAChiTkKbeSfIxoIjIg=;
        b=JxMIgbBPFLXbgIcRh0hoIBrRrgQBzJTgIGNmHMnpQCFQY/iTUK4MxD5cBdqO+uTJY6
         2oN0kRal/tndIrgJqsaFhVuLB40+diV3BB/ZWCkrDY3zrF7I0pZNkU9LI46RSM/knKg3
         P7yJbVcecbrLrh3l2aOSJq7A6TcGn3un/84R2d8xGhWXKHckSjG9Ef31EqiGKeF47c3U
         J8ZaSjf1l1PqQZ+hlM/3qoBsdfuTCdnvJthln2qfJ7iqJSXaa24/4qKFKrcfgZFCs7xV
         HXiySRCu2hprnM8VqNz6h+T/udSDa8jmVB7qmJ/ZgaIUQmUQFVUac/UhgxR+GnqWqLKA
         Kriw==
X-Gm-Message-State: AOAM5324/DobxvDV/RIJ2tKOyeVirHHnT6niIkl8BGLLATFRx3GLYTE/
        kZxA8oBJ8kZQUav2vbdLtVtV6Dp9l2gEQB0Hn+A=
X-Google-Smtp-Source: ABdhPJxuOKbSbtSYEK2PscBj01MMpuiLKLLk1ppADQSGSStMpoHVCu1Ypg4NI92XNWkLQ6BXRDTo3BHFyJMSn2N0xFg=
X-Received: by 2002:a81:8cf:0:b0:2f4:da59:9eef with SMTP id
 198-20020a8108cf000000b002f4da599eefmr25834657ywi.78.1651028349276; Tue, 26
 Apr 2022 19:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr> <YmhZSZWg9YZZLRHA@yury-laptop>
In-Reply-To: <YmhZSZWg9YZZLRHA@yury-laptop>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 27 Apr 2022 11:58:58 +0900
Message-ID: <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
Subject: Re: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings
 by 34% tree-wide
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gcc@gcc.gnu.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Alexander Lobakin <alexandr.lobakin@intel.com>

On Wed. 27 Apr 2022 at 05:42, Yury Norov <yury.norov@gmail.com> wrote:
> + gcc@gcc.gnu.org
> + Rikard Falkeborn <rikard.falkeborn@gmail.com>
>
> On Wed, Apr 27, 2022 at 01:16:58AM +0900, Vincent Mailhol wrote:
> > find_first_bit(), find_first_and_bit(), find_first_and_bit() and
> > find_first_and_bit() all invokes GENMASK(size - 1, 0).
> >
> > This triggers below warning when compiled with W=2.
> >
> > | ./include/linux/find.h: In function 'find_first_bit':
> > | ./include/linux/bits.h:25:36: warning: comparison of unsigned
> > | expression in '< 0' is always false [-Wtype-limits]
> > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > |       |                                    ^
> > | ./include/linux/build_bug.h:16:62: note: in definition of macro
> > | 'BUILD_BUG_ON_ZERO'
> > |    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > |       |                                                              ^
> > | ./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
> > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > |       |                 ^~~~~~~~~~~~~~
> > | ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > |    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > |       |          ^~~~~~~~~~~~~~~~~~~
> > | ./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
> > |   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > |       |                                             ^~~~~~~
> >
> > linux/find.h being a widely used header file, above warning show up in
> > thousand of files which include this header (either directly on
> > indirectly).
> >
> > Because it is a false positive, we just silence -Wtype-limits flag
> > locally to remove the spam. clang does not warn about it, so we just
> > apply the diag_ignore() directive to gcc.
> >
> > By doing so, the warnings for a W=2 build are reduced by
> > 34%. Benchmark was done with gcc 11.2.1 on Linux v5.17 x86_64
> > allyesconfig (except CONFIG_WERROR). Beforethe patch: 515496 warnings
> > and after: 340097.
> >
> > For reference, past proposal to modify GENMASK_INPUT_CHECK() was
> > rejected in:
> > https://lore.kernel.org/all/20220304124416.1181029-1-mailhol.vincent@wanadoo.fr/
>
> So, here is nothing wrong with the kernel code and we have an alternative
> compiler (clang) that doesn't throw Wtype-limits. It sounds to me like an
> internal GCC problem, and I don't understand how hiding broken Wtype-limits
> on kernel side would help people to improve GCC.
>
> On the thread you mentioned above:
>
> > > > > Have you fixed W=1 warnings?
> > > > > Without fixing W=1 (which makes much more sense, when used with
> > > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > > >
> > > > How is this connected?
> > >
> > > By priorities.
> > > I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.
> >
> > *My code* compiles for W=1. For me, fixing this W=2 in the next in line
> > if speaking of priorities.
> >
> > I do not understand why I should be forbidden to fix a W=2 in the
> > file which I am maintaining on the grounds that some code to which
> > I do not care still has some W=1.
>
> If you are concerned about a particular driver - why don't you silence
> the warning in there? Or alternatively build it with clang?

Sorry if my previous comments looked selfish. I used the first
person to illustrate my point but because this W=2 appears in
thousands of files my real intent is to fix it for everybody, not
only for myself.

> With all that, I think that the right way to go is to fix the root
> cause of this churn - broken Wtype-limits in GCC, and after that move
> Wtype-limits to W=1. Anything else looks hacky to me.

Why is this use of __diag_ignore() hacky compared when compared
to the other use of __diag_ignore() or the use of -Wno-something
in local Makefiles?

I did my due diligence and researched GCC’s buzilla before
sending this patch. There is an opened ticket here:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86647

In a perfect word, yes, all false positives should be fixed in
the compiler, but the reality is that this bug was reported in
July 2018, nearly four years ago. GCC developers have their own
priorities and fixing this bug does not appear to be part of
those. And I do not have the knowledge of GCC's internals to fix
this myself.  So what do we do next, blame GCC and do nothing or
silence it on our side in order to have a mininfull W=2 output?


Yours sincerely,
Vincent Mailhol
