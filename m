Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F654B3F66
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiBNCYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:24:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiBNCYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:24:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27150E13;
        Sun, 13 Feb 2022 18:24:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z19so27689312lfq.13;
        Sun, 13 Feb 2022 18:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfyV66Ru3m1gj4whgnxSGHYglltqayXR9QHml3YmGdw=;
        b=ltwRoL8c5wXPYmS1QALjteSv+eOgiTfeEP1xKaP2CwbQNNOzXlHZk110TKRfklZ6sF
         WIASZdf+AydQ/E4V+ZURsav3XVSa5TnNMKNQVbfsX835cfBu7ByTvdk5qVbKFbYKHPcV
         hi0HtBKMNXDZeiu1Ou7ZZU0dpBAZGnXnJW7XZD4qpbsAR9IINuak0yl3ezZ5qKEqqn/n
         HepehRmo/cRjuP7/q1es7tBwGVd1GpmIxuSJn7plQ7INQ5hhyYfpKa/pn2KtH5rV0r+y
         NBmglpD3On0s9+3Llmg1AnVuewKnW13O3Sar/BoqtrdH2AZvtIEvpR6+VSy0NKiw1pDQ
         H/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfyV66Ru3m1gj4whgnxSGHYglltqayXR9QHml3YmGdw=;
        b=irlVgPmsHGFf/79iXAFwnXKbteK+OKL3kQXXQTHlY/pE7EP3TQYSvWaGv7p9sNy4+T
         cizY+lbljwuahwwLobUPTMiOEAS5+S3CML5XdMb4iqPeR1wQAnBzWyQ3eEmqdmYWsy+G
         aye6JROHilsfqtNyVjG4+1u3hC3yVU7GTC81Y6C8hacC05QQIG5SQGOTykcl5HqgpwoU
         DACCOIcbVistA3vKmWY3Eo/UbmJ5hzKH5w8oh9sEKqBeLLYaliPP7IDzQpudutbVNTDV
         x0LLJaBzWfet9kFzcvT2Qi8XKZLVM5fTUcXL2UTBQh+r5Qx/PqDd25kfu79eTbgkqtwx
         uaeg==
X-Gm-Message-State: AOAM530DMnMM5CH+l2mNX5Rd1YielQyXQKCYwRtJwwi/6wXsIWCME7s1
        4pAJpDGzI/SV0VfGZ7exRH/z0jS+J8zAJt8HRpw=
X-Google-Smtp-Source: ABdhPJwRi4qGiq4WiMhzjCzAcLPkvE5huIF0K8zvl9LW7uWoucETVXrE69PiHdKDdQTNH6IOw4zn8c1JY0dhx1dOUJg=
X-Received: by 2002:a05:6512:2253:: with SMTP id i19mr4912334lfu.181.1644805444684;
 Sun, 13 Feb 2022 18:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20211212054706.80343-1-gnurou@gmail.com> <20211228220727.GA17003@duo.ucw.cz>
In-Reply-To: <20211228220727.GA17003@duo.ucw.cz>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 14 Feb 2022 11:23:53 +0900
Message-ID: <CAAVeFuJm1zO_Nfozj7uVXKVSNa2sduH5zvoFMP_ERnMLc1DzCw@mail.gmail.com>
Subject: Re: [PATCH v2] leds: add NCT6795D driver
To:     Pavel Machek <pavel@ucw.cz>, Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
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

Hi Pavel, (+Guenter for comments about NCT6775 as he maintains the hwmon driver)

