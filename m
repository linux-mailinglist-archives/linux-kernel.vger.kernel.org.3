Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA211462FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbhK3JfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhK3JfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:35:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:32:03 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a2so19519928qtx.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUO0zYMOFTImjhGnSua4FGc7M45+0o91QH3P+KyNO88=;
        b=C03OfCYd9KW5usMblxVVjO4GA8qqiIkLGOcYZdvMMcY9dVe047o0+AGFOm2iqa267O
         f9Xmd0H1uoP8+2QugfNG4NhBvL2p3O/6FS8+8JprxI431e001pvtmmOIcSfoG4Xtg//I
         KpgfBKzR8okx3vZ7nsdpD/EG+FrWNSiUmZirNJyCmnUXcqrMb0R+hxidJbo7MsSyuiK2
         iuTLyvb3zhaBhKXInoBNQ2H5NOxAbmzsvlWqip5omDpqyQe4i+VIxeKKyaM44CgJkqlg
         VUL7g/WEuRDD5HgmFjIl8JN3ExPHJL4PUaEuGjteHIn+7JIpgFNW0XfMvGap6N/jWPSG
         1G8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUO0zYMOFTImjhGnSua4FGc7M45+0o91QH3P+KyNO88=;
        b=5rMk488UvtqkETXgZPYpB6d4TcgLc+1W3Hkd16ROUKxnvZvGlTCptlqD3KWNSt3kvw
         0M2UrFgMSP9ZPnUZ8e/rnWEFIL/fH4gK3lJPTryJYiRFgbPcaGMAuNWsr/o9SqTyJE28
         wTBoDDc1qCDNZwZXDTca5FtstHyjUTW+HDEHKE2KgCqpCbBsNsLUV9vD1O87upfpe/OD
         pomjfZJTfxhs0rR6ISTKLnO0KWfRba1cKxMD1MfF+yHMOEupzPuO21iIgl77G0+qdjNf
         8LeGVz1Mp6vbUe4hPkYfqkvUO+Pqf4ibJZNuEX1/ihZzDz+/eU8E3bHeOkEW3kH3s3+4
         kqNQ==
X-Gm-Message-State: AOAM53140F3XohGQdV10U2jN0EcyGvmkEV9hIWUENq7G/FCIUXlo8hkb
        JYLls/RNL66Fb5sDId8NI/DnCZWmzRjcdpIz+GeqHA==
X-Google-Smtp-Source: ABdhPJxmLDZCFj0xvJYiN+/PqdA9cil06ermArqh0vD0zpnelQPpEweDRgPqu4aIMcAqQlHtdTH8wFo7SO3yeN29Ldk=
X-Received: by 2002:a05:622a:202:: with SMTP id b2mr49227244qtx.34.1638264723012;
 Tue, 30 Nov 2021 01:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20211117145829.204360-1-marcan@marcan.st> <20211117145829.204360-2-marcan@marcan.st>
 <f3582c00-925d-91ec-c829-0aaa8f0157c0@suse.de> <36f3cf18-6654-e1bf-1fa6-a5797751ee86@marcan.st>
 <CAL_JsqLd=NrZgkTw+N2+Ka4zqRVpZMRNSisUDV9MhBQA-0TZQg@mail.gmail.com>
 <CABxcv=mkuJLrXr_nbELg39qJvUvV2y69FAisFKURR9bqa3FzKg@mail.gmail.com> <9315c6f5-48f6-4f29-1e31-87ab5ed771b5@suse.de>
In-Reply-To: <9315c6f5-48f6-4f29-1e31-87ab5ed771b5@suse.de>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Tue, 30 Nov 2021 10:31:52 +0100
Message-ID: <CABxcv=kWa8ghQkVeKFN+emQ1wRV=AErULVr9E6R3ZBBiCkMxcw@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/simpledrm: Bind to OF framebuffers in /chosen
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Tue, Nov 30, 2021 at 9:31 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 30.11.21 um 07:44 schrieb Javier Martinez Canillas:

[snip]

> >
> > I think that instead it could be done in the sysfb_create_simplefb()
> > function [0], which already creates the "simple-framebuffer" device
> > for x86 legacy BIOS and x86/arm64/riscv EFI so it makes sense to do
> > the same for OF. That way the simplefb platform device registration
> > code could also be dropped from the driver and users would just need
> > to enable CONFIG_SYSFB and CONFIG_SYSFB_SIMPLEFB to have the same.
> >
> > I have a couple of boards with a bootloader that populates a
> > "simple-framebuffer" in the /chosen node so I could attempt to write
> > the patches. But probably won't happen until next week.
>
> IMHO it's better to keep the OF-related setup in the OF code. The sysfb
> code is for screen_info. We can try to find common code for OF and sysfb
> that then lives in a shared location.
>

Ok. As long as we don't end with code duplication then that works for me too.

> Using a single global screen_info variable is somewhat awkward these
> days. In the long term, I can think of pushing sysfb code into
> architectures. Each architecture would then setup the platform devices
> that it supports. But that's not really important right now.
>

That makes sense. And provide a set of helpers as you mentioned that could
be shared across the different architectures and firmware interfaces.

Best regards,
Javier
