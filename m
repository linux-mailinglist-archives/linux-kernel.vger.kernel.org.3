Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBA64C0142
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiBVS2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiBVS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:27:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFEEDF18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:27:33 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s1so21284359iob.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oObgooNlIOOo2XH59U0uuMMQ0kQeglBbkBAVHE8QeMY=;
        b=X1llFE4v/VRY2AuGSXbi23JXDtqqNaDh8fsyxisBfmcm7wEEv4bWP72G2JYWO6xIzm
         SeGiigJk+ptFVCouzFfg3QnP+4I0eLjF8kaTLVDdxTZOZxMvLR6QyZPhd6fYSMQM145L
         PSnL+n5akM1CZs6QQjmwCu/NWE4cckJNyfw8u4Po0NmGPCC1qOJ+gKj3SWYdgh4jmfDd
         zF+aEAirtu+m2K3aF1ZOfPZJQhmUgKCnfYceLtv83Kujk3tL25Rvc2IJWPp1j1e/rmyY
         B7JNBRDn8IwZ3tirtUqsUPQvIFKa9XpxRvBZiKn1gTxymYRFJGdm9yqjK3sO9qBieHye
         TYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oObgooNlIOOo2XH59U0uuMMQ0kQeglBbkBAVHE8QeMY=;
        b=jRVQZhO8PFikPuZUV6gQeg8dIChmGvfaGOxjS40RDXcNcnTilUhBfRJaXD27D2p7x6
         Ps0Tl7ENv5c+bNi7yGsLYijJXvbaqwV+vrxH0xJEElLVI6VPg41/Ro1D3RxiXTLuKTCR
         9UvDgszuFnPUIAM74NGufA9Hoyt2UEDG2/gy5JLKCmb24g0hETzO79sibmkFeRnoRrsQ
         TYyJZPJ4smGRgTg4txGDpMr/XKhtW0mvyN8PmRvQQ4sQOZyhjXP+zG5S9ApXGSbZrHr7
         L1sfg5f7IlXjkpj5cPofGE8EMMDqwzSnzQOQUHPeFCDXoFR5XlcgqbzaRn+U2wTGJC9V
         BKTA==
X-Gm-Message-State: AOAM530Lr7URtGkxsIWmJUcv+iJw34feoXizcV3QDMQRMNKRhBn4WCht
        DlRvxd6MfPlGnTwqmAnGRcrfVdB9AnTwlIRcMow=
X-Google-Smtp-Source: ABdhPJxKwsq7f7dnfDsFJ6WHUNfvkDEUzXGGIJmptnXcDExfCbRTViGGivFLy7UWteShDO/PE95/U+nRjeCf+HgkBd0=
X-Received: by 2002:a05:6638:10b:b0:314:ef3d:bfe4 with SMTP id
 x11-20020a056638010b00b00314ef3dbfe4mr6978543jao.218.1645554452615; Tue, 22
 Feb 2022 10:27:32 -0800 (PST)
MIME-Version: 1.0
References: <2d44632c4067be35491b58b147a4d1329fdfcf16.1645549750.git.andreyknvl@google.com>
 <CANpmjNOnr=B_o83BJ6b1S6FKWe+p2vR58H8CHtGPNPnu6-cQZg@mail.gmail.com>
 <CA+fCnZf2jE1N8j9iQRtOnQsTP=2CQOGYqREbzypPQa-=UXjhDA@mail.gmail.com> <CANpmjNN3-qX_brk9PTW0MkF0H=-DeM+n_ccge_QQ07oKBPx74w@mail.gmail.com>
In-Reply-To: <CANpmjNN3-qX_brk9PTW0MkF0H=-DeM+n_ccge_QQ07oKBPx74w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 22 Feb 2022 19:27:21 +0100
Message-ID: <CA+fCnZfy=c3haZqqmeBo6P1Fmt5s7dqt1jVfk=MEAJpCwuaR3A@mail.gmail.com>
Subject: Re: [PATCH mm] another fix for "kasan: improve vmalloc tests"
To:     Marco Elver <elver@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 7:11 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 22 Feb 2022 at 19:08, Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Tue, Feb 22, 2022 at 6:50 PM Marco Elver <elver@google.com> wrote:
> > >
> > > On Tue, 22 Feb 2022 at 18:10, <andrey.konovalov@linux.dev> wrote:
> > > >
> > > > From: Andrey Konovalov <andreyknvl@google.com>
> > > >
> > > > set_memory_rw/ro() are not exported to be used in modules and thus
> > > > cannot be used in KUnit-compatible KASAN tests.
> > > >
> > > > Drop the checks that rely on these functions.
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > ---
> > > >  lib/test_kasan.c | 6 ------
> > > >  1 file changed, 6 deletions(-)
> > > >
> > > > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > > > index ef99d81fe8b3..448194bbc41d 100644
> > > > --- a/lib/test_kasan.c
> > > > +++ b/lib/test_kasan.c
> > > > @@ -1083,12 +1083,6 @@ static void vmalloc_helpers_tags(struct kunit *test)
> > > >         KUNIT_ASSERT_TRUE(test, is_vmalloc_addr(ptr));
> > > >         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vmalloc_to_page(ptr));
> > > >
> > > > -       /* Make sure vmalloc'ed memory permissions can be changed. */
> > > > -       rv = set_memory_ro((unsigned long)ptr, 1);
> > > > -       KUNIT_ASSERT_GE(test, rv, 0);
> > > > -       rv = set_memory_rw((unsigned long)ptr, 1);
> > > > -       KUNIT_ASSERT_GE(test, rv, 0);
> > >
> > > You can still test it by checking 'ifdef MODULE'. You could add a
> > > separate test which is skipped if MODULE is defined. Does that work?
> >
> > Yes, putting it under ifdef will work. I thought that having a
> > discrepancy between built-in and module tests is weird, but I see the
> > kprobes tests doing this, so maybe it's not such a bad idea. Will do
> > in v2.
>
> Additionally you could have the test skip with kunit_skip(), so it's
> at least visible. The code itself has to be #ifdef'd I guess because
> set_memory_*() aren't even declared ifdef MODULE (I think?).

I sent v2 with the simplest approach without an additional test. I
hope that's OK with you.
