Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479C957ECDB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 10:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiGWI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGWI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 04:59:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E551919286;
        Sat, 23 Jul 2022 01:59:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d7-20020a17090a564700b001f209736b89so10094057pji.0;
        Sat, 23 Jul 2022 01:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnwVU85F3Nr2mx1Nxs2xgjSG1ClEaZuhHqfaqMrwwY0=;
        b=CZEcm3fDEPbxuI+gc+Z/g0vp4P+c8lMKGrmbpbg1vqpKjCZA3tP2Ry7MbDc+2ufJhT
         z8GI1Av0iFlmjHDGnPHm9CymVsXn0djALGJBFe+BV7hY/LPuw/3yfFA/kxz+fV9lh2m8
         Sd0tTWLojmpExzR1mq1D5binMn3s29ra5sgGYlSKmaA9Uy3+gtqW4yBgspUxaiE7hmHr
         pVzQ2TiWLPTyOAeWhQahGenMAZyULYrgecFx6ffPvSrkZuYU2bafoAGvz/D/bLABpNik
         jbhHC1B20ns/1WVMwWWowIWzKKQOEzu5rlA/RsKXg5l1AmOf67N+GnVHNvb6OTQT070y
         KBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnwVU85F3Nr2mx1Nxs2xgjSG1ClEaZuhHqfaqMrwwY0=;
        b=W4vHZpSmNXjMBZK4QT54ZbFS/tWQW/1DX3nFmyrhNd43UP1uqT2LeL7F2LWQEhR/W7
         AOD4jw1RheKE3nhmte5OeVbITq1CdBURA0gAuG0PjOmhVO5j3NRR3K4wfEI2V1/HXTRU
         cKfk+J80dnbEP5WkItochvp11JSMgeOfGDRZf5vlz6W8408MPrLuE1W/sa6G0SPLoWDL
         5gQjn7ivkSvuGSBiel4KpuNTjsEDMxbRwQ3UfgsFAoI8l1byNXPTaF01mGDw1ypZ/bW/
         PA0lhFXgBqHpbGz/bt9BlknN7FoPqJpSflgljJOCEDOHpkbOKSpt55aR93DCvA3pr+hd
         OqxA==
X-Gm-Message-State: AJIora9x+Cao3j4kMSFv33gKvZy+mlNRukSdtNSQ+q7D1/WjokPrL5Pr
        XCJDAjt3X0KozFl2ylBwB9biEgB9xmSQ30h03MZmdGXx
X-Google-Smtp-Source: AGRyM1uk+Gv8NE1yY9QhT2Ix6BgsCMfxZdp2tndVWT83GAivajcPvHNxfeOoNpXvD3rF73TixQ84iyP4r4N6DidQEgE=
X-Received: by 2002:a17:902:d2d2:b0:16b:e8da:409b with SMTP id
 n18-20020a170902d2d200b0016be8da409bmr3602873plc.81.1658566785009; Sat, 23
 Jul 2022 01:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
 <20220613191706.31239-3-jagathjog1996@gmail.com> <20220619141814.4b2b3dee@jic23-huawei>
 <CAM+2Eu+n40_WiQFJDWDeJxoSLxEKjNY1_vGxC_86DX7+jquPeg@mail.gmail.com> <20220716162001.054cd77f@jic23-huawei>
In-Reply-To: <20220716162001.054cd77f@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sat, 23 Jul 2022 14:29:33 +0530
Message-ID: <CAM+2EuL=ysbaGpsjgrpJw9T3pw7NKxwZhf4HS5EEVrFZPjU23g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: accel: bma400: Add support for single and
 double tap events
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
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

