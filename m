Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9951F3D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 07:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiEIFUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiEIFQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:16:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2567D106378;
        Sun,  8 May 2022 22:11:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k14so11104771pga.0;
        Sun, 08 May 2022 22:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGZmqn95QjN/qQTGFUiFVtHJQxgf+VYGBD6+xA+EjNE=;
        b=KRwaVbVyrF/6vmMixLxzQ8wLEGua3FYlpXNOs6UImejFBpJuzXXLfq4QxtTsoSiI46
         yH2JYGFETIzwdtr9W2jxjC0Y9TETYfk9R49Z3Rq7AkHw3gIwAzWBc2TRBApyxRKQWtpa
         Be49+n5xkzwZUOaIBvpw4rMTzS1We6objPhMTE/vF5ilRaJ537OL7ZSGU4mkw+UdBDKn
         ahAxHX+iW8HMqZsGvPtzem3jM9Kofr09L+m45MEXUb8npcohtRoPt0TCLABMVJEXiPyN
         wAwTzngtaKT8y5VlH5xhXJPnrSppCRy4/CsH5tdN1815AIYYy9HkVLQjGqA8PdFO36I+
         /IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGZmqn95QjN/qQTGFUiFVtHJQxgf+VYGBD6+xA+EjNE=;
        b=g1lzeGyS4LRxnirktiBiaN8aCNl+Tdb8TIdrKxE8aBYXx/HDSX5YDwzt6fvjliVrql
         oTQo5icN1UxwD7kFgHKHUFsBvp9Po1of8LUNW2QzmHPXc+gAjcV/Zy3BM1t36FzaFJrR
         EN8d2QDEzVmBTon1aXF2wF+/T8pzBKoz11LGFXL6WUM02ebDHpclpTh+b29j9ygiDlIz
         v+1Kzihm9ABYjw5mOuqi1JExNi9YMICOddxlBxK0BM36czO1c68M6jx7N8GtwBrsrl7Q
         A9o7Q1zoS9aWqPIiyIc1zPWTeoj1jN9EZbH9vuo0wx4LWQ49IwAghEts4Z+Q4w+Hnv6T
         vhCQ==
X-Gm-Message-State: AOAM532uFO0FZD4rlQVhfYof605ctEoUzRQ0xbJf7AljWCiIVhNhsM3V
        wvnR6Da7U87klV8dcpu1pghMWGqtwlBLtPMpMKA=
X-Google-Smtp-Source: ABdhPJxaG01u4iun8Jf9TsVEL7DMZ3YKhZaqDTKiKWhr4nRtNR90FQxsWi5R2/R4n9hZQzv0BFHoBUjpB3a4eFUTnAI=
X-Received: by 2002:a63:8ac9:0:b0:3ab:dab:16b4 with SMTP id
 y192-20020a638ac9000000b003ab0dab16b4mr12121953pgd.129.1652073115434; Sun, 08
 May 2022 22:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220505133021.22362-1-jagathjog1996@gmail.com>
 <20220505133021.22362-10-jagathjog1996@gmail.com> <20220507172416.0c74d4cb@jic23-huawei>
In-Reply-To: <20220507172416.0c74d4cb@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Mon, 9 May 2022 10:41:44 +0530
Message-ID: <CAM+2EuLYRGmhgWHiwZOwFSR9ssSOVwgm5gwVBHD=p57OF5e86A@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] iio: Add channel for tap and new modifiers for
 single and double tap
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

Thanks for accepting the patches.

On Sat, May 7, 2022 at 9:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu,  5 May 2022 19:00:20 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Strangely the last time I can remember discussion around how to
> support tap detection was way back in the early days of IIO, perhaps
> 10 years ago. I don't recall us ever coming to a conclusion on how to do it.
>
> > Add new channel type for tap and also add new modifiers for single and
> > double tap. This channel and modifiers may be used by accelerometer
> > sensors to express single and double tap events. For directional tap,
> > modifiers like IIO_MOD_(X/Y/Z) can be used along with rising and
> > falling direction.
>
> Not sure how that would work seeing as there is only one modifier
> field and it's not a bitmap.
> The event code would need to encode both what type of tap and
> the direction and there aren't two fields in which to do that.
>
> One way I can see this 'might' work would be to use
> the event type to encode tap and the direction could be 'abused'
> to encode single vs double (or other events like this)
>
> in_accel_x_tap_single
> in_accel_x_tap_double
>
> We could possibly be more generic and have the 'type' as
> 'event' or something like that allowing us to use the
> 7 bit direction field to encode different detectable events
> (I'm not that keen on the name event though, could maybe
> map it to gesture which would cover some of the other
> motion pattern detection devices out there)
>
> That would give us
>
> in_accel_x_event_singletap
> in_accel_y_event_doubletap
>
> etc.
>
> How ever we move forwards we do it this want to be in a new series with a nice
> bold title to attract that attention of people who don't really
> care about he bma400 but do care about tap detection; it's
> a common feature of accelerometers.

