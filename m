Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE648BF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 08:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351288AbiALHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 02:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351314AbiALHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 02:39:38 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15544C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:39:38 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id q15-20020a4a6c0f000000b002dc415427d3so425308ooc.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0UjdAdkvyGyBdDeJRmh0/905GmT+tl9Ko8X4YQ6eFHU=;
        b=UlXqyHjxjNnKAVw0+ayhTbo92N9ebMVlz1rAVWY1Xhw0JQGg8SOGQbvJGtklD7/yss
         QVGylcrSn2bhHatb44M5k4uO5rxwrQDbNXHGGZXCYD+NhjL+5+92SYssrSQ7CaRZSQlN
         NRo/tGjNXav1jCYrFrZ2qQQfrNR/Go6qaKH42Oq1n3nKibYqfkdv7HOAS9DJyMb5+9gp
         WWr47cu7Uz40HgIxsz1Xb4hgQMV5ZSD8D1cSxDSvJjuX8DGsyCiaiRtzLc0PXpHql4Tb
         IgaggYgv55cpQYCO9LQGzKOlF0FX1aX3mZKRCpc8+s5A7weSQP+ZLsaYe3wo3wEv5qS8
         Arng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0UjdAdkvyGyBdDeJRmh0/905GmT+tl9Ko8X4YQ6eFHU=;
        b=GyaZLPc5M36nIpf5Yo0vNpn72lojVw/zMASwaD+HL3S2GW7bN1/ORisl7bEdPqzgfO
         yCol3ULSDCr773bN8hqZR7vz45g+q0h4nS3lJ7Q1DGtlgeb979TcTldf1tydOZyIS5hH
         Cvj5R1Ho7k0kayOjydgJjw+JB9EUljCxLZ5QYPlRyZKNE0/ppc10h32azQGjrLGCDIVX
         19+j0ra1yFOEMh273NOVR0j15zUo3EMHTJjGbp71arfLBBPfeutwjsaLDI4WkRSQ6N73
         QhCz0MiIFEV/iGWL70MGYNZ7EdoBf0VDhx1xyRywkoWn3kVWJebuLlZJa74phV88A1sz
         QxIg==
X-Gm-Message-State: AOAM530mZQBoc1RgpwCyuPBN4AIBM3Nc3g+aYNXn+PWFKVgNDFC06ZIU
        od+gy2bq+EuacS8jMkME8+iNpEHFx9j/4xikVP/u4Q==
X-Google-Smtp-Source: ABdhPJySNabagEYkC1TTzHXdv3F+abrHDb5cQW54ucTV7V9XFyRblwiUMng/CKIs17F6vmzComYTOr7dbtUtqWco+pA=
X-Received: by 2002:a4a:d344:: with SMTP id d4mr1451343oos.18.1641973177120;
 Tue, 11 Jan 2022 23:39:37 -0800 (PST)
MIME-Version: 1.0
References: <CACDmwr_b0Z6JK2M6i6RZ4Qg3wb1uqG0NrybQ9mR2iw5QJT8XoA@mail.gmail.com>
 <CACT4Y+ZxnG0sLhqn4uw6ueAUsA4cNZJh0_6eES6C45u9jW-4Pw@mail.gmail.com>
 <CACDmwr8QH-2Kk8DU5zxJ6RLdCho2MzkA9uMJtQ+smoV-qhOq9A@mail.gmail.com>
 <CACT4Y+buWoqxZoUgzuYyYt6jP76GbjDoVqA7M07itQVgD60C9w@mail.gmail.com> <CACkBjsZ5BD7_vNWmLKfHUfU7D_-0A7V1-=U78sbe+qw=XUf9ag@mail.gmail.com>
In-Reply-To: <CACkBjsZ5BD7_vNWmLKfHUfU7D_-0A7V1-=U78sbe+qw=XUf9ag@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 12 Jan 2022 08:39:25 +0100
Message-ID: <CACT4Y+aM2qCBnjiVCiBhvGqYrDxBELPVYFPYYHf22zd-_GgnPg@mail.gmail.com>
Subject: Re: KCSAN: data-race in tick_nohz_stop_tick / tick_sched_timer
To:     Hao Sun <sunhao.th@gmail.com>
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

On Wed, 12 Jan 2022 at 02:39, Hao Sun <sunhao.th@gmail.com> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 01:18=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, 11 Jan 2022 at 17:56, Kaia Yadira
> > <hypericumperforatum4444@gmail.com> wrote:
> > >
> > > I'm sorry. They are similar but I can't tell if they are the same bug=
,
> > > so I report them individually.
> >
> > +CC list back
> >
> > I did not mean that you report similar bugs. I meant that you and
> > kvartet seem to be following the same process. There are several
> > complaints about the quality of reports. So I am wondering what you
> > are doing/why/what's your goal.
> >
> > Hao Sun, you are CCed on all emails, maybe you can shed some light on t=
his?
>
> Hi Dmitry,
>
> I'm on holiday and ignored these emails.
> kvartet is an acquaintance of mine, I have no idea who Kaia is.
> I have little knowledge of their actions. They may be new to the
> kernel community and may not understand the rules in reporting bugs
>
> Maybe we should add some `WARNING` in Syzkaller docs, e.g.,
> `how_to_report_bug.md`, to tell people to polish their reports before
> sending them out.

Hi Hao,

Thanks for the info.

We've already extended how_to_report_bug.md with some warning:
https://github.com/google/syzkaller/commit/ca0f51ac4a404a5378464e91c42eca8c=
1e78e21a
But it does not mention KCSAN/KMSAN yet, as these reports come in later.

> Or maybe we should just suppress all the `task-hung` and `kcsan`
> reports in Syzkaller by default, enable them manually if the user
> knows what they are doing.

This is a good idea.
We will need to figure out details, and this will require some coding.
