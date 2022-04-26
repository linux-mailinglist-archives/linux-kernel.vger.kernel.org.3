Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1450F994
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348445AbiDZKH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348405AbiDZKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:07:03 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B71ACD39;
        Tue, 26 Apr 2022 02:29:05 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id t85so7201225vst.4;
        Tue, 26 Apr 2022 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lgml70uDh935JdrnMqNiKObdRHrXvk0Wpgnn34fwnyA=;
        b=T66qe9pvrnhouXEYpnpQ0wTsEJhziAdfmnvfFEVBEEJnY5u6HE02fT8Y3tJQDq8g0r
         Sd3Nwse57ZJ/qoR5GStt1Qsz//4K9uS2G0vdKIdK7fWRP+VUszFPGZg48+/7d4jeIcJl
         +tVuoK1Spu4G6plQhK35Yps/YGTBH1pFMOhdJU4ymbEL32OVlcssPbuMp8udljuCPebX
         OilLvCkoareR9e34ZCfA6m8OC7yzuCD0cWAjjCmnf5jBNiGyVEbL+XUcC1b7mydYn3NS
         obLlol2xOIqP59SuJxpFjFmvlWGcx9F3cpXBFb4zVBqY6gi5EbO7BpHMdyTQ2TnEtS5d
         +O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lgml70uDh935JdrnMqNiKObdRHrXvk0Wpgnn34fwnyA=;
        b=dX6q0Ukkd69Ntddd6Wfhn+olKuheMKTXSP0wgWUkMzzbFEVkJbjiqSwE979qev3DGI
         dGzy2EFW05zDTTLh1iGWcYwif2Q+4Sk8pAwA9Hs/7stfNWOgyEJLzGgjkEvwM8APpi4U
         w6xtJvFfe/F+K2Fjp7gt2N9Cy0xAay15V7e6ZjATXGfpMn86rR63xrONV9LVPF+GTrv7
         m+d+m044yvYk7u5OmRgM+7ZxR8BRMrZGQHXI1V8nH2bogMXXYOJSdQWFI2Z1Ib6At/tg
         7ABydgJWRPAX2DJqW8nbQabKKEm8jxUy3VG4C8A+HOMkifcPxGj6ryW8N0/5VJQAqoRh
         kbqw==
X-Gm-Message-State: AOAM532fJfKlAxMkcMTCGvxPXRbJ5x0dftWSE6Q1uRb2HxybkWLLxxSH
        2ZwBJmkfW7jGtPMuN7AIqJ7xcn+HTrkdUf6S754=
X-Google-Smtp-Source: ABdhPJxC1in1WJiZR1lm+IHZ6NT04IBpqh32OaIjGzUivBCgdQcm27xYQv22o2gIa1txnPcs/+gCHhgkpxnR8QekGXk=
X-Received: by 2002:a67:fd65:0:b0:32a:27e9:7c09 with SMTP id
 h5-20020a67fd65000000b0032a27e97c09mr6161120vsa.55.1650965344616; Tue, 26 Apr
 2022 02:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-9-andrea.merello@gmail.com> <20220415184305.03805452@jic23-huawei>
 <CAN8YU5Mz--8R2oE=bgok_JdM6NNW8m2h5_V8LZSocFnaa-PADA@mail.gmail.com> <20220424184521.3f5a9d18@jic23-huawei>
In-Reply-To: <20220424184521.3f5a9d18@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 26 Apr 2022 11:28:53 +0200
Message-ID: <CAN8YU5OB5A0m3gQ0J-PTiEdcSTY_KXONK4V6sjmFEyyK0bmVmw@mail.gmail.com>
Subject: Re: [v4 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno dom 24 apr 2022 alle ore 19:37 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Tue, 19 Apr 2022 09:10:54 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > Il giorno ven 15 apr 2022 alle ore 19:35 Jonathan Cameron
> > <jic23@kernel.org> ha scritto:
> > >
> > > On Fri, 15 Apr 2022 14:59:59 +0200
> > > Andrea Merello <andrea.merello@gmail.com> wrote:
> > >
> > > > From: Andrea Merello <andrea.merello@iit.it>
> > > >
> > > > This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> > > > can be connected via both serial and I2C busses; separate patches will
> > > > add support for them.
> > > >
> > > > The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> > > > that provides raw data from the said internal sensors, and a couple of
> > > > "fusion" modes (i.e. the IMU also do calculations in order to provide
> > > > euler angles, quaternions, linear acceleration and gravity measurements).
> > > >
> > > > In fusion modes the AMG data is still available (with some calibration
> > > > refinements done by the IMU), but certain settings such as low pass
> > > > filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> > > > they can be customized; this is why AMG mode can still be interesting.
> > > >
> > > > Signed-off-by: Andrea Merello <andrea.merello@iit.it>

[...]

> > >
> > > > +
> > > > +     ret = regmap_read(priv->regmap, BNO055_CHIP_ID_REG, &val);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     if (val != BNO055_CHIP_ID_MAGIC) {
> > >
> > > We've run into this a few times recently.  Traditionally IIO has been very
> > > restrictive on allowing drivers to probe if the Who Am I type values
> > > don't match.  That causes problems for backwards compatibility in
> > > device tree - e.g. (with made up compatible part number 055b :)
> > > compatible = "bosch,bno055b", "bosch,bno055"
> > >
> > > The viewpoint of the dt maintainers is that we should assume the
> > > dt is correct and at most warn about missmatched IDs before trying
> > > to carry on.  So to avoid hitting that again please relax this to a
> > > warning and cross your fingers after this point if it doesn't match.
> > > I'm fine on the firmware question because we know we are dealing
> > > with buggy firmware.  Ideally we'll get some working firmware
> > > additions at somepoint then we can just label the bad firmwares
> > > and assume one less bug in the ones that don't match :)
> >
> > To be honest my point wasn't about the correctness of the DT at all..
> >
> > I've hit this several times when I was switching my test board from
> > serial to i2c and vice-versa, because I made wrong connections or I
> > forgot to switch FPGA image (which contains the serial IP here). I got
> > my test script failing because the IIO device didn't pop up at all,
> > which is better than getting e.g. random data. In the real world
> > people may have less chance to have to worry about this, but they may
> > when e.g. they have an RPi and a hand-wired IMU.
> >
> > .. IOW I'm seeing this as a hardware self-test rather than a SW
> > check.. But if the DT thing makes this a no-go, then I can live with
> > the warning, and e.g. by making my script to check the kernel log..
>
> Hmm. I  wonder if we can get the best of both worlds.  Given there
> is a WHOAMI and these very rarely / never take the value of all 0's or all 1's
> (what you'd see with a wiring error) maybe we can sanity check against
> those to provide the hardware self-test element.  Then accept any
> 'sane' value of WHOAMI, but with a warning?

While trying to do this and testing it, I've realized that indeed when
the BUS is broken (e.g. incorrect wiring) the probe() fails even
earlier. When we are unable to communicate with the device, this is
caught by the lower layer protocols (e.g. I2C sees no ACK, I suppose),
so there is no need to fail here; the IIO device doesn't eventually
pop up anyway.

So, I now revert my previous request to keep a check to bail out for
crazy IDs here :) ; I'd say we can just relax the check to just a
warning as you said before, without the need for checking for 0x00 and
0xff..

> Jonathan
>
>