Sure, I will try to make a new series for tap events with the given
inputs and send the RFC first to get all the comments from everyone.

>
> Jonathan
>
>
>
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
>
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
> >  drivers/iio/industrialio-core.c         |  3 +++
> >  include/uapi/linux/iio/types.h          |  3 +++
> >  tools/iio/iio_event_monitor.c           |  6 ++++++
> >  4 files changed, 23 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index d4ccc68fdcf0..bf2d10d6ad9b 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2030,3 +2030,14 @@ Description:
> >               Available range for the forced calibration value, expressed as:
> >
> >               - a range specified as "[min step max]"
> > +
> > +What:                /sys/.../events/in_tap_single_change_en
> > +What:                /sys/.../events/in_tap_double_change_en
> > +KernelVersion:       5.19
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Accelerometer device detects single or double taps and generate
> > +             events when threshold for minimum tap amplitide passes.
> > +             E.g. a single tap event is generated when acceleration value
> > +             crosses the minimum tap amplitude value set. Where tap threshold
> > +             value is set by using in_tap_change_value.
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index e1ed44dec2ab..9b0d7bbd07fc 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -87,6 +87,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >       [IIO_POSITIONRELATIVE]  = "positionrelative",
> >       [IIO_PHASE] = "phase",
> >       [IIO_MASSCONCENTRATION] = "massconcentration",
> > +     [IIO_TAP] = "tap"
> >  };
> >
> >  static const char * const iio_modifier_names[] = {
> > @@ -134,6 +135,8 @@ static const char * const iio_modifier_names[] = {
> >       [IIO_MOD_ETHANOL] = "ethanol",
> >       [IIO_MOD_H2] = "h2",
> >       [IIO_MOD_O2] = "o2",
> > +     [IIO_MOD_TAP_SINGLE] = "single",
> > +     [IIO_MOD_TAP_DOUBLE] = "double",
> >  };
> >
> >  /* relies on pairs of these shared then separate */
> > diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> > index 472cead10d8d..d1e61c84e0d5 100644
> > --- a/include/uapi/linux/iio/types.h
> > +++ b/include/uapi/linux/iio/types.h
> > @@ -47,6 +47,7 @@ enum iio_chan_type {
> >       IIO_POSITIONRELATIVE,
> >       IIO_PHASE,
> >       IIO_MASSCONCENTRATION,
> > +     IIO_TAP,
> >  };
> >
> >  enum iio_modifier {
> > @@ -95,6 +96,8 @@ enum iio_modifier {
> >       IIO_MOD_ETHANOL,
> >       IIO_MOD_H2,
> >       IIO_MOD_O2,
> > +     IIO_MOD_TAP_SINGLE,
> > +     IIO_MOD_TAP_DOUBLE,
> >  };
> >
> >  enum iio_event_type {
> > diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> > index 2f4581658859..7fa7d4285f40 100644
> > --- a/tools/iio/iio_event_monitor.c
> > +++ b/tools/iio/iio_event_monitor.c
> > @@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
> >       [IIO_POSITIONRELATIVE] = "positionrelative",
> >       [IIO_PHASE] = "phase",
> >       [IIO_MASSCONCENTRATION] = "massconcentration",
> > +     [IIO_TAP] = "tap",
> >  };
> >
> >  static const char * const iio_ev_type_text[] = {
> > @@ -122,6 +123,8 @@ static const char * const iio_modifier_names[] = {
> >       [IIO_MOD_PM4] = "pm4",
> >       [IIO_MOD_PM10] = "pm10",
> >       [IIO_MOD_O2] = "o2",
> > +     [IIO_MOD_TAP_SINGLE] = "single",
> > +     [IIO_MOD_TAP_DOUBLE] = "double",
> >  };
> >
> >  static bool event_is_known(struct iio_event_data *event)
> > @@ -164,6 +167,7 @@ static bool event_is_known(struct iio_event_data *event)
> >       case IIO_POSITIONRELATIVE:
> >       case IIO_PHASE:
> >       case IIO_MASSCONCENTRATION:
> > +     case IIO_TAP:
> >               break;
> >       default:
> >               return false;
> > @@ -215,6 +219,8 @@ static bool event_is_known(struct iio_event_data *event)
> >       case IIO_MOD_PM4:
> >       case IIO_MOD_PM10:
> >       case IIO_MOD_O2:
> > +     case IIO_MOD_TAP_SINGLE:
> > +     case IIO_MOD_TAP_DOUBLE:
> >               break;
> >       default:
> >               return false;
>
