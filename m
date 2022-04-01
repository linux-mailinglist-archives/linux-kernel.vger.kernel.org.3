Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2B84EF785
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbiDAQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbiDAP5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:57:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8929341C;
        Fri,  1 Apr 2022 08:28:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CD6A51F47CE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648826893;
        bh=0+Qy6DqL3DzylnNPp1BpGcwg8sHoEzTpg9tt+67cetk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaadmmE9l2jBobRHcuF+5apmP/oV1M+yQTgaQXh/490G5z2SvOZp7QLQgtzJgg9LJ
         kSSRoR/nvZ9CwLp45EzhG+gsEx3koHVUSuHt1JW59/t+bmT8pXUVS2QmnY9xmsUTpC
         X1WV89JttUN6+Th3tQeeGyVC1YwWsXUAEy4E+P0Xan4XfKtfPr4ZtwGN333euh6WrD
         N3loL42J+dcFCtia8Qc/ofLuqb3G3buKPaL9WdfbuFavNDoIIMZDK0K3IoFi0LcBXI
         AskMmI0jNnVIhTdrzAIT7CJxNibpnxmJUqkKLyDRo57zBD7XpsP3QwbD56h1ddTp85
         QH8WLFv/Q71Kg==
Received: by mercury (Postfix, from userid 1000)
        id 2CCD61060582; Fri,  1 Apr 2022 17:28:11 +0200 (CEST)
Date:   Fri, 1 Apr 2022 17:28:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        - <patches@opensource.cirrus.com>, linux-media@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix 'enum' lists with duplicate entries
Message-ID: <20220401152811.uv3wm55byrmk4gqc@mercury.elektranox.org>
References: <20220401141247.2993925-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gjfd7i3tbgmmz62e"
Content-Disposition: inline
In-Reply-To: <20220401141247.2993925-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gjfd7i3tbgmmz62e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 01, 2022 at 09:12:47AM -0500, Rob Herring wrote:
> There's no reason to list the same value twice in an 'enum'. Fix all the
> occurrences in the tree. A meta-schema change will catch future ones.
>=20
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: - <patches@opensource.cirrus.com>
> Cc: linux-media@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> There's also one other occurrence in snps,dwmac.yaml I didn't fix as=20
> there's a patch[1] for it which prompted this patch.
>=20
> Rob
>=20
> [1] https://lore.kernel.org/r/20220401030847epcms1p8cf7a8e1d8cd7d325dacf3=
0f78da36328@epcms1p8
>=20
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml        |  1 -
>  Documentation/devicetree/bindings/bus/ti-sysc.yaml    |  1 -
>  .../bindings/media/mediatek,vcodec-encoder.yaml       |  1 -
>  .../devicetree/bindings/pinctrl/cirrus,madera.yaml    | 11 +++++------
>  .../devicetree/bindings/power/supply/bq2415x.yaml     |  1 -
>  5 files changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-p=
mc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.ya=
ml
> index 0afec83cc723..564ae6aaccf7 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> @@ -13,7 +13,6 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> -      - nvidia,tegra20-pmc
>        - nvidia,tegra20-pmc
>        - nvidia,tegra30-pmc
>        - nvidia,tegra114-pmc
> diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.yaml b/Documen=
tation/devicetree/bindings/bus/ti-sysc.yaml
> index bd40213302da..fced4082b047 100644
> --- a/Documentation/devicetree/bindings/bus/ti-sysc.yaml
> +++ b/Documentation/devicetree/bindings/bus/ti-sysc.yaml
> @@ -34,7 +34,6 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - ti,sysc-omap2
>                - ti,sysc-omap2
>                - ti,sysc-omap4
>                - ti,sysc-omap4-simple
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-enco=
der.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.=
yaml
> index e7b65a91c92c..df7df06c378f 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -106,7 +106,6 @@ allOf:
>            enum:
>              - mediatek,mt8173-vcodec-enc
>              - mediatek,mt8192-vcodec-enc
> -            - mediatek,mt8173-vcodec-enc
> =20
>      then:
>        properties:
> diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml=
 b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
> index 8a90d8273767..6bd42e43cdab 100644
> --- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
> @@ -48,13 +48,12 @@ properties:
>                Name of one pin group to configure.
>              enum: [ aif1, aif2, aif3, aif4, mif1, mif2, mif3, pdmspk1,
>                      pdmspk2, dmic4, dmic5, dmic6, gpio1, gpio2, gpio3,
> -                    gpio4, gpio5, gpio6, gpio7, gpio7, gpio8, gpio9,
> +                    gpio4, gpio5, gpio6, gpio7, gpio8, gpio9,
>                      gpio10, gpio11, gpio12, gpio13, gpio14, gpio15,
> -                    gpio16, gpio17, gpio17, gpio18, gpio19, gpio20,
> -                    gpio21, gpio22, gpio23, gpio24, gpio25, gpio26,
> -                    gpio27, gpio27, gpio28, gpio29, gpio30, gpio31,
> -                    gpio32, gpio33, gpio34, gpio35, gpio36, gpio37,
> -                    gpio37, gpio38, gpio39 ]
> +                    gpio16, gpio17, gpio18, gpio19, gpio20, gpio21,
> +                    gpio22, gpio23, gpio24, gpio25, gpio26, gpio27,
> +                    gpio28, gpio29, gpio30, gpio31, gpio32, gpio33,
> +                    gpio34, gpio35, gpio36, gpio37, gpio38, gpio39 ]
> =20
>            function:
>              description:
> diff --git a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml =
b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
> index f8461f06e6f4..118cf484cc69 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
> @@ -16,7 +16,6 @@ allOf:
>  properties:
>    compatible:
>      enum:
> -      - ti,bq24150
>        - ti,bq24150
>        - ti,bq24150a
>        - ti,bq24151
> --=20
> 2.32.0
>=20

--gjfd7i3tbgmmz62e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJHGggACgkQ2O7X88g7
+po2uA/+OS0hkCudE7TWE85KDv5+/Qb+6/JFLz20iy0f8rQr3U1VOufXZccdMBmV
lPY7v8Tzl+P3F2tHUdy1A6MSRvSrfxGQi32YeaSR/jNylRY7Lpmm73psjokmXsX/
FZZMXB7SvHvSLPqIdfKfs9sxuWjeZqw/YsYTDXHvubTSX5LkDuxx1p9KYYoTtZ5y
jDDUYqCdc1j8+z6u302ErkzZLLxowhYXlfy5I0D3I9VlVA42X6+gVT6j108fgLMw
ARg8mB8LrTwigl+qpW4E91pH0IOwwVbyIoUAJOUEQlj2qsAxfxAvNOaAbT5KbRZS
Tj+4TqPQYM+srE8e4dqKCQHB5GQFqHlgFa4r4ATqaqCddL04Zvl1MhaVqoXIuGL/
NH28aDPnRib2ZR7JkbAQ77NyLnBFtfEbJ7EU58YeTkD+QWJ41Xj9OzH4oEDdurCx
ggml7FuQj4LaC4uy4cR2MDyHlsrg2wS24+R9rFeXc47HchTboXS14r+a5fOLetpp
BydxRULRfek5NWLZZGaWLzZZmWwGgG3/hNeNFXDPazkECoHC6HtfpNGX5XAuR3dx
/PUycmAYpb2KfL3gVZksITrrAZ2qc3tGJgn//rsmCHcouG1w5Kf9NlvRsCzCUAAY
gbTebdGk0p0ilzuOB4jo1QTy5xJgR6pUMzCWXigh4jkRzJU2pYI=
=3CSB
-----END PGP SIGNATURE-----

--gjfd7i3tbgmmz62e--
