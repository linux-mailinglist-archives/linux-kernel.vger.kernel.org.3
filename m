Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327E8579FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiGSNp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiGSNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:45:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63B39B19A;
        Tue, 19 Jul 2022 05:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 519F5CE1C0A;
        Tue, 19 Jul 2022 12:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817ADC341C6;
        Tue, 19 Jul 2022 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658235498;
        bh=cd3iDI2EaD0soZM4kdNoeMySuIe0jizK6RWp/s4z+oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1QMcnERnO1oFIfNx2LCKyNG6SgpAjHk9rn9PD3H/MPJ5mIaPseLEidwwJ6Gh98fQ
         don2/Rwo2BNT0VqCKdR5ONaJzTNFASCyNmCFG9nyAiqHiuyfa8Hkv5gKam9KQG6cHh
         B1ixsxdvyp6MLqn4ot0lMxw8DovY/9Vsk6/Q9O7/pV5WHDB2KsBoVQJ0Ket/I3xVLr
         FBDcLA0R0grrD5jKG8BUX+nrEu5VFAipW0aJ2J39sgkjgrZR8WK2NHdIsS5BC6L4kg
         BkHaHe9SOdKYbgoL+ZCUT1BjH6jLBV2Q0f4T1Wj1Hj2duyYTKDmacVA35CYj4fh43s
         944G8nkSz3Ilg==
Date:   Tue, 19 Jul 2022 13:58:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 03/14] regulator: dt-bindings: Add interrupts support
 to TPS65219 PMIC bindings
Message-ID: <YtaqZPwCKknz5uUT@sirena.org.uk>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-4-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36iGOHhGe96zj8wk"
Content-Disposition: inline
In-Reply-To: <20220719091742.3221-4-jneanne@baylibre.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36iGOHhGe96zj8wk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 11:17:31AM +0200, Jerome Neanne wrote:
> Add interrupt properties in PMIC TPS65219 bindings
>=20
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  .../bindings/regulator/ti,tps65219.yaml       | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)

The entire binding document should probably be in MFD if it's going to
have properties for other functions added to it (which is perfectly
reasonable).

--36iGOHhGe96zj8wk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWqmMACgkQJNaLcl1U
h9DmNQgAhD4Qme33mjkVeL+5oikrWaIXpUpPA/kInQYaBWLZtPhXEsmzc2aady9o
7/xbNKouihroI3jZU8f8cMmRs9i9VSz79bXjVUNNTcl4YW8JxYaRzh9WsRkAWMm3
PvOCz02OEpoDpyIo3yr3aDcNCB8OZWwFLcBZMUlzIpTP37MN3YRYXGEWa/81R96z
J2+mIxvNrOjedPzmssvA8CZlnUZL2SaWwUfn4x07yts7ZEYwjMGqSG91vhBt9CaR
uWb1d5roWNNIPvMoJDAHOj9dCWbKoky8RuvQQtLjrmoeCjEeQvplRvLnu2akKVtS
ntP0E4A/pXgRlZKRNqPFzIY2JjPhfQ==
=N7/y
-----END PGP SIGNATURE-----

--36iGOHhGe96zj8wk--
