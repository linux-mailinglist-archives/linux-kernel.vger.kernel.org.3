Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1EC48FBEF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 10:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiAPJXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 04:23:32 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34276 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiAPJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 04:23:30 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AD7BA1C0B76; Sun, 16 Jan 2022 10:23:28 +0100 (CET)
Date:   Sun, 16 Jan 2022 10:23:26 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com
Subject: Re: [PATCH 00/23] Add support for Tesla Full Self-Driving (FSD) SoC
Message-ID: <20220116092325.GA30745@amd>
References: <CGME20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4@epcas5p1.samsung.com>
 <20220113121143.22280-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch set adds basic support for the Tesla Full Self-Driving (FSD)
> SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
> as well as several IPs.

I'm not thrilled by their naming. Intel does not produce "Intel
Fastest in world SoC", and this chip is not actually suitable for
autonomous driving :-(.

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHj5A0ACgkQMOfwapXb+vLGvwCffXsUnQ6Xkz2YZtJkEworpnyu
jUUAn2Zr5IbMgKWYXoNIDLq5OJbwbM48
=Vle9
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
