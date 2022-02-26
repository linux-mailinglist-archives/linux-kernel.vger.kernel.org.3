Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03174C5866
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiBZV7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 16:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBZV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:59:37 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389DB1AE662
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:59:01 -0800 (PST)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mtxxk-1oDioB1fsS-00uHl7 for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022
 22:58:59 +0100
Received: by mail-wr1-f45.google.com with SMTP id r10so9678044wrp.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:58:59 -0800 (PST)
X-Gm-Message-State: AOAM533dBlaoj+r8rrdi1Hcjiq6HhCmLZHWLEK2xk/aJD6Cqo0odW6md
        0APdVTcbzJ9Q6FGrg5Jv00Df8t9neoeyyPuP5Wc=
X-Google-Smtp-Source: ABdhPJxIMRHcHYl03TUCv5wkOGw38ddPd33kAbcIXq38Ae6aP5aEwYf/SsOHWiu2pW/lReeQBoa2ITKHVcyza4FHIzI=
X-Received: by 2002:a5d:63c2:0:b0:1ef:840e:e139 with SMTP id
 c2-20020a5d63c2000000b001ef840ee139mr3249510wrw.192.1645912739041; Sat, 26
 Feb 2022 13:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20220226022053.958688-1-yusisamerican@gmail.com>
 <CAK8P3a3TWx71xT83003LSFsu1eF1p75hCxvpCB_FZf1SrNjQJw@mail.gmail.com> <CAJoG2+_qbu1Ca51exoq+0MSdcGda4y5YxM9vdseDqiH1n_i88A@mail.gmail.com>
In-Reply-To: <CAJoG2+_qbu1Ca51exoq+0MSdcGda4y5YxM9vdseDqiH1n_i88A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Feb 2022 22:58:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2cuanmR7oPefX-fZM2K1LioN40_c0SU-bdCAZQwcdyhQ@mail.gmail.com>
Message-ID: <CAK8P3a2cuanmR7oPefX-fZM2K1LioN40_c0SU-bdCAZQwcdyhQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: ddcci: upstream DDCCI driver
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>, javier@javigon.com,
        Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:iVSyEFetGP9yRAroK/KUA0rnWE58i9DJ3KKfN6T4NswGppwSc3K
 lzpXum49+bnrZmLb3eUfKR4+OcRn5iI23hFiJmme6MwEajcJGj6pNf0bX8Wy4ArErB88gjL
 yaW9MVZRl+1XTtG0Bez/5WDrRlwTZJYGIepbEKezHkYwbveCNApz3DRC1X65+uoEDSOILni
 i7UO4tx0NDocTaX9gzkWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2FnM3oqw6DA=:qCrVeAaKCggwSDa9ZL/coZ
 ecNiSrqvL0igoz/FgaXtPADRIrQtZCvnZ65eVygtSS8bAP9UXGegBF5JOBgXAU09tGPcYJFg4
 pvaTNkotCPP3hvhzpNSPH7Yt/hk8IY9ZQkd+9pps6kWvWFZEh9jJFZtd/mvLhZf7pYIUgWnSm
 5Wiup65MFJ4KsKzFvfZ1vgpV8xZ4abMmhOVLAk09GOh1DYhMSYxUnKBAyDJX/MTHPGYscWauT
 mVYFvcInpZ4guoZ21ovjeL2V0EpoquW6A4znlJ78Lh6fSTQeVdnju2RRHmk+HrBEZsLBV4QmF
 pvHQd83TdGWVJcQX5vge32k32gtWpHm+32SlFpzFPIWe1k0qLojTpAyObXfuh5prv13hWjX0r
 oh589fZlc5IOwKyVJOp2DiMbQWnwW3Io52EAH2PqMsLo1zLohzpOwxWFh4ZUgA7PL3/l+tjMh
 us7lH2dE75USxoU0plX19JQXH3rm0P6qECDuUhUTb052ADFDuIjd8WRIbUO25rekwr9cCiFZR
 +sP62MZCZxm+SbTTkxtv9pgoRrJHfyuXvD0wuMquHoyzURL6X1WeDSmogyEhjMpZdBiv1JjRo
 tPkXBYJNjdE9DUmtfcS4cvMdtH9W04h+rTDaroVGv6Sax5ZGCzCq0LMVh2LVUjrQZHjbAcck5
 fQ0NMCyKITvKFiWtA6vz9vIrYwse7vQwwCf+kinBS4hmOPIlS4XpelzNZUlV5zXme1tEF1zht
 WWQjMMVHbadmMgiKxzRkXm9XnWY0P0zU4ke3OWLeEr9H79uXQpcq2i4FfXkWx8xh5kAtWJMRy
 jAvPg/4Qa4hV5mLvi1JRZhjtQiJDvuYEP61HmUyFih/EtrPqyA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 11:48 AM Yusuf Khan <yusisamerican@gmail.com> wrote:
> On Sat, Feb 26, 2022 at 1:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > with the other ones.On Sat, Feb 26, 2022 at 3:20 AM Yusuf Khan
> > <yusisamerican@gmail.com> wrote:
> > >
> >
> > If this is a backlight driver, I think it should go into
> > drivers/video/backlight/,
> > no need for a top-level subsystem.
>
> Arnd, the driver includes a backlight driver, the main part of the
> driver(ddcci.c) is a monitor communication protocol. Should
> I leave the backlight driver(ddcci-backlight.c) in drivers/video/backlight?

It's more important to decide how the user space interface should be
handled, let's decide about that first.

> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +#include <asm-generic/fcntl.h>
> >
> > Including the asm-generic version causes the build failures. If you need
> > the contents, use <linux/fcntl.h>, otherwise leave it out.
> >
> > > +static dev_t ddcci_cdev_first;
> > > +static dev_t ddcci_cdev_next;
> > > +static dev_t ddcci_cdev_end;
> > > +static DEFINE_SEMAPHORE(core_lock);
> >
> > No new semaphores please, this should probably be a mutex.
> >
> >
> > > +struct bus_type ddcci_bus_type;
> > > +EXPORT_SYMBOL_GPL(ddcci_bus_type);
> > > +
> > > +/* Assert neccessary string array sizes  */
> > > +#ifndef sizeof_field
> > > +# define sizeof_field(t,m) FIELD_SIZEOF(t,m)
> > > +#endif
> > > +static_assert(sizeof_field(struct ddcci_device, prot) > 8);
> > > +static_assert(sizeof_field(struct ddcci_device, type) > 8);
> > > +static_assert(sizeof_field(struct ddcci_device, model) > 8);
> > > +static_assert(sizeof_field(struct ddcci_device, vendor) > 8);
> > > +static_assert(sizeof_field(struct ddcci_device, module) > 8);
> > > +
> > > +/* Internal per-i2c-client driver data */
> > > +struct ddcci_bus_drv_data {
> > > +       unsigned long quirks;
> > > +       struct i2c_client *i2c_dev;
> > > +       struct semaphore sem;
> > > +       unsigned char recv_buffer[DDCCI_RECV_BUFFER_SIZE];
> > > +};
> >
> > Same here.
> >
> > > +static const struct file_operations ddcci_fops = {
> > > +       .owner = THIS_MODULE,
> > > +       .read = ddcci_cdev_read,
> > > +       .write = ddcci_cdev_write,
> > > +       .open = ddcci_cdev_open,
> > > +       .release = ddcci_cdev_close,
> > > +       .llseek = ddcci_cdev_seek
> > > +};
> >
> > It looks like this adds low-level access to a bus that is already managed by
> > the drm (or older framebuffer) drivers. How do you prevent these two
> > from stepping on each other's toes?
