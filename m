Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A25962BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiHPSwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiHPSwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:52:38 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CB785FE6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:52:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-334dc616f86so1665207b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OqCx5/xCl6tw3i280dCLBLdpEzPrO+4Ppd9zzQXnvR4=;
        b=EAtl/HpJc7VUakyS2l7F7l5WxouXonrEy4tRWTKdcqphZcO/6j0KYh4oMPHn4LDqx3
         Nvfd9NHuPBg0Mrgp8z4wPpczL+amquWmEHQO1Vn///bnqnOcob55OGlvHsE7mJx5lzEq
         Nk07nvDuJvdoYUla/x+tPkAc3zvO6LFrE1NsLL1F8E9Mf0Be6iaPkyn6pwan4Zayp/Cm
         LTHo7T+52U8qLtITmXWY8f48Scl0Zf9WBzdQSPlH3z8UfmHxfnEW3L76YMWBBTq0k/vS
         yP2B2ZZckNH0p9MMZ0FIio/iwUTNTlhAGtkm5nERfTvotBYkCYweTDI43lqD4US+zhjQ
         0Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OqCx5/xCl6tw3i280dCLBLdpEzPrO+4Ppd9zzQXnvR4=;
        b=O+zkBv/sv3+kJXBL6gsMX3PPNadmXPBhwjHjHmPrjo7zkGv71weHNAHeyyDLmLTcLn
         cnncu7DA5w0P2qAO0V9yiTzLUduaPmZNwK9FEZFCehsmOzWzTOk932e9RlHXtz0IRJg6
         ixrHjRiasyCQpJ5Dv9IUNxSykJu+W2NR3QZOCa20mcra2QfPTTEocdJdbgDyeuaKWcU8
         RHqhwlwKlDd4coYbAXTINutDbRbqS/cHhVHauIMHDgHVAbXvhwy0QWg8pH6L/H+LwhEp
         hUBuZI6qYCyh83iggoBtRcfAMEdrPVn03WdxH0BQQtQe3CvUlBgOsjeyKHTulN4sf9f0
         Hbzg==
X-Gm-Message-State: ACgBeo3/6/LLATzr+ILBb6H2RTwm+XQNoPUbOY4mFms4znJK3lovEhQx
        /gHncWnrj51c/0JvJNYXb3Q86CHMnZ2vkXoLThBpNA==
X-Google-Smtp-Source: AA6agR6J9TNMQ9jspfYwg5KJAH6/4SjoX34GYoyO2fv483iqNZrR2zcvNvroKG2SEh9Xzh/thAi1bP5yxRi8XjdbSUQ=
X-Received: by 2002:a81:50d4:0:b0:31f:5f85:566a with SMTP id
 e203-20020a8150d4000000b0031f5f85566amr18183057ywb.218.1660675955611; Tue, 16
 Aug 2022 11:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com> <CAGETcx_tSndU0xerz=DF9JQxYFRC2aaxyOE-bR2JpM0L0ht=sw@mail.gmail.com>
 <CAGETcx-JUV1nj8wBJrTPfyvM7=Mre5j_vkVmZojeiumUGG6QZQ@mail.gmail.com> <8296964.NyiUUSuA9g@steina-w>
