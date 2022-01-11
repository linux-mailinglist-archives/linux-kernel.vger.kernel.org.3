Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A2C48AE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiAKNGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiAKNGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:06:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9326FC06173F;
        Tue, 11 Jan 2022 05:06:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40150B81AB4;
        Tue, 11 Jan 2022 13:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54CEC36AF4;
        Tue, 11 Jan 2022 13:06:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gJBCKMH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641906391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUgye/d6jt0DNu369eV2V7tQU7bwWVb+qYvWTJEDDUk=;
        b=gJBCKMH165sQrZK91jVMvJlAjIAXskVGtOctYi/ddmqiXUPOqgVgJQ7dcNUDFw5IINbLhZ
        S+3cTpwMqr6aE3go9Ru/ZgNWUWbVyo5P1L8dj4dO8mwJTtNDqXLRyuSAZ2ySH2JyEjcD98
        zKtTLtXqh6MLAQHy0K/2PpMEj2nGDCI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f19b60fb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 11 Jan 2022 13:06:31 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id p187so4561848ybc.0;
        Tue, 11 Jan 2022 05:06:31 -0800 (PST)
X-Gm-Message-State: AOAM532KDojvsFvb8Rgb8Wd3OZKha31+f+Es4F9ssIMpBiUJ/eOjgCH3
        Ia6NCre9pCC+H+/FMRUIE09mDmATctyhBK6aHqA=
X-Google-Smtp-Source: ABdhPJzPQZrE87XNNZNA2ikIc68treEqUvOMcyKN25afy+XYYUuJt2NLhxrqhLB5H05NAfIMwF2i/KDvCg+JjDvOOrM=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr6045343ybe.32.1641906388088;
 Tue, 11 Jan 2022 05:06:28 -0800 (PST)
MIME-Version: 1.0
References: <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor> <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu> <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu> <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu> <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
In-Reply-To: <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Jan 2022 14:06:17 +0100
X-Gmail-Original-Message-ID: <CAHmME9qw8hbbE2y56t7zygedofDDDLoPUxYWGZB_Kae0ipFARA@mail.gmail.com>
Message-ID: <CAHmME9qw8hbbE2y56t7zygedofDDDLoPUxYWGZB_Kae0ipFARA@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jan 11, 2022 at 2:44 AM Andy Lutomirski <luto@kernel.org> wrote:
> So let=E2=80=99s solve it for real.  Have a driver (in a module) that

Um, let's not. This really isn't something the kernel needs to solve
here at all. There's a viable userspace solution. I see that the
discussion of something finally slightly technical (as opposed to just
compliance BS) has nerd sniped you a bit, but keep in mind what the
actual overall picture is. This isn't something that needs to be done.
My little CUSE thing (which I'm happy to develop out a bit more, even)
has the intent of fulfilling a compliance checkbox and nothing more.

Jason
