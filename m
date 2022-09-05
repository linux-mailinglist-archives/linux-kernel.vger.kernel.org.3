Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1628C5AD8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiIESE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiIESEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:04:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D338F;
        Mon,  5 Sep 2022 11:04:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z8so12241085edb.6;
        Mon, 05 Sep 2022 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3C/5tWJzLnB1uE6HL3jJHlbk4fX0FVnZnTVN3xVcPmI=;
        b=UiIazjEkKmRM+x0DfJ6Vk+Bl7Ev6hqDCSjisqWYrV2B/uOnjhmKHz00Uw5uWJ0MJGI
         wM8Nl/NLVJoVdxTi1eqlUghyVfSeV1j6nOsih6vqmKtLbjss6B8TAuNO4sUfX3hgfVhr
         ni2waPQeYE2MKe5tJGZtSZG2NAeoqYn/dOvsdD+i95K+hn3qBtZBlBXI/CvedeqpoT4k
         lGMSAarIa4JNNd0DftcTaCUsIbKw8B9viYKUY73vG8wj+Ckg/fN/ifDTYbasD8OHT3mr
         qSQkersOHBMB0uLN+uaVOwb63Hn6TDogW20zjoP9hMnnZFcDbYSSPZGwDDomnvM1hKEZ
         63gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3C/5tWJzLnB1uE6HL3jJHlbk4fX0FVnZnTVN3xVcPmI=;
        b=WxeNPD64my9ijFlNAE2ZnGypupq4YJP7MqI42/onfbY06qp0Ep/mUMnnA5z0nM3M4J
         BKZRCc/OijaUduGuhVpsQE743lRzkEqap9phLZW79OoUJUPn9KFgcUO8mmwjOEkK+XPx
         Ck9XibsPYBe1cVeQ925jgjzexcmg4vZQ1bY7YprI7W1ZWkccyEGehR1xA0uHBi8fcw+U
         KuCXldniBB3SpKECVVRR+QpdmIg4L9NzcFj8djbhEg4JUnSrRxzSvazMlbPug6P8kf2n
         aaKc0QLo+wZSSGbsw0orbgBqoPS1ix/MlrpxtfKt3N29inGrURByQVUM0to1t32pZRSt
         e7fA==
X-Gm-Message-State: ACgBeo0pdNuPEzUqG3Cz5WuQWxSe8js7jkp3vzbmCABSMCeFoo2YJhz8
        MqZukSqde/zydHzueQjPXgSSbk0B9qQsIshA9oI=
X-Google-Smtp-Source: AA6agR4kpVggJLEnlqcW7ccGE3e2XeB/U3PfF4AlpO50c47FYYWf9zm0meONWHHZSke6F5OwYTA5peMlfQwrAkHoFjg=
X-Received: by 2002:a05:6402:17d7:b0:44e:95b0:3741 with SMTP id
 s23-20020a05640217d700b0044e95b03741mr3689380edy.281.1662401061871; Mon, 05
 Sep 2022 11:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220831063117.4141-1-jagathjog1996@gmail.com> <20220904173839.226167ad@jic23-huawei>
In-Reply-To: <20220904173839.226167ad@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Mon, 5 Sep 2022 23:34:09 +0530
Message-ID: <CAM+2Eu+fLvRQg0iJ13JV071khGeaFx_VnVpJrzGLw==iEyEzkg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] iio: Add single and double tap events support
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

Hi,

On Sun, Sep 4, 2022 at 10:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 31 Aug 2022 12:01:15 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > This patch series adds new event type for tap called gesture and direction
> > is used to differentiate single and double tap. This series adds single
> > and double tap support for bma400 accelerometer device driver.
>
> Applied to the togreg branch of iio.git and initially pushed out as testing
> for 0-day to see if it can find things we missed.
>
> I'm still open for comments on this if anyone interested has a chance to look
> at the ABI, but changes will need to come as patches after I push the
> tree out as non rebasing later this week.
>
> Thanks for your hard work on this Jagath - it's a hole that's been there
> a very long time so good to fill it in :)

Thank you Jonathan and Andy for your suggestions and the detailed review.

Jagath

>
>
> Jonathan
> >
> > Changes since v3
> > 1. Added a macro for the length of the tap configuration arrays.
> > 2. Corrected a grammar mistake.
> > 3. Arranged the local variables in reverse Xmas tree order.
> >
> > Changes since v2
> > 1. Replaced doubletap_tap_2min to doubletap_tap2_min.
> > 2. Added ABI docs for available attributes which lists tap configurations
> >    values.
> > 3. Added 'tap' in the naming of available attributes which are related to
> >    tap configurations.
> > 5. Added check for channel type in _read_event_value() and
> >    _write_event_value().
> > 6. KernelVersion changed to 6.1.
> > 7. Corrected typos.
> >
> > Changes since v1
> > 1. Included headers in alphabetical order.
> > 2. Changing tap_event_en variable name to tap_event_en_bitmask since it is
> >    used in bit manipulation operation.
> > 3. Assigning boolean value to step_event_en and activity_event_en instead
> >    of 0, since they are boolean type members.
> > 4. Using local variable for regmap_read() instead for *val itself.
> > 5. Correcting typos.
> > 6. Remove of IIO_EV_INFO_PERIOD.
> > 7. Now all 4 tap controls like threshold, quiet, tics_dt and quiet_dt can
> >    be configured from the userspace.
> > 8. Introducing new event info IIO_EV_INFO_RESET_TIMEOUT, and
> >    IIO_EV_INFO_TAP_2MIN_DELAY into iio_event_info.
> > 9. Creating custom read/write attributes for tics_dt called
> >    in_accel_gesture_maxtomin_time.
> > 10. Time based tap controls can be configured in seconds instead of raw
> >     values.
> > 11. Provided all available values for time base tap controls in seconds.
> > 12. Adding one more MODULE_AUTHOR().
> >
> > Changes since RFC
> > 1. Corrected the "quite" typo to "quiet".
> > 2. Added proper reference and name of the section from datasheet.
> > 3. Changed the ABI documentation to make it more generic.
> > 4. Added ABI documentation for double tap quiet period.
> > 5. Added available list by registering new event attribute for tap
> >    threshold values and double tap quiet period values.
> > 6. Sending both single and double tap events separately.
> > 8. Removed checking for tap enabled while changing data rate.
> > 9. Returning invalid with error message if the input data rate is not
> >    200Hz while enabling tap interrupts.
> > 7. Added datasheet reference for interrupt engine overrun.
> >
> > Jagath Jog J (2):
> >   iio: Add new event type gesture and use direction for single and
> >     double tap
> >   iio: accel: bma400: Add support for single and double tap events
> >
> >  Documentation/ABI/testing/sysfs-bus-iio |  69 +++++
> >  drivers/iio/accel/bma400.h              |  14 +
> >  drivers/iio/accel/bma400_core.c         | 343 +++++++++++++++++++++++-
> >  drivers/iio/industrialio-event.c        |   7 +-
> >  include/linux/iio/types.h               |   2 +
> >  include/uapi/linux/iio/types.h          |   3 +
> >  tools/iio/iio_event_monitor.c           |   8 +-
> >  7 files changed, 434 insertions(+), 12 deletions(-)
> >
>
