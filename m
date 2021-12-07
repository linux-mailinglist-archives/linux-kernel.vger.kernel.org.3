Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47A846B5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhLGIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:30:32 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58398 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbhLGIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:30:29 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 07E4B1C0B7A; Tue,  7 Dec 2021 09:26:58 +0100 (CET)
Date:   Tue, 7 Dec 2021 09:26:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 0/6] Initial Samsung Galaxy A8 (2018) support
Message-ID: <20211207082656.GA12097@duo.ucw.cz>
References: <20211205153302.76418-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20211205153302.76418-1-virag.david003@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add basic initial support for the Samsung Galaxy A8 (2018) smartphone.
> This phone is also known as "jackpotlte" and under the model name
> "SM-A530F". In its current state this should work on most if not all
> Exynos7885 phones/devices released.

Thank you, it is good to see support for more hardware.

Can I get you to cc phone-devel@vger.kernel.org mailing list in future?

Besst regards,
								Pavel
							=09

--=20
http://www.livejournal.com/~pavelmachek

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYa8a0AAKCRAw5/Bqldv6
8rEnAJ9mza7GT9xYuJR4Ikn+RPGTOW9uvACdGNsilj2XujCT77t5DgPSIqjBeUk=
=Vqks
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
