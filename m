Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D573F52019C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiEIPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiEIPx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:53:58 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D502D7ED6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:50:04 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h85so15759703iof.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGkep1cFKgrJ0+QYCkcQH8E9lVqym+xbFUqlGchTBdA=;
        b=GNqB9+dOPOgJAN/Rgmyvw+OC73ISW3HR99MI9WfWlaADf6nDOTS+TBu3SpiRznRYRU
         5LOT/9Gz+134yQVjM6txYZRqLxzNgCM4/aOeyqNl75DzVfAKHNrLA8C+0JxLI/RQVHKF
         4N70h0G5BK31FXQRH9JAHIiily8CdZhqzalBtINtMtBbkkYvKv/VkS6CfLCsZlWS5tol
         ert88JvCzo4XUIo+Yg7i6T5WecqnOX/AzanJWBJLgqkXf81RuNESX4SbVEqu0v1h4J5c
         2BBetxrqAo/N8KouURZrj8zJOuyIOOnWzA5Kf72qdgHPi1UbHMBQ8tQvF31PPd6QiVHK
         aHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGkep1cFKgrJ0+QYCkcQH8E9lVqym+xbFUqlGchTBdA=;
        b=NGjIdEuyaTKPXagkbaai5+4ee6VxGfudtNmT6yp6xRFVJSw7gFvpMoDSzzCouCyXiH
         GPHPmlud6l4ZwmGblxV4aSh71nReBF2vSFjVVfZpzbMXX3jOpEMqBBc7xhIH7kDxcTiS
         GtQaqk8W77EsMaW1CcLeDATmchMcM/v+XWwYkA/EVXfW9f2CwmVrtYYghAA70GCq0hNW
         VJU2b1E1i4RWaGTVfiIXmxm/dM/jChJlBALhpBZ5q4hZws7UW1/NXXP/da5tEhcP6Lyy
         JfIsxNZSGeyJA8xVGWI803IVrNEOr9nC6gj4s6ipgXiqPLPUz1Nh4g6v5q8nwbyFpkIm
         c8Pw==
X-Gm-Message-State: AOAM532y+y3VQea33rqyYJl7PiRONaKc9GNVaEqWTc/lHV1cSyA2rbqI
        IjsbPENnux6GrZQ/TwSzS4f7epJib+21R2Og4O4=
X-Google-Smtp-Source: ABdhPJwfjXOo+deeBis/EeuLvTu678Fa2xzj5BBYf3N5OZHQfcNrr+qi8opcvYMoOfZ0Ne3uB2cBJToFbVxyvJgrsMM=
X-Received: by 2002:a05:6638:30e:b0:32a:f864:e4d4 with SMTP id
 w14-20020a056638030e00b0032af864e4d4mr7221878jap.218.1652111403703; Mon, 09
 May 2022 08:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <3167cbec7a82704c1ed2c6bfe85b77534a836fdc.1651162840.git.andreyknvl@google.com>
 <CAG_fn=XFOA-qsvPwjwJ0iZH1Wy54aS7QtD4ETVdp9L-yvOkiWg@mail.gmail.com>
In-Reply-To: <CAG_fn=XFOA-qsvPwjwJ0iZH1Wy54aS7QtD4ETVdp9L-yvOkiWg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 May 2022 17:49:53 +0200
Message-ID: <CA+fCnZfkKwYRTn+oK71c89jJG9CKAUqrURxq=g6z7EJXrr_Pzw@mail.gmail.com>
Subject: Re: [PATCH 1/3] kasan: clean up comments in internal kasan.h
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Apr 28, 2022 at 6:42 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Thu, Apr 28, 2022 at 6:21 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Clean up comments in mm/kasan/kasan.h: clarify, unify styles, fix
> > punctuation, etc.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> >
> > +/* alloca redzone size. Compiler's ABI, do not change. */
> s/Compiler's/Compiler ?
>
> >  #define KASAN_ALLOCA_REDZONE_SIZE      32
> >
> > -/*
> > - * Stack frame marker (compiler ABI).
> > - */
> > +/* Stack frame marker. Compiler's ABI, do not change. */
> Ditto
>
> >
> > -/* The layout of struct dictated by compiler */
> > +/* Do not change the struct layout: compiler's ABI. */
> Ditto
>
> > -/* The layout of struct dictated by compiler */
> > +/* Do not change the struct layout: compiler's ABI. */
> Ditto
>
> > -       unsigned long has_dynamic_init; /* This needed for C++ */
> > +       unsigned long has_dynamic_init; /* This needed for C++. */
> "is needed"?
>
>
> > -        * is accepted since SLAB redzones aren't enabled in production builds.
> > +        * is accepted since slab redzones aren't enabled in production builds.
> s/accepted/acceptable ?

Will fix all in v2, thanks!
