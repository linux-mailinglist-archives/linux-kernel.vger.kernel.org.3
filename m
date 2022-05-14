Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA17C527108
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiENMZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiENMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:24:58 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455AD180;
        Sat, 14 May 2022 05:24:57 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ebf4b91212so113645547b3.8;
        Sat, 14 May 2022 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4vtyw82gu0YWV4gUHDkTWkOdf5pLOXcWgWx74KiU7mY=;
        b=l4JajCGkrCp4fqrYhekGpBJKjGWsOji219DoF1cntoiS+FtxthRPXgOWoSCaNJzy4S
         97nzSNv0V6Su+6jN2OvD2gV2cHftg4cBvgMIDPgF7jrUqB3C5bKZ1qYnVV1m1hnWiRqR
         cGvQwba1h0kujPXR4dUxA07T5mLLck3hCGJUdjYPJ0RGpArRb+CDuTtG86E2hJXWSp5X
         1iN2QiUZCrcHSVj6b2xfMDI9aLVieQj08aPmsv1lQBcF8cjBnBpOmtXVBp3Ms5MUNbC1
         wKwXA6nqEUNMyKYD4TU/bG3wLxwOCyTi9mEGLx/akMalbzwHPj1mebic3OTdh/tu7xWZ
         BE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4vtyw82gu0YWV4gUHDkTWkOdf5pLOXcWgWx74KiU7mY=;
        b=sn547nuu8LEeWfXmkre8+mno6l5fRRr0PAL7mI6lZxWRPRuhmjoJS+ZvzYHCxXf3Nz
         HCUHD9+h+Z+w1OpstILNvEfktz+T8eNYHXstndD6vieuZUTtfy7WVWpXWUhF6uiIXQIS
         Q2YoXWiGOdN4iICzd8UnxiCcqoYrXEjnR2JaHY+UqtZ9jkaDuflCI/b4JGLFEwlvyGqc
         RjNAQwFFD0yZ85/bIQb24orEeIPIIMggRbAwy3fq5FTFV8Kao+sxP2pIvbBQs1hlKq26
         jg8hMXKeek0++klqRYM7B1GT7V5kfxmPnRUzU5mXgwh6w9T7mro7xMmRH6+pCbo9FIeQ
         TlmA==
X-Gm-Message-State: AOAM532gtOzLhr0PEtI+MR2PZNYSGA/FBOhZNJG3t/OBF1n+s8r+tMrG
        B1apjTCCy8HcLsBYsidfTREju3cDKZyeoU9flvAKfoj+uPvW8w==
X-Google-Smtp-Source: ABdhPJyec9/Dvc6Yguv51xPnT+QaMakVio643lY4varv6VonCQqm1dO45Up/V7k7IlaYW0xal/zHf/dCMoar1INRXOo=
X-Received: by 2002:a81:2dc5:0:b0:2f5:c6c8:9ee5 with SMTP id
 t188-20020a812dc5000000b002f5c6c89ee5mr10438204ywt.518.1652531096471; Sat, 14
 May 2022 05:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182921.193462-1-max@enpas.org> <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
 <CAMZ6RqKjGJyOPCQvS95ZUc6UrgaFzjunRhU=10biAAWYT_V_ZQ@mail.gmail.com>
 <20220513205907.6d5473ff.max@enpas.org> <CAMZ6RqLj2eLX2UWMvGc9rH2SP6HNuqBAXnwJ6q6qvk+7QWE8pA@mail.gmail.com>
 <20220514131128.5e647fb8.max@enpas.org>
In-Reply-To: <20220514131128.5e647fb8.max@enpas.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 14 May 2022 21:24:45 +0900
Message-ID: <CAMZ6Rq+jQA5MhSG-W_h0s8nJUZVKHxYsp93vEftz9DDRgb86KA@mail.gmail.com>
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 14 May 2022 =C3=A0 20:11, Max Staudt <max@enpas.org> wrote:
> On Sat, 14 May 2022 12:14:24 +0900
> Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
>
> > But I still think it is possible to do pointer arithmetic.
> >
> > len =3D strnchr(elm->rxbuf, elm->rxfill, '\r') - elm->rxbuf;
> > (I let you check that I did not do an off by one mistake).
> >
> > The above should also work with memchr(). Although the C standard
> > doesn't allow pointer arithmetic on void *, GNU C adds an extension
> > for that: https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
> >
> > As I said before, your for loop is not fundamentally wrong, this is
> > just not my prefered approach. You have my suggestion, choose what you
> > prefer.
>
> Yeah, this is the arithmetic that I'd like to avoid here. In my
> opinion, it is clearer with indices.
>
> If I were searching through a UTF-8 string (i.e. with variable width
> chars), that'd be another matter entirely IMHO, and I'd rely on C
> library functions that know more about UTF that I do. But it's really
> just naked ASCII bytes this time.
>
>
> ...unless memchr() may be faster than the loop? Could this happen?

It depends on many factors, the length of the string, the architecture
on which you compile it, whether the compiler decides to inline it or
not=E2=80=A6

For long strings, there are some tricks to scan through the memory
using 64 bits operation instead of doing it bytes per bytes. But there
is a preparation overhead which makes it not worth it for small
buffers.

You can look at glibc implementation for reference:
https://github.com/lattera/glibc/blob/master/string/memchr.c

Of course, the kernel does not use glibc but often compilers
__builtin_memchr() instead (one more time, it depends on the
architecture). But it will give you an idea of why memchr() can be
faster than the loop.

Finally, the compiler might also detect your loop and take the
initiative to replace it with a call to memchr(). You have to check
the assembly to see if this is the case.

For a device which speaks on UART which by nature is slow,
optimizations are not critical, so readability is the priority, and is
why I prefer using the library functions.
