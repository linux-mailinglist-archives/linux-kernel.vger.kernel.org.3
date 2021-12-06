Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E05469427
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239746AbhLFKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbhLFKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:50:46 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D6C061746;
        Mon,  6 Dec 2021 02:47:17 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id a11so9721810ilj.6;
        Mon, 06 Dec 2021 02:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Um61Hr3jidIBFZSxFnTK93vDCH499LbCZV9DwbMfXng=;
        b=WLJgtSv+9cZ4KsNSDg/qz7ADMMWthNnKPcJTlClkuzTW8W51Z00OEGzB/VTimXR8Wn
         aFXa045HUfYtWdeJ9JHw2mMKbEXWKe+O8jszXQ4cEu9tssgOeR3SwrWVLmtrhdUDIYnS
         Z9DIbsGqAn2SZbvkgXgps20UDdMkzR0H7GQjAFfgJIEs7kYNEvBCVmyB7l6TA43VUU8p
         lkjKw2jRg9P1IPBQeGY4USGVg4cTCTW0GDoQ4t/WBIlj2KvRrGV384/ZlT6j6x+0n67D
         oam5ncSKZJxc7L3Se+tIu/YnwhGh1tAsE7pAvHqz5vXqHwrztaApWD4Il51+Wh/qaApb
         rluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Um61Hr3jidIBFZSxFnTK93vDCH499LbCZV9DwbMfXng=;
        b=JaPj+bsFMpT6qSsrrslscx9PqTB+ROISXyb19bmXpIPvnb5UNkivWgOPQWrHO1b8wi
         JcqKyqaGRL7wbHLtPOie/AidnVSB+IC0vUv11HXRnJv+BjR1Bw6tLCb3l284+pM3Tlos
         F79U3qtAsng3fYgZHbf+63aVhzh395cUaQhdGSzFb2bJmnGN3xnD+evf21cZCQRQQ5jO
         Iw12zrcit+xpjbowOapImQA3SdnofSWbc14md/c5yVYCShWrBjsdgF0jW/8eIBQYMYFJ
         koyhqOKXP3sQrrgBn0WF7yDlMYF+XnDyQvUbS5WPE/jW06+FzvjSb8bedNDIbKF9BLz/
         TPWQ==
X-Gm-Message-State: AOAM5339d5sYm1EZpLpWYWILIdaZjGXicQZREIK9RNQJU2jQ6dZk4jlZ
        xySf2Zgq1YWncqSG//ucO8qcRx6+VQs/xy2NJB8=
X-Google-Smtp-Source: ABdhPJzS8MaGOfxEKT8Wz+Oz+dyTmUiCjIopWOmUAkZATpwgn3INJ5OZmxv0t1dTyYDZUh0IeE2t6BgKq8PHHIao9c4=
X-Received: by 2002:a05:6e02:1b08:: with SMTP id i8mr26502232ilv.74.1638787637173;
 Mon, 06 Dec 2021 02:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20211202122021.43124-1-alistair@alistair23.me>
 <20211202122021.43124-2-alistair@alistair23.me> <20211204233233.6c55875c@aktux>
In-Reply-To: <20211204233233.6c55875c@aktux>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 6 Dec 2021 20:46:50 +1000
Message-ID: <CAKmqyKPDROFkAFgSjSDeTfhtZsArn4BbON9tyb1qTb_QcV5=xg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Input: Add driver for Cypress Generation 5 touchscreen
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 8:32 AM Andreas Kemnade <andreas@kemnade.info> wrote=
:
>
> Hi,
>
>
> On Thu,  2 Dec 2021 22:20:18 +1000
> Alistair Francis <alistair@alistair23.me> wrote:
>
> > From: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
> >
> > This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> > controllers. This driver supports only the I2C bus but it uses regmap
> > so SPI support could be added later.
> > The touchscreen can retrieve some defined zone that are handled as
> > buttons (according to the hardware). That is why it handles
> > button and multitouch events.
> >
> > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
> > Message-Id: <20180703094309.18514-2-mylene.josserand@bootlin.com>
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> I finally got it working. The order of initialisation is important.
> Params are copied on input_mt_init_slots() from ABS_MT* to ABS_*, so you
> have to set params first.
>
> Here is the patch i need on top of this one to make it actually work
> with X (evdev and libinput is tested):
>
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscr=
een/cyttsp5.c
> index b5d96eb71e46..3894ec85a732 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -415,19 +415,12 @@ static int cyttsp5_setup_input_device(struct device=
 *dev)
>         int max_x_tmp, max_y_tmp;
>         int error;
>
> -       __set_bit(EV_REL, ts->input->evbit);

Does it work with this still included? I need this for my userspace program=
.

Alistair

> -
>         max_x_tmp =3D si->sensing_conf_data.res_x;
>         max_y_tmp =3D si->sensing_conf_data.res_y;
>         max_x =3D max_x_tmp - 1;
>         max_y =3D max_y_tmp - 1;
>         max_p =3D si->sensing_conf_data.max_z;
>
> -       error =3D input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].ma=
x,
> -               INPUT_MT_DROP_UNUSED | INPUT_MT_POINTER);
> -       if (error < 0)
> -               return error;
> -
>         input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, max_x, 0, 0=
);
>         input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, max_y, 0, 0=
);
>         input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, max_p, 0, 0);
> @@ -435,6 +428,11 @@ static int cyttsp5_setup_input_device(struct device =
*dev)
>         input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, =
0, 0);
>         input_set_abs_params(ts->input, ABS_MT_TOUCH_MINOR, 0, MAX_AREA, =
0, 0);
>
> +       error =3D input_mt_init_slots(ts->input, si->tch_abs[CY_TCH_T].ma=
x,
> +               INPUT_MT_DROP_UNUSED | INPUT_MT_DIRECT);
> +       if (error < 0)
> +               return error;
> +
>         error =3D input_register_device(ts->input);
>         if (error < 0)
>                 dev_err(dev, "Error, failed register input device r=3D%d\=
n", error);
>
