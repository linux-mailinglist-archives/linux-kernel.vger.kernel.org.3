Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A97545592
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343954AbiFIU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiFIU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:26:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2749B4D;
        Thu,  9 Jun 2022 13:26:16 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96D70660174A;
        Thu,  9 Jun 2022 21:26:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654806375;
        bh=TxDn/EAJ1PhSPoOAcqA3PKEoHsTsX/OcuP68HYLNKqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POqhT479EDn2iYdm7IfUMSLS9/ZodN5x467kdwoeamdLHH4XK8aF6L3+/PnbFaxeo
         dj2iDLkctX6iFQo+iRT1X17FxIw9hBSzvnTpjRzt5uwz2ia7hC48K1xew4E5LNXwjR
         a9SCM6QcYpc1CXf8WQ8UNueFomO7zSokEeotN3WjvR8irWRpN9ZZDKh+M2BBRQgFDl
         iz+XykHDdrtY0bmzjlKBXpPOd3/YvY2abvHDWI9ZNgJxgpkzdBB8sAHARA3G0uLq45
         gvKbEoVr/jsy/UtUo2e/hhbwolPB4GKRXL2ex02F/wdzKqa1yGYj4tf4WT5D2QmM5W
         1Ge4VVbbK26Yg==
Received: by mercury (Postfix, from userid 1000)
        id 65BA710605B9; Thu,  9 Jun 2022 22:26:13 +0200 (CEST)
Date:   Thu, 9 Jun 2022 22:26:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jack Wu <wjack@google.com>
Cc:     kernel-team@android.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ken Yang <yangken@google.com>,
        AleX Pelosi <apelosi@google.com>,
        Vincent Wang <vincentwang@google.com>
Subject: Re: [PATCH v2] power: supply: add dock type
Message-ID: <20220609202613.pjojjw7meb4bekfr@mercury.elektranox.org>
References: <20220307034358.286657-1-wjack@google.com>
 <CAHnoD8BTEPeRToRtan7LZJae-K3dv0pvBYQrXkrr3scbjUUcTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwb3pz4yyfzitsrc"
Content-Disposition: inline
In-Reply-To: <CAHnoD8BTEPeRToRtan7LZJae-K3dv0pvBYQrXkrr3scbjUUcTg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fwb3pz4yyfzitsrc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 07, 2022 at 12:05:25PM +0800, Jack Wu wrote:
> Currently, power_supply framework supports only Battery, UPS,
> Mains, USB and WIRELESS power_supply_type. Add dock
> power_supply_type so that the drivers which supports dock can
> register a power supply class device with POWER_SUPPLY_TYPE_DOCK.

I asked for a driver using this. We do not add/extend sysfs API just
for the sake of downstream drivers. Either you send the
new driver/driver changes upstream that need POWER_SUPPLY_TYPE_DOCK,
or this will not get added.

Please don't waste reviewer's time!

-- Sebastian

> v2: updates to Documentation
>=20
> Thanks!
> Jack
>=20
> Jack Wu <wjack@google.com> =E6=96=BC 2022=E5=B9=B43=E6=9C=887=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:44=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Add dock power_supply_type for the drivers which supports dock can
> > register a power supply class device with POWER_SUPPLY_TYPE_DOCK.
> >
> > Signed-off-by: Jack Wu <wjack@google.com>
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> >  drivers/power/supply/power_supply_sysfs.c   | 1 +
> >  include/linux/power_supply.h                | 1 +
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentatio=
n/ABI/testing/sysfs-class-power
> > index 859501366777..0b45d9d3a50f 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -34,7 +34,7 @@ Description:
> >                 Describes the main type of the supply.
> >
> >                 Access: Read
> > -               Valid values: "Battery", "UPS", "Mains", "USB", "Wirele=
ss"
> > +               Valid values: "Battery", "UPS", "Mains", "USB", "Wirele=
ss", "Dock"
> >
> >  **Battery and USB properties**
> >
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/=
supply/power_supply_sysfs.c
> > index c0dfcfa33206..2b1f18b7f98c 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -57,6 +57,7 @@ static const char * const POWER_SUPPLY_TYPE_TEXT[] =
=3D {
> >         [POWER_SUPPLY_TYPE_USB_PD_DRP]          =3D "USB_PD_DRP",
> >         [POWER_SUPPLY_TYPE_APPLE_BRICK_ID]      =3D "BrickID",
> >         [POWER_SUPPLY_TYPE_WIRELESS]            =3D "Wireless",
> > +       [POWER_SUPPLY_TYPE_DOCK]                =3D "Dock",
> >  };
> >
> >  static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =3D {
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index e218041cc000..8f0425f00803 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -189,6 +189,7 @@ enum power_supply_type {
> >         POWER_SUPPLY_TYPE_USB_PD_DRP,           /* PD Dual Role Port */
> >         POWER_SUPPLY_TYPE_APPLE_BRICK_ID,       /* Apple Charging Metho=
d */
> >         POWER_SUPPLY_TYPE_WIRELESS,             /* Wireless */
> > +       POWER_SUPPLY_TYPE_DOCK,                 /* Dock Charging */
> >  };
> >
> >  enum power_supply_usb_type {
> > --
> > 2.35.1.616.g0bdcbb4464-goog
> >

--fwb3pz4yyfzitsrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiV2EACgkQ2O7X88g7
+pol7xAAk6Te9AhpNOGXFsk9TC2Kpb0tfwEivH9S/ClEMOsrj8Np01UQdlPIz/yF
fKXP3JcL/WO9D2MaCyPv4/lUbFj64cAW7fozIeL2TRUP+uwhoxTYN1IoadJggI0M
gYOsM3ZHIBNQ0BcVIIT4swttwsjNwdGTSMFt1iP+b4T2fLV/lIxIP7Am6Zeq6+bM
bvp8MGsscO/N1vQy/qRzPv3Go90E3GbKCHnT4wpKolb3Q2pNJ/bn7ndg5xUslVUl
MhNgcv5mT7RzQGCi83N8IsVz4O6sqypekBWGpyJZauFiJWdwNHdMc/dwPazkOKi+
tonvEIhtvkBxhDe4rCd6Yeof2OpoaFAFlWCkNnKwhEfw1pNlI0gss9EBOCuVruAb
ugxZCsEOFXCA6rXBHKyU/Czbn3Ki3PkAbDPYXEKfvU/xE8Sm6eBnagO8YF7M0eAf
LISPEaeWvJZXbXEZmtbSBqkgInQ//HLPrd3UnzlXRO2+cREblXdml7dJKWd0khDZ
lyLAynOmm26mCgs1lfXdEYlSKnf6TOpIH111XBCVr/UfEIleSwwPUJqgTlDPQVhF
NM9k71J7pueA8G7yIWNS8xqtTqTiZZA4pRzGYOVdfgOda6Dd95pVcGSf+onJbaTE
817IEIOgfmmrUda1NwRc8lcsZLe8enMb5CIy06dRAnzKil5fctw=
=DbUI
-----END PGP SIGNATURE-----

--fwb3pz4yyfzitsrc--
