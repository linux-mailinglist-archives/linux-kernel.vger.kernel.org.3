Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED2577837
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiGQUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:38:54 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D667D5F77;
        Sun, 17 Jul 2022 13:38:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 64so17756075ybt.12;
        Sun, 17 Jul 2022 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiYSup99uwU5NOviKuuMKo7BhkLIiiIQ+0H1fe5hX1k=;
        b=Y2tgy3kJv7l7mn79jdIYcMmXZNJpLRhygh+ca6MPCH1qymdCA8+NrjuArg6Of6/hxP
         F6kb8+EEhQLJj9qBBUo2oJSBuufPnzt20uMKJylBWGxePp7pl7I4MA5OUi3PAqksXJPP
         xmFhRsTKCnwWfZJ2j17dGlfiSkQTyuW5lf0xUNky0IkcurbqP/bt1CEUTKGOli+3X+KG
         l0yOn079Sh9TFVlrULEmkHpz8UEXg7692CGY6tytlgaN6PAmdFf+YX3LKON2bUuciUMZ
         JD3Y2H72PE74P0Rc/3mLAsv+ySjCDhkaq1kl9TTgWBmAwZOZS3gW9sgSp61bH6aEu+H1
         tXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiYSup99uwU5NOviKuuMKo7BhkLIiiIQ+0H1fe5hX1k=;
        b=7XAOFzdXuBjP7PHP2M/gR2sorjJ2kY41d6jVYaHqZ1YoFPl4QPKpKPxPRbzFup0xMl
         gf8bUO7aWY3H7WcNM46Rc9hRaZxYVSILezsM8YB6H8Vu2dJSxRgPhU+y8835OVmLdJsT
         k8krvl6NJiO5go1DICf1WpnxqiZpya1m6sqTt6m9yNiObAbG9iM4HZp2YareFm5kCgQr
         qvdbFVVVoY/jnJ8Pb5ZT7/CCH6MvaJp2kEDGZVrFzoV2ScoRxtKfkKbmLkaGEYW8GX0e
         cGhABzXCo3Uw1QXGFjtsisPr8Yj17heNB6AEM8CbrRaSpIqNyDikUL2JAGiBxg4fH4PF
         tEwQ==
X-Gm-Message-State: AJIora/8gD64C/eX/nCBeNUaJldCTDeVdKpjuwxK3YOF4Ut8mUochQXq
        6r5Rq6rMijFcU1DfJEYy3Fy0BdvvLQuWB8OQ0c4=
X-Google-Smtp-Source: AGRyM1soBR/gucIFEFNRakwNssNATZ5/O9lI3lT9DpslecEmedxGh+4cL15CKNkF/Mk658qlDEcYXio+htFRg7jSobY=
X-Received: by 2002:a25:6b0f:0:b0:66e:cba3:8f2d with SMTP id
 g15-20020a256b0f000000b0066ecba38f2dmr23046365ybc.183.1658090333076; Sun, 17
 Jul 2022 13:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
 <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
 <CADVatmO1V8DiAgWMW9EFHwt+ghwfHhueigXh214tUa_=tVxiug@mail.gmail.com> <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
In-Reply-To: <CAHk-=whjWyoognKy4QUUwf95L6qvPg7MGdp0CxqD2fpvZo7DLw@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 17 Jul 2022 21:38:17 +0100
Message-ID: <CADVatmMRC-T3vUfgzya1hYmGOme79kBu2hK2CxBU3+C5h1TAYA@mail.gmail.com>
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

On Sun, Jul 17, 2022 at 9:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jul 17, 2022 at 1:25 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > And the generated assembly still has the memset for "struct prom_args".
>
> Strange. That smells like a compiler bug to me.

Both gcc-12 and clang gives this error.

>
> But I can't read powerpc assembly code - it's been too many years, and
> even back when I did read it I hated how the register "names" worked.
>
> Maybe it was never the args array, and it was about the other fields.
> Not that that makes any sense either, but it makes more sense than the
> compiler turning a series of volatile accesses into a memset.

I have also tried adding volatile to all the members of that struct.  :(


-- 
Regards
Sudip
