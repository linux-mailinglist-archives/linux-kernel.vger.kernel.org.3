Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C06346DDBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhLHVoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:44:03 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39722 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhLHVoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:44:03 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 13C3C1C0B77; Wed,  8 Dec 2021 22:40:30 +0100 (CET)
Date:   Wed, 8 Dec 2021 22:40:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Dealing with custom hardware on x86
Message-ID: <20211208214028.GA16475@duo.ucw.cz>
References: <4ad5a438-ddc4-ca0a-a792-09d17edeb66b@alliedtelesis.co.nz>
 <20211124104723.GA8909@duo.ucw.cz>
 <b6924a00-873d-715f-2f00-93ee19032ecd@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <b6924a00-873d-715f-2f00-93ee19032ecd@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-11-24 20:22:38, Chris Packham wrote:
> Hi Pavel,
>=20
> Thanks for responding
>=20
> On 24/11/21 11:47 pm, Pavel Machek wrote:
> > Hi!
> >
> >> I'm about to start a project involving custom hardware using an x86 CP=
U.
> >> Complicating things somewhat we will have a CPU board supplied by a 3rd
> >> party vendor using a COM Express type 7 connector which will plug in to
> >> the board we're designing (actually 2 different boards each with some
> >> modular aspects) .
> >>
> >> Coming from an embedded (mostly ARM) background I'm used to describing
> >> the hardware via a devicetree and dealing with plug-in modules by
> >> loading devicetree overlays. How do people achieve this kind of thing =
on
> >> x86?
> >>
> >> I gather ACPI is involved somewhere but the knowledge that the BIOS has
> >> will go as far as the COM Express header and somehow we'll have to tell
> >> the kernel about the various non-probeable (mostly i2c) devices on our
> >> board which is kind of where I'm stuck. Any pointers would be greatly
> >> appreciated.
> > In x86 land, we usually use PCI/PCIE and have a add-on board expose
> > unique IDs with driver knowing what the IDs are. ACPI should not be
> > involved for add-on boards.
>=20
> So if I had a chain of i2c devices (endpoints behind muxes etc) I'd have=
=20
> the PCI add-on board declare that hierarchy with i2c_new_device()?

That sounds reasonable, yes.
									Pavel

--=20
http://www.livejournal.com/~pavelmachek

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbEmTAAKCRAw5/Bqldv6
8vHSAJ43mcUGfc9CqLm2yHpS/FulE2v4qwCeLri4KwVINCnl8qrpebFtURO67G8=
=si8Y
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
