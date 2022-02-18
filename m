Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89B4BB922
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbiBRM2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:28:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiBRM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:28:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F32B267;
        Fri, 18 Feb 2022 04:27:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a8so14659893ejc.8;
        Fri, 18 Feb 2022 04:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPb78P3cqG/5JcH44Mpn0ycJuuynvsj5Ss8VpDQPK9I=;
        b=TwDVTkAZ8SfYmVdyLtAvlFgsUHoUXW/BG9tzx+JaeB7RnLE81imVoYVMV3RO6SNNC8
         nRPE8WorJTMsjvbiHTs/m0EfZIQEfZhGN+R3fji9bKz2FHTSqF+d0nKqrobgtSuP4d5n
         IBbWoJ+jr1kCzNaxOb/8Wl61oQuEl8Nd1DjqpWW6PiL/8yMaljrQgsIDbKQJOXkRtBA9
         R33fyTw28URzSd6QuZfbeHJGC0ojZHZsZ3T7oQfxYd7cw57FY8VlvI8Uvfg9oHg36Blz
         n80I4Vix49I69DUuPO0w2bKO8Z4jUmfQFryQ7ALiWs1KHWFWIwTMLbwP5TqVu2/HHeRk
         GkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPb78P3cqG/5JcH44Mpn0ycJuuynvsj5Ss8VpDQPK9I=;
        b=GGG8ODCbDPMmpa00HCH3DbHwuXi4mvKcD/ACZDH+IjJgH7JKRbPAKplnM6sfWcTvky
         ikZoz5qXpxq30bwWudTy3VlMphnTJuW1hDpn/hYZZqsHIw4jeGHkul6JyLT4RsJGYX62
         oTi4/+URnjKburUE/NZMZc6pCtHjRLGOwz7xNfnLQVKnowQXS8GXJQ3ClqWC4FkLR9Fm
         jmBRTUWAtFbHz0W/0sU2AKZ47aqrYJsGAQAnDBV8U59e9mL0GBP1c3d2oFTcZH5pqvc9
         egp6yxe/pzuMNHUYe69akxj6WpuTVZ6yC18q4i/rUGl2HmUxw1xNKoIs7I3ki2cu5Xsl
         pRsA==
X-Gm-Message-State: AOAM533BtP9zwPLTHEWRTj7dAXV/DBcSfcLwiFuitJcWh5YJW676fPt6
        NyE12F8GS+N0LBh1UERaENsD843Ii7h1sVN6U0Q=
X-Google-Smtp-Source: ABdhPJy4l1IftTvBpL9CZodl5fjFko/+IPYWSFBdkXUBM/kDIpGma2HukCJfivOUSCpBdA+i1ExzYBPtfYqvF79ufpY=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr6288828ejc.497.1645187273159; Fri, 18
 Feb 2022 04:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20220217055208.2388929-1-kai.heng.feng@canonical.com>
 <CAHp75VfFGw3b_ZtQir0AfTfXfQ7fi_LKLsY-7ww=4+MMBR8BAQ@mail.gmail.com>
 <CAAd53p7O7joFa7MH0s+rw-59WQkigvjKBf1bpO9e2gX9ddjF-A@mail.gmail.com>
 <CAHp75Vf4pjyJJDLKWTjq2ny1xkF9fSCSPb_8q5yk69DjV9EUAg@mail.gmail.com> <20220218121017.32bbdef9@jic23-huawei>
In-Reply-To: <20220218121017.32bbdef9@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Feb 2022 13:27:17 +0100
Message-ID: <CAHp75Vdja-9tjXDiR_aMFP3twNuTXtC3w1mkPo81pdM6dRya6Q@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: adxl345: Add ACPI HID table
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
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

On Fri, Feb 18, 2022 at 1:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 18 Feb 2022 09:39:14 +0100
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Feb 18, 2022 at 4:46 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > > On Thu, Feb 17, 2022 at 6:57 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thursday, February 17, 2022, Kai-Heng Feng <kai.heng.feng@canoni=
cal.com> wrote:
> >
> > ...
> >
> > > >> +               acpi_id =3D acpi_match_device(dev->driver->acpi_ma=
tch_table, dev);
> > > >> +               if (acpi_id) {
> > > >> +                       type =3D acpi_id->driver_data;
> > > >> +                       name =3D acpi_id->id;
> > > >> +               } else
> > > >> +                       return -ENODEV;
> > > >
> > > > Thanks, but can we do this in ACPI agnostic way?
> > > >
> > > > Can be as simple as
> > > >
> > > > if (id)
> > > >   ...
> > > > else {
> > > >   match =3D device_get_match_data(dev);
> > > >   if (!match)
> > > >     return -ENODEV;
> > > > }
> > > >
> > > > Note, it might require to reconsider what is put in the driver data=
 (either convert to pointers, or be sure that valid type is never a 0/NULL)=
.
> > >
> > > Unlike acpi_match_device(), device_get_match_data() only get
> > > driver_data, so we need a new struct to provide both name and type.
> >
> > It's unfortunate. Let me think about it a bit more.
> Usual solution is just to add that name to a per device type structure.
> In this particular case there isn't one so far though and an enum is used
> in the one place we might otherwise have used a part number specific stru=
cture.
>
> Probably the easiest thing to do is use the enum to do a lookup in an arr=
ay
> of structures and have the string there.
>
> >
> > > > Also note, in both cases using ID name for name us fragile. Probabl=
y we have to fix that first. Let me check today=E2=80=99s evening.
> > >
> > > Can you please explain more on this? How does ID name make it fragile=
?
> >
> > I thought this one is used somehow by userspace to distinguish the
> > instance of the device, but looking into the rest of the IIO drivers
> > it seems more or less  a field for part number. That said, the ID is
> > okay to use. I hope Jonathan may correct me.
> >
> Should be part number.  Instances are distinguished via label rather than
> name (or via the device parent on older kernels where we didn't have
> label).
>
> There are a few places where we accidentally let though IDs that aren't
> always simply the part number and they became part of the ABI so we
> couldn't really fix them after the event.

Thanks for chiming in.
So, can we simply use dev_name() then? Or would it be too bad to have
the device instance name there?

--=20
With Best Regards,
Andy Shevchenko
