Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D34C5540
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiBZKtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiBZKtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:49:12 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244336EB19
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:48:37 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id g20so8081177vsb.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I27KF98I0JlvERzhmnPqQRZW8dN4hXcZo1yC0uVJNCU=;
        b=gAWvdMWzCQAuNFzuGaEBnVvHp7O5niBRhTGL7mZKkD8LYxmGoyJdczGYr0orZ3mG7p
         xKt6Z7IaNUaSDyOje94svuqvCaAN+nyXq4sEeICnz/jSs3YosCPugjBqGm5a3JuI2dcF
         QsVLMS2SIyqhSTcxHKmxBF3HKbB4N1HDel0Shji/fsSCAPl2ooWPZ1qfIQly53G2qYrT
         mlQstYftm9KXVNGazaZSmPLDvtRPOnWDhQrsWF0mEDrxeMfynhFIO+7JiehnCTEOffbG
         LYmqbvbU9PIcKmMv2N9duod7e8PQ414eggZBtffeqgAbjk+T56sAZJbpIxUI3YtIqrce
         7qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I27KF98I0JlvERzhmnPqQRZW8dN4hXcZo1yC0uVJNCU=;
        b=0kXSrzqi731HPmC9Of85OUtA7Su8G5AT/wDuVENMVu8WKbRIKu8Fv94GCd8T87JIbH
         e6HI4/bx/uv73p/gNiLkCIotBv7E59E7vBUMbfJXroTpgljVvdN7W2t1PzApQ24hyGGg
         Znw4k04ouwMaiWyMfza8yIoKsvaSK79Wl5aSA9QsRy+Q1sh7Mf5aGjNna667vDvTYEzI
         OPHTiNgC5N9SmUzIn3Q6IVaNrx2vFvJtA1NmCErfMHYoMuEAvqK/K/BorBOtKmms8jTI
         6vbPG17vmMSy699L52eiPs0Ts+XIldVUYZ4mRNmtLpG9k1U2F/Ee9mkwfGnJjoM9Z+l3
         3E+Q==
X-Gm-Message-State: AOAM531HC7JBSgfqXERsBJElUVbv3e5oJ6gWqgC/Iz0qvuObKwoK6AGK
        +lgbA1K19xv0f+HdyYV5BSBuAN2hMijWhFxLMe8=
X-Google-Smtp-Source: ABdhPJwJZdXHvxr1FV8CIRfqEAKpLcXu3Zpiaf6Lr2QbPlzjYHguxIDo7fEgfEVg/HZYpythMmcVW3S14OTexamm2nI=
X-Received: by 2002:a67:d886:0:b0:31c:44f6:a968 with SMTP id
 f6-20020a67d886000000b0031c44f6a968mr5160687vsj.60.1645872515947; Sat, 26 Feb
 2022 02:48:35 -0800 (PST)
MIME-Version: 1.0
References: <20220226022053.958688-1-yusisamerican@gmail.com> <CAK8P3a3TWx71xT83003LSFsu1eF1p75hCxvpCB_FZf1SrNjQJw@mail.gmail.com>
In-Reply-To: <CAK8P3a3TWx71xT83003LSFsu1eF1p75hCxvpCB_FZf1SrNjQJw@mail.gmail.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Sat, 26 Feb 2022 02:48:25 -0800
Message-ID: <CAJoG2+_qbu1Ca51exoq+0MSdcGda4y5YxM9vdseDqiH1n_i88A@mail.gmail.com>
Subject: Re: [PATCH] drivers: ddcci: upstream DDCCI driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>, javier@javigon.com,
        Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, the driver includes a backlight driver, the main part of the
driver(ddcci.c) is a monitor communication protocol. Should
I leave the backlight driver(ddcci-backlight.c) in drivers/video/backlight?

On Sat, Feb 26, 2022 at 1:39 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> with the other ones.On Sat, Feb 26, 2022 at 3:20 AM Yusuf Khan
> <yusisamerican@gmail.com> wrote:
> >
> > This patch upstreams the DDCCI driver by Christoph Grenz into
> > the kernel. The original gitlab page is loacted at https://gitlab
> > .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> >
> > Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> > ---
> >  drivers/Kconfig                 |    2 +
> >  drivers/Makefile                |    1 +
> >  drivers/ddcci/Kconfig           |    3 +
> >  drivers/ddcci/Makefile          |    3 +
> >  drivers/ddcci/ddcci-backlight.c |  413 +++++++
> >  drivers/ddcci/ddcci.c           | 1895 +++++++++++++++++++++++++++++++
> >  include/linux/ddcci.h           |  164 +++
>
> If this is a backlight driver, I think it should go into
> drivers/video/backlight/,
> no need for a top-level subsystem.
>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +#include <asm-generic/fcntl.h>
>
> Including the asm-generic version causes the build failures. If you need
> the contents, use <linux/fcntl.h>, otherwise leave it out.
>
> > +static dev_t ddcci_cdev_first;
> > +static dev_t ddcci_cdev_next;
> > +static dev_t ddcci_cdev_end;
> > +static DEFINE_SEMAPHORE(core_lock);
>
> No new semaphores please, this should probably be a mutex.
>
>
> > +struct bus_type ddcci_bus_type;
> > +EXPORT_SYMBOL_GPL(ddcci_bus_type);
> > +
> > +/* Assert neccessary string array sizes  */
> > +#ifndef sizeof_field
> > +# define sizeof_field(t,m) FIELD_SIZEOF(t,m)
> > +#endif
> > +static_assert(sizeof_field(struct ddcci_device, prot) > 8);
> > +static_assert(sizeof_field(struct ddcci_device, type) > 8);
> > +static_assert(sizeof_field(struct ddcci_device, model) > 8);
> > +static_assert(sizeof_field(struct ddcci_device, vendor) > 8);
> > +static_assert(sizeof_field(struct ddcci_device, module) > 8);
> > +
> > +/* Internal per-i2c-client driver data */
> > +struct ddcci_bus_drv_data {
> > +       unsigned long quirks;
> > +       struct i2c_client *i2c_dev;
> > +       struct semaphore sem;
> > +       unsigned char recv_buffer[DDCCI_RECV_BUFFER_SIZE];
> > +};
>
> Same here.
>
> > +static const struct file_operations ddcci_fops = {
> > +       .owner = THIS_MODULE,
> > +       .read = ddcci_cdev_read,
> > +       .write = ddcci_cdev_write,
> > +       .open = ddcci_cdev_open,
> > +       .release = ddcci_cdev_close,
> > +       .llseek = ddcci_cdev_seek
> > +};
>
> It looks like this adds low-level access to a bus that is already managed by
> the drm (or older framebuffer) drivers. How do you prevent these two
> from stepping on each other's toes?
>
>         Arnd
