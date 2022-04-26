Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655250F08B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiDZGDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbiDZGDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:03:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD461403F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:00:39 -0700 (PDT)
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhlbM-1oMhnx2qzA-00dpqY for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022
 08:00:37 +0200
Received: by mail-wm1-f54.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so189630wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:00:37 -0700 (PDT)
X-Gm-Message-State: AOAM5332PPBj6JFqHeTpTpw1AGbZ9BDpRHt9Zvo2CsOt/ukxypXO0+zI
        Xgs3UKa0jupYQFn8dX+foPCGfDYdEgr9KsM+DdY=
X-Google-Smtp-Source: ABdhPJy3c5lcSeSluq1OFXX5XYB6LISDtFDlKiWa0Rg3d6M03Gmt+hhEqCW75iUtmXQ0VFTk/w8CPqLe8gy80hIGYlQ=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr28016089wmc.94.1650952837280; Mon, 25
 Apr 2022 23:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220421192132.109954-1-nick.hawkins@hpe.com> <20220421192132.109954-5-nick.hawkins@hpe.com>
 <CAK8P3a0nQ1BrtfBJ7sUSaLkA=pbVwx83bEUpZczvLOSOHDR=dw@mail.gmail.com> <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
In-Reply-To: <CACRpkdbJ1N7VOgoBzGS+cOaErFcYiOVDeWRmhPyHA7=9W0CGhA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Apr 2022 08:00:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ie8kFYstCYr6FO6+yFw7VxyJjWYyy9b+rUHu_u0YXPg@mail.gmail.com>
Message-ID: <CAK8P3a2ie8kFYstCYr6FO6+yFw7VxyJjWYyy9b+rUHu_u0YXPg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] clocksource/drivers: Add HPE GXP timer
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:F+NFwuLXS6I9UmDvbjVRMD/vYazHkoSCiI07zytWSzv2FW5FnNs
 J5xWhK4YMKsukdmB90kv9kx7ua49jPlWwVYFgmiMctVWhuYGuMqxM9PV9nt1Zi0aEXvcxWh
 6ybDUNu2tkne+TT8sK4CTQFFUQmm1836hzv78LRzELDwGEcY6jnS+iUEkRfsWBKJfhW5C8X
 qxa8AUxgE1AsDc6rWxrMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6nR1b0EwYGw=:5cvFw57fTOrLA9Y6AofL7V
 A9Hlrhr78PkASx0E4550Ij0rv75xbDEckyrOvOpP3nLYHzj9LDm+u8451R57GiwcyxrxokjEX
 axVwEjKEdYGeH/JDm3EXT2dwZrfKHCrJ3gVgQsZPQOOEQEQ2FsfllH+keoIbzoX7afFeATfBd
 yBTHxQ3w70bkmDcVAGH3WlgFziNnGDxD0jsyl8w1nG1h6X6KsBZ1Cv9GstJXRb9KuwrRDx1DC
 +9eUmEP3SSoyLN9VUBcvFVlvSPPGmYg0gk3zk+v/bujlCYsG4/PBFCBtsXdPBNOJBTUREgsZ9
 IbYv25gim4n+UcR5op3l7Y2E0kqNsQuNk3yJI5HG7PUPM5el6SQyOD4y8GYVw/R9D1bixv3Eq
 jAKK7rfgmAOvr/Bgj7dFbi2xvoNYfETXcd2vVKil/1CMkegbq6oJYHJWFb3IZ8E6DUfx+GsLx
 0Hr3hn1be5wS3bLISCDoc9yWdrOj2O5yvKeULsQe5YZssuIYARSNmu34hwPoCbj2xEHjzbxU0
 2zSbZAPfPYcY4WkTKQKPUtuo3rnQUxjpRZJ+NE77XppqLg7ByCDRi/s2oq4d+tll7dniaK24n
 eLLDm9Crg5ZYemwpxRuWVuT2QwZGtgWZBAWO9iz5xPbS7BCN+2FmHEU2M1LZF+WAayJYwo5xF
 C1MQ7kNZzNw8xbsJ8mwUyQnbO3vVbX0c8hc0MkdS9Xo3SdY3CkApCP1RAWsDMCWq7tJk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:38 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Apr 22, 2022 at 3:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Apr 21, 2022 at 9:21 PM <nick.hawkins@hpe.com> wrote:
> >
> > > +
> > > +static struct platform_device gxp_watchdog_device = {
> > > +       .name = "gxp-wdt",
> > > +       .id = -1,
> > > +};
> > > +/*
> > > + * This probe gets called after the timer is already up and running. This will create
> > > + * the watchdog device as a child since the registers are shared.
> > > + */
> > > +
> > > +static int gxp_timer_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device *dev = &pdev->dev;
> > > +
> > > +       /* Pass the base address (counter) as platform data and nothing else */
> > > +       gxp_watchdog_device.dev.platform_data = local_gxp_timer->counter;
> > > +       gxp_watchdog_device.dev.parent = dev;
> > > +       return platform_device_register(&gxp_watchdog_device);
> > > +}
> >
> > I don't understand what this is about: the device should be created from
> > DT, not defined statically in the code. There are multiple ways of creating
> > a platform_device from a DT node, or you can allocate one here, but static
> > definitions are generally a mistake.
> >
> > I see that you copied this from the ixp4xx driver, so I think we should fix this
> > there as well.
>
> The ixp4xx driver looks like that because the register range used for
> the timer and the watchdog is combined, i.e. it is a single IP block:
>
>                 timer@c8005000 {
>                         compatible = "intel,ixp4xx-timer";
>                         reg = <0xc8005000 0x100>;
>                         interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> Device tree probing does not allow two devices to probe from the same
> DT node, so this was solved by letting the (less important) watchdog
> be spawn as a platform device from the timer.
>
> I don't know if double-probing for the same register range can be fixed,
> but I was assuming that the one-compatible-to-one-driver assumption
> was pretty hard-coded into the abstractions. Maybe it isn't?

Having a child device is fine, my objection was about the way
the device is created from a 'static platform_device ...' definition
rather than having the device structure allocated at probe time.

> Another way is of course to introduce an MFD. That becomes
> problematic in another way: MFD abstractions are supposed to
> be inbetween the resource and the devices it spawns, and with
> timers/clocksources this creates a horrible special-casing since the
> MFD bus (the parent may be providing e.g. an MMIO regmap)
> then need to be early-populated and searched by the timer core
> from TIMER_OF_DECLARE() early in boot.
>
> So this solution was the lesser evil that I could think about.

There are multiple ways of doing this that we already discussed
in the thread. The easiest is probably to have a child node without
custom registers in the DT and then use the DT helpers to
populate the linux devices with the correct data.

       Arnd
