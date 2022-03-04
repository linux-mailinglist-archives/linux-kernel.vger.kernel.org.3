Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703814CE005
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 23:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiCDWBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 17:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiCDWBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:01:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6327C79E;
        Fri,  4 Mar 2022 14:00:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5F7871F46F4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646431251;
        bh=5Rnh1wNpzkK58N3hpQJbE+uI0UsASxwgycbiMvIBxog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P6kq/hX7CnyJByBI6IWTdsTt2mMQp5tYVfQhWWg/YEfLIUr0INxC68pGNDxcNb5lU
         lTBIgCDmJI+ldm1BO1h4hc9mOd84rJVwEnA+qPm4+WBQyjBU9ekLmhUoCs7T/ToMEt
         /DqLlo+kYaydD8kcw8wye8jw1MNLusB1589vnkW15Jv17kFWHrv+PC0d+bIfTXjTFC
         NJmYJstYrj8SwMD8/blCoK/GOi2HHv9Yn5gxj3i+F1AoUJU/3oFtbboYdLY4S7GRN5
         qrXC3p9515zfG8snWD3sA0WvERNxOZdaohTM4yIpScQdDwrW47uhPthYGY22Xvi531
         CGq/j39cRS70w==
Received: by mercury (Postfix, from userid 1000)
        id 45F021060602; Fri,  4 Mar 2022 23:00:49 +0100 (CET)
Date:   Fri, 4 Mar 2022 23:00:49 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jack Wu <wjack@google.com>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, AleX Pelosi <apelosi@google.com>,
        Vincent Wang <vincentwang@google.com>,
        Ken Yang <yangken@google.com>
Subject: Re: [PATCH v1] power: supply: add dock type
Message-ID: <20220304220049.y7klqsgqinonsojx@mercury.elektranox.org>
References: <20220104122500.338870-1-wjack@google.com>
 <CAHnoD8CtN6QMUDnd+A+WqG__CL0njSqYvgCu0oKTiieQGaE88g@mail.gmail.com>
 <CAHnoD8DPRvBXP04H3zzBsefvzvfzVuk271-+WAtYV_2KJBbFEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zintmcb5spjuabi3"
Content-Disposition: inline
In-Reply-To: <CAHnoD8DPRvBXP04H3zzBsefvzvfzVuk271-+WAtYV_2KJBbFEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zintmcb5spjuabi3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When you send a new patch version you should

a) increase patch version (this is v2)
b) add a changelog below the --- marker

Apart from that this submission is still missing a
driver using the newly introduced POWER_SUPPLY_TYPE_DOCK.
Mainline kernel ABI is only extended for mainline kernel
users.

Thanks,

-- Sebastian

On Mon, Feb 14, 2022 at 02:22:52PM +0800, Jack Wu wrote:
> + Ken
>=20
> Jack Wu <wjack@google.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=887=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8811:37=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > + Alex and Vincent
> >
> > Jack Wu <wjack@google.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=884=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:25=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > Add dock power_supply_type for the drivers which supports dock can
> > > register a power supply class device with POWER_SUPPLY_TYPE_DOCK.
> > >
> > > Signed-off-by: Jack Wu <wjack@google.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> > >  drivers/power/supply/power_supply_sysfs.c   | 1 +
> > >  include/linux/power_supply.h                | 1 +
> > >  3 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentat=
ion/ABI/testing/sysfs-class-power
> > > index f7904efc4cfa..854299a0d36f 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-power
> > > +++ b/Documentation/ABI/testing/sysfs-class-power
> > > @@ -34,7 +34,7 @@ Description:
> > >                 Describes the main type of the supply.
> > >
> > >                 Access: Read
> > > -               Valid values: "Battery", "UPS", "Mains", "USB", "Wire=
less"
> > > +               Valid values: "Battery", "UPS", "Mains", "USB", "Wire=
less", "Dock"
> > >
> > >  **Battery and USB properties**
> > >
> > > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/powe=
r/supply/power_supply_sysfs.c
> > > index c3d7cbcd4fad..53494b56bbb4 100644
> > > --- a/drivers/power/supply/power_supply_sysfs.c
> > > +++ b/drivers/power/supply/power_supply_sysfs.c
> > > @@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] =
=3D {
> > >         [POWER_SUPPLY_TYPE_USB_PD_DRP]          =3D "USB_PD_DRP",
> > >         [POWER_SUPPLY_TYPE_APPLE_BRICK_ID]      =3D "BrickID",
> > >         [POWER_SUPPLY_TYPE_WIRELESS]            =3D "Wireless",
> > > +       [POWER_SUPPLY_TYPE_DOCK]                =3D "Dock",
> > >  };
> > >
> > >  static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> > > diff --git a/include/linux/power_supply.h b/include/linux/power_suppl=
y.h
> > > index 9ca1f120a211..fa80eaa54242 100644
> > > --- a/include/linux/power_supply.h
> > > +++ b/include/linux/power_supply.h
> > > @@ -187,6 +187,7 @@ enum power_supply_type {
> > >         POWER_SUPPLY_TYPE_USB_PD_DRP,           /* PD Dual Role Port =
*/
> > >         POWER_SUPPLY_TYPE_APPLE_BRICK_ID,       /* Apple Charging Met=
hod */
> > >         POWER_SUPPLY_TYPE_WIRELESS,             /* Wireless */
> > > +       POWER_SUPPLY_TYPE_DOCK,                 /* Dock Charging */
> > >  };
> > >
> > >  enum power_supply_usb_type {
> > > --
> > > 2.34.1.448.ga2b2bfdf31-goog
> > >

--zintmcb5spjuabi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIijAsACgkQ2O7X88g7
+ppiHxAAn+nd3ao3lUWSVtE/0lz3Qm9QUpBKiJlyfBL5GyILEh8MbWLA4E2wI0E9
ivqQb07ZWSX3mYUanGKibelr1dftw3gWruQZZWtN2OPaDReK3rHFen3ydueoMmzu
IA6hEG20GrO1ZcJI3VBtdLZb6yxy3D23z4xG3NJ1xr/be+jaK6hHfBPV5ZZJZ4Ma
psPfxPKU/8jd8ry1BbLx9TmT4SCAihwnFF1bdgDf622017awCxK4KWx5GK5/QGBT
jd1wb/0aH3vMEnnHDoxS++0G5aDw0Ga+azsguGbsc7Z8SuR0/pqpIx1VjsIHhcwn
yMSVxnHUTvoz33f3CNon7cZTXoFrjNn9okK0MowyZt06XEmz36dgbJfGI7Z9al1g
Ycyn+4hHyXWslPv6ekeDWa4ISkR4Rt61XnwALGD2toNEuwoG41gT2nDLpM3/QqpU
CA3+5e/dml56mJxopaMGBqbtE69VixwNLyaxmnidmrnJRaWwegHCchAGQO+ghAxz
8Vc+VWt0Yh592FiVsdTKvOyKNxvBErfxQNs+BUM9olGWSwJhgW/rQOt6fSEwe8Be
u6mzPwrMQU9wvG+POjO7USfQ5GCwowOwFSmfvamS3RMW8WIuT/3RbxmQcdSsZei0
miDsBtfJDFtTXJ8AlSi617gi0FKdqQMjugfOzlV9gun1xaUNH5c=
=rCH5
-----END PGP SIGNATURE-----

--zintmcb5spjuabi3--
