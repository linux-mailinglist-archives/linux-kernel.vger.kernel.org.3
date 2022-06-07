Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED2A53FEC7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiFGMaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiFGMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:30:50 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3868BF13C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:30:49 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3F85884368;
        Tue,  7 Jun 2022 14:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1654605047;
        bh=plnVJhBibFBWng6d8zcZND3hL04tiwjCDBmrnz5NM44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GXwrN1snNV07SXVe1eT0XQ/f5lncveP4aVUvUbUkqnWIChHcaJlLQNgNA6z0yU3Dr
         19FXk6pAXd8NpDzyy8YpVRhVSStUhEm4lq4CfD50xlgjdX7nT+buqO2gd7u2KGMh+6
         EofMwzGcMU3Fyb/+g79bndvQY3CsfxEowc7AYhJLxjVGpMJEHGu8ATDn+w70/x9R6f
         qPLSp7Gx+kgJqAHsisMj6dx0Rgu3MjRV9r2Z9xEFEC5iX3i3xAFgXhEW1Z3v/HUxV4
         aG1NiaPaUrkr6JG/d8mEDGJi3KyqvsMYPTT7tr4zfOHZ4IDAIL5KsK1CjlOYXwAgC3
         KcYMijJpR7HBQ==
Date:   Tue, 7 Jun 2022 14:30:39 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ASoC: wm8940: Remove warning when no plat data
Message-ID: <20220607143039.01cdff80@ktm>
In-Reply-To: <Yp4wzS0aLEo5werI@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
        <Yp4iGvGFD9jo4WUP@sirena.org.uk>
        <20220606181731.04b6f771@ktm>
        <Yp4wzS0aLEo5werI@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/ZDrERQF4JXuQvzusRTtzOG5"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZDrERQF4JXuQvzusRTtzOG5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, Jun 06, 2022 at 06:17:31PM +0200, Lukasz Majewski wrote:
> > > On Mon, Jun 06, 2022 at 05:44:39PM +0200, Lukasz Majewski wrote: =20
>=20
> > > > The lack of platform data in the contemporary Linux
> > > > shall not be the reason to display warnings to the
> > > > kernel logs. =20
>=20
> > > Given that the device requires configuration and doesn't appear to
> > > have any other firmware interface support that's rather a strong
> > > statement... =20
>=20
> > My point is that - similar codec - wm8974 don't display such
> > warnings. (this code was not updated/refactored for a quite long
> > time). =20
>=20
> Perhaps those drivers are buggy, or those devices lack this specific
> configuration that's being adjusted?  The changelog should at least
> address why the driver was warning about configuration being required
> but it's safe to ignore that.

With v4.4 from which I forward port those changes only the PXA
'stargate2' mach is using this codec.

In this version there is no reference to 'vroi'.

With newest Linux - there is no reference to this codec (even to any
DTS file), so we can assume that from at least v4.4 there is no
reference to platform data for it.


I guess that one can provide the 'vroi' information via DTS nowadays if
required.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ZDrERQF4JXuQvzusRTtzOG5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmKfRO8ACgkQAR8vZIA0
zr2zMQf/b77NogZ5Gk9SrUZ7tnUgQBCQNfeSGNsiTK0z1uHlS6CIcEhTidUfr60h
NOnlUDG+lYYN6Fyo7qzXVUlQ0ROOXKkvGCeFIwB6yQCb7y0/uZ9s+SozoXq7DjkT
CN4wA92r6g9B1J1rhcnUH4phPlazhDQifwDPQFxJ0ww7ODCER5tUUqzhE6Gsoplc
YUG48vjXxzg6Sy5pSKJHwcL7YIGwUTui1e82PVu+IZndAnP+4izheE3joAfhn14k
Q/F8qnOHH+FbF8FYKenJybVAZxE6JVXA4jY5RYknN65AwHYE8sAnyh2Zp1ckJQf4
vmu+7wnj4eNUbwGMgDyCyzOsO23I7w==
=g3pk
-----END PGP SIGNATURE-----

--Sig_/ZDrERQF4JXuQvzusRTtzOG5--
