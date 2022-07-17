Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C0577831
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiGQU0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGQUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:25:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE481180D;
        Sun, 17 Jul 2022 13:25:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 75so17769782ybf.4;
        Sun, 17 Jul 2022 13:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQJt1app/1+BamRnBVCCSfWXec050wLumfUNaLBnpKk=;
        b=JVPZrBIWXwyVza1YQ8QkiNAfIvcukmRwqMGFXojnG0BcXqzkervd//1ZTSrsyyNvt1
         EBcTmwMj1tnyAZSORZuQz9plll+SUJR2tEK7PxpxhMfETLD/wd6KbVgS6Uh3dGKTx2rH
         9vpYT2VeflRtXyAGNrlt1NUbSnNcoFpvMOnNZdGpJ+PnjP9AIBZVjKIMJboBFgO50OtX
         bYe6O4VG2xs90ySn79Xr/bJhWNd7moGr07CqEsy8XS/+4iTTbWxizNmHdch6HFOrV3Yb
         JULodIET9iTjZ+jUymOqH+1+6Klo+V6Cwz1Iqd7NIsSi3+dIUba50CBY0eMo07VYKNSS
         c5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQJt1app/1+BamRnBVCCSfWXec050wLumfUNaLBnpKk=;
        b=3zXKP5janbe1n0xrkurMF4IJeOwn6ercuP1wsh9IMgeGUJrLn52GRL902NNu012JzG
         urB1i+z5qSQZ/5CWAEAOnVyUFoHbaSKYiPEC7AdUWae99dy59lDD7JWpJhMwBcFFFjH7
         9RKptU/uSekjP21wHkqPuFf2DgYGm4BPNK/mSS79YOhUy8LDaqSyyzMjxMhvjNtBafLu
         SBNgtduUlmuviu8H/GPDuaoHHpEBpzpB1vFcTXyX2dQFiujugOpV2uJkI3VTwfap6REd
         qUF5R71cMmm5lDjDFnimRINVVnU5ulECLnsUW12JYCv2WiJ/NJLyd8mAvS3U+FQddXA6
         t2rw==
X-Gm-Message-State: AJIora928iy73DqmIjAcBkLkUjbG60OXkjrcHGLSj162qxWC1WJ9a8MR
        g+a15fJFRa4jD+R4BnySyWjmZqyaFaEnQOhrLhXnl4QPEdY=
X-Google-Smtp-Source: AGRyM1uUaFp4jr9Q7LCoBIhWkwizwk+v22P6cWnEUs23PHHmkHZVztizIgKt9DyWUHUnc1D79SgpJ1/yhCHxHRLym/w=
X-Received: by 2002:a25:b0a8:0:b0:66f:eb53:76ca with SMTP id
 f40-20020a25b0a8000000b0066feb5376camr14168595ybj.617.1658089557008; Sun, 17
 Jul 2022 13:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
In-Reply-To: <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 17 Jul 2022 21:25:20 +0100
Message-ID: <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 3:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jul 17, 2022 at 2:13 AM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > I was trying to check it. With gcc-11 the assembly code generated is
> > not using memset, but using __memset.
> > But with gcc-12, I can see the assembly code is using memset. One
> > example from the assembly:
>
> You could try making the 'args' array in 'struct prom_args' be marked
> 'volatile'.
>
> Ie something like this:
>
>   --- a/arch/powerpc/kernel/prom_init.c
>   +++ b/arch/powerpc/kernel/prom_init.c
>   @@ -115,6 +115,6 @@ struct prom_args {
>            __be32 service;
>            __be32 nargs;
>            __be32 nret;
>   -          __be32 args[10];
>   +        volatile __be32 args[10];
>    };
>
> because I think it's just the compilers turning the small loop over
> those fields into a "memset()".

That didn't work.
"Error: External symbol 'memset' referenced from prom_init.c" is still
there with this change.
And the generated assembly still has the memset for "struct prom_args".


-- 
Regards
Sudip
