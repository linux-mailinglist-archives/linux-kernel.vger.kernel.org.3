Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F07146F43F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhLITvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:51:48 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:43910 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhLITvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:51:46 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 396EC1C0B98; Thu,  9 Dec 2021 20:48:11 +0100 (CET)
Date:   Thu, 9 Dec 2021 20:48:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Subject: DRM? Re: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <20211209194807.GB28088@duo.ucw.cz>
References: <20211209151123.3759999-1-dbrazdil@google.com>
 <20211209151123.3759999-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20211209151123.3759999-3-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +config DICE
> +	tristate "Open Profile for DICE driver"
> +	depends on OF_RESERVED_MEM
> +	help
> +	  This driver allows to ownership of a reserved memory region
> +	  containing DICE secrets and expose them to userspace via
> +	  a character device.
> +

Explaining what DICE is (and what Open Profile is) would be useful.

I see it is for some kind of DRM? Why is in non-evil and why do we
want it in Linux?
							Pavel
						=09
--=20
http://www.livejournal.com/~pavelmachek

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbJddwAKCRAw5/Bqldv6
8h9wAKCpTMUcQwhJWIEJfQuRuxOfROL6iwCcDp7eJ1B7xgmFm3MmTHjVAAwGf8I=
=XD2H
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
