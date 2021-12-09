Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBA146F425
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhLITms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:42:48 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42748 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhLITms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:42:48 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C25991C0B77; Thu,  9 Dec 2021 20:39:12 +0100 (CET)
Date:   Thu, 9 Dec 2021 20:38:57 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     David Brazdil <dbrazdil@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <20211209193857.GA28088@duo.ucw.cz>
References: <20211209151123.3759999-1-dbrazdil@google.com>
 <20211209151123.3759999-3-dbrazdil@google.com>
 <YbIhaWC8b2DV5C7Y@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <YbIhaWC8b2DV5C7Y@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +	memzero_explicit(kaddr, dice_rmem->size);
> > +	devm_memunmap(dice_misc.this_device, kaddr);
>=20
> Do you really need to call memzero_explicit()?  This isn't "local"
> memory, if the compiler "optimizes away" a normal call, it would be
> _VERY_ broken.

For clearing secrets, I believe memzero_explicit is nice
documentation.

Best regards,
								Pavel
							=09
--=20
http://www.livejournal.com/~pavelmachek

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbJbUQAKCRAw5/Bqldv6
8n71AKCBLAVJBcsdGVg79i0seELqu5h7sQCgwIkrRK7FCzRulLPs8MlHx0SeYBg=
=GH6l
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
