Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D145A0C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbiHYJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiHYJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:17:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC44A894B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:17:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bs25so23797046wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=hfCNevAxgJvLuTWr8SaR94vFPaHmg4R55Me0Hy0yr2E=;
        b=sufzBfPfVuYtZY3PY6wJVunOCdpmjJtQQ3FShdHH3SEHEyKMq5q/+m/yebsuQQx1qS
         llyt6o4dRKXF3slpTAZiYDGMSflHDfzU4hYAuErYehIDmubif2jMd/K0skC2jf/jbcFy
         Jw3Dfj9frjUsQW7jTk0q/e8lf4AwohHw0nzfuSQkrgKW12Cig8SaWrl+4/1EICnw8Cge
         4mg+TsmDVqY9AVATxJbHX6ESt19x22Ryvn3LmTVUk/Rtcs75HBZiZgapVQXeih8iZqwn
         4rfKr85mbi78EPBASw1zKovtnQIOgt9fZtwqY7ECo8F1eoNvryGVjqB8WxQCC1dvfm2/
         DfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hfCNevAxgJvLuTWr8SaR94vFPaHmg4R55Me0Hy0yr2E=;
        b=eH6P+JfasW+auRC9EfZB4FSiyRJTI8309rs4loOiq1WpylSunFtHuOQTq1sjDSXt+p
         aBNBmjyUokYDHr04nYYY7Y4i4ydVC6O/mV3RAe4d3wBRsKq0zwShy1HB9n/wpruiL/JX
         RVly2nlvqtKvBpdm4XM6vxaAytKsoyZG7sdk2YGwwcE5C9rGXK+YSX4phdtPdiciP9vt
         GpuokD2Vz09ANwun3n11FxXbv8c+ph7gqTHNKaucOiRhBbJMvQYJtNZtMJfG/3LjPDHi
         tSsX8GVXDopKoLJxACtU38z75ajj45HCKi1pXc4k2Wkzll2BWSG98kcUt6SOM1XnDy0/
         lJRA==
X-Gm-Message-State: ACgBeo1ZYzO0Gd23xGKvhv2ufOhOxydsauQ8b1G8lJ/Nn6PppnCNBlUN
        DCOWOeYLy+C+9gc4eD+KtqR+Eg==
X-Google-Smtp-Source: AA6agR7yRTc1Q1vuAsghCBmXdphB36jE4XFkP7yyuUUAWwoYNpY0fEPzoiHLn303PEfylE6f5KDSxA==
X-Received: by 2002:a05:6000:12cd:b0:225:35b2:c020 with SMTP id l13-20020a05600012cd00b0022535b2c020mr1638661wrx.61.1661419052365;
        Thu, 25 Aug 2022 02:17:32 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:8020:2658:1f7c:362:3e99])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a603fbad5bsm4956489wmq.45.2022.08.25.02.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 02:17:31 -0700 (PDT)
Date:   Thu, 25 Aug 2022 11:17:30 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jerome Neanne <jneanne@baylibre.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 06/11] mfd: drivers: Add TI TPS65219 PMIC support
Message-ID: <20220825091730.i7qi7lnfq44cffjh@blmsp>
References: <20220726103355.17684-1-jneanne@baylibre.com>
 <20220726103355.17684-7-jneanne@baylibre.com>
 <YvEwpXKyMmfdWyfT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvEwpXKyMmfdWyfT@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

thanks for your comments. I am pushing the next version v4 for Jerome
and fixed most of your comments. Some inline comments.

On Mon, Aug 08, 2022 at 04:49:57PM +0100, Lee Jones wrote:
> On Tue, 26 Jul 2022, Jerome Neanne wrote:
> 
> > The TPS65219 is a power management IC PMIC designed
> > to supply a wide range of SoCs
> > in both portable and stationary applications.
> > Any SoC can control TPS65219 over a standard I2C interface.
> 
> Really odd line break choices here.
> 
> > It contains the following components:
> > - Regulators.
> > - Over Temperature warning and Shut down.
> > - GPIOs
> > - Multi Function Pins (MFP)
> > 
> > This patch adds support for tps65219 mfd device. At this time only
> 
> No such thing as an MFD device, what is it?  PMIC, no?
> 
> > the functionalities listed below are made available:
> > 
> > - Regulators probe and functionalities
> > - warm and cold reset support
> > - SW shutdown support
> > 
> > Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> > ---
> >  MAINTAINERS                  |   1 +
> >  drivers/mfd/Kconfig          |  15 +++
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/tps65219.c       | 214 +++++++++++++++++++++++++++++
> >  include/linux/mfd/tps65219.h | 251 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 482 insertions(+)
> >  create mode 100644 drivers/mfd/tps65219.c
> >  create mode 100644 include/linux/mfd/tps65219.h
> > 

...

> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 858cacf659d6..a8ff3d6ea3ab 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile

...

> 
> > +//
> > +// Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> > +//
> > +// This implementation derived from tps65218 authored by
> > +// "J Keerthy <j-keerthy@ti.com>"
> 
> Which he probably copied from elsewhere.
> 
> Please drop this line.
> 
> > +//
> 
> Drop this empty comment
> 
> Only C++ for the SPDX line please.

Mark Brown wanted this the other way around:

"Please make the entire comment a C++ one so things look more
intentional."
https://lore.kernel.org/all/YtayikFdidxXXubS@sirena.org.uk/

Let me know what I should do here.

...

> 
> > +		if (pm_power_off)
> > +			dev_warn(tps->dev, "Setup as system-power-controller but pm_power_off function already registered, overwriting\n");
> 
> Is that really what you want?
> 
> What about the other driver that thinks it's the
> system-power-controller? Seems wrong.

I am now not overwriting pm_power_off but print an error and probe
successfully.

...

> > diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
> > new file mode 100644
> > index 000000000000..e9197ab8bc75
> > --- /dev/null
> > +++ b/include/linux/mfd/tps65219.h
> > @@ -0,0 +1,251 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * linux/mfd/tps65219.h
> 
> No filenames please.  They tend to become unsynced.
> 
> > + * Functions to access TPS65219 power management chip.
> 
> As above.
> 
> > + * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
> > + */
> > +
> > +#ifndef __LINUX_MFD_TPS65219_H
> > +#define __LINUX_MFD_TPS65219_H
> 
> LINUX?

This seems to be quite common in include/linux/mfd/*.h to have
__LINUX_MFD_ as prefix (probably for the directory they are in). I am
assuming that's not the right style. What should be used instead?
__MFD_TPS65219_H or MFD_TPS65219_H or maybe something else?

...

> > +
> > +/**
> > + * struct tps65219 - tps65219 sub-driver chip access routines
> > + *
> > + * Device data may be used to access the TPS65219 chip
> > + */
> 
> This is not a complete kerneldoc header.
> 
> Please compile test with W=1.

I didn't see any errors reported for this struct with W=1. I am assuming
you meant missing field descriptions and added them.

Thanks,
Markus
