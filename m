Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B246E116
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhLIDDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:03:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhLIDDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639018787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfb3U3niqbzfyllKy5x8hcf0lVNrqUlULt6ivQ8k0u8=;
        b=fNsN3pn2Xanb1ETWQIcab+8oGR4YW2CuBuAg2FqN8JK4VtkbM0Pj1LGj16U6yxOGjgjghW
        8nLIBqHUXnhCEMqejUXkK3CBrsyI+h6P+V2wUVw3wiOH8j/5J7V+rYDayQidCHXQUk7tPM
        +NECuUzSygQrPsEEHeffB/Tc/bnRSq4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-_W5Bgj7DOTucBRC1m3-fKg-1; Wed, 08 Dec 2021 21:59:46 -0500
X-MC-Unique: _W5Bgj7DOTucBRC1m3-fKg-1
Received: by mail-yb1-f197.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so8101739ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 18:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfb3U3niqbzfyllKy5x8hcf0lVNrqUlULt6ivQ8k0u8=;
        b=gXBjkVfKm/U+pmjxM0xOUbztFmHaVJ19ObNZTQvrTY2LAkOaopDi3KQeW+DdfC4ijt
         Mn/qZEhw12l4Fbeviqe+XTCCkugOgvmBNH0F7IP+/hsyth4IkmUn2Z018iZF+CFkba64
         q36ssjQisDs9R3rhLe62BeO1XDvbP8Zr6PMWnyUsbaMncgKCOEDHP+vmgCbpWCaWECPC
         xiXzwLUpj5YNFxhg2PE12jSJwjrNww/hORrz0nvQsw7nek4IiNxNp61GmB51llUHMmz4
         x3Cfiyw5+5jKRsyAWbQ6rYjqUoqhdTA+8yBg6un324KZ3Ecu+/10gWPUbZft2tavPIcm
         0WgQ==
X-Gm-Message-State: AOAM532aKT8Qr+o9kH38FNnmPr3p8qvZkMDulLeFoVpqV1bmbESeccVi
        r/HkPSJWrnQ+rB2HD1hOv1f65SZe1d/33HDhQZ3areoMUS/pTjNsUVvMqCwoLzVnB0k+4aFG5Fy
        Qnr6/hhd9wH/BUygB+RAAPEbQj0f6XSvy64yG9QQJ
X-Received: by 2002:a25:d792:: with SMTP id o140mr3166106ybg.493.1639018785495;
        Wed, 08 Dec 2021 18:59:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBg0mmEpQ4xuCvkM0lS1TYLQJICuVFphZCyXkaM7g/28leqI7DNxQZ+/xxr0+/aZMzpmIyIOAygxl8cdrYg5Y=
X-Received: by 2002:a25:d792:: with SMTP id o140mr3166080ybg.493.1639018785247;
 Wed, 08 Dec 2021 18:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20211207214902.772614-1-jsavitz@redhat.com> <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
 <YbB0d6T8RbHW48sZ@dhcp22.suse.cz> <YbDX16LAkvzgYHpH@dhcp22.suse.cz>
In-Reply-To: <YbDX16LAkvzgYHpH@dhcp22.suse.cz>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Wed, 8 Dec 2021 21:59:29 -0500
Message-ID: <CAL1p7m4ka1v-Zoi-RpDy5ME-bMikGPX5V_4Hod-Y0KHOq_G8zA@mail.gmail.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 11:05 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 08-12-21 10:01:44, Michal Hocko wrote:
> > On Tue 07-12-21 15:47:59, Andrew Morton wrote:
> > > (cc's added)
> >
> > Extend CC to have all futex maintainers on board.
> >
> > > On Tue,  7 Dec 2021 16:49:02 -0500 Joel Savitz <jsavitz@redhat.com> wrote:
> > >
> > > > In the case that two or more processes share a futex located within
> > > > a shared mmaped region, such as a process that shares a lock between
> > > > itself and a number of child processes, we have observed that when
> > > > a process holding the lock is oom killed, at least one waiter is never
> > > > alerted to this new development and simply continues to wait.
> > >
> > > Well dang.  Is there any way of killing off that waiting process, or do
> > > we have a resource leak here?
> > >
> > > > This is visible via pthreads by checking the __owner field of the
> > > > pthread_mutex_t structure within a waiting process, perhaps with gdb.
> > > >
> > > > We identify reproduction of this issue by checking a waiting process of
> > > > a test program and viewing the contents of the pthread_mutex_t, taking note
> > > > of the value in the owner field, and then checking dmesg to see if the
> > > > owner has already been killed.
> > > >
> > > > This issue can be tricky to reproduce, but with the modifications of
> > > > this small patch, I have found it to be impossible to reproduce. There
> > > > may be additional considerations that I have not taken into account in
> > > > this patch and I welcome any comments and criticism.
> >
> > Why does OOM killer need a special handling. All the oom killer does is
> > to send a fatal signal to the victim. Why is this any different from
> > sending SIGKILL from the userspace?
>
> I have had a closer look and I guess I can see what you are trying to
> achieve. futex_exit_release is normally called from exit_mm context. You
> are likely seeing a situation when the oom victim is blocked and cannot
> exit. That is certainly possible but it shouldn't be a permanent state.
> So I would be more interested about your particular issue and how long
> the task has been stuck unable to exit.

Before applying this patch I never saw a task eventually exit during
the reproduction of this system state.
Every task in this waiting-on-a-dead-owner situation state appeared to
be permanently blocked until user intervention killed it manually.

>
> Whether this is safe to be called from the oom killer context I cannot
> really judge. That would be a question to Futex folks.

I am also very interested in feedback from the Futex folks.
This is the first fix for the bug that I have found but I am not sure
whether this introduces other issues due to the context.

> --
> Michal Hocko
> SUSE Labs
>

Best,
Joel Savitz

