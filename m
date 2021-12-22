Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD83447CE95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbhLVJBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243554AbhLVJBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:01:30 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FE6C06173F;
        Wed, 22 Dec 2021 01:01:30 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id e136so4661694ybc.4;
        Wed, 22 Dec 2021 01:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysosXtFfyBojHJLz2B9nDDvXFhZv0++ox9CFVTznA+c=;
        b=JsUN+RmQivZezcs9oQRRqoXfB599vatZ0Ep+6oVEJ0sx8pgAdz6tqV22dkNqhKeYXJ
         zTWTgE4Hw53v60oDlu3eK9AGY4MLc8mAKO9uWy6Jn4mYYgm1/4ypeQQOJg5DjOB8zp+l
         bLAxqDbG4newwic8yL6vKmit9GrPpFA9dET/6J2COBSJCAQYfBXvgge5/u1+YED9TZi5
         lotcsIMqCDI37QJzDUsUaJESuuHRvp9mYOc/iTVXPgoOD/zlgH8qMoWnkxXK+YXc/9q5
         p9kzPDt2zzE4gRFeSRYD8p+1eFpTgLddYeeAyWJqLxgcg9Heza2geY+cJy4iHu1AHM6w
         JINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysosXtFfyBojHJLz2B9nDDvXFhZv0++ox9CFVTznA+c=;
        b=C18/EJHWD4PA4TYJxyVeOkknX4ePBpQYvRggztVlKGKxU0Ts9IysdQh0suTVhZH2HA
         Ys9aYppTwSLNsPV3WA+plnlHGGkzAaMfGHc1vqAi/IZbxhnh4GVRYhYNfOkV+RQfj55D
         QuwZZVS7pgRlNQTRQ7VJ+kf7eul7sVDLVih9gjY8jvmOPMlV3LfXUIndJr8vKAMA5y/1
         jdy3gwCCy1Kh9/s7JJMv8QlJr1Ha5o9vrRN8cVT6/fRNrRVAWyoNMknheTWnMGdw20FA
         PqgiNU+2ZIhxOytBOmLR8bNDZvrosCBgqfI3Gq2COU2niV9AF9TO+bcWWGJNO32t/dz+
         r3DA==
X-Gm-Message-State: AOAM531i7PsoWFP3YaqT6/XoWJ7xTOYgQW10ZWEJ13Vhbvs7O3dJfdlU
        E5pOV8MYr+pHNKv+5lUuIFKx44qSlAP3RUMxEww=
X-Google-Smtp-Source: ABdhPJy8SPaXPB+PlYBKclA6Nzp2t6vAeKGWi+UVGwSmqff9B9lRwibzONxW/zvOUq1rv58c9AT9u5fHqQgMa/RYpKc=
X-Received: by 2002:a25:84c1:: with SMTP id x1mr3018951ybm.690.1640163689302;
 Wed, 22 Dec 2021 01:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20211221171532.29881-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YcLBZBwIZkhhKxGD@kroah.com>
In-Reply-To: <YcLBZBwIZkhhKxGD@kroah.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 22 Dec 2021 09:01:03 +0000
Message-ID: <CA+V-a8s1RzonxKf2PbitTmb88WKKW9eSiZPsdHO6=-vxww7LFQ@mail.gmail.com>
Subject: Re: [PATCH] usb: renesas_usbhs: Fix unused variable warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thank you for the review.

On Wed, Dec 22, 2021 at 6:10 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 21, 2021 at 05:15:32PM +0000, Lad Prabhakar wrote:
> > This patch fixes the below warning:
> >
> > drivers/usb/renesas_usbhs/mod.c: In function 'usbhs_status_get_each_irq':
> > drivers/usb/renesas_usbhs/mod.c:195:13: warning: variable 'intenb0'
> > set but not used [-Wunused-but-set-variable]
> >   195 |         u16 intenb0, intenb1;
> >       |
> >
> > Fixes: 33e4245ee919 ("usb: renesas_usbhs: Use platform_get_irq() to get the interrupt")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/usb/renesas_usbhs/mod.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
> > index f2ea3e1412d2..3919e350b487 100644
> > --- a/drivers/usb/renesas_usbhs/mod.c
> > +++ b/drivers/usb/renesas_usbhs/mod.c
> > @@ -192,13 +192,12 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
> >                                    struct usbhs_irq_state *state)
> >  {
> >       struct usbhs_mod *mod = usbhs_mod_get_current(priv);
> > -     u16 intenb0, intenb1;
> >       unsigned long flags;
> > +     u16 intenb1;
> >
> >       /********************  spin lock ********************/
> >       usbhs_lock(priv, flags);
> >       state->intsts0 = usbhs_read(priv, INTSTS0);
> > -     intenb0 = usbhs_read(priv, INTENB0);
>
> Did you just break the hardware?  Reading is often times needed and
> clang has no idea about hardware issues.  We need proof in the changlog
> that this really is safe to do.
>
I introduced this warning in commit 33e4245ee919 ("usb: renesas_usbhs:
Use platform_get_irq() to get the interrupt'') where
IORESOURCE_IRQ_SHAREABLE flag handling was dropped and I missed to
remove this change. As a result I included a fixes tag for this
commit. Let me know if you want me to update the changelog.

> How did you test your change?
>
I haven't but can test it.

Cheers,
Prabhakar
