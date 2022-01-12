Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB0748C5D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbiALOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiALOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:19:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DDBC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:19:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w16so10514699edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWDPHKiHVEi6XaHX046Gy6+jTaNRC7On6YkGQdpOLA8=;
        b=fBG8B/U1HhbBvtljKKjZGjGYC5ARGawtrGo2K9k9W6f5nw1Re4xMZ5XGNvkSlo1Fnh
         gZhIpT01ULGkRA9CBsxHYZ8oc4bNSc0cHz6cxsjfAMFy3rFztdPrOvovoBPYvvdLoWVd
         ZLaNVrJYnK2l/tAYlygarS3aghM1Ap8JYou9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWDPHKiHVEi6XaHX046Gy6+jTaNRC7On6YkGQdpOLA8=;
        b=ddnyaNW15omzuiao/oN3Lhk6mRe+4YXMEh4el0Iej6+K8jybURU99mk6pJ8tT5GwpY
         EUNVwkOqMG+9L+V35SA86oVIxnrTMt1WCJ7kiGQRzHYgYXSAmzB+Kfbcji1SZECjCbQB
         QmHVRNoL/W80zoeyRnlQ+R+hreE5zmd9+9915dbAsRorTN8YHx9EliZa/dkK86GL5rgy
         SculTnJLhSHs2QxE9J1wUW8ki1aQRsK5RQwFdxYgUer85f2p8VniJxCSA7AO1TD6337n
         KHdYcZD8eo1M2dnSp0SpScnE8GiIpGZIvtu3Ib7hqtUbDYUCDxvWMygxxTcoxvwFgHUH
         PZ3g==
X-Gm-Message-State: AOAM5326DlWEv8OD7kYmr2fkdEVYiwfY/i/Sa3BH9gZ7R1SG125DvhWn
        ksIc/73AfkLAbvyeZyPkv7dBkeRsCt16iGp+lHpuWA==
X-Google-Smtp-Source: ABdhPJweVM/8LEIjEk4lPXPk1WktMzTKABxXOE6g/K8s1+E1cmghb68HHmZoQd3a4E1QbppCeoOK194jCvP5CMkN9sw=
X-Received: by 2002:a17:907:6d1e:: with SMTP id sa30mr7947084ejc.1.1641997177124;
 Wed, 12 Jan 2022 06:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20220112140137.728162-1-jforbes@fedoraproject.org>
 <CAHmME9rJFVeWL=SFTkM8=+2te_GnH4n-THH+F3p5mnHfCkhZ4w@mail.gmail.com>
 <CAMj1kXHubNk3gRTOmD1rOCifCUE4O6=TvNr_XhP1tNcCBuzfBQ@mail.gmail.com>
 <CAHmME9oKEawBAGSN_tdpBDe2_vRUE8Gh+GMXn+d94A6te4FJPQ@mail.gmail.com>
 <CAMj1kXGzzHefRu1wcgDsYpybSDrUK__FXE-Mjm2r1fg2xiz6Jg@mail.gmail.com>
 <CAHmME9p25W3Pg4T4Pers+hxryhAcQZEZMx5uueF3a-oCr7ABuA@mail.gmail.com>
 <CAMj1kXEgE-3Pnnak-RZAPch=ma399Ki4jrMb8j32x2AFyZZALA@mail.gmail.com> <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
In-Reply-To: <CAHmME9oTsOZCJoPUT=LwUuwWHbAa_N1MRoGjTYY5Poj4tr0+Zg@mail.gmail.com>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 12 Jan 2022 08:19:26 -0600
Message-ID: <CAFxkdAo0MbdmNQmChuDNEJN6DMN5-_fsph8QeU4dY2CuwgRzaw@mail.gmail.com>
Subject: Re: [PATCH v2] lib/crypto: add prompts back to crypto libraries
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 8:15 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Wed, Jan 12, 2022 at 3:13 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 12 Jan 2022 at 15:12, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 3:08 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 12 Jan 2022 at 15:08, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > >
> > > > > On Wed, Jan 12, 2022 at 3:06 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, 12 Jan 2022 at 15:05, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > > >
> > > > > > > This commit also needs this snippet:
> > > > > > >
> > > > > >
> > > > > > Why?
> > > > >
> > > > > So that the menu of crypto library options is inside of the library
> > > > > menu. Otherwise this will appear inside of the _root_ menu, which
> > > > > isn't what we want.
> > > >
> > > > Why not? I think that's fine.
> > >
> > > It's really not appropriate there. Look:
> > >
> > > - Justin vanilla: https://i.imgur.com/14UBpML.png
> > > - Justin + Jason: https://i.imgur.com/lDfZnma.png
> > >
> > > We really don't want another top level menu. We're not that important.
> > > Rather, crypto libraries are but one ordinary subset of ordinary
> > > libraries, just like how the build system does it too.
> >
> > I disagree. The root menu is a jumble of things already, and having
> > this one at the root is really not a problem.
>
> Should CRC routines also go into a submenu and be put at the root?
> What about other library functions? Library functions belong in the
> library submenu. We don't need our own top level submenu for this. The
> whole point of lib/crypto/ is that they're just boring library
> functions. Libraries! So, part of the libraries menu.

Specifically in this menu, users were expecting to see it in the
Cryptographic API menu.  I think having it in the main menu just below
this entry is much more appropriate than being buried under another
menu.  Particularly if the goal is to get rid of the menu again all
together once we can audit the full set of deps on crypto libraries.

Justin