On Sat, Jul 16, 2022 at 8:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 26 Jun 2022 18:53:11 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Hi Jonathan,
> >
> > On Sun, Jun 19, 2022 at 6:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Tue, 14 Jun 2022 00:47:06 +0530
> > > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> > >
> > > > Add support for single and double tap events based on the tap threshold
> > > > value and minimum quiet time value between the taps. The INT1 pin is used
> > > > to interrupt and event is pushed to userspace.
> > > >
> > > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/bma400.h      |  11 ++
> > > >  drivers/iio/accel/bma400_core.c | 210 ++++++++++++++++++++++++++++++--
> > > >  2 files changed, 211 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > > > index e8f802a82300..d05edd9b009a 100644
> > > > --- a/drivers/iio/accel/bma400.h
> > > > +++ b/drivers/iio/accel/bma400.h
> > > > @@ -40,6 +40,7 @@
> > > >  #define BMA400_INT_STAT1_REG        0x0f
> > > >  #define BMA400_INT_STAT2_REG        0x10
> > > >  #define BMA400_INT12_MAP_REG        0x23
> > > > +#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
> > > >
> > > >  /* Temperature register */
> > > >  #define BMA400_TEMP_DATA_REG        0x11
> > > > @@ -105,6 +106,16 @@
> > > >  #define BMA400_INT_GEN2_MSK         BIT(3)
> > > >  #define BMA400_GEN_HYST_MSK         GENMASK(1, 0)
> > > >
> > > > +/* TAP config registers */
> > > > +#define BMA400_TAP_CONFIG           0x57
> > > > +#define BMA400_TAP_CONFIG1          0x58
> > > > +#define BMA400_S_TAP_MSK            BIT(2)
> > > > +#define BMA400_D_TAP_MSK            BIT(3)
> > > > +#define BMA400_INT_S_TAP_MSK        BIT(10)
> > > > +#define BMA400_INT_D_TAP_MSK        BIT(11)
> > > > +#define BMA400_TAP_SEN_MSK          GENMASK(2, 0)
> > > > +#define BMA400_TAP_QUIET_MSK        GENMASK(3, 2)
> > >
> > > So following up on the 'what is the maximum time between double taps
> > > question I took a look at the datasheet.
> > >
> > > What about quiet_dt and tics_th?
> >
> > I kept both of them as default values since there is only _period attribute
> > which matches these values.
>
> Understood.  Definitely feels like we are stretching that ABI too far.
>
> >
> > >
> > > quiet_dt seems to be min time between taps in a double tap, and tics_th
> > > is about the 'tap' algorithm itself.
> > >
> > > Interesting, tics_th is kind of the opposite of what we'd normally use period
> > > for.  We only get event if the max to min of tap occur closer together than
> > > this value.
> > >
> > > quiet_dt seems a closer fit to what you documented period for.  quiet
> > > controls min space between single taps.  So related but indirectly to
> > > double tap detection.
> > > If I have understood this correctly.
> > >
> > > * If two taps are more that quiet apart then we get 2 single taps.
> > > * If two taps are more than quiet_dt apart but less than quiet apart then
> > >   we get a double tap.
> > > * If two taps are less than quiet_dt apart, then we probably detect them
> > >   as a single tap, as long as the tics_th timing condition is met.
> > >
> > > Whilst quiet effects both single and double tap I think we would have
> > > to define it as controls on both of them (linked by changing value of
> > > one effecting the other).
> > >
> > > Period doesn't fit any of these but I'm struggling to come up with
> > > good ABI.
> > >
> > > Maybe use "holdoff" for single tap to indicate minimum time after
> > > first tap before we can have another one.  (lifted from naming of
> > > controls on oscilloscope triggers).
> > >
> > > What to call the same time for double taps (which it's a limit on how
> > > far apart they can be) isn't obvious.  Nor is what would map to quiet_dt
> > > a they are both very specific to double taps.
> > > Maybe "period" makes sense for quiet (not quiet_dt) when applied to a double
> > > tap as it's time within which the event must have completed (got 2 taps)
> > > but it's a stetch.
> > >
> > > Anyhow, this needs more thought.  All suggestions welcome!
> >
> > Thanks for the suggestion,
> > For double-tap, the quiet value represents window time which means both taps
> > should occur within this period of time.
> >
> > Please give me suggestions for the name "pulse window" or only "window" for
> > double tap quiet value and "latency" for the quiet_dt.
>
> Window doesn't really describe anything - it's too vague.
>
> >
> > Most of the accelerometer sensors which support tap feature define
> > quite, quite_dt
> > register field with different names then, can I add these attributes in the core
> > with the final suggested name?
>
> ABI definition is tricky.  Normal trick is to look at other similar sorts of things
> (like oscilloscope triggers). https://download.tek.com/document/55W_17291_6_0.pdf (1st
> hit in google)
> So, one option is to use the concept of triggers resetting.
>
> Hence quiet might work as
> gesture_singletap_resettimeout (in seconds)  Until this time has passed the
> detector is not reset to look for another event.

