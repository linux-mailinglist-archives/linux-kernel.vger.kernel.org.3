Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B500F5A0349
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiHXV1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiHXV13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 17:27:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A627C76A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:27:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id l5so13812100qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NrHh48Gf19GlQMqAuAe/NxXBbY/CiWw/bN0ZZpZssVk=;
        b=Hn+k/ujBweFlPuihiZhFdJsivHBvjwnCG0HCpC4oENGJoEFa0bCxazOwVm5o5IRsTv
         usIGaWcI0y1qatxjb7sQVOOENpdPO2pxTSf8VW4hrcPmWo8qBA5aHCyKCO3LIuQ3jy3R
         GAfUD9ZlLtWLS4aYw+tuzZArUx3FGSakUD3bJ8LrlXt0nsRAaqQdQGAowHbn+uu/IqZL
         Qe0iUTJVyQTZINW0S4TbDaQxNR/lfjDk/uj/INvsgkTfotxDGPf9uVlFfQXM1nX3LHnV
         Dt+pwqcQHZNl0z5Wz0CIs54oqU7fZDdaXRs/Iuzh7yRhV6M/QmEv16vuIcNhXXcQPCld
         AzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NrHh48Gf19GlQMqAuAe/NxXBbY/CiWw/bN0ZZpZssVk=;
        b=b48EyeRKRtXp8nCkvu5bclLy1iwYG3odEFpvPZLY7GJQBhgaIaSbsy4xDVvlKq6RcY
         4Lh6qJHmvHzHJofz5NsuZYXAp/bOWQw0LuOch3QInEWmXZ2nFSyEtQAscJ1n7c8PBiTd
         1De8WQVSa2KPbl7aLaLnH0lM5mFH4h1u9Jocwj+xkSa+/mwNdTYQGbBTAwQBZkGsdgnV
         LHPbcxgk9+aEOq7OsGUtMmjnzhvXIyZ+NT8EhmF7bsm04zU2RUs0pZrN7a39lfg3+Yhf
         hAwECayoJcH04YHiBPRbpXRfT9niPGk5PhpMQhw85jtBjeJnNMX2Z0fxbPB8DAFHYSzA
         HJHg==
X-Gm-Message-State: ACgBeo2gDdEvRmGQ2pjyf4l2AWcD+nS2zfpUlxJOFrmFM8aO/+tDzDqm
        5weBTaK1b+nz+oY9QUCdeqk=
X-Google-Smtp-Source: AA6agR5Hd0O/42pHYfqMUlwgpkfZvsFI6xVGd2lr90dapcRYklrPnpIOIDi6u2zbfsJXx9lk3qcgww==
X-Received: by 2002:ac8:7dc4:0:b0:343:622d:5fda with SMTP id c4-20020ac87dc4000000b00343622d5fdamr1115818qte.197.1661376447268;
        Wed, 24 Aug 2022 14:27:27 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5a54:d9d9:c2a4:527e])
        by smtp.gmail.com with ESMTPSA id r17-20020ac85e91000000b00344c29bc045sm6078438qtx.25.2022.08.24.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:27:26 -0700 (PDT)
Date:   Wed, 24 Aug 2022 14:27:26 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2 3/3] lib/find_bit: optimize find_next_bit() functions
Message-ID: <YwaXvphVpy5A7fSs@yury-laptop>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-4-yury.norov@gmail.com>
 <CAHp75Ve4QTSs_mSB7uMqOK4q+A-z-O1tc2k5=2qaRHTdAC3yog@mail.gmail.com>
 <YwYtQ7t+3grPF16n@yury-laptop>
 <CAHp75VfeZVjv_3r4e1uib0BOfxaKTr6Sx59xiUZr=oQ+z_2Fig@mail.gmail.com>
 <CAHp75Vcbkt09J1_reRJFeYAkjoTF1abfvHi1LWc4JyWPpLD=YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcbkt09J1_reRJFeYAkjoTF1abfvHi1LWc4JyWPpLD=YQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 08:56:02PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 8:54 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Aug 24, 2022 at 4:53 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > On Wed, Aug 24, 2022 at 12:19:05PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Aug 24, 2022 at 4:56 AM Yury Norov <yury.norov@gmail.com> wrote:
> 
> ...
> 
> > > > > +#define FIND_NEXT_BIT(EXPRESSION, size, start)                                 \
> > > > > +({                                                                             \
> > > > > +       unsigned long mask, idx, tmp, sz = (size), __start = (start);           \
> > > > > +                                                                               \
> > > > > +       if (unlikely(__start >= sz))                                            \
> > > > > +               goto out;                                                       \
> > > > > +                                                                               \
> > > > > +       mask = word_op(BITMAP_FIRST_WORD_MASK(__start));                        \
> > > > > +       idx = __start / BITS_PER_LONG;                                          \
> > > > > +                                                                               \
> > > > > +       for (tmp = (EXPRESSION) & mask; !tmp; tmp = (EXPRESSION)) {             \
> > > >
> > > > for (unsigned long tmp ...;
> > > > But hey, why not loop over idx (which probably should be named as
> > > > offset)
> > >
> > > Offset in structure, index in array, isn't?
> > >
> > > > as I proposed in the first patch? You will drop a lot of
> > > > divisions / multiplications, no?
> > >
> > > Those divisions and multiplications are optimized away, and
> > > what you suggested blows up the EXPRESSION.
> > >
> > > I tried like this:
> > >    mask = word_op(BITMAP_FIRST_WORD_MASK(__start));
> > >    idx = __start / BITS_PER_LONG;
> > >    tmp = (EXPRESSION);
> > >
> > >    while (1) {
> > >         if (tmp) {
> > >                sz = min(idx * BITS_PER_LONG + __ffs(word_op(tmp)), sz);
> > >                break;
> > >         }
> > >
> > >         if (++idx > sz)
> > >                 break;
> > >
> > >         tmp = (EXPRESSION);
> > >    }
> > >
> > > And it generated the same code, but looks less expressive to me.
> > > If you have some elegant approach in mind - can you please share
> > > it, and how the generated code looks?
> >
> > for (unsigned long idx = 0; idx < sz; idx++) {
> 
> Of source 0 should be changed to whatever start you have there.
> 
> >   unsigned long tmp;
> >
> >   tmp = (EXPRESSION);
> >   if (tmp) {
> >     ...
> >   }
> > }
> >
> > No?

No. For the first iteration, the tmp can't be calculated inside the loop
(my example above is wrong) because we need to clear first bits:

   mask = BITMAP_FIRST_WORD_MASK(__start);
   idx = __start / BITS_PER_LONG;
   tmp = (EXPRESSION) & mask;   // First fetch is here

   while (1) {
        if (tmp) {              // Evaluate here
               sz = min(idx * BITS_PER_LONG + __ffs(tmp), sz);
               break;
        }

        if (++idx > sz)         // Increment here
                break;

        tmp = (EXPRESSION);     // Other fetches here
   }

Trying to move iterator increment inside the for-loop, like you suggested
would break the sequence - common-case word fetch will happen before the
idx++.
