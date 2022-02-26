Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904E04C54ED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiBZJjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 04:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBZJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 04:39:42 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9B3AA2FB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 01:39:06 -0800 (PST)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McY0L-1nvaGS1Fcb-00cucF for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022
 10:39:05 +0100
Received: by mail-wr1-f50.google.com with SMTP id s13so7869568wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 01:39:05 -0800 (PST)
X-Gm-Message-State: AOAM531bEnJk47UjADTPWPGw0jnCJwT3fZ+xqRC2bw+P/Us6In4wZIQP
        AoAN41GAFjX9egZ+i6sEdCMKKx8Z4cynDtGaaO0=
X-Google-Smtp-Source: ABdhPJz5BYSSQUITstBOGh3oQUl0MT9nxRdFpSTkQkaM/Mp2O6n4D5+VZUw9uqGXLyEWFliZMNZp0PqkbSgCjnh2pOI=
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id
 v3-20020adfedc3000000b001ec5f115415mr7159000wro.317.1645868344946; Sat, 26
 Feb 2022 01:39:04 -0800 (PST)
MIME-Version: 1.0
References: <20220226022053.958688-1-yusisamerican@gmail.com>
In-Reply-To: <20220226022053.958688-1-yusisamerican@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Feb 2022 10:38:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3TWx71xT83003LSFsu1eF1p75hCxvpCB_FZf1SrNjQJw@mail.gmail.com>
Message-ID: <CAK8P3a3TWx71xT83003LSFsu1eF1p75hCxvpCB_FZf1SrNjQJw@mail.gmail.com>
Subject: Re: [PATCH] drivers: ddcci: upstream DDCCI driver
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B2DstmSc9M3m0E9elewUttugDookDbMvQA63i0T014IA1fVd9LF
 TRZEhGMQLL8/lINsjOQRsv4TphtN+WRMDC8YWm4djgtsOz/u6zxmikIdONsQA2dI7rVmgQS
 1uaG7+uHHGUwF6rI+ua3M8HMftim0JIicmjDdG/aeSOhXs6tlBpnBjToYCPQHlWtGdpcauf
 BPEmRigA9zbtJRrW2GO7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8I52WhC/3No=:8mKCrXoAa9h3mt/XaPdAU1
 51i/CIFZEXJFx2L+K1V/re+fiBBC4HjmA+Scj8eM7aUC6S7gCqI63zJxoMPM2B3u8MCtM17TS
 xBcAbbt1rAsD771IbhhrtLLC+pE5Kf+8dSj5E449gJQ+kDVPIo9ohgdkOwgSs51GxImVem5mu
 idFFgM/4fOfom05BdTbYBx7+6n8c1jmuQVzyg2oaLyChqZnxVtnMXlCH1uHaK0nhapeGahs4j
 f+FnhxdImhpUx73BwJ8HssmycgOPYIQh1hqbIDF2tk8bkk4tTjp0zHgTpCuKa/jCQKnHNGKxE
 UJIXSTH5qxxGyWyRBHDZwaRIG090JEQ4azklPVm1ZvH8EXrZmquLJVH+PJayUyY63WO2x9KL8
 SFah3ElhyZPLjzELu1LMeZ7tFWjTWwQHqIPnmaWIYSYfoiS7hEF5lbMX+Ywe2JtHOqG/icHzd
 D1tcHgfQepeRHCWnNzCSVvA9VXy/uqimUbLOBU3S6Y/F9lYViZNKP4c0ZnZCGXP34QmbaLfzm
 WpM0eJYrHhZW/amZDMJWQVEFZcFzIGKB1zAXg1iwMoPpyVwzqGNM2n2ugqEkyPBCwBA4RwNKA
 M4JyrpJy3zj7uKoI0SZc2pgj5zKO9b3YJmzmNIZIsLG+uX4F3UZiSEp6WBOyGuL3TwHq3RTIw
 6R5nWDuqRrfxxZauQhjVuEk0tByYQlIrk709AOobaiRDBC/eIjWWbjjiPVncTfkhywSv2O8/X
 s5G6K1QAnFDcWiQq/EgMdvKTutIvqyfQtg/kePWxGmionUDzy83cdtSWvH3+FxXtvZ5Cn8IYO
 BH5FPYI75eId0cu6r2W21hqunHmhgfHDDSlrcfBOOVVAgMFLDs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

with the other ones.On Sat, Feb 26, 2022 at 3:20 AM Yusuf Khan
<yusisamerican@gmail.com> wrote:
>
> This patch upstreams the DDCCI driver by Christoph Grenz into
> the kernel. The original gitlab page is loacted at https://gitlab
> .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
>
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
>  drivers/Kconfig                 |    2 +
>  drivers/Makefile                |    1 +
>  drivers/ddcci/Kconfig           |    3 +
>  drivers/ddcci/Makefile          |    3 +
>  drivers/ddcci/ddcci-backlight.c |  413 +++++++
>  drivers/ddcci/ddcci.c           | 1895 +++++++++++++++++++++++++++++++
>  include/linux/ddcci.h           |  164 +++

If this is a backlight driver, I think it should go into
drivers/video/backlight/,
no need for a top-level subsystem.

> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <asm-generic/fcntl.h>

Including the asm-generic version causes the build failures. If you need
the contents, use <linux/fcntl.h>, otherwise leave it out.

> +static dev_t ddcci_cdev_first;
> +static dev_t ddcci_cdev_next;
> +static dev_t ddcci_cdev_end;
> +static DEFINE_SEMAPHORE(core_lock);

No new semaphores please, this should probably be a mutex.


> +struct bus_type ddcci_bus_type;
> +EXPORT_SYMBOL_GPL(ddcci_bus_type);
> +
> +/* Assert neccessary string array sizes  */
> +#ifndef sizeof_field
> +# define sizeof_field(t,m) FIELD_SIZEOF(t,m)
> +#endif
> +static_assert(sizeof_field(struct ddcci_device, prot) > 8);
> +static_assert(sizeof_field(struct ddcci_device, type) > 8);
> +static_assert(sizeof_field(struct ddcci_device, model) > 8);
> +static_assert(sizeof_field(struct ddcci_device, vendor) > 8);
> +static_assert(sizeof_field(struct ddcci_device, module) > 8);
> +
> +/* Internal per-i2c-client driver data */
> +struct ddcci_bus_drv_data {
> +       unsigned long quirks;
> +       struct i2c_client *i2c_dev;
> +       struct semaphore sem;
> +       unsigned char recv_buffer[DDCCI_RECV_BUFFER_SIZE];
> +};

Same here.

> +static const struct file_operations ddcci_fops = {
> +       .owner = THIS_MODULE,
> +       .read = ddcci_cdev_read,
> +       .write = ddcci_cdev_write,
> +       .open = ddcci_cdev_open,
> +       .release = ddcci_cdev_close,
> +       .llseek = ddcci_cdev_seek
> +};

It looks like this adds low-level access to a bus that is already managed by
the drm (or older framebuffer) drivers. How do you prevent these two
from stepping on each other's toes?

        Arnd
