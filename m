Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E146A371
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbhLFRsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhLFRsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:48:16 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D17C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:44:47 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i9so11059912ilu.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0awCCs680xscQQTdgkJbUPAtLqPotiTRb/qZpNCKBbs=;
        b=V20h/AqDaIPIgjacUjBehJoKrkz1ug+dPRNi9A4mRcrCr5bFmQ5J1XCKYnhNti54pr
         kwhb1NB61Lp8esNLp0/qmt0UocrqqUoNvKiAWgQq7lKChohzSgNRYhUEYQCYXCG0Th3s
         5b3MdFLkAWg8xUU0d7Jl36ltQWfqX5SRasj5fQJtso8sLhM3yVIxbXkJJ6YUrkhWoKpH
         09n2g1JnFGqnpnTMMC8nWO/pejR78V+Q7UbF27jEf676eanf+xG+fw3QgijQLr7+Oh90
         cXnSpwxkktP58uKJ0hzXfDvmOuC/+Ge7qjWzhnjToXun68B3nPsz+ZV3u7HwYIQ/oaA6
         eYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0awCCs680xscQQTdgkJbUPAtLqPotiTRb/qZpNCKBbs=;
        b=47rjTvtPv5yxR6wa6OZPcL3s1JpruS7H7V8QP+tKm+M+XvaPMLHfteLETrNfMc4fZ1
         BLkjcxAbPFpE+r8Rs/sZR35RHOjWZxxjCF9fuhisMTKuJV/H+lSNtNdJJW1VP5Tld87D
         y5gzE7DudXef5V5XWtvARz8dmzx40OwhR/9W3TXZEhKDW9Oq2v8fEPGX6WUMMb4faTlm
         e5iTCRNpE0j3RkGuDLAMdvCrs8Jo7qU4mS1SNszrlRcHN2ONJqh8pjmeTisg90A34H/b
         oCUqDWDH/9alDN4CkwO2gEiGgt8MjfzKzaIn1oNoOeZ5Ys3dus0TDsBCT0Z4JTx+K7Ag
         WehQ==
X-Gm-Message-State: AOAM5330jdMMci19k/uRywRCoWfKWXmYxpBTqgBOgAhsTNPoM6O8uMdS
        U77FMuZsE0e6iVw8P0PKq4ZHa6jgGa7xHviYbTk=
X-Google-Smtp-Source: ABdhPJzMMuY+hv1M6ecs2AD0miT00TwORSRigakuQzBvf4gLeX8yGxQ1L5xFRexYq8jVSrtzAmmxXKy5WQbogUZpzoE=
X-Received: by 2002:a05:6e02:180d:: with SMTP id a13mr33279428ilv.1.1638812686852;
 Mon, 06 Dec 2021 09:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20211204181458.10076-1-6812skiii@gmail.com> <f7d9194b-6681-48f0-b5e9-11f43d2849bd@collabora.com>
In-Reply-To: <f7d9194b-6681-48f0-b5e9-11f43d2849bd@collabora.com>
From:   Jangwoong Kim <6812skiii@gmail.com>
Date:   Tue, 7 Dec 2021 02:44:36 +0900
Message-ID: <CAF=mnpi65WtnK_mF1f8GfMEczS1ruj8q4YbA18R5KvWcpkxLxw@mail.gmail.com>
Subject: Re: [PATCH] futex: Fix a faulty comment.
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dvhart@infradead.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andr=C3=A9.

That patch was definitely wrong, I apologize.

However, since futex_wait_multiple_setup() sets the last index of
futex that was woken up,
shouldn't the comment be modified as below?

If so, I will resend a patch.

                /*
-                * Even if something went wrong, if we find out that a fute=
x
-                * was woken, we don't return error and return this index t=
o
-                * userspace
+                * Even if something went wrong, if we find out that any fu=
tex
+                * was woken, we don't return error and return the last ind=
ex
+                * awoken to userspace
                 */
                *woken =3D unqueue_multiple(vs, i);
                if (*woken >=3D 0)

I sent the patch because I thought this was important enough to be correcte=
d.

Let me know If this is not crucial enough to be patched, so I won't
keep sending comment-fixing patches.

Thank you.
Jangwoong Kim.

2021=EB=85=84 12=EC=9B=94 6=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:12, A=
ndr=C3=A9 Almeida <andrealmeid@collabora.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> Hi Jangwoong,
>
> Thanks for your patch! However...
>
> =C3=80s 15:14 de 04/12/21, 6812skiii@gmail.com escreveu:
> > From: Jangwoong Kim <6812skiii@gmail.com>
> >
> > We return 1, not the index of futex woken up.
> >
> > Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
> > ---
> >  kernel/futex/waitwake.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
> > index 4ce0923f1ce3..d148e5d4956b 100644
> > --- a/kernel/futex/waitwake.c
> > +++ b/kernel/futex/waitwake.c
> > @@ -455,8 +455,8 @@ static int futex_wait_multiple_setup(struct futex_v=
ector *vs, int count, int *wo
> >
> >               /*
> >                * Even if something went wrong, if we find out that a fu=
tex
> > -              * was woken, we don't return error and return this index=
 to
> > -              * userspace
> > +              * was woken, we don't return error and make userspace aw=
are
> > +              * of this by returning 1.
>
> We return to userspace the value at *woken, so your fix is wrong. Have a
> look at futex_wait_multiple():
>
>                 ret =3D futex_wait_multiple_setup(vs, count, &hint);
>                 if (ret) {
>                         if (ret > 0) {
>                                 /* A futex was woken during setup */
>                                 ret =3D hint;
>                         }
>                         return ret;
>                 }
>
> When we return 1 at futex_wait_multiple_setup(), we end up returning the
> hint/woken value to userspace.
>
> Let me know if you have questions.
>
>         Andr=C3=A9
