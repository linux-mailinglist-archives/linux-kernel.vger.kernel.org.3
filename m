Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58EA4BB464
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiBRIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:40:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiBRIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:40:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2666265136;
        Fri, 18 Feb 2022 00:39:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h18so14197077edb.7;
        Fri, 18 Feb 2022 00:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g5OkeuTfr4KZRQqShhSXo68jRGfkegJkXmtaiGdTszU=;
        b=UWW0dS9gtbq8WhED+3o0WdFpnplxoP319PmrWBzjgyzl01jB3ogcJX4i1IM4uq0qho
         42d4OTMKmZsu/LXQFoaySdSVthS+iOXz3xmV0FzmRK+RXd+oudRkXb5bwFxps0kaYfDD
         9CUoTr06wJ4/wIbuPLj2Mmj24ch8eGuNtQP7UnaGGxfWSigHOMGASy0BjdAQHPCHmg5B
         2QfyVOKFzMm8v18dTcRi/MYPbn/Z8/qwY5c9Y/DQ0wCCzBv4ekJODW/vtZ3tfmY5dLDU
         0CQ6u42s0rBWZnfE8MYMTQZhBYfJQrDp8/7/jG8Bu2FONF/poAidFjURyIfkCzVLOjqO
         sdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g5OkeuTfr4KZRQqShhSXo68jRGfkegJkXmtaiGdTszU=;
        b=fVHtN5t1yFuQxcgEdg0DyVBW0BtNr7o2DaO2Pp5vNV12X6epCDEQW1GUMSMDJs6cMw
         0AGXfPOiBivt3RZpUZCWWPzMwRdoHtzTskc0IxefzyF7Q/BJyt8RjuHHjs9SNCP/6b7f
         VT9+zuLEaMASREx+yk7WruqTi01EKDglYJzcgFmH23PcrN74wfkvf0TuHG2iVoAPsIgT
         fpviJvaYe+q+4gMsaVGWBmAm5GWY8Foz+K1T/meT1cxCKv3f9WMq/reyYxXQgz5QCr//
         3eVTGP211FYXK1t9Fay2+nqv2HUfLYNmB4hMtmQuUIlF9b2XuvD600TWHvC7q2WM2kx1
         08Bg==
X-Gm-Message-State: AOAM533FOj20/TJ27k68RvKnUqLihHWxcMMYrF/jvkWIpfEjHPEQngwy
        2WyJNnd8jWBwMGYdxY8HmL0YAOBPIDamBBcH434=
X-Google-Smtp-Source: ABdhPJwyTqV3pg/0GVBz6HN/kTpPD64M8SxNGxlJaHFLeJoOxVTqGqOd7MhrTtAW/s+f2u14vypGQ0RyZ8+mH2VfLkY=
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id
 r24-20020a056402019800b0041083e321d7mr7000565edv.159.1645173590335; Fri, 18
 Feb 2022 00:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217055208.2388929-1-kai.heng.feng@canonical.com>
 <CAHp75VfFGw3b_ZtQir0AfTfXfQ7fi_LKLsY-7ww=4+MMBR8BAQ@mail.gmail.com> <CAAd53p7O7joFa7MH0s+rw-59WQkigvjKBf1bpO9e2gX9ddjF-A@mail.gmail.com>
In-Reply-To: <CAAd53p7O7joFa7MH0s+rw-59WQkigvjKBf1bpO9e2gX9ddjF-A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Feb 2022 09:39:14 +0100
Message-ID: <CAHp75Vf4pjyJJDLKWTjq2ny1xkF9fSCSPb_8q5yk69DjV9EUAg@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: adxl345: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 4:46 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Thu, Feb 17, 2022 at 6:57 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thursday, February 17, 2022, Kai-Heng Feng <kai.heng.feng@canonical.=
com> wrote:

...

> >> +               acpi_id =3D acpi_match_device(dev->driver->acpi_match_=
table, dev);
> >> +               if (acpi_id) {
> >> +                       type =3D acpi_id->driver_data;
> >> +                       name =3D acpi_id->id;
> >> +               } else
> >> +                       return -ENODEV;
> >
> > Thanks, but can we do this in ACPI agnostic way?
> >
> > Can be as simple as
> >
> > if (id)
> >   ...
> > else {
> >   match =3D device_get_match_data(dev);
> >   if (!match)
> >     return -ENODEV;
> > }
> >
> > Note, it might require to reconsider what is put in the driver data (ei=
ther convert to pointers, or be sure that valid type is never a 0/NULL).
>
> Unlike acpi_match_device(), device_get_match_data() only get
> driver_data, so we need a new struct to provide both name and type.

It's unfortunate. Let me think about it a bit more.

> > Also note, in both cases using ID name for name us fragile. Probably we=
 have to fix that first. Let me check today=E2=80=99s evening.
>
> Can you please explain more on this? How does ID name make it fragile?

I thought this one is used somehow by userspace to distinguish the
instance of the device, but looking into the rest of the IIO drivers
it seems more or less  a field for part number. That said, the ID is
okay to use. I hope Jonathan may correct me.

--=20
With Best Regards,
Andy Shevchenko