On Wed, Dec 29, 2021 at 7:07 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Add support for the LED feature of the NCT6795D chip found on some
> > motherboards, notably MSI ones. The LEDs are typically used using a
> > RGB connector so this driver takes advantage of the multicolor
> > framework.
>
> Ok.
>
> > Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
> > ---
> > Changes since v1 [1]:
> > - Use the multicolor framework
> >
> > [1] https://lkml.org/lkml/2020/7/13/674 (sorry, took me some time to
> >     come back to this patch)
> >
> >  drivers/leds/Kconfig         |  10 +
> >  drivers/leds/Makefile        |   1 +
> >  drivers/leds/leds-nct6795d.c | 442 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 453 insertions(+)
> >  create mode 100644 drivers/leds/leds-nct6795d.c
> >
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index ed800f5da7d8..0db5986ca967 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -871,6 +871,16 @@ config LEDS_ACER_A500
> >         This option enables support for the Power Button LED of
> >         Acer Iconia Tab A500.
>
> Can we put it into drivers/leds/multi/? Lets group multicolor stuff there.

Sure. Should I create a sub-menu for multicolor leds in the Kconfig as well?

>
> > +config LEDS_NCT6795D
> > +     tristate "LED support for NCT6795D chipsets"
> > +     depends on LEDS_CLASS_MULTICOLOR
> > +     help
> > +       Enables support for the RGB LED feature of the NCT6795D chips found
> > +       on some MSI motherboards.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called leds-nct6795d.
>
> .ko?

The description of the other LED modules mention the module name
without the .ko suffix so I did the same for consistency, but let me
know if you prefer to have it anyway.

