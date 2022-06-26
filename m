Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9855B244
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiFZNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiFZNWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 09:22:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4BE0EC;
        Sun, 26 Jun 2022 06:22:07 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 68so6672373pgb.10;
        Sun, 26 Jun 2022 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SQY7O4NK/F4WowPtOoM0TY83tF17ZTiYqKFA7f+7XA=;
        b=OBhYWevba/qLxkScco4KRQgaAMDBolxOfQeTnuMncUOEJXmtNjX2pl18Cogf9K+OA1
         xdLvtsFNzwMGYB9nZ5uiCNgKBpBydrDY8MD4OvWwgg4bmO+F+eDpkTzbXZmaswvnhAsv
         H7+xsRyuJRhfttzQ08G1YrD2KH/gYCkms0qQdJA1SfqKykNSx1487Ygb02P4fSUgC5uR
         oPiBPNbfg67T8C1iSRyRyRM+KNrWwjVHB6eC6QF33s3cchfy+khP9AWY4LBi8TgoHWPS
         0hvv0HL+8f9XcsE2jXR4ZPiEcDpo7ixm/M4WAWGKWy3vAdrlfTovi5J9f6LkcwqHHIdH
         DHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SQY7O4NK/F4WowPtOoM0TY83tF17ZTiYqKFA7f+7XA=;
        b=HcWxWm7kW6L6CixLB5gJA9g4X1ILdRNM87q2q4tsyjKx5wYOth3zklvjJZpihDyhY+
         bGeHcoRaoBLy2FbM/VSSO9qQB2SlC2dC36/fvCCLSGAspoNwcpLqWpcZaS4XvJ//HlnC
         uiu/NGHrd75EK1NcfkqMpxXgHmwItgyeOoF5DRVUipDxItpLei6Nwn+rMEF6gMBtz9WO
         MX3Arn1emCQP124EwFGNG9OXFQw/Z8tRPP2W2YoKimFXNpCqwh8DntFE3C5PaTHF+0Ub
         Ba/t5N8uhFeGCbgyJKuXMmdMl4rNAe9tZmrMdSmRiP+rhBm5pVmPqSVU2/k8Ey+jCcvb
         IOXA==
X-Gm-Message-State: AJIora/xRW0tNqlDY9JFWdxDwqZSJZYnBdfGDamQsvZ9Zo62tu0a6xgw
        hD6oV3++IX4vVdaJLhNqyol5Z88JFeq3DOP/wg4=
X-Google-Smtp-Source: AGRyM1uMhhmGCrrtlpgGGePWwMcdNFA6SM9+vbHdU5d5ot4X3ipaNz44XhjsC4CbvEv+3X7IS5zJ9+ZUtc9WrV3PMQE=
X-Received: by 2002:a63:85c2:0:b0:40d:34b5:5f8d with SMTP id
 u185-20020a6385c2000000b0040d34b55f8dmr7874091pgd.129.1656249726421; Sun, 26
 Jun 2022 06:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220613191706.31239-1-jagathjog1996@gmail.com>
 <20220613191706.31239-2-jagathjog1996@gmail.com> <20220619135427.4ffc2d3d@jic23-huawei>
In-Reply-To: <20220619135427.4ffc2d3d@jic23-huawei>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Sun, 26 Jun 2022 18:51:54 +0530
Message-ID: <CAM+2EuJWEOn-Vtaox=G3zXcd+zpx=mAhY1YHuNJx2XpAyPB1xg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: Add new event type gesture and use direction
 for single and double tap
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

Sorry for the delay in replying.

On Sun, Jun 19, 2022 at 6:15 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 14 Jun 2022 00:47:05 +0530
> Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> > Add new event type for tap called gesture and the direction can be used
> > to differentiate single and double tap. This may be used by accelerometer
> > sensors to express single and double tap events. For directional tap,
> > modifiers like IIO_MOD_(X/Y/Z) can be used along with singletap and
> > doubletap direction.
> >
> > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
>
> Hi,
>
> With fresh eyes I think we need to rethink the use of _period to make sure
> we have 'space' for another very like ABI element which is the maximum
> time between events for them to be considered a double tap.
>
> Jonathan
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
> >  drivers/iio/industrialio-event.c        |  5 ++++-
> >  include/uapi/linux/iio/types.h          |  3 +++
> >  tools/iio/iio_event_monitor.c           |  8 +++++++-
> >  4 files changed, 38 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 3e00d7f7ee22..4eaf85e01911 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2035,3 +2035,27 @@ Description:
> >               Available range for the forced calibration value, expressed as:
> >
> >               - a range specified as "[min step max]"
> > +
> > +What:                /sys/.../events/in_accel_gesture_singletap_en
> > +What:                /sys/.../events/in_accel_gesture_doubletap_en
> > +KernelVersion:       5.19
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Device generates an event on a single or double tap.
> > +
> > +What:                /sys/.../events/in_accel_gesture_singletap_value
> > +What:                /sys/.../events/in_accel_gesture_doubletap_value
> > +KernelVersion:       5.19
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Specifies the threshold value that the device is comparing
> > +             against to generate the tap gesture event. Units and exact
> > +             meaning of value are device specific.
>
> I'm fine with this one being device specific, as likely a complex alg
> involved.
>
> > +
> > +What:                /sys/.../events/in_accel_gesture_doubletap_period
> > +KernelVersion:       5.19
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Minimum time period between before and after the double tap
> > +             event. Units and exact meaning of period value are device
> > +             specific.
>
> I think the units need to be standard.  Also would this work better
> as a description?
>
>         Minimum time in seconds between the two taps making up a double
>         tap event.

The values for the time between the two taps are not in terms of seconds,
here period value is in terms of data samples which depends on
the data rate.

>
> Raises a question though. How would we specify the maximum time? I.e.
> if taps are further apart than Xseconds, they are reported as two single
> taps.
>
> Maybe reusing period here isn't a good idea and we need to have new ABI for
> this?
>
>
>
>
