Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB4B5A00CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiHXRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiHXRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:55:27 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1996FF5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:55:23 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id b2so13455823qvp.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=u0McpXYtOTvCm3oJmLu2/FQ3Yt0NnpKe4YGOkK9vKWQ=;
        b=Km1cMWoRnbcrRJy/1JXv49V5CKO98yzrTjYZITA4+o0XeiZwPnlKShBMUBOr1PZsLb
         BY+zodJ+0sq8OUTk8VmG+6mzRW8IKHKhqFe4Jxz2WwZgc3r9TcMvdBUC9kJHlhYVHwVk
         SYM61YBpjSrb4IdRiN8QLRL27Ax4ir1RKqBZDZcNF/XQB+UDa0Fhe1pAYL11oufhwZIk
         6REeEOjvObWaZyKypSyBr1OzIvu6++v9CNFQZ4qfqtlqP/v4nUaB9Ied66TVI4c7V/zl
         i0AWdbuDId6TdsnXxh9b0+Clgty2RuIdkUcp7cSJ3CHEjVykXf59zFvEVEbrEyAEvOcs
         T4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=u0McpXYtOTvCm3oJmLu2/FQ3Yt0NnpKe4YGOkK9vKWQ=;
        b=pTdtDlIZ0BV3sAQdSSyzSwd9Tm0vNEGC+PgZAq6XvHCGWxFE0qQ8VpOGGNghQAJQxl
         zEBrW2RhBmxKXEENigxCB0lW36apTL5+hoZ2HRvUqcMH+x1Bnp5dCnhXZRFlUnidkP3H
         clvu+pauZRPz3bD8Q7W/9+HimjICBU1YtXJ+Us0Zldm4wbtJg7I/0OgnLhK33sInCfcT
         +uOFjrCv1hjuyQxr0nPk625rLew6AvoJ0QNfHjqqe5GnKjl3840S3v5smTvsyVKNvACj
         9egck4pZhgIUDEKSsmF/3rJo+6fYsuNKUyiCYN6uz6CkqmjOGDbtnw8FLchpRCfTiSv2
         pfzQ==
X-Gm-Message-State: ACgBeo0o8HX/NK9uCUq2KinS+ShLleDWXAHEFvJTCvh6SQwVmeVXCiPu
        WuMj/EV0kQk3HxDoZBam0mTtqKDpTKAH9CuK+oE=
X-Google-Smtp-Source: AA6agR4RFJLP9kEila08J/oNLwVKokkbeYl1RtKrllt5h1jYb8x+jhvURSK0pAnDFylc2ofEGCRhsbctwvuAcneiMu4=
X-Received: by 2002:a0c:aadb:0:b0:497:1283:c849 with SMTP id
 g27-20020a0caadb000000b004971283c849mr279833qvb.11.1661363722765; Wed, 24 Aug
 2022 10:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-4-yury.norov@gmail.com> <CAHp75Ve4QTSs_mSB7uMqOK4q+A-z-O1tc2k5=2qaRHTdAC3yog@mail.gmail.com>
 <YwYtQ7t+3grPF16n@yury-laptop>
In-Reply-To: <YwYtQ7t+3grPF16n@yury-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 20:54:46 +0300
Message-ID: <CAHp75VfeZVjv_3r4e1uib0BOfxaKTr6Sx59xiUZr=oQ+z_2Fig@mail.gmail.com>
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

On Wed, Aug 24, 2022 at 4:53 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Aug 24, 2022 at 12:19:05PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 24, 2022 at 4:56 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > > +#define FIND_NEXT_BIT(EXPRESSION, size, start)                                 \
> > > +({                                                                             \
> > > +       unsigned long mask, idx, tmp, sz = (size), __start = (start);           \
> > > +                                                                               \
> > > +       if (unlikely(__start >= sz))                                            \
> > > +               goto out;                                                       \
> > > +                                                                               \
> > > +       mask = word_op(BITMAP_FIRST_WORD_MASK(__start));                        \
> > > +       idx = __start / BITS_PER_LONG;                                          \
> > > +                                                                               \
> > > +       for (tmp = (EXPRESSION) & mask; !tmp; tmp = (EXPRESSION)) {             \
> >
> > for (unsigned long tmp ...;
> > But hey, why not loop over idx (which probably should be named as
> > offset)
>
> Offset in structure, index in array, isn't?
>
> > as I proposed in the first patch? You will drop a lot of
> > divisions / multiplications, no?
>
> Those divisions and multiplications are optimized away, and
> what you suggested blows up the EXPRESSION.
>
> I tried like this:
>    mask = word_op(BITMAP_FIRST_WORD_MASK(__start));
>    idx = __start / BITS_PER_LONG;
>    tmp = (EXPRESSION);
>
>    while (1) {
>         if (tmp) {
>                sz = min(idx * BITS_PER_LONG + __ffs(word_op(tmp)), sz);
>                break;
>         }
>
>         if (++idx > sz)
>                 break;
>
>         tmp = (EXPRESSION);
>    }
>
> And it generated the same code, but looks less expressive to me.
> If you have some elegant approach in mind - can you please share
> it, and how the generated code looks?

for (unsigned long idx = 0; idx < sz; idx++) {
  unsigned long tmp;

  tmp = (EXPRESSION);
  if (tmp) {
    ...
  }
}

No?

-- 
With Best Regards,
Andy Shevchenko
