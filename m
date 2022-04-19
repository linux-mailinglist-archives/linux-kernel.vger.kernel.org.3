Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10614506560
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349166AbiDSHNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiDSHNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:13:48 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1283056F;
        Tue, 19 Apr 2022 00:11:07 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id z139so9287803vsz.0;
        Tue, 19 Apr 2022 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fJRznz45+6b8f9tgPBJNZwr3gSIqLHvLJH94gCmXiWs=;
        b=Hru924K0BBg56zYFePikkE2q8hrW26jqhVb5NGTx4S5VXYH+9FR37XeQTl7w8hka/I
         NqwpWRJ54uoxIjTo2HOQt2Ys2oaqvcpgb0dbQVXkRBZ+GiQuWVV3ZTjUWc5d1oqJnYn7
         /6KOI7Q/i6FR3G0zGkvQHKdUkvVU3Wg+1ZeskVutSF+Ea5d9O3RCFUCcH2Kc4tFgIuA8
         ClF64wcN07XSD8NemlElU6P4Bx3MNZPh+qjy+O5jPv4CfFZjJVUULkbEhC1bj1sCPvB6
         i9Vx8KSR5HTfGcZUkTa+AtvAQgTPG++P5xWs/KQ/VcKk2sN/7Dn9L3konkxTuTyjQud3
         m8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fJRznz45+6b8f9tgPBJNZwr3gSIqLHvLJH94gCmXiWs=;
        b=kLKilO/qTpIz1q/wUtrsbeoGxZJB+SJrXlM1s76QCzNgvIMucPT6bS3ZVQWR8Z9dP2
         TFUyWHJg9yyyF6b/awM0+dGZDdLKxgw22TZ/YpeVq5pAI2BYlUpGEPoaCYLHCY/2Vltm
         sNWD/c+xTyUnvzdg8B9/uCblQFMQuf/ynSwM/oVaOifhfeicqyDFBb7zH1gjYGLJKSr0
         74cnzGtZsw31UZzdMwLDzA9XelpvBBhmwIa3aHymOG3x+AOo4V0/5mhS+bLPorjOfeu0
         /iebRFIiJs9RhlXtMK4aCkNa6FzC25v08D2kKL/zsXgiPr8+AAiBBh2AI1EGaXhZ4oQw
         fx8w==
X-Gm-Message-State: AOAM530UW2aFHnvAHLGMY7DG79p0Ta9UyIZ/Dkc+xcxnApglYiddQEij
        swYtdNUhhmM9eIY1WbV5fGhAfDTIItqWH/l5LSw=
X-Google-Smtp-Source: ABdhPJxwItw29QxufrFTI6tPUY/l1+fgfbzWDqzwcGFMB2auBxs9/K/icUT5zkTEnFEQPzZ5icyN4geQyINLrfYbwhk=
X-Received: by 2002:a05:6102:199:b0:32a:5d51:1770 with SMTP id
 r25-20020a056102019900b0032a5d511770mr1913464vsq.27.1650352266169; Tue, 19
 Apr 2022 00:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-9-andrea.merello@gmail.com> <20220415184305.03805452@jic23-huawei>
In-Reply-To: <20220415184305.03805452@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 19 Apr 2022 09:10:54 +0200
Message-ID: <CAN8YU5Mz--8R2oE=bgok_JdM6NNW8m2h5_V8LZSocFnaa-PADA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno ven 15 apr 2022 alle ore 19:35 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Fri, 15 Apr 2022 14:59:59 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > From: Andrea Merello <andrea.merello@iit.it>
> >
> > This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> > can be connected via both serial and I2C busses; separate patches will
> > add support for them.
> >
> > The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> > that provides raw data from the said internal sensors, and a couple of
> > "fusion" modes (i.e. the IMU also do calculations in order to provide
> > euler angles, quaternions, linear acceleration and gravity measurements).
> >
> > In fusion modes the AMG data is still available (with some calibration
> > refinements done by the IMU), but certain settings such as low pass
> > filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> > they can be customized; this is why AMG mode can still be interesting.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> Hi Andrea,
>
> A few trivial things from me on this read through.
>
> I haven't commented on a lot of the patches because I was happy with them.
>
> Other than the small changes requested from me, we mostly need to get
> device tree review of the binding and allow time for others to take
> another look.
>
> Thanks,
>
> Jonathan

Ok, good! As usual, just a few inline comments, ok for the rest.

> > +int bno055_probe(struct device *dev, struct regmap *regmap,
> > +              int xfer_burst_break_thr, bool sw_reset)
> > +{
> > +     const struct firmware *caldata;
> See comment below. I think you need to set this to NULL here

Hum. I'm confused here: I think I did set it to NULL (is some later
LOC) in V2, but you argued against it, because hopefully
request_firmware() does it by itself.
https://www.spinics.net/lists/linux-iio/msg64896.html

What has changed or what I've missed? Was your original point just to
move the NULL assignment back at declaration time?

>
> > +
> > +     ret = regmap_read(priv->regmap, BNO055_CHIP_ID_REG, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (val != BNO055_CHIP_ID_MAGIC) {
>
> We've run into this a few times recently.  Traditionally IIO has been very
> restrictive on allowing drivers to probe if the Who Am I type values
> don't match.  That causes problems for backwards compatibility in
> device tree - e.g. (with made up compatible part number 055b :)
> compatible = "bosch,bno055b", "bosch,bno055"
>
> The viewpoint of the dt maintainers is that we should assume the
> dt is correct and at most warn about missmatched IDs before trying
> to carry on.  So to avoid hitting that again please relax this to a
> warning and cross your fingers after this point if it doesn't match.
> I'm fine on the firmware question because we know we are dealing
> with buggy firmware.  Ideally we'll get some working firmware
> additions at somepoint then we can just label the bad firmwares
> and assume one less bug in the ones that don't match :)

To be honest my point wasn't about the correctness of the DT at all..

I've hit this several times when I was switching my test board from
serial to i2c and vice-versa, because I made wrong connections or I
forgot to switch FPGA image (which contains the serial IP here). I got
my test script failing because the IIO device didn't pop up at all,
which is better than getting e.g. random data. In the real world
people may have less chance to have to worry about this, but they may
when e.g. they have an RPi and a hand-wired IMU.

.. IOW I'm seeing this as a hardware self-test rather than a SW
check.. But if the DT thing makes this a no-go, then I can live with
the warning, and e.g. by making my script to check the kernel log..