>
> > diff --git a/drivers/leds/leds-nct6795d.c b/drivers/leds/leds-nct6795d.c
> > new file mode 100644
> > index 000000000000..90d5d2a67cfa
> > --- /dev/null
> > +++ b/drivers/leds/leds-nct6795d.c
> > @@ -0,0 +1,442 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * NCT6795D/NCT6797D LED driver
> > + *
> > + * Copyright (c) 2021 Alexandre Courbot <gnurou@gmail.com>
> > + *
> > + * Driver to control the RGB interfaces found on some MSI motherboards.
> > + * This is for the most part a port of the MSI-RGB user-space program
> > + * by Simonas Kazlauskas (https://github.com/nagisa/msi-rgb.git) to the Linux
> > + * kernel LED interface.
> > + *
> > + * It is more limited than the original program due to limitations in the LED
> > + * interface. For now, only static colors are supported.
>
> Ok. We do have pattern trigger and hardware-accelerated blinking, if
> it helps. But that may be a lot of fun with multicolor.
>
> > +static inline int superio_enter(int ioreg)
> > +{
> > +     if (!request_muxed_region(ioreg, 2, "NCT6795D LED"))
> > +             return -EBUSY;
> > +
> > +     outb(0x87, ioreg);
> > +     outb(0x87, ioreg);
> > +
> > +     return 0;
> > +}
> > +
> > +static inline void superio_exit(int ioreg)
> > +{
> > +     outb(0xaa, ioreg);
> > +     outb(0x02, ioreg);
> > +     outb(0x02, ioreg + 1);
> > +     release_region(ioreg, 2);
> > +}
>
> Are these two too big for inline?

Removed the inline.

>
> > +static u8 init_vals[NUM_COLORS];
> > +module_param_named(r, init_vals[RED], byte, 0);
> > +MODULE_PARM_DESC(r, "Initial red intensity (default 0)");
> > +module_param_named(g, init_vals[GREEN], byte, 0);
> > +MODULE_PARM_DESC(g, "Initial green intensity (default 0)");
> > +module_param_named(b, init_vals[BLUE], byte, 0);
> > +MODULE_PARM_DESC(b, "Initial blue intensity (default 0)");
>
> Lets... not add parameters for this.

Removed this.

>
> > +/*
> > + * Return the detected chip or an error code. If no chip was detected, -ENXIO
> > + * is returned.
> > + */
> > +static enum nct679x_chip nct6795d_led_detect(u16 base_port)
> > +{
>
> "enum" return type is confusing here, as you also return errors.

Ack, converted this to a regular int.

>
> > +     val = superio_inb(led->base_port, 0x2c);
> > +     if ((val & 0x10) != 0x10)
> > +             superio_outb(led->base_port, 0x2c, val | 0x10);
> > +
> > +     superio_select(led->base_port, NCT6795D_RGB_BANK);
> > +
> > +     /* Check if RGB control enabled */
> > +     val = superio_inb(led->base_port, 0xe0);
> > +     if ((val & 0xe0) != 0xe0)
> > +             superio_outb(led->base_port, 0xe0, val | 0xe0);
>
> I'd simply do outbs unconditionally...

Indeed.

>
> > +/*
> > + * Commit all colors to the hardware.
> > + */
> > +static int nct6795d_led_commit(const struct nct6795d_led *led)
> > +{
> > +     const struct mc_subled *subled = led->subled;
> > +     int ret;
> > +
> > +     dev_dbg(led->dev, "setting values: R=%d G=%d B=%d\n",
> > +             subled[RED].brightness, subled[GREEN].brightness,
> > +             subled[BLUE].brightness);
> > +
> > +     ret = superio_enter(led->base_port);
> > +     if (ret)
> > +             return ret;
>
> Are you sure you want to do superio_enter() each time LED values are
> updated? That sounds... expensive, wrong. You have
> request_muxed_region() call in there.

This is just what other superio-based drivers do as the bus can be
shared between several drivers, each controlling a different function
(see for instance gpio-f7188x or the hwmon NCT6775 driver).
request_muxed_region() is used as a way to make sure they do not get
in the way of one another - they all acquire the region for a short
time and release it as soon as they are done. I agree it would be
better if we could arbitrate access in a more centralized way, but
that goes beyond the scope of this patch. There are mentions of moving
the superio functions to a separate file in the hwmon driver though,
so maybe this will happen at some point?

>
> > +static int __init nct6795d_led_init(void)
> > +{
> > +     static const u16 io_bases[] = { 0x4e, 0x2e };
> > +     struct resource io_res = {
> > +             .name = "io_base",
> > +             .flags = IORESOURCE_REG,
> > +     };
> > +     enum nct679x_chip detected_chip;
> > +     int ret;
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(io_bases); i++) {
> > +             detected_chip = nct6795d_led_detect(io_bases[i]);
> > +             if (detected_chip >= 0)
> > +                     break;
> > +     }
>
> Are you sure this won't cause problems somewhere? Could compatible
> mainboards be detected using DMI or something like that?

I looked at the output of dmidecode and could not find anything
relevant to help probing this unfortunately. Again other superio-based
drivers are doing the same thing for detecting the presence of the
chip.

>
>
> > +     if (i == ARRAY_SIZE(io_bases)) {
> > +             pr_err(KBUILD_MODNAME ": no supported chip detected\n");
> > +             return -ENXIO;
> > +     }
>
> I don't think ENXIO is normally used like this. -ENODEV? You have this
> elsewhere, too.

Switched these to -ENODEV.

>
> > +
> > +     pr_info(KBUILD_MODNAME ": found %s chip at address 0x%x\n",
> > +             chip_names[detected_chip], io_bases[i]);
> > +
> > +     ret = platform_driver_register(&nct6795d_led_driver);
> > +     if (ret)
> > +             return ret;
> > +
> > +     nct6795d_led_pdev =
> > +             platform_device_alloc(NCT6795D_DEVICE_NAME "_led", 0);
> > +     if (!nct6795d_led_pdev) {
> > +             ret = -ENOMEM;
> > +             goto error_pdev_alloc;
> > +     }
>
> Are you sure you are using platform devices in reasonable way? You
> probe, first, then register. That's highly unusual.

Agreed, but that's also what the hwmon and f7188 GPIO drivers do. The
more I repeat this, the more it sounds like we should wait until there
is a more centralized way to manage the superio bus before thinking
about merging this. :) Let's see what Guenter thinks.

Cheers,
Alex.
