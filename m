Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940735ADA72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiIEUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiIEUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:54:00 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4A14E633
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:53:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s22so6944139qkj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3/RM6NI1xD0KfggIAxAiR262mP+cF5baa1PLRg4NH9k=;
        b=G9z+EvS2Wqtba+jOm4m0Qbrf2RRYIzrnD3zMzFbZB8qkKbNj5ESH83zXxDU77a4zjl
         FrtqCU5yfAe13CuDf6LETaMDJdUthJHHXUxPqNPMlSIR3Vs9dp72B4HoJ+pebLtTpV8a
         kyrf2xtzwrYUITUTGeyH0cFRYYwGUuYjhefkyFc9Gr/EbCLmHKnvBJsHzSVsZHkjCj6g
         XjEkMmwK97V/siI7AUUvAM+WDwegohtOyngq9z4kWi/EwTunI2XDdv/bu2al0AF1jK2i
         00zh3xjpybLOW2e8qVuBBaVkEbWw2MRM80U02hQrU8cxfBViOjCom+Tfi7pvZn9XhlrC
         +RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3/RM6NI1xD0KfggIAxAiR262mP+cF5baa1PLRg4NH9k=;
        b=koIDAq/VonrH4uAyo0pYVok9mWl3ocfz6AxbnGtl1kRlb9CY6wnhRIuyJDML0T/YNO
         2NTrEXHNNc9Kfurrv9F0N/olh1FZ0G7xvaNs9E+p0TfhHHhSBpDu6ySrBaXQGIwMgG8/
         W4TI+KJ+9Gq+aVI8BcYKsYkumPO+HzluX8jaLqqRYTqEUeunGpK5x7nLhhsxpuKos6xO
         ckuUs1O87KOna9/koKPyjX4LNET5DkYTA79XOXdWUKP4UYMzPuYfDXRq5fiQCUnCm+1N
         AtPuKYZbRqcfnc/Ik+O0hCDKc9M5KzxPH6IjhMC+7/IGsC+dN91dCJDlTb5q/vpoXxtf
         fmqQ==
X-Gm-Message-State: ACgBeo1C29Sb+B9aWWeUbOXHfZRagyIE2KIrNIc8D0VLGQALIsd0K0ba
        E0+tUbXRMPc0ipEGagIHMvn2zGu6D3tS9iFW5sSiUoGt
X-Google-Smtp-Source: AA6agR7Amw2WalDpZucZ1oitGN5MjQaghekEeU9fuF2XzEtK0QuRIU4bQFyx4PeLU8qCSXja7lgFHquh5uhVEI1WCnI=
X-Received: by 2002:a05:620a:843:b0:6be:86a8:4099 with SMTP id
 u3-20020a05620a084300b006be86a84099mr28542817qku.386.1662411238391; Mon, 05
 Sep 2022 13:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220901044249.4624-1-osalvador@suse.de> <20220901044249.4624-2-osalvador@suse.de>
 <YxBsWu36eqUw03Dy@elver.google.com> <YxBvcDFSsLqn3i87@dhcp22.suse.cz> <CANpmjNNjkgibnBcp7ZOWGC5CcBJ=acgrRKo0cwZG0xOB5OCpLw@mail.gmail.com>
In-Reply-To: <CANpmjNNjkgibnBcp7ZOWGC5CcBJ=acgrRKo0cwZG0xOB5OCpLw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Sep 2022 22:53:47 +0200
Message-ID: <CA+fCnZckFNqDA2SJSMjM7gpUF_U7Ps_3u+JzvN_cKvskz0FuOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib/stackdepot: Add a refcount field in stack_record
To:     Marco Elver <elver@google.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
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

On Thu, Sep 1, 2022 at 11:18 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, 1 Sept 2022 at 10:38, Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 01-09-22 10:24:58, Marco Elver wrote:
> > > On Thu, Sep 01, 2022 at 06:42AM +0200, Oscar Salvador wrote:
> > [...]
> > > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > > index 5ca0d086ef4a..aeb59d3557e2 100644
> > > > --- a/lib/stackdepot.c
> > > > +++ b/lib/stackdepot.c
> > > > @@ -63,6 +63,7 @@ struct stack_record {
> > > >     u32 hash;                       /* Hash in the hastable */
> > > >     u32 size;                       /* Number of frames in the stack */
> > > >     union handle_parts handle;
> > > > +   refcount_t count;               /* Number of the same repeated stacks */
> > >
> > > This will increase stack_record size for every user, even if they don't
> > > care about the count.
> >
> > Couldn't this be used for garbage collection?
>
> Only if we can precisely figure out at which point a stack is no
> longer going to be needed.
>
> But more realistically, stack depot was designed to be simple. Right
> now it can allocate new stacks (from an internal pool), but giving the
> memory back to that pool isn't supported. Doing garbage collection
> would effectively be a redesign of stack depot. And for the purpose
> for which stack depot was designed (debugging tools), memory has never
> been an issue (note that stack depot also has a fixed upper bound on
> memory usage).
>
> We had talked (in the context of KASAN) about bounded stack storage,
> but the preferred solution is usually a cache-based design which
> allows evictions (in the simplest case a ring buffer), because
> figuring out (and relying on) where precisely a stack will
> definitively no longer be required in bug reports is complex and does
> not guarantee the required bound on memory usage. Andrey has done the
> work on this for tag-based KASAN modes:
> https://lore.kernel.org/all/cover.1658189199.git.andreyknvl@google.com/

To be clear, the stack ring buffer implementation for the KASAN
tag-based modes still uses the stack depot as a back end to store
stack traces.

I plan to explore redesigning the stack depot implementation to allow
evicting unneeded stack traces as the next step. (The goal is to have
a memory-bounded stack depot that doesn't just stop collecting stack
traces once the memory limit is reached.) Having a refcount for each
saved stack trace will likely be a part of this redesign.
