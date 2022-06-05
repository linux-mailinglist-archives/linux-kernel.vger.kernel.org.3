Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9608453DA39
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 07:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243878AbiFEFI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 01:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiFEFIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 01:08:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF33320F40;
        Sat,  4 Jun 2022 22:08:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n8so9780554plh.1;
        Sat, 04 Jun 2022 22:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THrbA4LPfwfZr+VCF9dE4+Tkx7gN3vSkH6zMKCFiKvM=;
        b=hRtVi4988JA+f+SfLeJuf1Lus0GFGwM+MlkvsHxeUZO6DUOlH21ceWsThP8trC0MWT
         v/KAZIRLd2F+KRd8ZEFI9Wmnw1KltC20jfdbXOw9Oqaym8f00z2/WjBrPA1aRF4KAfF+
         a09NLYyJItAKFXWguFYm2JeqYeMBOhQcUBHu9o+UZ5XpZlng1dPzDml6fQMiDjGBlX/9
         GkyZDP1A8eADRXt9rSD/qyrhVP/+YQIq99nKFXfMH8cfzIiZjsim34DCqJjMfu49Ho38
         VPLYDa0hLEa7TB+V7jSNQh62rvk88Q0zeunzruTEiTyqFS2gMp70UCBUk2ZFvqyFkLJR
         b7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THrbA4LPfwfZr+VCF9dE4+Tkx7gN3vSkH6zMKCFiKvM=;
        b=eLWtRjZ0U1bxUqmStJpChawAjDg/DiZuuR/+N8J3bTR2+68JJgPiFbZ8esE0OQmge8
         CiWd430sDXwI8OtN6SjNMIk8vs0zY1cn5v09bxrvgGKHPIrhYtVZ6it0S60JD1sMszSe
         rvkF+DfcJ4zwgdEzh/m4gW+0NpGYL7DZoJ+B/9UqLPNNvEsXS7XwlibU071uwaEtcPby
         4RBenYbeAIPZrYQxLyvK71p66A0oAA+2WoHxgPzn0Hic+5EOLbK/gafCSu5LFBTC7TOH
         P8mITqjRSdV/etXWkJmgg73MknFj7pxsgnN56CALP+w70eEzJc7D3GgXZUZnlEILte0u
         LDcA==
X-Gm-Message-State: AOAM533hjKD+R6bWSNEyXp5OHYMHG0HLEJB1yUS/uJV4ssfJIVGV5DkZ
        78whF7ch5wpYiOImYhp+ZL/fN+3Toh6ibK3rCijs8Tm0AXXTSg==
X-Google-Smtp-Source: ABdhPJxCkiGzXThmY7+VAtpUhCNJWYGicSpJXyyb8fXA9xJ4IBsFzZX4YdHDjq9KB6dh9T4qAt5V29ofbL1tRZkhGv4=
X-Received: by 2002:a17:902:9a83:b0:15e:f718:4ced with SMTP id
 w3-20020a1709029a8300b0015ef7184cedmr17670558plp.69.1654405701249; Sat, 04
 Jun 2022 22:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220529040153.4878-1-jagathjog1996@gmail.com>
 <20220529040153.4878-3-jagathjog1996@gmail.com> <20220604160153.504e96ae@jic23-huawei>
In-Reply-To: <20220604160153.504e96ae@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sun, 5 Jun 2022 10:38:10 +0530
Message-ID: <CAM+2EuLdTtXHGR5Oy6ay3yM__LK8Dea2rhXJMBNV35-S9HdmVg@mail.gmail.com>
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

Hi Jonathan and Andy.

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

Andy, I will correct this QUITE in the next patch version.

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

I will add ABI docs for the period.

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

I will update this with the proper datasheet section details.

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
This checking is to make sure not to execute
bma400_set_accel_output_data_rate() function while disabling the
tap event to avoid the negative (-EBUSY) return value from the
function bma400_set_accel_output_data_rate() when either of
the tap is enabled.

