Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D794BB8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiBRMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:03:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiBRMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:03:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA3220F42;
        Fri, 18 Feb 2022 04:03:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42485B825D4;
        Fri, 18 Feb 2022 12:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51578C340E9;
        Fri, 18 Feb 2022 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645185809;
        bh=5eCNGRZmLgvKjz0xwJntkcNjbDBrasjKtxubxgHEuIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gat8Bz/ayLWMwqVKTR/TpQ1SFEyaR0to68tpYy9Ee9p4nSXcFNP5rR9IP8hPB5R7i
         m69pfGU6QgcA+JQ1yjc1MaNrf+1tKQKEE6UhTrawngSuQnmgDDCGYo3+0nuqgE4BAN
         fUmteywuV18OhthhefEzIf4heM+3qs8Efr96LFw4aYdlhPEgFQe82T2WyvR8SsaWNS
         h5qJwByeXpTf4TWDGX3xZJSUoYmGXxLqtnh958/2MEsbYXcg4HvuQobvwI8OAfmy7o
         P/WVYFICdJ9ygz54YuIGiZNLQ2wa/62QI8J/f2dk3zzjCezt89Limwl9XeBNB2l4po
         4b2ORGQo6cOaA==
Date:   Fri, 18 Feb 2022 12:10:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: accel: adxl345: Add ACPI HID table
Message-ID: <20220218121017.32bbdef9@jic23-huawei>
In-Reply-To: <CAHp75Vf4pjyJJDLKWTjq2ny1xkF9fSCSPb_8q5yk69DjV9EUAg@mail.gmail.com>
References: <20220217055208.2388929-1-kai.heng.feng@canonical.com>
        <CAHp75VfFGw3b_ZtQir0AfTfXfQ7fi_LKLsY-7ww=4+MMBR8BAQ@mail.gmail.com>
        <CAAd53p7O7joFa7MH0s+rw-59WQkigvjKBf1bpO9e2gX9ddjF-A@mail.gmail.com>
        <CAHp75Vf4pjyJJDLKWTjq2ny1xkF9fSCSPb_8q5yk69DjV9EUAg@mail.gmail.com>
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

On Fri, 18 Feb 2022 09:39:14 +0100
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Feb 18, 2022 at 4:46 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> > On Thu, Feb 17, 2022 at 6:57 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote: =20
> > > On Thursday, February 17, 2022, Kai-Heng Feng <kai.heng.feng@canonica=
l.com> wrote: =20
>=20
> ...
>=20
> > >> +               acpi_id =3D acpi_match_device(dev->driver->acpi_matc=
h_table, dev);
> > >> +               if (acpi_id) {
> > >> +                       type =3D acpi_id->driver_data;
> > >> +                       name =3D acpi_id->id;
> > >> +               } else
> > >> +                       return -ENODEV; =20
> > >
> > > Thanks, but can we do this in ACPI agnostic way?
> > >
> > > Can be as simple as
> > >
> > > if (id)
> > >   ...
> > > else {
> > >   match =3D device_get_match_data(dev);
> > >   if (!match)
> > >     return -ENODEV;
> > > }
> > >
> > > Note, it might require to reconsider what is put in the driver data (=
either convert to pointers, or be sure that valid type is never a 0/NULL). =
=20
> >
> > Unlike acpi_match_device(), device_get_match_data() only get
> > driver_data, so we need a new struct to provide both name and type. =20
>=20
> It's unfortunate. Let me think about it a bit more.
Usual solution is just to add that name to a per device type structure.
In this particular case there isn't one so far though and an enum is used
in the one place we might otherwise have used a part number specific struct=
ure.

Probably the easiest thing to do is use the enum to do a lookup in an array
of structures and have the string there.

>=20
> > > Also note, in both cases using ID name for name us fragile. Probably =
we have to fix that first. Let me check today=E2=80=99s evening. =20
> >
> > Can you please explain more on this? How does ID name make it fragile? =
=20
>=20
> I thought this one is used somehow by userspace to distinguish the
> instance of the device, but looking into the rest of the IIO drivers
> it seems more or less  a field for part number. That said, the ID is
> okay to use. I hope Jonathan may correct me.
>=20
Should be part number.  Instances are distinguished via label rather than
name (or via the device parent on older kernels where we didn't have
label).

There are a few places where we accidentally let though IDs that aren't
always simply the part number and they became part of the ABI so we
couldn't really fix them after the event.

Jonathan


