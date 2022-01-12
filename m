Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DA648BC84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiALBjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiALBjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:39:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1785FC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:39:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i6so1832690pla.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CEddybII/pOZ/AUul1lLDQ8u29cZ1yKYu2ca2ijz+E4=;
        b=BR8PExhwg1IPKgizgDz/RafgQ3W12/R44fW/VFd3g54a+G2sW+BbpEI6RwR3jH322N
         iUNPIUbq/gTfQliMj2ZQlQ95c7qEgr9TZ0m2ItlE0VRC0hlT0si2K1NcKirDfo4D9MDd
         DyszCmQFnQVJY6UJysZrhFsk7zUyWPHw4LuVs1mQERE+y+M+YdeVduzQyKxKwxAiF5ZY
         8wtxRV4jNi0q99M85I5iic6RFzB0bG7Gfu1cSv71e+Xd6Vc8l2rQ3ebw/qnxVIgJgkRv
         rM8dXoR617TrHaCV3LK4pUuDuWS8xStozEg5UiS8c8eqw7Vt3yir8lGf3/I+iUkroaZD
         eiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CEddybII/pOZ/AUul1lLDQ8u29cZ1yKYu2ca2ijz+E4=;
        b=41sHpYcgjCadDWCxyCnWc+ARfuG745u1dJHg2+l7BTdjV+hGvyLLw60Bo6h/ql/m1B
         v+n0Dd0vLW4UnSHiVfcbs/EKUP4bl3GiSGULSIkwBJuzBLHitHa50zFCc1czxkhvk+FA
         8dPQ60W9Pecl8A6ui7G5uw8RZ51Z0vL6jgF/o7qhiaWhWCQSEQlvUy4NQbcwRBhFxeKJ
         ceebDZAPPAeyhVYm6RhVLcqBkpYe3hLCWQ6fyx5i1v/J266AtS4MNX/sAWnVogKJw4h2
         Zx9qQFfl0q3aQvKfEwHe6Ll3W/k2Wb3VxK+IAX4oKU15afmzHr1EuBiXddGBXr3P+9//
         C42Q==
X-Gm-Message-State: AOAM531WTgeQ6gHU42KqkUN6SBmMNIYBFhSdXVPGqNv/BeTW6ad7NSOi
        GbXmTsSsvPufxY/4BKY6gG3Ii4z6k1Z5TW20dQ==
X-Google-Smtp-Source: ABdhPJyOthR9/rK6CalS6S3KECo/JVObAvM8e+gOSxs02jbDz+pzVT1sNxCXVZBtqQ4UQhSNgf/PRhh2jmaJAL4n7j8=
X-Received: by 2002:a17:903:41c6:b0:14a:3c28:6808 with SMTP id
 u6-20020a17090341c600b0014a3c286808mr7182772ple.155.1641951558443; Tue, 11
 Jan 2022 17:39:18 -0800 (PST)
MIME-Version: 1.0
References: <CACDmwr_b0Z6JK2M6i6RZ4Qg3wb1uqG0NrybQ9mR2iw5QJT8XoA@mail.gmail.com>
 <CACT4Y+ZxnG0sLhqn4uw6ueAUsA4cNZJh0_6eES6C45u9jW-4Pw@mail.gmail.com>
 <CACDmwr8QH-2Kk8DU5zxJ6RLdCho2MzkA9uMJtQ+smoV-qhOq9A@mail.gmail.com> <CACT4Y+buWoqxZoUgzuYyYt6jP76GbjDoVqA7M07itQVgD60C9w@mail.gmail.com>
In-Reply-To: <CACT4Y+buWoqxZoUgzuYyYt6jP76GbjDoVqA7M07itQVgD60C9w@mail.gmail.com>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 12 Jan 2022 09:38:58 +0800
Message-ID: <CACkBjsZ5BD7_vNWmLKfHUfU7D_-0A7V1-=U78sbe+qw=XUf9ag@mail.gmail.com>
Subject: Re: KCSAN: data-race in tick_nohz_stop_tick / tick_sched_timer
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Kaia Yadira <hypericumperforatum4444@gmail.com>,
        kvartet <xyru1999@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov <dvyukov@google.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=89 01:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 11 Jan 2022 at 17:56, Kaia Yadira
> <hypericumperforatum4444@gmail.com> wrote:
> >
> > I'm sorry. They are similar but I can't tell if they are the same bug,
> > so I report them individually.
>
> +CC list back
>
> I did not mean that you report similar bugs. I meant that you and
> kvartet seem to be following the same process. There are several
> complaints about the quality of reports. So I am wondering what you
> are doing/why/what's your goal.
>
> Hao Sun, you are CCed on all emails, maybe you can shed some light on thi=
s?

Hi Dmitry,

I'm on holiday and ignored these emails.
kvartet is an acquaintance of mine, I have no idea who Kaia is.
I have little knowledge of their actions. They may be new to the
kernel community and may not understand the rules in reporting bugs

Maybe we should add some `WARNING` in Syzkaller docs, e.g.,
`how_to_report_bug.md`, to tell people to polish their reports before
sending them out.
Or maybe we should just suppress all the `task-hung` and `kcsan`
reports in Syzkaller by default, enable them manually if the user
knows what they are doing.

Hao
