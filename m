Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ED24BC98C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242707AbiBSRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:37:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbiBSRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:37:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB41A58F3;
        Sat, 19 Feb 2022 09:37:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 968DEB8006F;
        Sat, 19 Feb 2022 17:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1284CC004E1;
        Sat, 19 Feb 2022 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645292249;
        bh=MxKMw0UCb/0C7x1FzTqGDYUoWJlUy28nMDjAHOt7STs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rAF35+INvoSdr+m8S4zLJeuD43T5yudc76VFpv8YLaiLGy1odOasyNFlwpMFXsc4z
         3YhnOp8ahanTUJaEv2iUIY/r/L22oURP8DyPLObczo6YDKO2zjyP8rhdqTqD8uwKwb
         rD7DyJQNorVHiX7or3vzUkTtHa84lDdbxaofTCXRg5D0e+EgMBZa7qcOzIFIxhjSR0
         TBgbX4Uoy41D6N444cP1BUYXm7lLsP27jn3D39cY7II9Bntc++dDcFm+2eEZSA70dR
         5/eFIS62W9sYwX/VLHfc9mCcZDBFHQUKzwWHSWd+RTFwZpVlsFbhBHQkhfU/zAHxXG
         JMN/PLRJi1d2Q==
Date:   Sat, 19 Feb 2022 17:44:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: accel: adxl345: Add ACPI HID table
Message-ID: <20220219174417.47586791@jic23-huawei>
In-Reply-To: <CAHp75Vdja-9tjXDiR_aMFP3twNuTXtC3w1mkPo81pdM6dRya6Q@mail.gmail.com>
References: <20220217055208.2388929-1-kai.heng.feng@canonical.com>
        <CAHp75VfFGw3b_ZtQir0AfTfXfQ7fi_LKLsY-7ww=4+MMBR8BAQ@mail.gmail.com>
        <CAAd53p7O7joFa7MH0s+rw-59WQkigvjKBf1bpO9e2gX9ddjF-A@mail.gmail.com>
        <CAHp75Vf4pjyJJDLKWTjq2ny1xkF9fSCSPb_8q5yk69DjV9EUAg@mail.gmail.com>
        <20220218121017.32bbdef9@jic23-huawei>
        <CAHp75Vdja-9tjXDiR_aMFP3twNuTXtC3w1mkPo81pdM6dRya6Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 13:27:17 +0100
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 18, 2022 at 1:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 18 Feb 2022 09:39:14 +0100
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > On Fri, Feb 18, 2022 at 4:46 AM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote: =20
> > > > On Thu, Feb 17, 2022 at 6:57 PM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote: =20
> > > > > On Thursday, February 17, 2022, Kai-Heng Feng <kai.heng.feng@cano=
nical.com> wrote: =20
> > >
> > > ...
> > > =20
> > > > >> +               acpi_id =3D acpi_match_device(dev->driver->acpi_=
match_table, dev);
> > > > >> +               if (acpi_id) {
> > > > >> +                       type =3D acpi_id->driver_data;
> > > > >> +                       name =3D acpi_id->id;
> > > > >> +               } else
> > > > >> +                       return -ENODEV; =20
> > > > >
> > > > > Thanks, but can we do this in ACPI agnostic way?
> > > > >
> > > > > Can be as simple as
> > > > >
> > > > > if (id)
> > > > >   ...
> > > > > else {
> > > > >   match =3D device_get_match_data(dev);
> > > > >   if (!match)
> > > > >     return -ENODEV;
> > > > > }
> > > > >
> > > > > Note, it might require to reconsider what is put in the driver da=
ta (either convert to pointers, or be sure that valid type is never a 0/NUL=
L). =20
> > > >
> > > > Unlike acpi_match_device(), device_get_match_data() only get
> > > > driver_data, so we need a new struct to provide both name and type.=
 =20
> > >
> > > It's unfortunate. Let me think about it a bit more. =20
> > Usual solution is just to add that name to a per device type structure.
> > In this particular case there isn't one so far though and an enum is us=
ed
> > in the one place we might otherwise have used a part number specific st=
ructure.
> >
> > Probably the easiest thing to do is use the enum to do a lookup in an a=
rray
> > of structures and have the string there.
> > =20
> > > =20
> > > > > Also note, in both cases using ID name for name us fragile. Proba=
bly we have to fix that first. Let me check today=E2=80=99s evening. =20
> > > >
> > > > Can you please explain more on this? How does ID name make it fragi=
le? =20
> > >
> > > I thought this one is used somehow by userspace to distinguish the
> > > instance of the device, but looking into the rest of the IIO drivers
> > > it seems more or less  a field for part number. That said, the ID is
> > > okay to use. I hope Jonathan may correct me.
> > > =20
> > Should be part number.  Instances are distinguished via label rather th=
an
> > name (or via the device parent on older kernels where we didn't have
> > label).
> >
> > There are a few places where we accidentally let though IDs that aren't
> > always simply the part number and they became part of the ABI so we
> > couldn't really fix them after the event. =20
>=20
> Thanks for chiming in.
> So, can we simply use dev_name() then? Or would it be too bad to have
> the device instance name there?

I'd rather it wasn't the device instance.  All the documentation etc
says part number for this so that's what will be expected by most
users.  The docs are deliberately vague (Typically a part number)
because some devices don't have one and we have those historical parts
where I missed they were using the instance name when reviewing.

Jonathan



>=20

