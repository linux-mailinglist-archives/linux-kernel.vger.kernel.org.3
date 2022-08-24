Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BD25A00D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiHXR5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbiHXR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:56:41 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC912316B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:56:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m5so10622664qvo.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9CXiN/f38xrjnVFAJBLJLmpUxNRcRVRzq1k058bxfcw=;
        b=eF7ZWWTCO2FIyRuX+ks4C8xUfsfE+qppB9UMsrM9mAcoAHSGzFbBXhjxOfhJOyNcae
         cRm92PQak1NihUM2n8USl2GwycUmw+0poGQVHLbfQ77BvE5aTuUCeDabGsKvXvR7E+0w
         /lu/KaIIo+1PRB8TXvJU68jligK4yuZYrgylmK3+qU7WPKRu+1SgEM1c/czEI+iMPpPt
         jzYsAyqvUAeGojgjmxoFj60NCD/B9Yiqcgt4x2Oec7/ahns+jIqFLFnch6h8s5o3frrP
         GjbTbbvPimGWNdQf5a1hkZTjmc4srCjL4huMrYOenQefkyLRbqmb2OFF0QqtJrcy0zPd
         2vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9CXiN/f38xrjnVFAJBLJLmpUxNRcRVRzq1k058bxfcw=;
        b=yArZYELUwIbmT6Dejj2E7mDieb1rf70rjrn7qhajnnfXlEJEpfetxy4perTHQ0Bxx2
         wueQOiub7qDgDWLd6Wzz+tp7d4XyNH+gApzrbkviXptEyi+ElzNt15Rsg1uA3hLQl/QN
         qhIMlvhKv2R8ETRSxehxtDKZ5EqOGPOB1HsSYb2RftOvs2eowCxd7/G57jaBjkg8yM9d
         XRBPQUfAfDl0kBpns6lsS8zqpKeeDesx4y78xfbvuxHl9Jf7mieMFgNguOEDulFX4Sc2
         tQGUIi+f7jVFRr88GvxzodC9/jPzjDrhWBxK8EHJ9/WHxPUMcvwdHpNmkNp1IHzsYHKu
         3NZA==
X-Gm-Message-State: ACgBeo3GvNFaP8CDKdI/zlDrQ2qjEimL6dXcGWEpLwL7oqHwAU9K4aov
        RY+JUqk9zrF4d5Z9WMThtiPOT0pOuZNp1Na+BHw=
X-Google-Smtp-Source: AA6agR7pluq5O36CBJks5Xc9+UK7HlT2mBW7KgJAZ8nY/CvgYULqlntzspVSB2Ck3kDWvvUnZumTUf/eaUkkSTb6hNI=
X-Received: by 2002:ad4:4eaf:0:b0:496:ac46:2d9c with SMTP id
 ed15-20020ad44eaf000000b00496ac462d9cmr231066qvb.82.1661363798458; Wed, 24
 Aug 2022 10:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-4-yury.norov@gmail.com> <CAHp75Ve4QTSs_mSB7uMqOK4q+A-z-O1tc2k5=2qaRHTdAC3yog@mail.gmail.com>
 <YwYtQ7t+3grPF16n@yury-laptop> <CAHp75VfeZVjv_3r4e1uib0BOfxaKTr6Sx59xiUZr=oQ+z_2Fig@mail.gmail.com>
In-Reply-To: <CAHp75VfeZVjv_3r4e1uib0BOfxaKTr6Sx59xiUZr=oQ+z_2Fig@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 20:56:02 +0300
Message-ID: <CAHp75Vcbkt09J1_reRJFeYAkjoTF1abfvHi1LWc4JyWPpLD=YQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lib/find_bit: optimize find_next_bit() functions
To:     Yury Norov <yury.norov@gmail.com>
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

On Wed, Aug 24, 2022 at 8:54 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Aug 24, 2022 at 4:53 PM Yury Norov <yury.norov@gmail.com> wrote:
> > On Wed, Aug 24, 2022 at 12:19:05PM +0300, Andy Shevchenko wrote:
> > > On Wed, Aug 24, 2022 at 4:56 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > > > +#define FIND_NEXT_BIT(EXPRESSION, size, start)                                 \
> > > > +({                                                                             \
> > > > +       unsigned long mask, idx, tmp, sz = (size), __start = (start);           \
> > > > +                                                                               \
> > > > +       if (unlikely(__start >= sz))                                            \
> > > > +               goto out;                                                       \
> > > > +                                                                               \
> > > > +       mask = word_op(BITMAP_FIRST_WORD_MASK(__start));                        \
> > > > +       idx = __start / BITS_PER_LONG;                                          \
> > > > +                                                                               \
> > > > +       for (tmp = (EXPRESSION) & mask; !tmp; tmp = (EXPRESSION)) {             \
> > >
> > > for (unsigned long tmp ...;
> > > But hey, why not loop over idx (which probably should be named as
> > > offset)
> >
> > Offset in structure, index in array, isn't?
> >
> > > as I proposed in the first patch? You will drop a lot of
> > > divisions / multiplications, no?
> >
> > Those divisions and multiplications are optimized away, and
> > what you suggested blows up the EXPRESSION.
> >
> > I tried like this:
> >    mask = word_op(BITMAP_FIRST_WORD_MASK(__start));
> >    idx = __start / BITS_PER_LONG;
> >    tmp = (EXPRESSION);
> >
> >    while (1) {
> >         if (tmp) {
> >                sz = min(idx * BITS_PER_LONG + __ffs(word_op(tmp)), sz);
> >                break;
> >         }
> >
> >         if (++idx > sz)
> >                 break;
> >
> >         tmp = (EXPRESSION);
> >    }
> >
> > And it generated the same code, but looks less expressive to me.
> > If you have some elegant approach in mind - can you please share
> > it, and how the generated code looks?
>
> for (unsigned long idx = 0; idx < sz; idx++) {

Of source 0 should be changed to whatever start you have there.

>   unsigned long tmp;
>
>   tmp = (EXPRESSION);
>   if (tmp) {
>     ...
>   }
> }
>
> No?

-- 
With Best Regards,
Andy Shevchenko