>
> Also if bma400_set_accel_output_data_rate() is effectively a noop when
> the data rate is unchanged (and it should be with regmap caching) then
> maybe just call it unconditionally?
>
> This might be a nasty surprise for other users though - so if buffered
> output is in use, maybe just don't allow the rate change, even if
> that means not enabling tap detection.
>
> > +             ret = bma400_set_accel_output_data_rate(data, 200, 0);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
> > +                              BMA400_S_TAP_MSK,
> > +                              FIELD_PREP(BMA400_S_TAP_MSK, state));
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (dir) {
> > +     case IIO_EV_DIR_SINGLETAP:
> > +             mask = BMA400_S_TAP_MSK;
> > +             set_mask_bits(&field_value, BMA400_S_TAP_MSK,
> > +                           FIELD_PREP(BMA400_S_TAP_MSK, state));
> > +             break;
> > +     case IIO_EV_DIR_DOUBLETAP:
> > +             mask = BMA400_D_TAP_MSK;
> > +             set_mask_bits(&field_value, BMA400_D_TAP_MSK,
> > +                           FIELD_PREP(BMA400_D_TAP_MSK, state));
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG, mask,
> > +                              field_value);
> > +     if (ret)
> > +             return ret;
> > +
> > +     set_mask_bits(&data->tap_event_en, mask, field_value);
>
> blank line here
>
> > +     return 0;
> > +}
> > +
> > +static int bma400_disable_adv_interrupt(struct bma400_data *data)
> > +{
> > +     int ret;
> > +
> > +     ret = regmap_write(data->regmap, BMA400_INT_CONFIG0_REG, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = regmap_write(data->regmap, BMA400_INT_CONFIG1_REG, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->tap_event_en = 0;
> > +     data->generic_event_en = 0;
> > +     data->step_event_en = 0;
> > +     data->activity_event_en = 0;
>
> blank line here
>
> > +     return 0;
> > +}
> > +
> >  static int bma400_write_event_config(struct iio_dev *indio_dev,
> >                                    const struct iio_chan_spec *chan,
> >                                    enum iio_event_type type,
> > @@ -1111,10 +1205,20 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
> >
> >       switch (chan->type) {
> >       case IIO_ACCEL:
> > -             mutex_lock(&data->mutex);
> > -             ret = bma400_activity_event_en(data, dir, state);
> > -             mutex_unlock(&data->mutex);
> > -             return ret;
> > +             switch (type) {
> > +             case IIO_EV_TYPE_MAG:
> > +                     mutex_lock(&data->mutex);
> > +                     ret = bma400_activity_event_en(data, dir, state);
> > +                     mutex_unlock(&data->mutex);
> > +                     return ret;
> > +             case IIO_EV_TYPE_GESTURE:
> > +                     mutex_lock(&data->mutex);
> > +                     ret = bma400_tap_event_enable(data, dir, state);
>
> Given existing naming event_en would seem more consistent.
>
> > +                     mutex_unlock(&data->mutex);
> > +                     return ret;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       case IIO_STEPS:
> >               mutex_lock(&data->mutex);
> >               ret = bma400_steps_event_enable(data, state);
> > @@ -1159,8 +1263,8 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
> >       struct bma400_data *data = iio_priv(indio_dev);
> >       int ret, reg;
> >
> > -     switch (chan->type) {
> > -     case IIO_ACCEL:
> > +     switch (type) {
> > +     case IIO_EV_TYPE_MAG:
> >               reg = get_gen_config_reg(dir);
> >               if (reg < 0)
> >                       return -EINVAL;
> > @@ -1196,6 +1300,25 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
> >               default:
> >                       return -EINVAL;
> >               }
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     ret = regmap_read(data->regmap,
> > +                                       BMA400_TAP_CONFIG, val);
>
> Line wrap looks a bit premature - BMA400_TAP_CONFIG can fit on previous line.
>
> > +                     if (ret)
> > +                             return ret;
> > +                     *val = FIELD_GET(BMA400_TAP_SEN_MSK, *val);
> > +                     return IIO_VAL_INT;
> > +             case IIO_EV_INFO_PERIOD:
> > +                     ret = regmap_read(data->regmap,
> > +                                       BMA400_TAP_CONFIG1, val);
> > +                     if (ret)
> > +                             return ret;
> > +                     *val = FIELD_GET(BMA400_TAP_QUITE_MSK, *val);
> > +                     return IIO_VAL_INT;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -1211,8 +1334,8 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
> >       struct bma400_data *data = iio_priv(indio_dev);
> >       int reg, ret;
> >
> > -     switch (chan->type) {
> > -     case IIO_ACCEL:
> > +     switch (type) {
> > +     case IIO_EV_TYPE_MAG:
> >               reg = get_gen_config_reg(dir);
> >               if (reg < 0)
> >                       return -EINVAL;
> > @@ -1228,7 +1351,6 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
> >               case IIO_EV_INFO_PERIOD:
> >                       if (val < 1 || val > 65535)
> >                               return -EINVAL;
> > -
> >                       mutex_lock(&data->mutex);
> >                       put_unaligned_be16(val, &data->duration);
> >                       ret = regmap_bulk_write(data->regmap,
> > @@ -1248,6 +1370,30 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
> >               default:
> >                       return -EINVAL;
> >               }
> > +     case IIO_EV_TYPE_GESTURE:
> > +             switch (info) {
> > +             case IIO_EV_INFO_VALUE:
> > +                     if (val < 0 || val > 7)
>
> Add an _avail for the event control perhaps?
> I think we never brought those into the core code, so you'll have to do
> it manually by registering the additional event attr.
>
> There are some examples in tree such as light/tsl2591

Thanks for the suggestion I will add _avail for value and also
I will address other comments in the next patch.

>
> > +                             return -EINVAL;
> > +
> > +                     return regmap_update_bits(data->regmap,
> > +                                               BMA400_TAP_CONFIG,
> > +                                               BMA400_TAP_SEN_MSK,
> > +                                               FIELD_PREP(BMA400_TAP_SEN_MSK,
> > +                                                          val));
> > +
> > +             case IIO_EV_INFO_PERIOD:
> > +                     if (val < 0 || val > 3)
> > +                             return -EINVAL;
> > +
> > +                     return regmap_update_bits(data->regmap,
> > +                                               BMA400_TAP_CONFIG1,
> > +                                               BMA400_TAP_QUITE_MSK,
> > +                                               FIELD_PREP(BMA400_TAP_QUITE_MSK,
> > +                                                          val));
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -1350,6 +1496,28 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> >       if (ret || !data->status)
> >               goto unlock_err;
> >
> > +     /* Disable all advance interrupts if interrupt engine overrun occurs */
>
> Add a reference, or more detail on why this is the correct action if we get
> an engine overrun.
>
> > +     if (FIELD_GET(BMA400_INT_ENG_OVRUN_MSK, le16_to_cpu(data->status))) {
> > +             bma400_disable_adv_interrupt(data);
> > +             dev_err(data->dev, "Interrupt engine overrun\n");
> > +             goto unlock_err;
> > +     }
> > +
> > +     if (FIELD_GET(BMA400_INT_S_TAP_MSK, le16_to_cpu(data->status)))
> > +             ev_dir = IIO_EV_DIR_SINGLETAP;
> > +
> > +     if (FIELD_GET(BMA400_INT_D_TAP_MSK, le16_to_cpu(data->status)))
>
> If both can occur, send two events. If not, else if
>
> > +             ev_dir = IIO_EV_DIR_DOUBLETAP;
> > +
> > +     if (ev_dir != IIO_EV_DIR_NONE) {
> > +             iio_push_event(indio_dev,
> > +                            IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +                                               IIO_MOD_X_OR_Y_OR_Z,
> > +                                               IIO_EV_TYPE_GESTURE, ev_dir),
> > +                            timestamp);
> > +     }
> > +
> > +     ev_dir = IIO_EV_DIR_NONE;
> >       if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
> >               ev_dir = IIO_EV_DIR_RISING;
> >
>
