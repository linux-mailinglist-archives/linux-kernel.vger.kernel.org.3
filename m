Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21B647CB79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbhLVDCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:02:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39804 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbhLVDCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:02:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CF2F61853;
        Wed, 22 Dec 2021 03:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02385C36AEA;
        Wed, 22 Dec 2021 03:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640142168;
        bh=WSyHhrcXZ9EjPtj2ifCKZZNJIhxwOB+mDw+QIlWtL/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I2KaiqF5sYXZhMucQyRMZ10uvWNMNCbOBPKkDU+x1dqk7UWRqUZ2RdJCp1LbqcZfP
         4AL6AvRzcrDYPQXxabUQQs5Z6cLlj71D8cuX1hvRKDOjnPeUAndFB01QTsiwCm/075
         W0DoSxxoRWZlm/9t+3Of2qRglSaD7QGIAqWgv+X7xVyf1pBiswScZdYQNFhVYqSbCD
         F/KsLko7lfMmgVwoqS4c4kR7QVSlJxrFzWKq8SIbX6it/O+zaZLQzgMWYJfoGwJlE1
         3oTzZvqCuS/x8icsHcGV9tBSwTldeAuoAUAAoBnB9OEgc6l9S9wef4OpcPHsUv5D9B
         6dB8M+u94N5ug==
Received: by mail-ua1-f42.google.com with SMTP id r15so1886115uao.3;
        Tue, 21 Dec 2021 19:02:47 -0800 (PST)
X-Gm-Message-State: AOAM530FNleSCJu5FQByofILfpZQG/dYUkKW19nW18V09QrGFUEFFnmp
        GIe4S1RQs+6J/y9/nQL2sryGRk65ttP91kdFrzo=
X-Google-Smtp-Source: ABdhPJzfN/S3U1di5WXrgKLqFzURs4/ZUuNwOZaTWJPgOpxekWFKl2Xv/1LYWtbuDbIFhbJWM7A7WQmzLZESZuK+tLE=
X-Received: by 2002:a67:f94b:: with SMTP id u11mr409927vsq.51.1640142167064;
 Tue, 21 Dec 2021 19:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20211221170057.2637763-1-guoren@kernel.org> <20211221170057.2637763-5-guoren@kernel.org>
 <c084037b-1f30-53be-bf6b-06e3401b20e8@csgroup.eu>
In-Reply-To: <c084037b-1f30-53be-bf6b-06e3401b20e8@csgroup.eu>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 11:02:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQbpVczn=Zz9rgvgNRSM9AFaoc2zVz9YaL_hWpgYSaR2w@mail.gmail.com>
Message-ID: <CAJF2gTQbpVczn=Zz9rgvgNRSM9AFaoc2zVz9YaL_hWpgYSaR2w@mail.gmail.com>
Subject: Re: [PATCH 4/8] sched: powerpc: Remove unused TASK_SIZE_OF
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sparclinux@vger.kernel.or" <sparclinux@vger.kernel.or>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "inux-parisc@vger.kernel.org" <inux-parisc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 2:43 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 21/12/2021 =C3=A0 18:00, guoren@kernel.org a =C3=A9crit :
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This macro isn't used in Linux sched, now. Delete in
> > include/linux/sched.h and arch's include/asm.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >   arch/powerpc/include/asm/task_size_64.h | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/inc=
lude/asm/task_size_64.h
> > index c993482237ed..7e2eca4fac4d 100644
> > --- a/arch/powerpc/include/asm/task_size_64.h
> > +++ b/arch/powerpc/include/asm/task_size_64.h
> > @@ -44,12 +44,10 @@
> >    */
> >   #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
> >
> > -#define TASK_SIZE_OF(tsk)                                            \
> > -     (test_tsk_thread_flag(tsk, TIF_32BIT) ? TASK_SIZE_USER32 :      \
> > +#define TASK_SIZE                                                    \
> > +     (test_tsk_thread_flag(current, TIF_32BIT) ? TASK_SIZE_USER32 :  \
> >                                               TASK_SIZE_USER64)
>
> I think you should use test_thread_flag() instead.
>
> Or even better: use is_32bit_task() and bring back this macro as a
> single line, something like:
>
> #define TASK_SIZE (is_32bit_task() ? TASK_SIZE_USER32 : TASK_SIZE_USER64)
Okay, looks better. I would fix it in the next version.

>
> >
> > -#define TASK_SIZE TASK_SIZE_OF(current)
> > -
> >   #define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
> >   #define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER=
64 / 4))
> >
> >



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
