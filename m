Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0CA541BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383184AbiFGVwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348269AbiFGU5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:57:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBA201FE6;
        Tue,  7 Jun 2022 11:44:20 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u2so16278783pfc.2;
        Tue, 07 Jun 2022 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOh2j3WPqqZfAHg6UCY/WH1moRrUi0fP4m5QLPcPAtU=;
        b=EltmP1MRnsgOZX4RJxec52xpO+IOtJiPd87sgl1IdzrJ7nGSbqsIBILiF1450oQVFq
         kNLB5vry+A3cntQVnpZ+/9sh5uwiJh8jQUNvIH/3V1hOvpsG2X9lzZYvnRZyLZW5cWUb
         rcfSZs3foO/Rj8VM4nBbLGtf3g/voGsQtkkI5HKbHyo8hm9dg35at3kMQ6FIPL/G/bwq
         f27OaKGg4UcI03xh5KUITq/boG+cCvnF5G6kQLPiUNTPS9VWX9ml+zJ37KDVd5IsHaQd
         rBT6nMvyCs6S34gpt4Auw1MKb4UbZ6AjqG1iHFZ7w7OryJwdq79J/HNIQe6ahaoxXstd
         NIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOh2j3WPqqZfAHg6UCY/WH1moRrUi0fP4m5QLPcPAtU=;
        b=pGlMY5Zl6DTbLHZGpAyGiV2vwcVsGaVLKvXKs6o9BN6TI+HmwBzvpO8zWkbCqzouLq
         op9EHxrG61Y8Bc5qWyMm6yTIgXKJqF1yJIzEtcQ4jwOLc8JGQVtUHJ5jAXT6QMxPDDuX
         vHuflg5Q970ZMX04saUqT0EoHDpGS/qwJHAdhtQYUjJgTFfyjHAV0bTc6mNj1opYSPtv
         vpZHIvID3drdBOaOs2fzRow8ZxPGO9Vhpjy4qP+TTQDAQe5tmRvEyX4cwg4z9UVq1TYW
         f1oHKxsADCRrdS1r4RzIu1xFATJRTgTL2kegSF1lIbTLxdMgDcaWI2LzC6VaJ5VVss9H
         Y2lw==
X-Gm-Message-State: AOAM5335/fB86Pjs/vLsd4GSk0mnZpWllR5C196QSTnwZcPYrwq/NgPD
        kWAAE34epaLYTtFH6Ts/vvunpnaBh6kDGtqC6ZE=
X-Google-Smtp-Source: ABdhPJydy4gPOye9/FJko+2pCnb0E7rvz1unuxSiwC5OTsvf+3PWCq9Q4XJ3R+G1/zuFLkH+4C9ZgVovUwmweb+8kjQ=
X-Received: by 2002:a63:8b4b:0:b0:3fc:ee1a:9574 with SMTP id
 j72-20020a638b4b000000b003fcee1a9574mr24673843pge.431.1654627459664; Tue, 07
 Jun 2022 11:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220529040153.4878-1-jagathjog1996@gmail.com>
 <20220529040153.4878-3-jagathjog1996@gmail.com> <20220604160153.504e96ae@jic23-huawei>
In-Reply-To: <20220604160153.504e96ae@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Wed, 8 Jun 2022 00:14:08 +0530
Message-ID: <CAM+2Eu+krxxTcN+F7F69X4z=Rz2=zpUx2WLgJMgs9XApWhnMjQ@mail.gmail.com>
Subject: Re: [RFC 2/2] iio: accel: bma400: Add support for single and double
 tap events
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Jonathan,

