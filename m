Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7B8592D25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiHOKSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiHOKSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:18:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8CD27E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:18:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j8so12747762ejx.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Z/Q6CR/SPVatWHvELppezc+4y+wJNMFxgASHSY0j6L8=;
        b=LZYgfKev6RocfwUGd1BJiz6YldfHaiiTV/6nFJ/11T+sRz/1rNAF5gd/sF6sOnc078
         77vT0vBbNJMI9ggsauNYhnfqhG2A8MYGjZfKJpPTTMaxvIZbZXYIdRz7EUcEJWcwwnq5
         sZyDGZLTdGHRdGkxVkyoAh2IXctUnV0sAfdZbriRSOoCyqjw6kjdBwMcd3Y8zPqTlakO
         3DKDlmKvBJ08QofUVtjf5kRHqx9Q9YQWgEGv3qrXO7FGY1WvewahlebrCfrFdZK/eVWQ
         dBrhTsTCixSYkkRbZhpTBKZPKabgaGOvy+4irPPLDMzsUPB5ho5+yg6RTz+oupM8W2sL
         ZuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Z/Q6CR/SPVatWHvELppezc+4y+wJNMFxgASHSY0j6L8=;
        b=8SKtqtP0sBm+MGtJp/7iRsHO+m88R3SPZ9CMr9KVX+Vgj8plAIf+BLibZ9oS4kBDkk
         bXC5h5HzLRJ3AsPZQaRCTB9G5LQfsL3bgk1B8KCSy1rD+CsBy1q0CXVFJYHX7OTy5Noc
         eToLAu4K0XP4Mn41eVrlOSkoJkI3Ud+78PtUkVlRgz4jvZOQxZ0bfcSQ8YJ+wazPolFq
         sMWgoVh77WhWR4LaXx2at0/zKn/oeMZSzMM/mJ2c0V+snlXbyTKgjFjxO+vRks9JkpRN
         V0O3tlpana8KU7sWRZ/yd2EBeZGaDh45WXcCIXh9qQBecgyKNEf95m7VGVivRAnd6nZS
         8jqw==
X-Gm-Message-State: ACgBeo3Wyr5vcw6ZSk1/SPzQq1S2xxeQK1ZhJYL6h9IVSt7kQgBRh1XD
        oFQZKN7ndcEJlL/JvbxodJEJVaT25/GR9T0EwKubGA==
X-Google-Smtp-Source: AA6agR79URV926F8kY2eT9PNM8ZDigqw2rjbQGExeYIT68Gp4fZdnPbdF/t1q5U1y/6qHYnCKzkJczS6ilwv6NFzXKE=
X-Received: by 2002:a17:907:2721:b0:731:2aeb:7940 with SMTP id
 d1-20020a170907272100b007312aeb7940mr10409876ejl.448.1660558691411; Mon, 15
 Aug 2022 03:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com> <CAGETcx_nVXbHzZ3+_aR4SZtSnSBU=Rfp8Qm2jOs7zGZRaH_88A@mail.gmail.com>
In-Reply-To: <CAGETcx_nVXbHzZ3+_aR4SZtSnSBU=Rfp8Qm2jOs7zGZRaH_88A@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 15 Aug 2022 15:47:59 +0530
Message-ID: <CA+G9fYuUbEiGNpVsSsVcSmB3azaYKs8WrSCP1z1wx6dJKhB5Jw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
To:     Saravana Kannan <saravanak@google.com>
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
        Alexander Stein <alexander.stein@ew.tq-group.com>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Aug 2022 at 11:29, Saravana Kannan <saravanak@google.com> wrote:
>
> +Naresh Kamboju
>
> On Tue, Aug 9, 2022 at 11:00 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > This patch series improves fw_devlink in the following ways:
> >
> > 1. It no longer cares about a fwnode having a "compatible" property. It
> >    figures this our more dynamically. The only expectation is that
> >    fwnode that are converted to devices actually get probed by a driver
> >    for the dependencies to be enforced correctly.
> >
> > 2. Finer grained dependency tracking. fw_devlink will now create device
> >    links from the consumer to the actual resource's device (if it has one,
> >    Eg: gpio_device) instead of the parent supplier device. This improves
> >    things like async suspend/resume ordering, potentially remove the need
> >    for frameworks to create device links, more parallelized async probing,
> >    and better sync_state() tracking.
> >
> > 3. Handle hardware/software quirks where a child firmware node gets
> >    populated as a device before its parent firmware node AND actually
> >    supplies a non-optional resource to the parent firmware node's
> >    device.
> >
> > 4. Way more robust at cycle handling (see patch for the insane cases).
> >
> > 5. Stops depending on OF_POPULATED to figure out some corner cases.
> >
> > 6. Simplifies the work that needs to be done by the firmware specific
> >    code.
> >
> > This took way too long to get done due to typo bugs I had in my rewrite or
> > corner cases I had to find and handle. But it's fairly well tested at this
> > point and I expect this to work properly.
> >
> > Abel & Doug,
> >
> > This should fix your cyclic dependency issues with your display. Can you
> > give it a shot please?
> >
> > Alexander,
> >
> > This should fix your issue where the power domain device not having a
> > compatible property. Can you give it a shot please?
> >
> > Tony,
> >
> > This should handle the odd case of the child being the supplier of the
> > parent. Can you please give this a shot? I want to make sure the cycle
> > detection code handles this properly and treats it like it's NOT a cycle.
> >
> > Geert,
> >
> > Can you test the renesas stuff I changed please? They should continue
> > working like before. Any other sanity test on other hardware would be
> > great too.
> >
> > Sudeep,
> >
> > I don't think there are any unfixed issues you had reported in my other
> > patches that this series might fix, but it'll be nice if you could give
> > this a sanity test.
> >
> > Guenter,
> >
> > I don't think this will fix the issue you reported in the amba patch, but
> > it's worth a shot because it improves a bunch of corner case handling. So
> > it might be better at handling whatever corner cases you might have in the
> > qemu platforms.
>
> Hi Naresh,
>
> Thanks for testing these patches in the other thread. Mind giving your
> tested-by here? I know you tested these patches in X15, but were there
> also other boards these patches were tested on as part of the run?

I have tested your patches and boot is successful on x15 device and Juno-r2.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> > Cc: Abel Vesa <abel.vesa@linaro.org>
> > Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: John Stultz <jstultz@google.com>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> >
> > Saravana Kannan (9):
> >   driver core: fw_devlink: Don't purge child fwnode's consumer links
> >   driver core: fw_devlink: Improve check for fwnode with no
> >     device/driver
> >   soc: renesas: Move away from using OF_POPULATED for fw_devlink
> >   gpiolib: Clear the gpio_device's fwnode initialized flag before adding
> >   driver core: fw_devlink: Add DL_FLAG_CYCLE support to device links
> >   driver core: fw_devlink: Allow marking a fwnode link as being part of
> >     a cycle
> >   driver core: fw_devlink: Consolidate device link flag computation
> >   driver core: fw_devlink: Make cycle detection more robust
> >   of: property: Simplify of_link_to_phandle()
> >
> >  drivers/base/core.c             | 437 +++++++++++++++++++++-----------
> >  drivers/gpio/gpiolib.c          |   6 +
> >  drivers/of/property.c           |  84 +-----
> >  drivers/soc/renesas/rcar-sysc.c |   2 +-
> >  include/linux/device.h          |   1 +
> >  include/linux/fwnode.h          |  12 +-
> >  6 files changed, 323 insertions(+), 219 deletions(-)
> >
> > --
> > 2.37.1.559.g78731f0fdb-goog

- Naresh
