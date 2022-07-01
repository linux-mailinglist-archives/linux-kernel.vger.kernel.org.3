Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8512756317A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiGAKfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGAKe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:34:56 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BD174345
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:34:53 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y16so3085455lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9tKEj16d5tR2G+qnALq6e2umf1wAchyZTQfWhHn/lQ=;
        b=hOWskhaT9BnBIvhYHwEipW3tIPTPzs+uwhJQcQvKiX36zsPu3hbdGi8car8k4C3Nv4
         a6jxrlWgQRh9j0Jd3iCSsI3CPEJzdXY1sutH2NrQJ/KpqS+zPNvUYv/xARIGCRgIqcwu
         P/NAQjBIxMV9QslcP9CZrDbXa3KC57R3bnGRB/4DOPcKG/V3VD/V4K+kVa/1Y6wmhvCs
         cPq67bZWiz9SS8D9C8PNjVBnuCkOSzQVjwmFQHqcSbTiNzjTF/H9M2aQFrEybJFd6duW
         jlLYHBlYx1BcpPQ41+nKa34vmIlYNmKk9wOeAnJCYZNEzdKAuhmfXTaSY0rryr1usjYj
         jJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9tKEj16d5tR2G+qnALq6e2umf1wAchyZTQfWhHn/lQ=;
        b=fc6NcoQUh4jS33HIJ0JCUKT+7YSOQiZWzq84KOKi/b590E0GdyqqK/wW2X/1AzuU1T
         cNIZmWDs4QIO34mlpoUjHa1/PrUSIZluiM0dBn7hN+KVAF+NlLxtWARVaTTMIPA9w83i
         0Vsf2Hxv5UkqOOedm1st/5G+RJbrFnyZ8gTLuIzsBXSIo32VyUkEqSjs23hJM6i2B5o/
         3J3139kXl20W+nInqtarQQmFSA57f2YngXC0LlC8hxMqRm1EPrjfMmkxhSlilNW7sqrt
         leC+QtFAwddOrrCTBjQqAGGXMrEJsjySPELl1wtSbhG29XCnTbbYiBot3JEIsDO+6pxh
         ynxQ==
X-Gm-Message-State: AJIora8qknNduk2fQCtKh1U61mlZB1gafi/l6k4244EeRTgZigUhn64S
        zl4hDQyl17XgAECddKi2NBGPpp9HzLYwkyujf51scA==
X-Google-Smtp-Source: AGRyM1v5FUVOat6gmgFRKbQSnfiJy8R8hSU6Xh0lZv1nXMkdfAeKL5kC85n2Od+ElP7r82Pw5f9ECw9k9nrZtDTko/w=
X-Received: by 2002:a05:6512:10c3:b0:47f:a97e:35c with SMTP id
 k3-20020a05651210c300b0047fa97e035cmr8666355lfg.417.1656671686899; Fri, 01
 Jul 2022 03:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220630080834.2742777-1-davidgow@google.com> <20220630080834.2742777-2-davidgow@google.com>
 <CACT4Y+ZahTu0pGNSdZmx=4ZJHt4=mVuhxQnH_7ykDA5_fBJZVQ@mail.gmail.com>
 <20220630125434.GA20153@axis.com> <CA+fCnZe6zk8WQ7FkCsnMPLpDW2+wJcjdcrs5fxJRh+T=FvFDVA@mail.gmail.com>
 <CABVgOSmxnTc31C-gbmbns+8YOkpppK77sdXLzASZ-hspFYDwfA@mail.gmail.com>
 <20220701091653.GA7009@axis.com> <CABVgOSnEEWEe16O4YsyuiWttffdAAbkpuXehefGEEeYvjPqVkA@mail.gmail.com>
 <20220701100441.GA8082@axis.com>
In-Reply-To: <20220701100441.GA8082@axis.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Jul 2022 12:34:35 +0200
Message-ID: <CACT4Y+ZvPDLR_e2VR8+hKZ+fnLo9_KkTTgUMqqM1kaoo0kW-fA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] UML: add support for KASAN under x86_64
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     David Gow <davidgow@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>
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

On Fri, 1 Jul 2022 at 12:04, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
> > <vincent.whitchurch@axis.com> wrote:
> > > On Fri, Jul 01, 2022 at 11:08:27AM +0200, David Gow wrote:
> > > > On Thu, Jun 30, 2022 at 9:29 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> > > > > Stack trace collection code might trigger KASAN splats when walking
> > > > > stack frames, but this can be resolved by using unchecked accesses.
> > > > > The main reason to disable instrumentation here is for performance
> > > > > reasons, see the upcoming patch for arm64 [1] for some details.
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=802b91118d11
> > > >
> > > > Ah -- that does it! Using READ_ONCE_NOCHECK() in dump_trace() gets rid
> > > > of the nasty recursive KASAN failures we were getting in the tests.
> > > >
> > > > I'll send out v5 with those files instrumented again.
> > >
> > > Hmm, do we really want that?  In the patch Andrey linked to above he
> > > removed the READ_ONCE_NOCHECK() and added the KASAN_SANITIZE on the
> > > corresponding files for arm64, just like it's already the case in this
> > > patch for UML.
> >
> > Personally, I'm okay with the performance overhead so far: in my tests
> > with a collection of ~350 KUnit tests, the total difference in runtime
> > was about ~.2 seconds, and was within the margin of error caused by
> > fluctuations in the compilation time.
> >
> > As an example, without the stacktrace code instrumented:
> > [17:36:50] Testing complete. Passed: 364, Failed: 0, Crashed: 0,
> > Skipped: 47, Errors: 0
> > [17:36:50] Elapsed time: 15.114s total, 0.003s configuring, 8.518s
> > building, 6.433s running
> >
> > versus with it instrumented:
> > [17:35:40] Testing complete. Passed: 364, Failed: 0, Crashed: 0,
> > Skipped: 47, Errors: 0
> > [17:35:40] Elapsed time: 15.497s total, 0.003s configuring, 8.691s
> > building, 6.640s running
>
> OK, good to know.
>
> > That being said, I'm okay with disabling it again and adding a comment
> > if it's slow enough in some other usecase to cause problems (or even
> > just be annoying). That could either be done in a v6 of this patchset,
> > or a follow-up patch, depending on what people would prefer. But I'd
> > not have a problem with leaving it instrumented for now.
>
> I don't have any strong opinion either way either, so you don't have to
> change it back on my account.  Thanks.

I would consider using READ_ONCE_NOCHECK() by default. And then
switching to KASAN_SANITIZE:=n only if there is a real reason for
that. Disabling instrumentation of any part of the kernel makes things
faster, but at the same time we are losing checking coverage.
For arm it was done for a very specific reason related to performance.
While UML can be considered more test-oriented rather than
production-oriented.