On Sat, Jun 4, 2022 at 8:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 29 May 2022 09:31:53 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Add support for single and double tap events based on the tap threshold
> > value and minimum quite time value between the taps. INT1 pin is used to
> > interrupt and event is pushed to userspace.
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
>
> Hi Jagath,
>
> A few comments inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/bma400.h      |  11 ++
> >  drivers/iio/accel/bma400_core.c | 186 ++++++++++++++++++++++++++++++--
> >  2 files changed, 188 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index e8f802a82300..7331474433fa 100644
> > --- a/drivers/iio/accel/bma400.h
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -40,6 +40,7 @@
> >  #define BMA400_INT_STAT1_REG        0x0f
> >  #define BMA400_INT_STAT2_REG        0x10
> >  #define BMA400_INT12_MAP_REG        0x23
> > +#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
> >
> >  /* Temperature register */
> >  #define BMA400_TEMP_DATA_REG        0x11
> > @@ -105,6 +106,16 @@
> >  #define BMA400_INT_GEN2_MSK         BIT(3)
> >  #define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> >
> > +/* TAP config registers */
> > +#define BMA400_TAP_CONFIG           0x57
> > +#define BMA400_TAP_CONFIG1          0x58
> > +#define BMA400_S_TAP_MSK            BIT(2)
> > +#define BMA400_D_TAP_MSK            BIT(3)
> > +#define BMA400_INT_S_TAP_MSK        BIT(10)
> > +#define BMA400_INT_D_TAP_MSK        BIT(11)
> > +#define BMA400_TAP_SEN_MSK          GENMASK(2, 0)
> > +#define BMA400_TAP_QUITE_MSK        GENMASK(3, 2)
> > +
> >  /*
> >   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
> >   * converting to micro values for +-2g range.
> > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > index 517920400df1..2385883707f2 100644
> > --- a/drivers/iio/accel/bma400_core.c
> > +++ b/drivers/iio/accel/bma400_core.c
> > @@ -88,6 +88,7 @@ struct bma400_data {
> >       bool step_event_en;
> >       bool activity_event_en;
> >       unsigned int generic_event_en;
> > +     unsigned int tap_event_en;
> >       /* Correct time stamp alignment */
> >       struct {
> >               __le16 buff[3];
> > @@ -216,6 +217,19 @@ static const struct iio_event_spec bma400_accel_event[] = {
> >                                      BIT(IIO_EV_INFO_HYSTERESIS) |
> >                                      BIT(IIO_EV_INFO_ENABLE),
> >       },
> > +     {
> > +             .type = IIO_EV_TYPE_GESTURE,
> > +             .dir = IIO_EV_DIR_SINGLETAP,
> > +             .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > +                                    BIT(IIO_EV_INFO_ENABLE),
> > +     },
> > +     {
> > +             .type = IIO_EV_TYPE_GESTURE,
> > +             .dir = IIO_EV_DIR_DOUBLETAP,
> > +             .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > +                                    BIT(IIO_EV_INFO_PERIOD) |
>
> Feels like period isn't well defined for this case.  So probably needs a specific
> ABI entry and period might not be best choice...  However, period has no logical
> other meaning in this case (what does 'amount of time a double tap has been true for before
> event mean?') so I think it is fine to use it, as long as ABI docs exist to say what it's
> meaning is for this case.
>
> > +                                    BIT(IIO_EV_INFO_ENABLE),
> > +     },
> >  };
> >
> >  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> > @@ -407,6 +421,14 @@ static int bma400_set_accel_output_data_rate(struct bma400_data *data,
> >       unsigned int val;
> >       int ret;
> >
> > +     /*
> > +      * No need to change ODR when tap event is enabled because
>
> Do not change ODR...
>
>
> > +      * tap interrupt is operating with the data rate of 200Hz.
> > +      * See datasheet page 124.
> > +      */
> > +     if (data->tap_event_en)
> > +             return -EBUSY;
> > +
> >       if (hz >= BMA400_ACC_ODR_MIN_WHOLE_HZ) {
> >               if (uhz || hz > BMA400_ACC_ODR_MAX_HZ)
> >                       return -EINVAL;
> > @@ -1012,6 +1034,10 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
> >               case IIO_EV_DIR_FALLING:
> >                       return FIELD_GET(BMA400_INT_GEN2_MSK,
> >                                        data->generic_event_en);
> > +             case IIO_EV_DIR_SINGLETAP:
> > +                     return FIELD_GET(BMA400_S_TAP_MSK, data->tap_event_en);
> > +             case IIO_EV_DIR_DOUBLETAP:
> > +                     return FIELD_GET(BMA400_D_TAP_MSK, data->tap_event_en);
> >               default:
> >                       return -EINVAL;
> >               }
> > @@ -1101,6 +1127,74 @@ static int bma400_activity_event_en(struct bma400_data *data,
> >       return 0;
> >  }
> >
> > +static int bma400_tap_event_enable(struct bma400_data *data,
> > +                                enum iio_event_direction dir, int state)
> > +{
> > +     int ret;
> > +     unsigned int mask, field_value;
> > +
> > +     if (data->power_mode == POWER_MODE_SLEEP)
> > +             return -EBUSY;
>
> There are existing examples of this in driver, but I can't immediately
> see how we end up in sleep mode.  Perhaps a comment on why this might happen?

Currently, only during the driver unwinding the device is put into sleep mode.
I should be checking whether the device is in normal mode or not since
the tap interrupts only in normal mode. I will change this.

>
> > +
> > +     /*
> > +      * acc_filt1 is the data source for the tap interrupt and it is
> > +      * operating on an input data rate of 200Hz.
> > +      */
> > +     if (!data->tap_event_en) {
>
> Feels like checking the wrong thing.  If we need 200Hz, check if the
> data rate is at 200Hz rather than if the tap_event is not enabled.
> Obviously same result, but one seems more obvious.

if (!data->tap_event_en)
As I mentioned in the previous mail this checking is to make sure
not to execute bma400_set_accel_output_data_rate() function
while disabling the tap event.

>
> Also if bma400_set_accel_output_data_rate() is effectively a noop when
> the data rate is unchanged (and it should be with regmap caching) then
> maybe just call it unconditionally?
>
> This might be a nasty surprise for other users though - so if buffered
> output is in use, maybe just don't allow the rate change, even if
> that means not enabling tap detection.

In this case, if the tap is enabled before the buffer do I need to disable
the tap events before enabling buffer?
I have tested tap events with continuous trigger buffer read but only
thing is, it is not possible to change the data rate.

Thanks,
Jagath
