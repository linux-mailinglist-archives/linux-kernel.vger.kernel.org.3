Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71B6569E34
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiGGI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiGGI5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:57:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5478F4D4DE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:57:31 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31c89653790so112500627b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hxxPRIfRZ6kDlNJS/WoodDXQuHq7aEJrE7gGVlQfxtc=;
        b=ZmyUgdvMu6NZCSWtYE6O6bzfid1hYCJsA7WyF7VN2wseRhfi03QNLKlYGcZZtXLGEJ
         RTF2FqOAwVxGBekRl3B9p48InGj1uoc/j7Q6nJ6sfHlOq89OKAMiRcDIy8QqsyEvrnRn
         LtmJypAw8lzH7McW1PPBK663RQuWJ5IMBs5xGFttjpi/nPfgjq+BEg0SDZiRL/uY6cyT
         9RgpawoxCGaMe57GPQgJRyNSeEpyA2Rml9efUjdp1DmHrt6WvJz+qMY9Xz/m2mm56DZv
         Qn5QCfb1BrT2/2pEI9nCqlOmZa/CIFjCNHza/sTkGLBbQw3Nbgxng4QfCrgrnu3ZrA8a
         M24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hxxPRIfRZ6kDlNJS/WoodDXQuHq7aEJrE7gGVlQfxtc=;
        b=V4KhFKMeUARQ6P7L5DHdDG50lhDuuD0ILF/mWJrXilk0YqlFan4lB9B7lv2wfx7i+6
         jJjn0NlAor0Y0HdarMh9KyeSxer6LgUBCArE6I3K0wPIVGIBQ38DQBoLtgyEGp2XPTHH
         +Mc20aiUP7Q4q3pxthBBr/WAv/47aqNNOjR9F8ov4RAsjuu5kDyH+NCODB0Ei/OwWYXU
         dQrBKrOLwMp/J3ppaDqah6IKRv3ebVT6aHLiiB3gGtj7BeNvi0l2ruwUVRzDo7RO8rm8
         wZlmqH2AjHlpMCdSEqQS5zMQ8egOXZhzC3Yv1GXpNh4AwRI56BrAw48AOBa2/2wjlM7a
         VWtA==
X-Gm-Message-State: AJIora+a6LXwCk4vEnaV7s/p9+uS6FOAZrGifyJkLPkfP1wl7T/CufZ7
        uWRkIZfaV4JDLPAIjoE/VXg9Y46Gdo8LdQmZzdgRvA==
X-Google-Smtp-Source: AGRyM1u5n+5YHZaW5ne094F1MJ3Dh/iwnzn5Yo8ytzAmgsdWnzH5qYppBnkr6xJWsGT8xbgLo+p+vGyX8BjAF/7xOes=
X-Received: by 2002:a0d:e905:0:b0:31c:9616:1fc5 with SMTP id
 s5-20020a0de905000000b0031c96161fc5mr24879363ywe.265.1657184248976; Thu, 07
 Jul 2022 01:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
 <20220622162230.83474-4-kirill.shutemov@linux.intel.com> <CAG_fn=WgyitSd9h2ni2xpBBvgnoGTcwZOpWyNE5QRSRn+PcC=A@mail.gmail.com>
 <20220706231349.4ghhewbfpzjln56u@black.fi.intel.com>
In-Reply-To: <20220706231349.4ghhewbfpzjln56u@black.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 7 Jul 2022 10:56:53 +0200
Message-ID: <CAG_fn=Ut8OaQ40VmNvG8HtJ7Cb4M03ce3ihFPrmj+PNQB0tF3A@mail.gmail.com>
Subject: Re: [PATCHv4 3/8] mm: Pass down mm_struct to untagged_addr()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 1:14 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Jul 05, 2022 at 05:42:21PM +0200, Alexander Potapenko wrote:
> > Kirill,
> >
> >
> > > diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> > > index feeb935a2299..abc096a68f05 100644
> > > --- a/lib/strnlen_user.c
> > > +++ b/lib/strnlen_user.c
> > > @@ -97,7 +97,7 @@ long strnlen_user(const char __user *str, long coun=
t)
> > >                 return 0;
> > >
> > >         max_addr =3D TASK_SIZE_MAX;
> > > -       src_addr =3D (unsigned long)untagged_addr(str);
> > > +       src_addr =3D (unsigned long)untagged_addr(current->mm, str);
> >
> > In a downstream kernel with LAM disabled I'm seeing current->mm being
> > NULL at this point, because strnlen_user() is being called by
> > kdevtmpfs.
> > IIUC current->mm is only guaranteed to be non-NULL in the userspace
> > process context, whereas untagged_addr() may get called in random
> > places.
> >
> > Am I missing something?
>
> Hm. Could you show a traceback?
>
> As strnlen_user() intended to be used on an user string I expected it to
> be called from a process context. I guess I'm wrong, but I don't yet
> understand why.

Oh, I see now. The old implementation of devtmpfsd()
(https://elixir.bootlin.com/linux/v5.4/source/drivers/base/devtmpfs.c#L397)
uses ksys_mount(), which assumes that the strings must be copied from
the userspace, whereas they are actually constants in kernel .rodata

Wonder if the validity of mm->current for userspace accesses is
actually enforced anyhow in newer kernels.

> --
>  Kirill A. Shutemov



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
