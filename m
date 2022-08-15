Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5563593827
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbiHOTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245089AbiHOTDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:03:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE64357F7;
        Mon, 15 Aug 2022 11:34:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id jm11so4845059plb.13;
        Mon, 15 Aug 2022 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aKqmajQ9X+EYzsYtEXOQFkHP1rwVZnhO5f2qFoxc1VE=;
        b=BmF6atkwIPKXb6BsniFXPjql0MUeyRBrbnS1/YGf2d2mz2fta+bfm3CO4Puzpy9Vc6
         Xq+txbm9ZPu99JX5OTQcuv0KiuNZIGMMbB9ehIM3vCGewBVQK8BLLFihFf2/yKM2R6p4
         jntZcnwMXUAkRSRhBjvuPnouf+b5JhzPxSnBVEZ6QhtVAR6ZpBUGtagIECE30D7bjjDH
         S2q73rOnErwSdWf+1iXdaktG4Or8cKh3NiCCFJ82qbbwn/4N3ittI4ec996wrryFcLRC
         Eq2bx/BEbGNDlPXPKgKDbBMcVrTpOB2g0U3i1NwlxoAhbpbw/kiu/j1bTcr25KQjTIHb
         JdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aKqmajQ9X+EYzsYtEXOQFkHP1rwVZnhO5f2qFoxc1VE=;
        b=eW3hzj1Tr/ZCHtl8m5yzD8jC0pYO7auIAOJ606QNsv9BimoPntM4sxdqN+cePwTRLI
         ZdhhsM9fRP/Fps3mJwvrjEcpCi9ZFf0uEJGVHTbC3xTneezkoY8lF+mALGNFdIETDRLI
         pBv35VOH5Ud3bCMvZvSWGcU7dLlBvq8nViy7tqgSfb5tuUtH9DXlP0rRGwmAVjdxYBdQ
         HNA2vagPUxaL2wrz6bb4vhG2298qo6zgBAZGqNB0S2DTv5bF9IIIQCfm2XUd9Dfm2vFf
         aGvTQu4JLWk22QU4CujRdspVNMQtdN/UuVRmaqG4fjEsrbP3O/DVh26le/erbx4vD61g
         iuxQ==
X-Gm-Message-State: ACgBeo2IWDyixGmptDTkrIxlpYnjBbL11YM0Snzfzhi0nUbXKaaEpQW7
        chr46j2o6h+8e4FQgjCBgB/ZBbnKXkG5ftlEuygAwL5yJqo=
X-Google-Smtp-Source: AA6agR4GbyJlO7YOnmFCtWHmVv8XGdHtHQKpmW2JZwowFjFLQsWJ1WdTNi1d5MWhLR/SXsdZ6mhB/x/PuQXrbWp6zdQ=
X-Received: by 2002:a17:902:d2c6:b0:16e:d285:c602 with SMTP id
 n6-20020a170902d2c600b0016ed285c602mr18077608plc.81.1660588439508; Mon, 15
 Aug 2022 11:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220813071803.4692-1-jagathjog1996@gmail.com>
 <20220813071803.4692-2-jagathjog1996@gmail.com> <20220814180451.44a27126@jic23-huawei>
In-Reply-To: <20220814180451.44a27126@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Tue, 16 Aug 2022 00:03:47 +0530
Message-ID: <CAM+2EuJu3g98NOt2tOxPzWnGO3kvFNkruuAeZBd-=VxYvw7x9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: Add new event type gesture and use direction
 for single and double tap
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     andy.shevchenko@gmail.com, hadess@hadess.net, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Aug 14, 2022 at 10:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 13 Aug 2022 12:48:02 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Add new event type for tap called gesture and the direction can be used
> > to differentiate single and double tap. This may be used by accelerometer
> > sensors to express single and double tap events. For directional tap,
> > modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> > doubletap direction.
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> Hi Jagath,
>
> This ABI is definitely something I want more eyes than ours on, so
> whatever happens I'll leave it on the list for a few weeks.

Sure, I will leave KernelVersion blank in the next series.

>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 41 +++++++++++++++++++++++++
> >  drivers/iio/industrialio-event.c        |  7 ++++-
> >  include/linux/iio/types.h               |  2 ++
> >  include/uapi/linux/iio/types.h          |  3 ++
> >  tools/iio/iio_event_monitor.c           |  8 ++++-
> >  5 files changed, 59 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index e81ba6f5e1c8..54cb925f714c 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2038,3 +2038,44 @@ Description:
> >               Available range for the forced calibration value, expressed as:
> >
> >               - a range specified as "[min step max]"
> > +
> > +What:                /sys/.../events/in_accel_gesture_singletap_en
> > +What:                /sys/.../events/in_accel_gesture_doubletap_en
> > +KernelVersion:       5.21
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Device generates an event on a single or double tap.
> > +
> > +What:                /sys/.../events/in_accel_gesture_singletap_value
> > +What:                /sys/.../events/in_accel_gesture_doubletap_value
> > +KernelVersion:       5.21
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Specifies the threshold value that the device is comparing
> > +             against to generate the tap gesture event. Units and exact
> > +             meaning of value are device specific.
>
> I wonder if we should list a direction?  As in smaller is more sensitive?

Yeah in most of the devices which support tap, this value represents the
threshold, the lower the value higher the tap sensitivity. I will add it to the
description in the next series.

> (at least to first approximation)
Do I need to add available attributes into ABI docs?

> That way a user would at least be able to consistently decide if they should
> raise or lower the number to get the perf the want.
>
> > +
> > +What:                /sys/.../events/in_accel_gesture_singletap_reset_timeout
> > +What:                /sys/.../events/in_accel_gesture_doubletap_reset_timeout
> > +KernelVersion:       5.21
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Specifies the timeout value in seconds for the tap detector
> > +             to not to look for another tap event after the event as
> > +             occoured. Basically the minimum quiet time between the two
> spelling.  occured

Sorry, I will correct this.

Thank you
Jagath

>
> > +             single-tap's or two double-tap's.
> > +
> > +What:                /sys/.../events/in_accel_gesture_doubletap_tap_2min_delay
>
> I'm not sure this naming is intuitive enough. Might be a simple
> as doubletap_tap2_min_delay?  My brain didn't parse 2min correctly.
>
> This one is a bit odd, so definitely want to hear more view points on whether
> this is general enough to cover sensors and intuitive enough that people
> have some hope of setting it right.
>
> > +KernelVersion:       5.21
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Specifies the minimum quiet time in seconds between the two
> > +             taps of a double tap.
> > +
> > +What:                /sys/.../events/in_accel_gesture_maxtomin_time
> > +KernelVersion:       5.21
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Specifies the maximum time difference allowed between upper
> > +             and lower peak of tap to consider it as the valid tap event.
> > +             Units in seconds.
> Needs to be associated with 'tap' in the naming.
> Easiest is probably only to define it as
> singletap_maxtomin_time + doubletap_maxtomin_time and not have the
> shared version as we'd lose the 'tap' part of the name.
>
>
