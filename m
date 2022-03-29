Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197DF4EB480
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiC2UNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiC2UNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:13:40 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FB22325E0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:11:56 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b16so22423262ioz.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Hh0vVsE5NsIgTehOa3nlosmMfHWGMN9c6MMyMO5zeA=;
        b=RCfMNSkuStRnGHPd8TI50xmq7vkhNjP1+3HBy1AUUbB8DmgOc0CeB/s2yIVkc0VV2q
         bb3IaX3O/QNfu92Et0gyXFhsOA9+CYX0+sQvitrSQuqIIs8b0WiXb+e0us6ol5URb8z5
         q2JYqiKu2DmH3w+opGujLnnCMgY8VxNseu1l4+qsFtWTHcfhP3prOnA81Huz615X6ma/
         gGzH73c7SVkFU6q37izzYhwLRK0ZDbBPXEgEug8Oxc4rOSNPVfPhSO+xh9sWe42t8nDo
         KIcWdKHr/IWvGkjhIAHQF7+f6dWr5jxI5Hna+4bIEpHK9u5eMgTrk3/iVHYFKcPZKr/J
         wvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Hh0vVsE5NsIgTehOa3nlosmMfHWGMN9c6MMyMO5zeA=;
        b=iO2itVPFSzEyH+5KjZw99FbwUZtd2cA55TXIgJXyN+D2Fi64/MBOrOM0WRzB82Fcah
         gnJ5rrDhuVPrMVERHW+suN6LGL5Nuxgwa57ztNdIFoZlFbqnan+o4BPXXVwZ6WGRSwYT
         J9C7/44VrJ6i/vXG7HqOHQAzDpUxM4shnuAnh1jNwQXiZtV6c5W0sOUJBumuGUlQBKac
         NX+JOH1ps4u2ige2HJ87gR6d+niOzzbVmSZmmbDZMu3DHVx2KFmmaux3ZWJaab4IrpLA
         VyHAFgksOsTGOpp5NeTQkYcu5R3L5I46MGYV/HfLdF1ByDVVMbjV1LPuz+FSLUjbfzaS
         1Cnw==
X-Gm-Message-State: AOAM532j8SayfuzSB0UFoubCQyzFJXpeH919fYd9SOxGZosKyWX9MLTq
        gOVyNXRPmTpLLLeBF+TOv5htvdzT+2/1oBnb/Io=
X-Google-Smtp-Source: ABdhPJyCArHsnFq1o+gDamX8A/FwJjCgzvbDIxBdKui/ziva4Bj/hhbmEWYcj6j0CFZqKXC43krf+JbpRKNmgtj1nJo=
X-Received: by 2002:a05:6638:2113:b0:321:4e19:b04d with SMTP id
 n19-20020a056638211300b003214e19b04dmr18181370jaj.71.1648584716304; Tue, 29
 Mar 2022 13:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648049113.git.andreyknvl@google.com> <CANpmjNP_bWMzSkW=Q8Lc7yRWw8as_FoBpD-zwcweAiSBVn-Fsw@mail.gmail.com>
 <CA+fCnZeiR4v72P1fbF1AP=RqViCnkdtES0NtcmN6-R-_9NS4kQ@mail.gmail.com>
In-Reply-To: <CA+fCnZeiR4v72P1fbF1AP=RqViCnkdtES0NtcmN6-R-_9NS4kQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 29 Mar 2022 22:11:45 +0200
Message-ID: <CA+fCnZcPOfBuOMiXsaQzWMYxG=L_QGVgLDAdNWmYciA0JT+Deg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] kasan, arm64, scs, stacktrace: collect stack
 traces from Shadow Call Stack
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Mar 29, 2022 at 8:36 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Mon, Mar 28, 2022 at 2:36 PM Marco Elver <elver@google.com> wrote:
> >
> > > Changes v1->v2:
> > > - Provide a kernel-wide stack_trace_save_shadow() interface for collecting
> > >   stack traces from shadow stack.
> > > - Use ptrauth_strip_insn_pac() and READ_ONCE_NOCHECK, see the comments.
> > > - Get SCS pointer from x18, as per-task value is meant to save the SCS
> > >   value on CPU switches.
> > > - Collect stack frames from SDEI and IRQ contexts.
> >
> > Do any of these new changes introduce new (noticeable) overhead (in
> > particular patch 2)?
>
> I'll measure the overheads and include the results into v3. Thanks!

Hm, looks like the overhead is overly significant: ~5%. I'll explore a
different approach in v3 instead.
