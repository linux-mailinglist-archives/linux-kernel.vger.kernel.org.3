Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3364CDFBC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiCDVZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCDVZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:25:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575B837A13;
        Fri,  4 Mar 2022 13:24:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 21AB31F46DBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646429094;
        bh=oahX6BKKRUADoQxxViiHUeyWMtqZ5bjQV0BfWQNZtKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCh3DIN2CSUUmUJNSyQAOJRnXRB+EysTscJF4H8PJHmpYxb+Mt6xghX2QmmHESqbN
         Kp4sJQCrjnqJCqJgPWHf2B6Y0HlfgKp93/gwyeKbRQ5MFX9vpx73tL1qC8Vtliobpa
         2bVz5Nn7EElzcGtzVz8RknVOyxJ7Wd/27XZjsDPjQIi39aF6FUXpxJ5UF4sP7OhVXZ
         ElhjZT48xTqJozSXBUf2dUJFBqr10ycjH3I3L4Qh5rJ+3ymIh8U+JiThT2ggcXdfdV
         Ppk1d9qttg+j5UBoj4VJeLtFqpGe1RAXFfnVmhqrAFV1V92faPo9Sj52Tm/CUcaVUO
         AF2yF0WOiN5rQ==
Received: by mercury (Postfix, from userid 1000)
        id 2333B1060602; Fri,  4 Mar 2022 22:24:52 +0100 (CET)
Date:   Fri, 4 Mar 2022 22:24:52 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] power: supply: ab8500: Remove unused variable
Message-ID: <20220304212452.pyqbxqbmhu6ewpcy@mercury.elektranox.org>
References: <20220301052850.5382-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ort522qbjz7sr4x"
Content-Disposition: inline
In-Reply-To: <20220301052850.5382-1-jrdr.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ort522qbjz7sr4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 01, 2022 at 10:58:50AM +0530, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>=20
> Kernel test robot reported below warning ->
> drivers/power/supply/ab8500_chargalg.c:790:13: warning:
> variable 'delta_i_ua' set but not used [-Wunused-but-set-variable]
>=20
> Remove unused variable delta_i_ua.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_chargalg.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index b5a3096e78a1..f73d29c09caf 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -793,13 +793,10 @@ static void init_maxim_chg_curr(struct ab8500_charg=
alg *di)
>   */
>  static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_charg=
alg *di)
>  {
> -	int delta_i_ua;
> =20
>  	if (!di->bm->maxi->ena_maxi)
>  		return MAXIM_RET_NOACTION;
> =20
> -	delta_i_ua =3D di->ccm.original_iset_ua - di->batt_data.inst_curr_ua;
> -
>  	if (di->events.vbus_collapsed) {
>  		dev_dbg(di->dev, "Charger voltage has collapsed %d\n",
>  				di->ccm.wait_cnt);
> --=20
> 2.25.1
>=20

--7ort522qbjz7sr4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIig6MACgkQ2O7X88g7
+prdGA//eF9JmBR99xdPgdAoicwtAquDf3nGDNRy5F1GLhM+ZX17vYFR8r4Wc74v
cAjV7kOWdbwleBs05+pemRKbwvv0p+sNwxqccApPA7jzpI8escZxlys2u4or9fNM
KU7o8w1NgYedcCq6ek5dLYbX17DtWicA099AVR2wyYnuW9PBDCNMNmgRhOmlaD2U
lZUR9ehz6myHH3rHAWeV54xaIDKk16ogVL7Yf8n47VU4pf3OiLIdlDbeLDiAyua8
FYMQK6U9jAm7vj9/OjatAFr9bQGftWukBELrmajCJBREjH83y/rjgwKRQIQ5x2RE
uTfGt75jtrOMvXnt+pKkeWe2AhKAqv5UaUMWWEa7+gOPP6zna8Fw778TPjOygdkK
+UyvRiZ29pi2VZbzMO4MMbGG6N6i/BAucYd8NisL9RlhR03rwlESNgT9urV9XcrB
zCCBliwSaX59ZDacPODWVUE/4loctY9+NZRM/TgCzjSofQ0B6LrN92hehO0oiLjs
IlUGVJd1qr5lxM15xH2o4JTWGIokD/ZUx8DAQiUc9SoICceoUewSSL6PNgajmrKb
l7TnBv7GIVU5ijM9yNPlFSTt6EdszIjibJ28ByU6DGWufL3YG0D8pCizu1KLOAu9
bYTOdOF9+l4S9tMfqpIggX83DpcHrkHdn+lVe1GFJuLXY/JlHVk=
=E9c1
-----END PGP SIGNATURE-----

--7ort522qbjz7sr4x--
