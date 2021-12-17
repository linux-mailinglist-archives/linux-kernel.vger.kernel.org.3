Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44996478B18
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhLQMJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236260AbhLQMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:09:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA9C061759
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:09:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s1so3672399wrg.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 04:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TpogRltD/BPLIa5iBku/o4kEHCjlMgOzFRWSLg+D5DY=;
        b=Zr3oTIIiE4UtFg8dXb7VIOhTOza5J9sI7QJcI9iYvlfQaNZR/7ItD/cJO71lrpmhph
         zb1jW31FT7jS8Li+1LGmaazUZjXZAYs7oKIGZSHjh/jv1UzgXtiQ99ga9ev+c9nSG4zT
         T+GvTp/CJLXr1oErK8HA20LE7aAQxcDRMqQ5YS0mDt0okmuLh3yYIdcQKxdjm1gGCm5o
         vdF28fy2+sp6eswLq5nQnnncKiz8HdmUTnFxlOO/rUIKF6BOdiUdvivlyAQ+gDzOcwO0
         x1Es8C6Ir9P7GVJRPEQD7PUOhNCqaLzGbrz83CZsFz0fuTYkfay1qf73A514yEMnhV2E
         466Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TpogRltD/BPLIa5iBku/o4kEHCjlMgOzFRWSLg+D5DY=;
        b=c9Bb0IBryOm/TDLqTuWv/MNQ1UaEZgxIWxGsRTJUapHGK3h3wqpwwORPygOzfHDaiO
         RDQru283PzArusvlYQBrSO0vwFUhMtlKTXuAioT+Bp4CKqKBsObUil5fNQM9wKk+Q/0D
         H0+WNnKBtA6lKMw8lidG7K1zp02q0o/YXzD8yvFlWA5iVhiJihocf4ZRfnXzRL6k01LD
         iNF6FOKW5pw6Grp1FzgW3QiI2airc8MGT7T3Kj7B9nXGZz2dpDjXDjG+cvUWAlLyVAWg
         sUdxJkgzy5CnrESRUbKKcQwI+K/yGZ2aaBwB0zjqqSdSF2a8TsAdG5OJ5VMa4lCaRciW
         7p/Q==
X-Gm-Message-State: AOAM533aAUHFY/KqhH79DWPocLp3GqNDa5+thFPSNQbeC8kUQdmrGD5R
        D1sY7eo713HwFn1KGWNm0YGgNsZPkRpwpRgou1Izrnf45uMXWA==
X-Google-Smtp-Source: ABdhPJynCWaK+LT9ICjcxzHwwuwQCjPpQl3/7JBL1kclfNriHwhwbMSzSqkJP8t42glvYDUaOq9tt7Xwqq3UMuuij9I=
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr2434038wru.214.1639742974266;
 Fri, 17 Dec 2021 04:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
 <BC1B38E7-1170-4C05-948A-D18E80AC49E7@jrtc27.com> <fd40010f-f2ec-b32a-6850-1e054af43725@canonical.com>
 <150C4E84-2C69-45DB-AF27-1E0C223D8D7A@jrtc27.com> <611d4055-c50c-55c1-0e02-43ffda66dbce@canonical.com>
In-Reply-To: <611d4055-c50c-55c1-0e02-43ffda66dbce@canonical.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Dec 2021 17:39:22 +0530
Message-ID: <CAAhSdy3CXJAieR3toyhQtk07CiCkUkmK7hB1DiQ5Wrd7JCqcmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Atish

On Fri, Dec 17, 2021 at 4:12 PM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 12/16/21 17:51, Jessica Clarke wrote:
> > On 16 Dec 2021, at 14:17, Heinrich Schuchardt <heinrich.schuchardt@cano=
nical.com> wrote:
> >>
> >> On 12/16/21 14:49, Jessica Clarke wrote:
> >>> On 16 Dec 2021, at 12:35, Heinrich Schuchardt <heinrich.schuchardt@ca=
nonical.com> wrote:
> >>>>
> >>>> The SBI 0.1 specification is obsolete. The current version is 0.3.
> >>>> Hence we should not rely by default on SBI 0.1 being implemented.
> >>> It=E2=80=99s what BBL implements, and some people are still using it,
> >>> especially given early hardware shipped before OpenSBI grew in
> >>> popularity.
> >>> Jess
> >>
> >> Do you mean BBL is not developed anymore?
> >>
> >> Some people may still be using a 0.1 SBI. But that minority stuck on a=
n outdated software stack does not justify defaulting to deprecated setting=
s in future Linux releases.
> >
> > BBL is still actively maintained; its most recent commit was 24 days
> > ago. Also, the amount of code CONFIG_RISCV_SBI_V01 affects is tiny, so
> > I see no tangible benefit from making this change, just unnecessary
> > breakage of perfectly functional systems.
>
> Only the default is changed. How could this break any existing system?
> You can still compile with the deprecated setting.
>
> I can not see why we should keep a default that will cause issues on
> systems complying to the current SBI specification.

I agree with Heinrich.

Almost all SBI implementations (OpenSBI, EDK2, KVM, Xvisor, etc) are
providing at least SBI v0.2 and we can't endlessly wait for BBL to move
away from SBI v0.1. We can't totally remove SBI v0.1 but we should
at least disable it by default.

Same rationale applies to the spinwait CPU operations which are only
required for systems using BBL. The sparse HART id series from Atish
can include a patch to have spinwait CPU operations disabled by
default.

@Atish/Palmer, what do you think ?

Regards,
Anup