In-Reply-To: <8296964.NyiUUSuA9g@steina-w>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Aug 2022 11:51:59 -0700
Message-ID: <CAGETcx882GejPk4cPhSRzruUYvPZLHDyORWz2i7xP9uw6eAmzg@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:17 AM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hello Saravana,
>
> Am Montag, 15. August 2022, 22:56:07 CEST schrieb Saravana Kannan:
> > On Mon, Aug 15, 2022 at 12:17 PM Saravana Kannan <saravanak@google.com>
> wrote:
> > > On Mon, Aug 15, 2022 at 5:39 AM Alexander Stein
> > >
> > > <alexander.stein@ew.tq-group.com> wrote:
> > > > Hello Saravana,
> > > >
> > > > Am Mittwoch, 10. August 2022, 08:00:29 CEST schrieb Saravana Kannan:
> > > > > Alexander,
> > > > >
> > > > > This should fix your issue where the power domain device not having a
> > > > > compatible property. Can you give it a shot please?
> > > >
> > > > thanks for the update. Unfortunately this does not work:
> > > > > [    0.774838] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@0
> > > >
> > > > > [    0.775100] imx-pgc imx-pgc-domain.1: __genpd_dev_pm_attach()
> > > > > failed to
> > > >
> > > > find PM domain: -2
> > > >
> > > > > [    0.775324] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@2
> > > >
> > > > > [    0.775601] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@3
> > > >
> > > > > [    0.775842] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@4
> > > >
> > > > > [    0.776642] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@7
> > > >
> > > > > [    0.776897] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@8
> > > >
> > > > > [    0.777158] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@9
> > > >
> > > > > [    0.777405] PM: Added domain provider from /soc@0/bus@30000000/
> > > >
> > > > gpc@303a0000/pgc/power-domain@a
> > > >
> > > > > [    0.779342] genpd genpd:0:38320000.blk-ctrl:
> > > > > __genpd_dev_pm_attach()
> > > >
> > > > failed to find PM domain: -2
> > > >
> > > > > [    0.779422] imx8m-blk-ctrl 38320000.blk-ctrl: error -ENODEV: failed
> > > > > to
> > > >
> > > > attach power domain "bus"
> > > >
> > > > > [    0.848785] etnaviv-gpu 38000000.gpu: __genpd_dev_pm_attach()
> > > > > failed to
> > > >
> > > > find PM domain: -2
> > > >
> > > > > [    1.114220] pfuze100-regulator 0-0008: Full layer: 2, Metal layer:
> > > > > 1
> > > > > [    1.122267] pfuze100-regulator 0-0008: FAB: 0, FIN: 0
> > > > > [    1.132970] pfuze100-regulator 0-0008: pfuze100 found.
> > > > > [    1.157011] imx-gpcv2 303a0000.gpc: Failed to create device link
> > > > > with
> > > >
> > > > 0-0008
> > > >
> > > > > [    1.164094] imx-gpcv2 303a0000.gpc: Failed to create device link
> > > > > with
> > > >
> > > > 0-0008
> > > >
> > > > The required power-supply for the power domains is still not yet
> > > > available.
> > > > Does this series require some other patches as well?
> > >
> > > Ah sorry, yeah, this needs additional patches. The one I gave in the
> > > other thread when I debugged this and I also noticed another issue.
> > > Here's the combined diff of what's needed. Can you add this on top of
> > > the series and test it?
> > >
> > > diff --git a/drivers/irqchip/irq-imx-gpcv2.c
> > > b/drivers/irqchip/irq-imx-gpcv2.c index b9c22f764b4d..8a0e82067924 100644
> > > --- a/drivers/irqchip/irq-imx-gpcv2.c
> > > +++ b/drivers/irqchip/irq-imx-gpcv2.c
> > > @@ -283,6 +283,7 @@ static int __init imx_gpcv2_irqchip_init(struct
> > > device_node *node,
> > >
> > >          * later the GPC power domain driver will not be skipped.
> > >          */
> > >
> > >         of_node_clear_flag(node, OF_POPULATED);
> > >
> > > +       fwnode_dev_initialized(domain->fwnode, false);
> > >
> > >         return 0;
> > >
> > >  }
> > >
> > > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > > index 6383a4edc360..181fbfe5bd4d 100644
> > > --- a/drivers/soc/imx/gpcv2.c
> > > +++ b/drivers/soc/imx/gpcv2.c
> > > @@ -1513,6 +1513,7 @@ static int imx_gpcv2_probe(struct platform_device
> > > *pdev)>
> > >                 pd_pdev->dev.parent = dev;
> > >                 pd_pdev->dev.of_node = np;
> > >
> > > +               pd_pdev->dev.fwnode = of_fwnode_handle(np);
> > >
> > >                 ret = platform_device_add(pd_pdev);
> > >                 if (ret) {
> > >
> > > With this patch, I'd really expect the power domain dependency to be
> > > handled correctly.
> > >
> > > > Whats worse, starting with commit 9/9 [of: property: Simplify
> > > > of_link_to_phandle()], other drivers fail to probe waiting for pinctrl
> > > > to be available.
> > >
> > > Heh, Patch 9/9 and all its other dependencies in this series was to
> > > fix your use case. Ironic that it's causing you more issues.
> > >
> > > > > $ cat /sys/kernel/debug/devices_deferred
> > > > > gpio-leds       platform: wait for supplier gpioledgrp
> > > > > extcon-usbotg0  platform: wait for supplier usb0congrp
> > > > > gpio-keys       platform: wait for supplier gpiobuttongrp
> > > > > regulator-otg-vbus      platform: wait for supplier reggotgvbusgrp
> > > > > regulator-vdd-arm       platform: wait for supplier dvfsgrp
> > > >
> > > > Apparently for some reason they are not probed again, once the pinctrl
> > > > driver probed.
> > >
> > > I'm hoping that this is just some issue due to the missing patch
> > > above, but doesn't sound like it if you say that the pinctrl ended up
> > > probing eventually.
> > >
> > > So when device_links_driver_bound() calls
> > > __fw_devlink_pickup_dangling_consumers(), it should have picked up the
> > > consumers of node like gpiobuttongrp and moved it to the pinctrl
> > > device. And right after that we call __fw_devlink_link_to_consumers()
> > > that would have created the device links. And then right after that,
> > > we go through all the consumers and add them to the deferred probe
> > > list. After that deferred probe should have run... either because it's
> > > enabled at late_initcall() or because a new device probed
> > > successfully.
> > >
> > > Can you check which one of my expectations isn't true in your case?
> >
> > Actually I have a hypothesis on what might be happening. It could be a
> > case of the consumer device getting added after the supplier has been
> > initialized.
> >
> > If the patch above doesn't fix everything, can you add this diff on
> > top of the patch above and see if that fixes everything? If it fixes
> > the pinctrl issue, can you check my hypothesis be checking in what
> > order the devices get added and get probed?
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 2f012e826986..866755d8ad95 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2068,7 +2068,11 @@ static int fw_devlink_create_devlink(struct device
> > *con, device_links_write_unlock();
> >         }
> >
> > -       sup_dev = get_dev_from_fwnode(sup_handle);
> > +       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> > +               sup_dev = fwnode_get_next_parent_dev(sup_handle);
> > +       else
> > +               sup_dev = get_dev_from_fwnode(sup_handle);
> > +
> >         if (sup_dev) {
> >                 /*
> >                  * If it's one of those drivers that don't actually bind to
> >
>
> And with this change my pinctrl probing is fixed as well!

Thanks for testing these! I'll roll these into v2 of the series.

Glad to see I've fixed all the issues I set out to fix. Now to figure
out what other corner cases I've missed.

-Saravana
