Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF8857ECD2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiGWIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiGWIz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:55:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15E15809;
        Sat, 23 Jul 2022 01:55:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so6268536pfd.9;
        Sat, 23 Jul 2022 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/hiSA7tfOhhItlZMNyP7rE7eTE9zhuzix6o1mkkaQI=;
        b=daRru6nvDBf3J6bjjteKP9fdtBcSm0eeGDjgA232i9WDqpU2V9qDlEPJ19eSPaZrsH
         Z7jIovabG2qZWJ3S9ieMo8pAm66rsBPZ6VbeUp47IFMOo9wvtv/NdD5Q2ZHXKV2Tmdbe
         udxqDpoSnxhFEEcyClStE1Sw1edaQrkM8QTT++JO4jW56pDioDVBz18b7BY9iuRbH2hG
         dC4JrMsRD1Q8LtgXDwm1DOB+JzJM6wukAW07oIC0zfOc5ZU60mcgQRpIJQwPYIOvqIFf
         DGBS8IcCn296ynAye49rfcC4zXUyEdKV8QAB9uYJL0rkV0FOhEKlFpzv81ewGy89kSDP
         NKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/hiSA7tfOhhItlZMNyP7rE7eTE9zhuzix6o1mkkaQI=;
        b=KT033+dl7GXMn9XuIerDyRhqF9NDbaW2KR3jMtCIXGmBxWuuS99RMbBWNJkkWv3gGP
         ye1saF96oA0EAKxci0md8/BSOoogOkcssT1WLlOyx1iYgf6wi+IBp94JUWoHc69QQOij
         1CKadyKUEerTIIF1E9NwEqhGS7C4s1igZRJjvA/9z6humnnvFWRxx87tWWaZGHKaHk67
         JpB5q2DVuBr3FtablMLv36yGRLZpo1xKvrAu3DeMspVzbIOCFDlzPX6ZXLx2EztQksdZ
         D0tpqB1hE0ePScHg7VxvaRfOq3d7ohgITGG9NhWmUNjdDZZaHIYVZ+6qpks+T7N52UAU
         i0JQ==
X-Gm-Message-State: AJIora/CBKA/E/BYrCOBXqayMMgQB1qLw3cS+iwFxuWP6rr++31/NvP+
        Cmc2gG4nFFQL/jKd+qztSsDq4RZ0qd8fM7MYLUtmQAHO
X-Google-Smtp-Source: AGRyM1vpxl9IcytS0wQP/GU9WxT2lnlMrubpttuQuKVnh1X7pg374hbl+764MO2LJdJ4n9nUA/NBcGGJAzTn9ZjX5r4=
X-Received: by 2002:a05:6a02:302:b0:415:fa99:e0aa with SMTP id
 bn2-20020a056a02030200b00415fa99e0aamr3105979pgb.516.1658566554250; Sat, 23
 Jul 2022 01:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
 <20220613191706.31239-2-jagathjog1996@gmail.com> <20220619135427.4ffc2d3d@jic23-huawei>
 <CAM+2EuJWEOn-Vtaox=G3zXcd+zpx=mAhY1YHuNJx2XpAyPB1xg@mail.gmail.com> <20220716155633.244b9243@jic23-huawei>
In-Reply-To: <20220716155633.244b9243@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sat, 23 Jul 2022 14:25:42 +0530
Message-ID: <CAM+2EuJR9EEEKdi-Ku_wFY=Lb+_H6gBDKGSW3qM0twOH2913kw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: Add new event type gesture and use direction
 for single and double tap
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Jul 16, 2022 at 8:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 26 Jun 2022 18:51:54 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > Sorry for the delay in replying.
> >
> > On Sun, Jun 19, 2022 at 6:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Tue, 14 Jun 2022 00:47:05 +0530
> > > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >
> > > > Add new event type for tap called gesture and the direction can be used
> > > > to differentiate single and double tap. This may be used by accelerometer
> > > > sensors to express single and double tap events. For directional tap,
> > > > modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> > > > doubletap direction.
> > > >
> > > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > >
> > > Hi,
> > >
> > > With fresh eyes I think we need to rethink the use of _period to make sure
> > > we have 'space' for another very like ABI element which is the maximum
> > > time between events for them to be considered a double tap.
> > >
> > > Jonathan
> > >
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
> > > >  drivers/iio/industrialio-event.c        |  5 ++++-
> > > >  include/uapi/linux/iio/types.h          |  3 +++
> > > >  tools/iio/iio_event_monitor.c           |  8 +++++++-
> > > >  4 files changed, 38 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > > index 3e00d7f7ee22..4eaf85e01911 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > > @@ -2035,3 +2035,27 @@ Description:
> > > >               Available range for the forced calibration value, expressed as:
> > > >
> > > >               - a range specified as "[min step max]"
> > > > +
> > > > +What:                /sys/.../events/in_accel_gesture_singletap_en
> > > > +What:                /sys/.../events/in_accel_gesture_doubletap_en
> > > > +KernelVersion:       5.19
> > > > +Contact:     linux-iio@vger.kernel.org
> > > > +Description:
> > > > +             Device generates an event on a single or double tap.
> > > > +
> > > > +What:                /sys/.../events/in_accel_gesture_singletap_value
> > > > +What:                /sys/.../events/in_accel_gesture_doubletap_value
> > > > +KernelVersion:       5.19
> > > > +Contact:     linux-iio@vger.kernel.org
> > > > +Description:
> > > > +             Specifies the threshold value that the device is comparing
> > > > +             against to generate the tap gesture event. Units and exact
> > > > +             meaning of value are device specific.
> > >
> > > I'm fine with this one being device specific, as likely a complex alg
> > > involved.
> > >
> > > > +
> > > > +What:                /sys/.../events/in_accel_gesture_doubletap_period
> > > > +KernelVersion:       5.19
> > > > +Contact:     linux-iio@vger.kernel.org
> > > > +Description:
> > > > +             Minimum time period between before and after the double tap
> > > > +             event. Units and exact meaning of period value are device
> > > > +             specific.
> > >
> > > I think the units need to be standard.  Also would this work better
> > > as a description?
> > >
> > >         Minimum time in seconds between the two taps making up a double
> > >         tap event.
> >
> > The values for the time between the two taps are not in terms of seconds,
> > here period value is in terms of data samples which depends on
> > the data rate.
>
> These time based controls in IIO are always defined in seconds. You'll have
> to correct for the data rate in the driver.
>
> Either just make the available options change with data rate, or have the
> driver do a 'nearest possible' choice based on what was requested and what
> is possible at the current data rate.
>
> It's more complex but it gives a consistent ABI across devices that work
> in many different ways.

TAP interrupts work with a 200 Hz data rate, so all the time-related
config values
are converted to seconds and provided the available options.
I have prepared the v2 and soon I will send the same.

Thank you,
Jagath


>
> Jonathan
>
> >
> > >
> > > Raises a question though. How would we specify the maximum time? I.e.
> > > if taps are further apart than Xseconds, they are reported as two single
> > > taps.
> > >
> > > Maybe reusing period here isn't a good idea and we need to have new ABI for
> > > this?
> > >
> > >
> > >
> > >
>
