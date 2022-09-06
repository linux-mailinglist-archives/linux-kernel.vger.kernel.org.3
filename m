Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D635AE36C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbiIFItm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbiIFIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:48:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B02179638;
        Tue,  6 Sep 2022 01:45:34 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9A9F61C0001; Tue,  6 Sep 2022 10:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1662453931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SHIU3mW9MXIg4heWeGX4mWOogF29zRAR22i6C80XFw=;
        b=ZYECbAe1b3KFoW1tl2/Ad23VJ0NnF/bvOG92+0pXf7r6u1ejIBgwWw0KFkmUlvQIucezWt
        e4ogmA5P73EnQG4c5ywuDp1E6zq/kTJxgJ0uTD8QSUS217kB8sBJ/gJsRlhwtjyyBtGVID
        EiD45S3UohMN5Yv3Ar3fqrCvxvRlwlo=
Date:   Tue, 6 Sep 2022 10:45:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     festevam@gmail.com, shawnguo@kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de, kernel@puri.sm,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH v2 2/6] arm64: dts: imx8mq-librem5: add RGB pwm
 notification leds
Message-ID: <20220906084531.GA29911@duo.ucw.cz>
References: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
 <20220902084216.1259202-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20220902084216.1259202-3-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Guido G=FCnther <agx@sigxcpu.org>
>=20
> Describe the RGB notification leds on the Librem 5 phone.
> Use the common defines so we're sure to adhere to the common patterns,
> use predefined led colors and functions so we're being warned in case
> of deprecations.

I'd like LED lists to be cc-ed on patches like this, so that we can
keep userland API consistent.

In particular, RGB LED is very common feature on the phones, and it
would be good to have it consistent accross them. Can you take a look
at Documentation/leds/well-known-leds.txt, decide if your current API
is suitable, and update the file so that we get the consistency?

Thanks,
								Pavel

> +	led-controller {
> +		compatible =3D "pwm-leds";
> +
> +		led-0 {
> +			function =3D LED_FUNCTION_STATUS;
> +			color =3D <LED_COLOR_ID_BLUE>;
> +			max-brightness =3D <248>;
> +			pwms =3D <&pwm2 0 50000 0>;
> +		};
> +
> +		led-1 {
> +			function =3D LED_FUNCTION_STATUS;
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			max-brightness =3D <248>;
> +			pwms =3D <&pwm4 0 50000 0>;
> +		};
> +
> +		led-2 {
> +			function =3D LED_FUNCTION_STATUS;
> +			color =3D <LED_COLOR_ID_RED>;
> +			max-brightness =3D <248>;
> +			pwms =3D <&pwm3 0 50000 0>;
> +		};
> +	};
> +
>  	reg_aud_1v8: regulator-audio-1v8 {
>  		compatible =3D "regulator-fixed";
>  		pinctrl-names =3D "default";
> --=20
> 2.30.2

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYxcIqwAKCRAw5/Bqldv6
8lCXAJ4x2g8SJqp5mrj7kCc6IKN20hswnwCfUZFTxFlQgSz8OdLdLfwln3PRm70=
=EuwN
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
