Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED547F75B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 15:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhLZOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 09:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhLZOuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:50:55 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC5FC06173E;
        Sun, 26 Dec 2021 06:50:54 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id y70so16365939iof.2;
        Sun, 26 Dec 2021 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBKfb8uWWCXg0RyG0RR8HgZVF58Z/QKEmyuw3hN2Mms=;
        b=Yd4ZdyK+lgqlFLENR4r2XVKi/Mr3WlV372s6r3q7VJAOMkUuL++v9LuJweW7//LOjF
         cGwPD9GPp69bSSq3kR4k0yBELRbfR0HsXNv/FXamnWzK7P0lTaUrcb4o7BowBYhqU/3l
         h+R7bPjWWZzLQZzXwgYuBN/Gi5CMasme5Ps3RlpFGe/aqRbJj6cs9Y0odFDqSbF8VE9J
         GhE7RSZYUlXBsvVqBVL+YMDrLKGd8zqIegQ6bhqw7/7yKNcLI81GuF2sUG+MLJiFu4ko
         uM6pLCLnSdvA/0Atoklu6AjtaWquWeRbcbBLNkZe52RrkpbLSfIRYWZjCC1B5b3CLu4E
         i/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBKfb8uWWCXg0RyG0RR8HgZVF58Z/QKEmyuw3hN2Mms=;
        b=a1eZTF9iot9UDhEnUIpbF/DAUjGKt8o4J37TMQq9eXwU294WQc/Hv/5gcppYJhNBcv
         lNpbCuJOedkHpY+nxMP2uiKVMZT4YFxNVTt1bvA0XjXSv5elM8HmT2pC2mhaW/5Um1WE
         3JTa8KCnR/A/Nk/Nw/ejlAYR4EK/xzLRZN7oSHXRPBIhfHAct3fhwPPga2A7/JDOBVl0
         7Kvme54rpTOpG58+ENr5VIbrZWclxvWVHCH7u3seCA+DHmBdlsfIztNGNicp+G6oy3Sn
         Zb24YY1up7UtLHPpMkieTRDwaKxrcmdJPwA74Gtwh+FZu7SW6xf3pzrXwny2c1ZlldHU
         +oUQ==
X-Gm-Message-State: AOAM531ompmWkFtjf8a1xO95R6+RNdjUvtmHtCDKvVkW6HtOmUGSdUOa
        ycTrVeBeJamLnvLoRyBaL8K9izs+03t1ra8DovWBE+Ea
X-Google-Smtp-Source: ABdhPJxzXk6v9topiQUsYp/GRDF4xtMy+Glo9b8RGHsw0O6Q62tBXvZPIkaXwxNTc/XIpbJKBwK9TJAnnTwCg9hQWSI=
X-Received: by 2002:a05:6638:3449:: with SMTP id q9mr5849777jav.218.1640530254086;
 Sun, 26 Dec 2021 06:50:54 -0800 (PST)
MIME-Version: 1.0
References: <f55721ade28b2715eaf54b28a1bbfaad7b5adc0d.1640471342.git.andreyknvl@gmail.com>
 <Ycgi7GiU2udbjF2f@kroah.com> <CA+fCnZeC8PbDg_E3WWtqGBAwUs65Y7=b5DG=whN-CaOEs5uS7g@mail.gmail.com>
 <796577bb0052f4f08f58882dfc86734d72f2aa29.camel@perches.com>
In-Reply-To: <796577bb0052f4f08f58882dfc86734d72f2aa29.camel@perches.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 26 Dec 2021 15:50:43 +0100
Message-ID: <CA+fCnZcwkmw-phG2nHW=4-dxwxUy3AGFsppk==x96uwJRSEG2Q@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: upgrade license identifier
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        andrey.konovalov@linux.dev, Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 3:02 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2021-12-26 at 14:19 +0100, Andrey Konovalov wrote:
> > I wonder if checkpatch could alert about considering GPL-2.0+ when
> > adding new files.
>
> No. Licensing is up to the author/submitter.

You're right. However, knowingly choosing a license requires that the
author doesn't forget to look into the difference and understand it.

When I contributed this code, I didn't realize that GPL-2.0 and
GPL-2.0+ are different things. I was focused on the excitement of
contributing a new USB gadget driver.

What would have allowed my to not overlook this, is that if throughout
the _process_ of contributing a new module, something would _ask_ me:
"Is this really the license you want to use?".

Within my process of submitting kernel patches, that could have been
either checkpatch or an email bot.

I don't insist that this must be done by checkpatch; this could be
done by another entity. However, it would be nice to see this as an
explicit step of a standardized contribution process.

Thanks!
