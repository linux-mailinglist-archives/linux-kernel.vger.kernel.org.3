Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8235247CE0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243306AbhLVIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbhLVIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:22:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC4C061574;
        Wed, 22 Dec 2021 00:22:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 911AA61913;
        Wed, 22 Dec 2021 08:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0265CC36AE8;
        Wed, 22 Dec 2021 08:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640161357;
        bh=2XdBX3wzyy6S5BxKK0ZicVvab6NsAf6qcGVNsQ9XyZI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KtdKY+FXEiDVg9WQNV0t7EC6t4i7gAAFZ+kBlTZtb0HBt9x8jhg/odf9AySq5PB4b
         iMxJPs/aCg28tgmd20/QLFYgyU8rv9U8nYl0vzOjWgWsMffpnId5R0AGx+4wOcZLzO
         OK7VtF7KeXGYBaiwjS8kDYiXdwy0Wsp29BhWN6Pzn38t95I/FbsY39qB6lQwvOmPkW
         eMEdQ0jUlOJZhmT/Onp3kifA/GXbi5EPXwqRwGIRNFqOIZftsbR6fnlLarjwz01mkt
         ch9boYJ1kfbIpo99eCFpb5AdirSJlePYOaHN8g+RaekBhLXBNxc2druEoONM/aJTGj
         OmoCAF3S6L3hQ==
Received: by mail-ua1-f48.google.com with SMTP id y23so2777266uay.7;
        Wed, 22 Dec 2021 00:22:36 -0800 (PST)
X-Gm-Message-State: AOAM532ZYPruz1+CjKpaKSpyv24HkOHxPxmVCtRE+ezcAXhxQuYhtl7i
        Z5ETppmIH8Y2yEFQXgxB1GdTRUEla+MEQXPbJMA=
X-Google-Smtp-Source: ABdhPJyrBN3Y+GFr2Jt9nGnwL8yvmgKGPxXYCH/BMlHDVbFRTyxSsMe3GTBWxXqMbH4bqKtfuLnOWF72/H7yGJFpaXg=
X-Received: by 2002:a05:6102:316e:: with SMTP id l14mr716344vsm.8.1640161355738;
 Wed, 22 Dec 2021 00:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20211221170057.2637763-1-guoren@kernel.org> <20211221170057.2637763-5-guoren@kernel.org>
 <c084037b-1f30-53be-bf6b-06e3401b20e8@csgroup.eu> <CAJF2gTQbpVczn=Zz9rgvgNRSM9AFaoc2zVz9YaL_hWpgYSaR2w@mail.gmail.com>
 <7ce6caf5-b16d-97de-fcc3-882a9a98437a@csgroup.eu>
In-Reply-To: <7ce6caf5-b16d-97de-fcc3-882a9a98437a@csgroup.eu>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 16:22:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR5NbuVRkBWyEiCmsq4y3Ua_JMZSPcX=LQdzo2tOCFyYQ@mail.gmail.com>
Message-ID: <CAJF2gTR5NbuVRkBWyEiCmsq4y3Ua_JMZSPcX=LQdzo2tOCFyYQ@mail.gmail.com>
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

Got it. Thx

On Wed, Dec 22, 2021 at 3:27 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 22/12/2021 =C3=A0 04:02, Guo Ren a =C3=A9crit :
> > On Wed, Dec 22, 2021 at 2:43 AM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 21/12/2021 =C3=A0 18:00, guoren@kernel.org a =C3=A9crit :
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> This macro isn't used in Linux sched, now. Delete in
> >>> include/linux/sched.h and arch's include/asm.
> >>>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> ---
> >>>    arch/powerpc/include/asm/task_size_64.h | 6 ++----
> >>>    1 file changed, 2 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/i=
nclude/asm/task_size_64.h
> >>> index c993482237ed..7e2eca4fac4d 100644
> >>> --- a/arch/powerpc/include/asm/task_size_64.h
> >>> +++ b/arch/powerpc/include/asm/task_size_64.h
> >>> @@ -44,12 +44,10 @@
> >>>     */
> >>>    #define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
> >>>
> >>> -#define TASK_SIZE_OF(tsk)                                           =
 \
> >>> -     (test_tsk_thread_flag(tsk, TIF_32BIT) ? TASK_SIZE_USER32 :     =
 \
> >>> +#define TASK_SIZE                                                   =
 \
> >>> +     (test_tsk_thread_flag(current, TIF_32BIT) ? TASK_SIZE_USER32 : =
 \
> >>>                                                TASK_SIZE_USER64)
> >>
> >> I think you should use test_thread_flag() instead.
> >>
> >> Or even better: use is_32bit_task() and bring back this macro as a
> >> single line, something like:
> >>
> >> #define TASK_SIZE (is_32bit_task() ? TASK_SIZE_USER32 : TASK_SIZE_USER=
64)
> > Okay, looks better. I would fix it in the next version.
>
> Note that is_32bit_task() exists on powerpc, parisc and sparc.
>
> For other ones you can still use test_thread_flag() instead of
> test_tsk_thread_flag(current)



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