There is already IIO_EV_INFO_TIMEOUT defined which almost maps to the
given suggestion. Your thoughts on reusing the same for quiet
(gesture_singletap_timeout)?

>
> It's a bit of a stretch to use this for quiet_dt. There is a similar concept
> in the above scope manual, but it's defined as AB triggers and that's complex
> and doesn't map great to simple naming.
> gesture_doubletap_tap2mindelay (in seconds)

Thanks for the suggestions.
I will send v2 soon so that I can get more comments on this from others also.

> maybe?  Note these are only vague suggestions.  There are a various userspace
> folk who are often kind enough to give us feedback on things affecting ABI.
> So +CC
> Bastien Nocera <hadess@hadess.net>
> Hans de Goede <hdegoede@redhat.com>
>
> (for Bastien and Hans: the aim here is to finally add ABI to IIO for single and double
>  tap detection from accelerometers - in particular trying to come up with sensible tunables
>  that are suitable for the algorithms various devices implement).
>
> >
> > Since tics_th is specific to bma400 can I define this by creating custom
> > attributes with the same name using IIO_DEVICE_ATTR_RW()?
>
> No.  Custom ABI is fine for a driver if needed like here, but it needs to be inline with
> the standard ABI such that if we make it standard later, we can hopefully make
> use of it.   I'm not sure this will ever be standards, but let's aim for
> something readable(ish).
>
> _maxtomin_time  (in seconds)  might work perhaps?

This tics_th (_maxtomin_time) in seconds is more specific to bma400 so I thought
of providing a custom ABI for this, but the values are in floating
point. How can
I decode these floating point values (string) in the custom *_show and *_store?

To avoid floating point operations, is there any helper similar to kstrtoint()?

For other ABI like _tap2mindelay and _resettimeout are also floating
point values
but the core will convert into micro since they are added in core as
standard ABI.

>
> I've not looked at what the input subsystem does for touch screens. Feels like they'll
> have at least some of the same controls.  Perhaps there is something to be learnt
> from there?

Input subsystem is using MT protocol for reporting multi-touch and events are
reported to userspace, but I didn't find attributes related to tap
configurations
that are being read or written from userspace.

There is an adxl34x accelerometer driver in the input subsystem which supports
tap but the configuration values for tap are hardcoded in the driver.

Thanks
Jagath

