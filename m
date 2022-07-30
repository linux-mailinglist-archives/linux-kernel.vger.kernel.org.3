Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC601585C43
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiG3VTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiG3VTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:19:07 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F313D3F;
        Sat, 30 Jul 2022 14:19:06 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CF4201C0001; Sat, 30 Jul 2022 23:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659215944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jYlNXr3xqxg2RIekxKjmDmBToZoH8HQ7IIwLxMtV03E=;
        b=sTmQrYFXCY+XsKsvBV5SkcBW7Se4hcBftTxYB+uCWJkMAWsB/o5PD0MRl1Tk8V5F0dN9XH
        2Xmv6vSIOYWHob04ztJP1soJAdtGHyhtobiowMqKgbc80wIFAOm6918HI1upAbB/eSagjC
        XUaq1wwUgocK2KmFV30cKgQtev+qTCM=
Date:   Sat, 30 Jul 2022 23:19:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     robh+dt@kernel.org, sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        andy.shevchenko@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Message-ID: <20220730211904.GF23307@duo.ucw.cz>
References: <20220719191801.345773-1-jjhiblot@traphandler.com>
 <20220719191801.345773-5-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Content-Disposition: inline
In-Reply-To: <20220719191801.345773-5-jjhiblot@traphandler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> By allowing to group multiple monochrome LED into multicolor LEDs,
> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.
>=20
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  drivers/leds/rgb/Kconfig                 |   6 +
>  drivers/leds/rgb/Makefile                |   1 +
>  drivers/leds/rgb/leds-group-multicolor.c | 153 +++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
>=20
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index 204cf470beae..70b157d1fdca 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -2,6 +2,12 @@
> =20
>  if LEDS_CLASS_MULTICOLOR
> =20
> +config LEDS_GRP_MULTICOLOR
> +	tristate "multi-color LED grouping Support"

Make this
        tristate "Multi-color LED grouping support"

Others commented on other issues.

Thank you,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWgSAAKCRAw5/Bqldv6
8niGAJ9pNMbzeu7BXVid4jeXPDiq74xwNgCfaY800t4ajzbNXJS9X2SrxZjHFMk=
=6EBs
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
