Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BCB4631C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbhK3LGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:06:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhK3LGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:06:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9C35E1F44BBC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638270173; bh=l98QiWJLerDn9mqrR91nYQugxDENe5cVgoLVb3pluVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4pV1AD9qM8OrAcSvPDBWAsPHYQQ9BQmb2E/mlkJ3L/EEeNQSV4F4BhvIJpmALoRW
         /5MD1jojOanc6EVvFoEq62Ig390EbIqTFa0UAXdf2AtFKJDHOu4s7Uhy9B2bWNKijn
         XCxB8vwP1ODKzAaAln0S/1XRVtw3LyhNF3D7I8osuZFNPB2yNyXEtttffAzL94rH/L
         yEijKCm6RITgEdGa99ZPZZpqXX3wlMwKsSfg4V1j933kKOV7+LSjPii5xCBsemXBny
         slirmlgUN1VVx0Cejw1079siC6/vANgWCxqs5yHSTzKZ5W+44lvoE9YjYi0yj9ch5+
         NH4S3Y4t2KP9A==
Received: by earth.universe (Postfix, from userid 1000)
        id 3E42B3C0CA8; Tue, 30 Nov 2021 12:02:51 +0100 (CET)
Date:   Tue, 30 Nov 2021 12:02:51 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: power: supply: pm8941-charger: add
 pm8226
Message-ID: <20211130110251.o7fdea4spwd5qntl@earth.universe>
References: <20211118210210.160895-1-luca@z3ntu.xyz>
 <YaVeBGAnU2CY9SLr@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gjnpwqyqafz37nmp"
Content-Disposition: inline
In-Reply-To: <YaVeBGAnU2CY9SLr@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gjnpwqyqafz37nmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 29, 2021 at 05:11:00PM -0600, Rob Herring wrote:
> On Thu, 18 Nov 2021 22:02:04 +0100, Luca Weiss wrote:
> > The charger in PM8226 (used in MSM8226) is similar to the charger in
> > PM8941.
> >=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  .../devicetree/bindings/power/supply/qcom,pm8941-charger.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--gjnpwqyqafz37nmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGmBNAACgkQ2O7X88g7
+pptUA/+NOVilzivowBa8AyUf9dPhz6xP9hhQwNeR5I6Fa5Abq3uaHHzOwik2mP3
SjcOKdazMq6fnpoaqxw5ecVXlGACSvbTJPef1nUH5nxD7NR0gwRlPjBKoepAo83l
CGAiwNSJ3NG/qmCF52lPS48fle3KB3jSr24ak4bZVU3liIdEkutevgB2EG5ryWi0
LHu+kpfcXzRsj8qDBsz4O0hraXPr5SxbhxJhNjzwhHeVrwWr40VLTEOV2rwPgWJp
ttGrXZa3uzYvJkob6B9fLSh+W5dRkFB0ETUofJQbq6EK58ApDqA3l7J6h2/7Vul6
b0jASLQGWqutcCtyMnD73W3kNuFK3LN4bbYGQ4IqXdnN/Qn/IEbc60s/+BKlSkWq
/3H9kkY8+P/4IPthLCO3zneTFPbHU59+Qa1g9RDSRDeujzPmmx1uFKC7aLr/EvLK
+pbKUUfh+ZUT+tCE4pW+WIVS1DoSYn7HbSZ+fg5jwjpfZIMc98+nDkeBgKrdTtxs
WRPP5HYQG7kDSyrSGKbiApBtinRreOBdoVhpm16rKOtilc0cbb/r3tXiRoWV8q6N
pgnmUQs2nJlzhKqU864MIds6ACQ9i/cNMm2pww6LsxrmlZ+1XBuZI0W2bBybJhqt
/4Gihh/ovqwbcoEMKaLnhE0jjzfhhMJDYRx9hNNx3/5C8xq7rvM=
=3o7m
-----END PGP SIGNATURE-----

--gjnpwqyqafz37nmp--
