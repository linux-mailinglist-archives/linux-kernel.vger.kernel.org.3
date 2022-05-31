Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5835390EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbiEaMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbiEaMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F8C1056F;
        Tue, 31 May 2022 05:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E914611EC;
        Tue, 31 May 2022 12:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D415C385A9;
        Tue, 31 May 2022 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654000905;
        bh=50k5P2deod6KO8gvHsZ0qJej+m44dwOkD8HE8Gg5bjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MO2bw7bbdUFxvvki8bhZ3MgawmrbJZNY4ep7dcTpbtkPkBrD1hNo20l60DI3T7Oj1
         nlEdkpQz4meR1xf1XIYnfpCEfnmw3hcFzO7dSl+AV566wl8NggjS3iS6AJi7CzsMZX
         AN27nByTMKymlcyySqfBAbf2gzy8zhdHvemoux4FVUEYrqpGuxQI+T7JGhU0N6HVrH
         foWmceq2jqtCybmNYuVDwkPIWVeUhAcJAKqePfeEoG7aeHhOX0vJwnz4IPCq6XRJS0
         Qh7pYiaRubz31TiwxkjXegOnMv4Tyt7uBHh0AoRxhnqbluKjyV3pK5BlOng75mJBSN
         FCgiuBVpURnIQ==
Date:   Tue, 31 May 2022 14:41:42 +0200
From:   Mark Brown <broonie@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 03/14] regulator: mt6370: Add mt6370 DisplayBias and
 VibLDO support
Message-ID: <YpYNBo90NETXtjkV@sirena.org.uk>
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
 <20220531102809.11976-4-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hl22OOkO/wMChZ8B"
Content-Disposition: inline
In-Reply-To: <20220531102809.11976-4-peterwu.pub@gmail.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hl22OOkO/wMChZ8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2022 at 06:27:58PM +0800, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Add mt6370 DisplayBias and VibLDO support.

Other than one small thing this looks nice and clean:

> +	enable_gpio =3D fwnode_gpiod_get_index(of_fwnode_handle(np), "enable", =
0,
> +					     GPIOD_OUT_HIGH |
> +					     GPIOD_FLAGS_BIT_NONEXCLUSIVE,
> +					     desc->name);
> +	if (IS_ERR(enable_gpio)) {
> +		config->ena_gpiod =3D NULL;
> +		return 0;
> +	}

Please just use the OF APIs - due to ACPI's handling of power for
devices the regulator API OF bindings can't be used sensibly on
ACPI so it's better to explicitly work on DT only.  This won't
actually cause problems here but it's a bit clearer.

--hl22OOkO/wMChZ8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKWDQUACgkQJNaLcl1U
h9CrHwf/Xn0rciY/VlcVjndWUL/zYX17wRyxPAwxx/DOq/VCeystayvT4671ML/1
6h5ZE7pKGSzHQjyt8x3BXHDAvn0EW5KNrc+lwBTQDrhiE7hbKcXb0cChQBvcM4KJ
m2ETTDdgNoBEkUQwj40OnrL/DIw7NpILWAOaoB+gGwelfj4Lu8LxTcZsRQqdwAGN
Q4lC4mPkae3NP0+tc82DyjtHytJPaX5jCPML4AofpFKs6A95yGyKlARdDgQqVVXP
sbKZA93RwgxZDSH0pxXBaKCBTEwOIjIl5qXbk0OXyvnopAYvVGVe6oFgutC2MPqa
joJC6sXurZO+wFB9H9tlKwq9Au8AOQ==
=WP6+
-----END PGP SIGNATURE-----

--hl22OOkO/wMChZ8B--
