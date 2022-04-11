Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A218D4FC313
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348827AbiDKRWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348828AbiDKRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:22:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701CE25E8F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:20:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z128so14782236pgz.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONFEOnrVZ9bjjIY7JAyb4o3HO+WCsKL7A8xVivcrZIE=;
        b=lq39LnDuprsBafq43PI2TmKx4kPt9ZRqRHn5SGyOwZQWSkktfBs6dbau5X8h4LkySX
         lwXi+mwKMQbfCtBoYOxPX8GG0eLr0X2dRcemnpC9gx7NbfYwQRK6rcCXSqFAUuOWM8vS
         a8RVF0eiMB3zpr7lu05GLKlBbhNnQ9QIhzYNXTs0qHVZPl/xttZGomiL6AzBOtOTOIpE
         1WySjGo0KWMbPeNQ2BGvuSpz4z+PsWZLkU9kiJLoeCjcJvbHy0yc+y2/fgEJpcok7yhG
         xBrqAM6YwZB1rg9h7JDHzGwqJp8rmclbU19wbuvpPJ+7T6COX3kYIE6AAmJNg0/xXFWk
         Ckvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONFEOnrVZ9bjjIY7JAyb4o3HO+WCsKL7A8xVivcrZIE=;
        b=eNmU2KVaKTy9A9hYGExFJBdNuMtxEXLfPQ7jrzq8QaSjKsqR1rxmzi0kuVJvvgZIUj
         85clHfUPfb8fa4qDjHyxtDsKUJn2Q+HqsuddgnBHWNlAYBCW2rAhkXyOfn3YJUmUA0Ev
         itIBP7m88ta73zkzm2mRsu9PPmA8f5MzG4WlaYRbIli5M6lKzzH5f3NPHam5Sk0L9b5p
         UyNQaUkACTJ90H8k6ibpugh/gIb+F2b9KOevL1w8xnBZ1Vj2HnVr/I2VC88u2p0izWsP
         yuVggeofmTqHlxX2nrLe5Q1oacqC6zryww2aWRWt5ZZzOv3iFSzC/tIIFSw+m7FLLlQ/
         vlmQ==
X-Gm-Message-State: AOAM531FN/AmGP1LD4XHG6jSBfh4ThmRjb2i2ZhmAd6ktm+XeHsls3Un
        ivRKmGcCbBxt9sUlTr50wOw6u/G6P3XYVRA9ZQs=
X-Google-Smtp-Source: ABdhPJwvRZq3s06VUhs7xehfpg19fW+KHV2DMPoc52Ja6WHgi/kvliBGxPSxxEfk8WCuq1bfMfSi3treL1rPgaq7MI4=
X-Received: by 2002:a63:7c06:0:b0:398:31d5:f759 with SMTP id
 x6-20020a637c06000000b0039831d5f759mr27248005pgc.513.1649697613767; Mon, 11
 Apr 2022 10:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220411150555.26023-1-anna-maria@linutronix.de> <YlRNwV3jlikHfu/v@smile.fi.intel.com>
In-Reply-To: <YlRNwV3jlikHfu/v@smile.fi.intel.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Mon, 11 Apr 2022 10:20:02 -0700
Message-ID: <CAAH8bW9hvKA_q8eS-QpMkU3EhD7kM5heuQjbtd4A=tVhAznioQ@mail.gmail.com>
Subject: Re: [PATCH] include/linux/find: Fix documentation
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Mon, Apr 11, 2022 at 8:52 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Apr 11, 2022 at 05:05:55PM +0200, Anna-Maria Behnsen wrote:
> > The order of the arguments in function documentation doesn't fit the
> > implementation. Change the documentation so that it corresponds to the
> > code. This prevent people to get confused when reading the documentation.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied here:
https://github.com/norov/linux.git
branch: bitmap-for-next


> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > ---
> >  include/linux/find.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/find.h b/include/linux/find.h
> > index 5bb6db213bcb..424ef67d4a42 100644
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -21,8 +21,8 @@ extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long siz
> >  /**
> >   * find_next_bit - find the next set bit in a memory region
> >   * @addr: The address to base the search on
> > - * @offset: The bitnumber to start searching at
> >   * @size: The bitmap size in bits
> > + * @offset: The bitnumber to start searching at
> >   *
> >   * Returns the bit number for the next set bit
> >   * If no bits are set, returns @size.
> > @@ -50,8 +50,8 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
> >   * find_next_and_bit - find the next set bit in both memory regions
> >   * @addr1: The first address to base the search on
> >   * @addr2: The second address to base the search on
> > - * @offset: The bitnumber to start searching at
> >   * @size: The bitmap size in bits
> > + * @offset: The bitnumber to start searching at
> >   *
> >   * Returns the bit number for the next set bit
> >   * If no bits are set, returns @size.
> > @@ -79,8 +79,8 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
> >  /**
> >   * find_next_zero_bit - find the next cleared bit in a memory region
> >   * @addr: The address to base the search on
> > - * @offset: The bitnumber to start searching at
> >   * @size: The bitmap size in bits
> > + * @offset: The bitnumber to start searching at
> >   *
> >   * Returns the bit number of the next zero bit
> >   * If no bits are zero, returns @size.
> > --
> > 2.20.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
