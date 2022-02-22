Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F84C0101
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiBVSLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiBVSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:11:33 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C15172E4F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:11:07 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id b35so15196099ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vv7itYaWRJkHxlIs8WR7327QmS0peJ/llMiCwV0cNp4=;
        b=ntHc747k5aYWBHe1Z4y8Fz2hJW4Fo8vJrUB6RCyrfijB27K/aykNq2x0JK92KJb0Va
         pwP/1ZtoHgqMRBWweSv0ilf1vQEpcsnawUZ0OAwYy6w/1iI/mrGqGG9vblnHUVZTtDJx
         MHpZPxOKwaHVUSPTyYbjSv/ykCPTrukRBMGvv6mW1RzTnRHsXjZ8lU2fDtFFAfNu41AY
         szR4OFwkl/O4caKzEa358VDkAMObruixk1FuzcCX5OkNRTe/Nx4uaLOmn2fq0PgYakiu
         1FJqjif+5EnY6SbVyUHV785ILiApP/kChvVG7PCui2yjHtDnm9qcBmgOF6psQ6T3yPVo
         pMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vv7itYaWRJkHxlIs8WR7327QmS0peJ/llMiCwV0cNp4=;
        b=YdmCiWhKMrPrn3U1cIhRfgq4SsicmGNAyKToSBB/lWHtWhnfClfrpK7WqPsdnYB4BS
         xuH7gNRPr2LHSd/DET+GydEQUp8z0txRzCdVVCysFa5y5nudyyPlaD0cP2b19xDWCc08
         17/jjDQqjemmv7fuNXAB3x+VUvE+20yfOtEQDjZ6MXRIqLbkjmLwSqhUvRcJgz87yhKO
         F8tT8F6WGkQt7JmP+2DwNQfyWoUxNdfO7uy8uhcaxy1MC0duQYMzamqvFUAX1mdfZfQR
         J9LELJKlnupENG3V27viRlV2y1+zonaGH8QqcTgbSSs5QzIpEJOyDN73LXmJDlXEJr+g
         joLA==
X-Gm-Message-State: AOAM533m5PUS59UFF4nzMALetsmPZzBbE8+OTb7TBPnmXEiM3OqN65Wm
        glJt4OGQBELG5RZRrtaCKBOhb13NHiFPqmAa0Y94Mw==
X-Google-Smtp-Source: ABdhPJwaQcThOmQlZPbhYVDEyVpHw2j2uPxfEwpatir200X9OqS1YlFR+Zo074lIz0Rev1o0RmzFhEcmDSaxOvOkHZI=
X-Received: by 2002:a25:e057:0:b0:624:2ade:2a8f with SMTP id
 x84-20020a25e057000000b006242ade2a8fmr23575031ybg.87.1645553466469; Tue, 22
 Feb 2022 10:11:06 -0800 (PST)
MIME-Version: 1.0
References: <2d44632c4067be35491b58b147a4d1329fdfcf16.1645549750.git.andreyknvl@google.com>
 <CANpmjNOnr=B_o83BJ6b1S6FKWe+p2vR58H8CHtGPNPnu6-cQZg@mail.gmail.com> <CA+fCnZf2jE1N8j9iQRtOnQsTP=2CQOGYqREbzypPQa-=UXjhDA@mail.gmail.com>
In-Reply-To: <CA+fCnZf2jE1N8j9iQRtOnQsTP=2CQOGYqREbzypPQa-=UXjhDA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Feb 2022 19:10:55 +0100
Message-ID: <CANpmjNN3-qX_brk9PTW0MkF0H=-DeM+n_ccge_QQ07oKBPx74w@mail.gmail.com>
Subject: Re: [PATCH mm] another fix for "kasan: improve vmalloc tests"
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 at 19:08, Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Tue, Feb 22, 2022 at 6:50 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 22 Feb 2022 at 18:10, <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > set_memory_rw/ro() are not exported to be used in modules and thus
> > > cannot be used in KUnit-compatible KASAN tests.
> > >
> > > Drop the checks that rely on these functions.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  lib/test_kasan.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > index ef99d81fe8b3..448194bbc41d 100644
> > > --- a/lib/test_kasan.c
> > > +++ b/lib/test_kasan.c
> > > @@ -1083,12 +1083,6 @@ static void vmalloc_helpers_tags(struct kunit *test)
> > >         KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
> > >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
> > >
> > > -       /* Make sure vmalloc'ed memory permissions can be changed. */
> > > -       rv = set_memory_ro((unsigned long)ptr, 1);
> > > -       KUNIT_ASSERT_GE(test, rv, 0);
> > > -       rv = set_memory_rw((unsigned long)ptr, 1);
> > > -       KUNIT_ASSERT_GE(test, rv, 0);
> >
> > You can still test it by checking 'ifdef MODULE'. You could add a
> > separate test which is skipped if MODULE is defined. Does that work?
>
> Yes, putting it under ifdef will work. I thought that having a
> discrepancy between built-in and module tests is weird, but I see the
> kprobes tests doing this, so maybe it's not such a bad idea. Will do
> in v2.

Additionally you could have the test skip with kunit_skip(), so it's
at least visible. The code itself has to be #ifdef'd I guess because
set_memory_*() aren't even declared ifdef MODULE (I think?).
