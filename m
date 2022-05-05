Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1199E51C219
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380490AbiEEOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiEEOSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:18:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9205A08B;
        Thu,  5 May 2022 07:14:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 99B0B1F4579A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651760080;
        bh=r33seUc7ch2ErUOuHDOu/kLhA/pqR1qUoAKMOVPvGl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qy+mVmCiI+cGac8hF4ckuNPcfThjIc1BzyLbDAmxrUDhWix4W+GEoZpFD+0RgOl35
         mEAmmhpXNSQJRWaX0B/PyDotoud2XI0UKts+9HvJ06IPvTh3D5K2N7u6E796aYFyMS
         nVX50vDvohv1RTKh+5v/tpSTkMAHu3iHv6nCyprnqnSNGfV4iT90FErodSk4rnHQvy
         zwVy58INW077N0dFQlhEcuTDFJHfRCQkO/QwZZ6SxI9VN696k0kKggJ1mS1eXcmc95
         O4mqkh/fx9bzgyQ8Dt+uVmVzf4X2vI+gTtt9vGiSQg4TYcK9dbe5KlJhplcrUO306M
         JDwTHLJDEp8OA==
Received: by mercury (Postfix, from userid 1000)
        id 6BBEB1060437; Thu,  5 May 2022 16:14:38 +0200 (CEST)
Date:   Thu, 5 May 2022 16:14:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCHv2 01/21] dt-bindings: pinctrl: rockchip: add rk3588
Message-ID: <20220505141438.7tqanpu5gumkpxos@mercury.elektranox.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aiobpk3ve3g3geno"
Content-Disposition: inline
In-Reply-To: <20220504213251.264819-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aiobpk3ve3g3geno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 04, 2022 at 11:32:31PM +0200, Sebastian Reichel wrote:
> Add compatible string for rk3588 pin controller. No other changes
> are required, since the new controller can use the old binding.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

This patch has already been applied and I accidently resend it.
Please ignore.

-- Sebastian

>  Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.y=
aml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> index b0eae3a67ab1..e62fb5e9db76 100644
> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> @@ -44,6 +44,7 @@ properties:
>        - rockchip,rk3368-pinctrl
>        - rockchip,rk3399-pinctrl
>        - rockchip,rk3568-pinctrl
> +      - rockchip,rk3588-pinctrl
>        - rockchip,rv1108-pinctrl
> =20
>    rockchip,grf:
> --=20
> 2.35.1
>=20

--aiobpk3ve3g3geno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJz284ACgkQ2O7X88g7
+prDiBAAjKfr+0DCR6KkMpPqlTHOTGrVzK48kK3SKovBaEB12SpFGm6JjVmrjDFi
87sS6NIjz8VAoLbKIR9Jvznx9nrg5lm5A9XAwq8tJQa1PGUoj23hmshlQ5xwkYBB
d4ccesgEuOumHEoMA8FdXWe6geflTCiehaaQNpBS6y0gvfA/DHp/b2lvtDkTAB1X
zodwTs7Hu5Fcu4yUVai7SfCUf2p/B3uW8PwXowr5OFVjLfYFVui57ZX/1pioWEAy
StjCo7WRFwTKLZswNTgz1CGDIfp+74C6BoCDyI5RAlmCO2PGO+xtvTMtnS+C3+pN
HkHLRd5AluhvTqJCrxjOUbQyUVt/oo5k8mP3Wx5PCIbp7GS2vz6sHtugmVkrEQg7
VNEm/8krtLzRuRnpVqRUuv0pH6ISuKwiHTrCrtEtpVwuAmaY187r9B6VtOBj+Y+v
ajoSdRfCk8T/McvuJ6Ut6WgLL0LK7blQYo2SpWkI1rQu2NcikEs2DY3tAhAgKm8O
/owEOTtHLHvsX5bBLALg7GXgfCWYPVwvTiVSdNRNGmdUGa9s5IywThggQu+RG0hU
IDY+8bSH37udHDAinE0gIbStFzDweQT6RhuRrueoVmBT/Lgzx2looPzTkVKrdPRG
9ms3yw0hcGtR21VjmjCuW//MutObsThVvgQfD3SLGp0vYSRAUXA=
=bSaz
-----END PGP SIGNATURE-----

--aiobpk3ve3g3geno--
