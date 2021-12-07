Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC946BFCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbhLGPxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbhLGPw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:52:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC0C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 07:49:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0E0E5CE1B60
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BEBC341C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:49:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WyGjEHMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638892163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5xLidv0Jet0uhvStOh3cHmNx+1Zq0cTicPBO56WosCQ=;
        b=WyGjEHMjxWQTUiMsNCtVPf518t/VRR4PItBoIqyWouofwUkVwpL2COO+HytWhvq0TBoqhO
        Ql63wSk2aqE4H8VeaT9McawfWwLCfRWPODdlJF1jDPJ4E/8MR69/bEjtW5KiwUadtaCsAA
        QdqmOFnbCH18/tVxfHLY6oy7C3v6dQU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b6f29e72 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 7 Dec 2021 15:49:22 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id v203so41993554ybe.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 07:49:22 -0800 (PST)
X-Gm-Message-State: AOAM532Ra9FgHfu3UzjL7jgHeHzBCaAs0emUmfLC4PYwARWm/wQp/v+Y
        ssXMXbWP8O9dVXaF5caX19jS3WihEOcrkM9WEdg=
X-Google-Smtp-Source: ABdhPJy5tmSUwizGXrqf4iv+m+DlaicDj61kH8nvpKvyH4guUh4x/iS8eBuG7I/HnDEZ5OfxFztG9qA0bhtaVejQn10=
X-Received: by 2002:a25:a427:: with SMTP id f36mr51468185ybi.245.1638892161818;
 Tue, 07 Dec 2021 07:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20211130184315.258150-1-Jason@zx2c4.com> <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
 <CAHmME9q7kVREOGPpG+kafS25Ny1=geFPwLRREe+nkC=UkGQUHw@mail.gmail.com>
 <YauCkjsgDL4sdCId@mit.edu> <CAHmME9q_hYyiUKb+H82-njugXaruQc6=sVa3HCQHnOHEOsGVwQ@mail.gmail.com>
In-Reply-To: <CAHmME9q_hYyiUKb+H82-njugXaruQc6=sVa3HCQHnOHEOsGVwQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Dec 2021 16:49:10 +0100
X-Gmail-Original-Message-ID: <CAHmME9qECnsh0EhV8Zi0vFntqT4OaAbhfOXFFZBjQjzpReNAJg@mail.gmail.com>
Message-ID: <CAHmME9qECnsh0EhV8Zi0vFntqT4OaAbhfOXFFZBjQjzpReNAJg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: co-maintain random.c
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 4:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Sat, Dec 4, 2021 at 4:00 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > Thanks for stepping up.  There's no question that this Fall has been
> > insanely busy for me, and for the past 3 weeks or so, I've been on
> > vacation and Thanksgiving travel, and I'm still catching up on a
> > mountain of e-mail.
> >
> > Something that I think would make sense is that we set up a joint git
> > tree on git.kernel.org, for which we would both have access to push
> > to, and use a group maintainership model much like what other teams
> > have done.  Do you agree?
>
> Sure, that works for me. I had started using zx2c4/random.git. But
> I'll talk to Konstantin about moving that over to a shared repository
> in a group namespace.

We're all set now with
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/crng/random.git

Jason