Jagath
>
> Jonathan
>
>
> >
> > Thank you,
> > Jagath
> >
> >
> > >
> > >
> > > A few trivial things inline as well.
> > >
> > >
> > >
> > > > +
> > > >  /*
> > > >   * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
> > > >   * converting to micro values for +-2g range.
> > > > diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> > > > index c31bdd9b168e..f8945dc0de04 100644
> > > > --- a/drivers/iio/accel/bma400_core.c
> > > > +++ b/drivers/iio/accel/bma400_core.c
> > > > @@ -29,6 +29,7 @@
> > > >  #include <linux/iio/trigger.h>
> > > >  #include <linux/iio/trigger_consumer.h>
> > > >  #include <linux/iio/triggered_buffer.h>
> > > > +#include <linux/iio/sysfs.h>
> > > >
> > > >  #include "bma400.h"
> > > >
> > > > @@ -88,6 +89,7 @@ struct bma400_data {
> > > >       bool step_event_en;
> > > >       bool activity_event_en;
> > > >       unsigned int generic_event_en;
> > > > +     unsigned int tap_event_en;
> > > >       /* Correct time stamp alignment */
> > > >       struct {
> > > >               __le16 buff[3];
> > > > @@ -216,6 +218,36 @@ static const struct iio_event_spec bma400_accel_event[] = {
> > > >                                      BIT(IIO_EV_INFO_HYSTERESIS) |
> > > >                                      BIT(IIO_EV_INFO_ENABLE),
> > > >       },
> > > > +     {
> > > > +             .type = IIO_EV_TYPE_GESTURE,
> > > > +             .dir = IIO_EV_DIR_SINGLETAP,
> > > > +             .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > > > +                                    BIT(IIO_EV_INFO_ENABLE),
> > > > +     },
> > > > +     {
> > > > +             .type = IIO_EV_TYPE_GESTURE,
> > > > +             .dir = IIO_EV_DIR_DOUBLETAP,
> > > > +             .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> > > > +                                    BIT(IIO_EV_INFO_PERIOD) |
> > > > +                                    BIT(IIO_EV_INFO_ENABLE),
> > > > +     },
> > > > +};
> > > > +
> > > > +/* List of sensitivity values available to configure tap interrupts */
> > > > +static IIO_CONST_ATTR(in_accel_gesture_value_available, "0 1 2 3 4 5 6 7");
> > > > +
> > > > +/* List of minimum quiet time before and after double tap, in data samples. */
> > > > +static IIO_CONST_ATTR(in_accel_gesture_doubletap_period_available,
> > > > +                   "60 80 100 120");
> > > > +
> > > > +static struct attribute *bma400_event_attributes[] = {
> > > > +     &iio_const_attr_in_accel_gesture_value_available.dev_attr.attr,
> > > > +     &iio_const_attr_in_accel_gesture_doubletap_period_available.dev_attr.attr,
> > > > +     NULL
> > > > +};
> > > > +
> > > > +static const struct attribute_group bma400_event_attribute_group = {
> > > > +     .attrs = bma400_event_attributes,
> > > >  };
> > > >
> > > >  #define BMA400_ACC_CHANNEL(_index, _axis) { \
> > > > @@ -1012,6 +1044,10 @@ static int bma400_read_event_config(struct iio_dev *indio_dev,
> > > >               case IIO_EV_DIR_FALLING:
> > > >                       return FIELD_GET(BMA400_INT_GEN2_MSK,
> > > >                                        data->generic_event_en);
> > > > +             case IIO_EV_DIR_SINGLETAP:
> > > > +                     return FIELD_GET(BMA400_S_TAP_MSK, data->tap_event_en);
> > > > +             case IIO_EV_DIR_DOUBLETAP:
> > > > +                     return FIELD_GET(BMA400_D_TAP_MSK, data->tap_event_en);
> > > >               default:
> > > >                       return -EINVAL;
> > > >               }
> > > > @@ -1101,6 +1137,80 @@ static int bma400_activity_event_en(struct bma400_data *data,
> > > >       return 0;
> > > >  }
> > > >
> > > > +static int bma400_tap_event_en(struct bma400_data *data,
> > > > +                            enum iio_event_direction dir, int state)
> > > > +{
> > > > +     int ret;
> > > > +     unsigned int mask, field_value;
> > > > +
> > > > +     /*
> > > > +      * Tap interrupts can be configured only in normal mode.
> > > > +      * See table in section 4.3 "Power modes - performance modes" of
> > > > +      * datasheet v1.2.
> > > > +      */
> > > > +     if (data->power_mode != POWER_MODE_NORMAL)
> > > > +             return -EINVAL;
> > > > +
> > > > +     /*
> > > > +      * Tap interrupts are operating with the data rate of 200Hz.
> > > > +      * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
> > > > +      */
> > > > +     if (data->sample_freq.hz != 200) {
> > > > +             dev_err(data->dev, "Invalid data rate for tap interrupts.\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     ret = regmap_update_bits(data->regmap, BMA400_INT12_MAP_REG,
> > > > +                              BMA400_S_TAP_MSK,
> > > > +                              FIELD_PREP(BMA400_S_TAP_MSK, state));
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     switch (dir) {
> > > > +     case IIO_EV_DIR_SINGLETAP:
> > > > +             mask = BMA400_S_TAP_MSK;
> > > > +             set_mask_bits(&field_value, BMA400_S_TAP_MSK,
> > > > +                           FIELD_PREP(BMA400_S_TAP_MSK, state));
> > > > +             break;
> > > > +     case IIO_EV_DIR_DOUBLETAP:
> > > > +             mask = BMA400_D_TAP_MSK;
> > > > +             set_mask_bits(&field_value, BMA400_D_TAP_MSK,
> > > > +                           FIELD_PREP(BMA400_D_TAP_MSK, state));
> > > > +             break;
> > > > +     default:
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG1_REG, mask,
> > > > +                              field_value);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     set_mask_bits(&data->tap_event_en, mask, field_value);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int bma400_disable_adv_interrupt(struct bma400_data *data)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     ret = regmap_write(data->regmap, BMA400_INT_CONFIG0_REG, 0);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     ret = regmap_write(data->regmap, BMA400_INT_CONFIG1_REG, 0);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     data->tap_event_en = 0;
> > > > +     data->generic_event_en = 0;
> > > > +     data->step_event_en = 0;
> > > > +     data->activity_event_en = 0;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  static int bma400_write_event_config(struct iio_dev *indio_dev,
> > > >                                    const struct iio_chan_spec *chan,
> > > >                                    enum iio_event_type type,
> > > > @@ -1111,10 +1221,20 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
> > > >
> > > >       switch (chan->type) {
> > > >       case IIO_ACCEL:
> > > > -             mutex_lock(&data->mutex);
> > > > -             ret = bma400_activity_event_en(data, dir, state);
> > > > -             mutex_unlock(&data->mutex);
> > > > -             return ret;
> > > > +             switch (type) {
> > > > +             case IIO_EV_TYPE_MAG:
> > > > +                     mutex_lock(&data->mutex);
> > > > +                     ret = bma400_activity_event_en(data, dir, state);
> > > > +                     mutex_unlock(&data->mutex);
> > > > +                     return ret;
> > > > +             case IIO_EV_TYPE_GESTURE:
> > > > +                     mutex_lock(&data->mutex);
> > > > +                     ret = bma400_tap_event_en(data, dir, state);
> > > > +                     mutex_unlock(&data->mutex);
> > > > +                     return ret;
> > > > +             default:
> > > > +                     return -EINVAL;
> > > > +             }
> > > >       case IIO_STEPS:
> > > >               mutex_lock(&data->mutex);
> > > >               ret = bma400_steps_event_enable(data, state);
> > > > @@ -1159,8 +1279,8 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
> > > >       struct bma400_data *data = iio_priv(indio_dev);
> > > >       int ret, reg;
> > > >
> > > > -     switch (chan->type) {
> > > > -     case IIO_ACCEL:
> > > > +     switch (type) {
> > > > +     case IIO_EV_TYPE_MAG:
> > > >               reg = get_gen_config_reg(dir);
> > > >               if (reg < 0)
> > > >                       return -EINVAL;
> > > > @@ -1196,6 +1316,25 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
> > > >               default:
> > > >                       return -EINVAL;
> > > >               }
> > > > +     case IIO_EV_TYPE_GESTURE:
> > > > +             switch (info) {
> > > > +             case IIO_EV_INFO_VALUE:
> > > > +                     ret = regmap_read(data->regmap, BMA400_TAP_CONFIG,
> > > > +                                       val);
> > > > +                     if (ret)
> > > > +                             return ret;
> > > > +                     *val = FIELD_GET(BMA400_TAP_SEN_MSK, *val);
> > >
> > > I'd prefer a local variable for regval into which the regmap_read goes.
> > >
> > > Slightly more readable that way as *val then only ever means one thing.
> > >
> > > > +                     return IIO_VAL_INT;
> > > > +             case IIO_EV_INFO_PERIOD:
> > > > +                     ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
> > > > +                                       val);
> > > > +                     if (ret)
> > > > +                             return ret;
> > > > +                     *val = FIELD_GET(BMA400_TAP_QUIET_MSK, *val);
> > > > +                     return IIO_VAL_INT;
> > > > +             default:
> > > > +                     return -EINVAL;
> > > > +             }
> > > >       default:
> > > >               return -EINVAL;
> > > >       }
> > > > @@ -1209,10 +1348,10 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
> > > >                                   int val, int val2)
> > > >  {
> > > >       struct bma400_data *data = iio_priv(indio_dev);
> > > > -     int reg, ret;
> > > > +     int reg, ret, quiet_period;
> > > >
> > > > -     switch (chan->type) {
> > > > -     case IIO_ACCEL:
> > > > +     switch (type) {
> > > > +     case IIO_EV_TYPE_MAG:
> > > >               reg = get_gen_config_reg(dir);
> > > >               if (reg < 0)
> > > >                       return -EINVAL;
> > > > @@ -1228,7 +1367,6 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
> > > >               case IIO_EV_INFO_PERIOD:
> > > >                       if (val < 1 || val > 65535)
> > > >                               return -EINVAL;
> > > > -
> > >
> > > Clear out this noise.
> > >
> > > >                       mutex_lock(&data->mutex);
> > > >                       put_unaligned_be16(val, &data->duration);
> > > >                       ret = regmap_bulk_write(data->regmap,
> > > > @@ -1248,6 +1386,31 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
> > > >               default:
> > > >                       return -EINVAL;
> > > >               }
> > > > +     case IIO_EV_TYPE_GESTURE:
> > > > +             switch (info) {
> > > > +             case IIO_EV_INFO_VALUE:
> > > > +                     if (val < 0 || val > 7)
> > > > +                             return -EINVAL;
> > > > +
> > > > +                     return regmap_update_bits(data->regmap,
> > > > +                                               BMA400_TAP_CONFIG,
> > > > +                                               BMA400_TAP_SEN_MSK,
> > > > +                                               FIELD_PREP(BMA400_TAP_SEN_MSK,
> > > > +                                                          val));
> > > > +
> > > > +             case IIO_EV_INFO_PERIOD:
> > > > +                     quiet_period = (val / 20) - 3;
> > > > +                     if (quiet_period < 0 || quiet_period > 3)
> > > > +                             return -EINVAL;
> > > > +
> > > > +                     return regmap_update_bits(data->regmap,
> > > > +                                               BMA400_TAP_CONFIG1,
> > > > +                                               BMA400_TAP_QUIET_MSK,
> > > > +                                               FIELD_PREP(BMA400_TAP_QUIET_MSK,
> > > > +                                                          quiet_period));
> > > > +             default:
> > > > +                     return -EINVAL;
> > > > +             }
> > > >       default:
> > > >               return -EINVAL;
> > > >       }
> > > > @@ -1287,6 +1450,7 @@ static const struct iio_info bma400_info = {
> > > >       .write_event_config = bma400_write_event_config,
> > > >       .write_event_value = bma400_write_event_value,
> > > >       .read_event_value = bma400_read_event_value,
> > > > +     .event_attrs = &bma400_event_attribute_group,
> > > >  };
> > > >
> > > >  static const struct iio_trigger_ops bma400_trigger_ops = {
> > > > @@ -1350,6 +1514,32 @@ static irqreturn_t bma400_interrupt(int irq, void *private)
> > > >       if (ret || !data->status)
> > > >               goto unlock_err;
> > > >
> > > > +     /*
> > > > +      * Disable all advance interrupts if interrupt engine overrun occurs.
> > > > +      * See section 4.7 "Interrupt engine overrun" in datasheet v1.2.
> > > > +      */
> > > > +     if (FIELD_GET(BMA400_INT_ENG_OVRUN_MSK, le16_to_cpu(data->status))) {
> > > > +             bma400_disable_adv_interrupt(data);
> > > > +             dev_err(data->dev, "Interrupt engine overrun\n");
> > > > +             goto unlock_err;
> > > > +     }
> > > > +
> > > > +     if (FIELD_GET(BMA400_INT_S_TAP_MSK, le16_to_cpu(data->status)))
> > > > +             iio_push_event(indio_dev,
> > > > +                            IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > > +                                               IIO_MOD_X_OR_Y_OR_Z,
> > > > +                                               IIO_EV_TYPE_GESTURE,
> > > > +                                               IIO_EV_DIR_SINGLETAP),
> > > > +                            timestamp);
> > > > +
> > > > +     if (FIELD_GET(BMA400_INT_D_TAP_MSK, le16_to_cpu(data->status)))
> > > > +             iio_push_event(indio_dev,
> > > > +                            IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > > > +                                               IIO_MOD_X_OR_Y_OR_Z,
> > > > +                                               IIO_EV_TYPE_GESTURE,
> > > > +                                               IIO_EV_DIR_DOUBLETAP),
> > > > +                            timestamp);
> > > > +
> > > >       if (FIELD_GET(BMA400_INT_GEN1_MSK, le16_to_cpu(data->status)))
> > > >               ev_dir = IIO_EV_DIR_RISING;
> > > >
> > >
>
