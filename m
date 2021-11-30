Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAF462D03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbhK3GsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhK3GsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:48:24 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A6BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:45:05 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g28so25696967qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKE3SwAPujqmjUAZ9rQU1XdIfpsX7BZWFDwsRhFkyDo=;
        b=g7xUjsHLoB/kGuWRUDrA4d3KpXufSvrgvzJQ6chy6Ws52RnweR0HKccFg4O6xqRU09
         T1hqP5mfqLt0B7sLTHR0XX4fZvcW6fg18HQSQ4FGEcBlTJ5G7EgTj8u7fruO+EMHrYQR
         7Y8nYjZvd0EqxmGFiomh+R9dk0pGYkBmUtMPOHMDW1GCjnFeGA+ci9CC/zW2HhmbpqBw
         3EHoO4FBD9nxho73oFftoo4XVljvlbn3FQgpwLwnSbYY3CaqfqAuDGkFQjv1g9bJPGox
         RB3vIiVq6XBFj8BWIkYnHeho85J+mMybfT4FrFsTRj7Wt0GYZhL4Yjs01Lf3u3H9MY5d
         XK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKE3SwAPujqmjUAZ9rQU1XdIfpsX7BZWFDwsRhFkyDo=;
        b=epNKIORsdMJ0sna3xgkccilju4YAs+bJ45RBaho5xZhrqxNk1N6gvq6sYjgfo+xBTf
         azdfrNqsjHCi93ePA1I7BpsysSHzmJm6gMYK6dP3GPdYsU/Jw7J56wa+1TGSctag28r0
         Cqb7iOiViW0adzwuJwIOb20sCpoChj6XYKHrSTI2vM3dt7XOJUGnCr5/MwsirS2hUD1u
         hZRZbVcHsUPmT4/M5wSK3YLobMEmGuDGGxEQeAkHp10DmNLwoRpNBxpKRbNVYqnc32IB
         LRn0r1lAP1XglmLhvMH+lVbRL6xdJUjZc1yFc9ODIFjbCt9yCDxkkVwwbj38xC9cTwmm
         3MqA==
X-Gm-Message-State: AOAM531vSoUJHNhtGIxLPRTh6jfIwS7AFrpT8Um4UbHoE9tw2zPs0geA
        vbjaszRHUs9KJZOdspWrNX+YTE/L7/yiNPlYAWlcwaOKDjDLlA==
X-Google-Smtp-Source: ABdhPJwlh9AXckQRtlJG9Tc6C7SGMudaXmy5jY/4bAoMJccAQqzFx6Kkm7Odxp+lmklWV0D4oI1N34TE5V7Fve1V0FA=
X-Received: by 2002:a05:620a:430c:: with SMTP id u12mr35141300qko.589.1638254704508;
 Mon, 29 Nov 2021 22:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20211117145829.204360-1-marcan@marcan.st> <20211117145829.204360-2-marcan@marcan.st>
 <f3582c00-925d-91ec-c829-0aaa8f0157c0@suse.de> <36f3cf18-6654-e1bf-1fa6-a5797751ee86@marcan.st>
 <CAL_JsqLd=NrZgkTw+N2+Ka4zqRVpZMRNSisUDV9MhBQA-0TZQg@mail.gmail.com>
In-Reply-To: <CAL_JsqLd=NrZgkTw+N2+Ka4zqRVpZMRNSisUDV9MhBQA-0TZQg@mail.gmail.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Tue, 30 Nov 2021 07:44:53 +0100
Message-ID: <CABxcv=mkuJLrXr_nbELg39qJvUvV2y69FAisFKURR9bqa3FzKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/simpledrm: Bind to OF framebuffers in /chosen
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > Simpledrm is just a driver, but this is platform setup code. Why is this
> > > code located here and not under arch/ or drivers/firmware/?
> > >

Agreed. Creating platform devices is something for platform code and
not really a DRM driver.

> > > I know that other drivers do similar things, it doesn't seem to belong here.
> >

Yeah, the simplefb driver does this but that seems like something that
should be changed.

> > This definitely doesn't belong in either of those, since it is not arch-
> > or firmware-specific. It is implementing support for the standard
> > simple-framebuffer OF binding, which specifies that it must be located
> > within the /chosen node (and thus the default OF setup code won't do the
> > matching for you); this applies to all OF platforms [1]
> >
> > Adding Rob; do you think this should move from simplefb/simpledrm to
> > common OF code? (where?)
>
> of_platform_default_populate_init() should work.

That should work but I still wonder if it is the correct place to add
this logic.

I think that instead it could be done in the sysfb_create_simplefb()
function [0], which already creates the "simple-framebuffer" device
for x86 legacy BIOS and x86/arm64/riscv EFI so it makes sense to do
the same for OF. That way the simplefb platform device registration
code could also be dropped from the driver and users would just need
to enable CONFIG_SYSFB and CONFIG_SYSFB_SIMPLEFB to have the same.

I have a couple of boards with a bootloader that populates a
"simple-framebuffer" in the /chosen node so I could attempt to write
the patches. But probably won't happen until next week.

[0]: https://elixir.bootlin.com/linux/v5.16-rc3/source/drivers/firmware/sysfb_simplefb.c#L60

Best regards,
Javier
