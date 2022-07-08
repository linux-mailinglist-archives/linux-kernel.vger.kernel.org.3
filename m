Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49156BFA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiGHQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiGHQlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:41:00 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086062A711
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:40:59 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 185so10630115vse.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OKQC1JfennXMYbCH8QLvSZ9ug8KCsBnDh54Yf6DjVM=;
        b=JNrhC24tPcjj2Z6XWK9r9nRSuWELe3mhvLRc0RbRppcAtR4JfNGs/V0I8QkDuGWQ9k
         aoDmdcO41Hxkve2tq7gX6+VEpZzyXv8GlgDSjSPqVUx/iVAaAuS7b74ClQ9Erre1UDFw
         J0r97wURkzpgiR/9UxMBFTVtyGxTFrGirQnc2ja98n5g0Y01cgz0XnQL7DYJyPGXL/nV
         aW5D0NkVD5413ncIxapey+9mKOyPqwsc3yV+2L2mLsIfSM/dUFuvXx8G3bCgnzupdLc/
         nUS1j+VDbMhbYQeB7qDv02EDxQB2WijfDlTmnrO1jpGvgfAU68bseH37rrCRAlfRfpv3
         W3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OKQC1JfennXMYbCH8QLvSZ9ug8KCsBnDh54Yf6DjVM=;
        b=mcO+Pwp/0TZ2winVXUn9VcMsfeqUSYdTgtdkECYXWAu+OBEent9FvBMEJZ8Z0PwdQH
         Bv2VS7gcSanzpsKIyQLyrxyChOlYoya4O889Txyjn74SD0Y8m4DTqLd+KAFVi0zlFqgY
         mgXyom5PFMLJkOLInlRX0tOkKOtYAIl96EvbbdwRjM2jx+XqFPv73CNNbK/EhDVoDKGe
         BOLB8Esdtxj6Xo/YrH2MW5mpl9B13A3v58WauwWjYhb5B2arHRSbuUt2UNsDMxcRmd8Q
         wBm4tdoYzYnRGXy7F9tEiZBWAm65VJm/J4jRAY9gH3ZR0fVqpC+XiQhhFHCIOL96XuIZ
         d8xw==
X-Gm-Message-State: AJIora8NS0bDEM02ukvn4klAnOElrWJV+bmIRkjRbwEQbiwDLj6NIofx
        uv/nd9Hsiuc4hhYF1Q2kh/708H9dWeztlekABf8=
X-Google-Smtp-Source: AGRyM1sBNryM/rW7zwsyvbHs9vVDhF7I5Qky84PEi7ygqiN8kumjn1yPRzZwOCmQfHDZu11Cpg3wAbUmcHtEr+HQWhs=
X-Received: by 2002:a05:6102:3d9e:b0:357:4526:ae58 with SMTP id
 h30-20020a0561023d9e00b003574526ae58mr221179vsv.56.1657298458927; Fri, 08 Jul
 2022 09:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182300.70862-1-yury.norov@gmail.com> <20220706182300.70862-2-yury.norov@gmail.com>
 <423c4368-0a1c-792c-2637-768532fc7782@rasmusvillemoes.dk> <YsdKMQzUFVwIaqtJ@yury-laptop>
 <d86ad462-fb4c-4768-b060-201511f9ff64@rasmusvillemoes.dk> <CAHp75Vfx3RADfU0cm7Y0kYfOtba4K008xZSSVbACRa3OwbAKGw@mail.gmail.com>
In-Reply-To: <CAHp75Vfx3RADfU0cm7Y0kYfOtba4K008xZSSVbACRa3OwbAKGw@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 8 Jul 2022 09:40:48 -0700
Message-ID: <CAAH8bW9qP8YY8k_JOE+oezU0iFCZq6H2W6dv8sL2kr3Q_eLQ8Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] lib: add find_nth(,and,andnot)_bit()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Fri, Jul 8, 2022 at 2:13 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 8, 2022 at 10:55 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > On 07/07/2022 23.03, Yury Norov wrote:
> >
> > >> And I don't
> > >> like that the index is apparently 1-based (and that surprising API isn't
> > >> spelled out anywhere).
> > >
> > > Yeah... My motivation to start counting from 1 is to keep consistency
> > > with ffs: __ffs(word) <=> fns(word, 1).
> >
> > I understand that you're translating that second f in ffs (find First
> > set) to a 1. But I disagree that that's necessarily a logical thing to
> > do. Everybody understands that (given a C or python or... context) when
> > some prose talks about "the first element in an array", it's the one at
> > [0]. So I find it much more natural that the set bits in a word are
> > enumerated 0, 1, ..., popcount(w)-1.
>
> I agree that here we operate with an array of bits, which naturally
> starts from bit 0.

OK, I'll send v2 shortly
