Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DE648C0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349430AbiALJU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:20:58 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47765 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238292AbiALJU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:20:57 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BCC15C0079;
        Wed, 12 Jan 2022 04:20:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Jan 2022 04:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=V+GbNSPBdICaZKehO+PC4kEUsaB
        EXQDl4qLU+2VgtCk=; b=B+onJ4TC5FsYfNdGlXGkmB7EI/LR4jr+5mMGyKN+SNg
        lztvN0zNHoVIq5q2cZoDS6tBGBQJKQ+Bs4fZvcSytUTiO3p4BLYPmEgSkM/wDSyY
        8Mx1KoWsCRzwjBMyN3uNhjJptxc2oAzp7Nkw747Ojz6rgo8Fgv7r/lZbuJ+7ADvy
        aZuFEaqIlAAuzDUWlZr/c1jkfymyOkYjCg8Uu3ViQMf1WlqT6Hi7uADfedcXwsEY
        9txzMYNzigtUwY13wNQvT7Fw2/T8QJLV+4ZCYeSlB5dWTlAD/oA+knhidpdALEqJ
        Hg0WCUlnGyv/dJH7c+x+BYk75YUwIF+wA+oCSvGgICQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V+GbNS
        PBdICaZKehO+PC4kEUsaBEXQDl4qLU+2VgtCk=; b=Vn8EuFshYYWqDRfu8bbAVb
        4P8KYMLNyFv+CQ0zJ24q1f5Xgr315b2l1S/MAGyijhM9B7CP1PEoPG80Fpy0yPLq
        KsuCs9XLKmSjbRgRGgPFMPLTGrBITTitAOLDgmnYSmQC8HoROlV0Oq6IT0T+Az2c
        bR/t7eEH2wfvSeffjXX4IBeVuV3Gnug60Fq4pQy9C/o3h83Tcwq5IC9vR5AhYVrP
        bn/hYYuWXDhrinZv+ODmYCvoKsoEDXtyZAYcuIWPKsBhwQgrSYE2j95HZFWRJnhA
        1Wyldluxag40wPsizr3t2EyKLkfpHnv08lrSVH3ZRQ9VEksyZ/QsmkGmmb7n4fWQ
        ==
X-ME-Sender: <xms:eJ3eYVtLivXks0Lo1j1X3k40KaYs9UH4AfWuOOs2ZX2D-ywkCNX3vg>
    <xme:eJ3eYefzb3WNeaWUyRJ6maBE9fkBO_bHqhFocP3BLDzFcThax0HjZ31B5Ee5-xoqG
    O0umP0piN84psVqvJQ>
X-ME-Received: <xmr:eJ3eYYy7ILhrB4KQTNA1LWuD3LTY8S37TH60Ai5qHoDZeHlWjsVyQ_gQdRIUUD9USHkXSCjWhvb9Nsd9j2lubww0RaZu2--KsWC35Rc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehhedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:eJ3eYcMOY2Brwe45QOyu9PtKPzGPP2E_lUpTIA5LZvwmFfYinSQ7wQ>
    <xmx:eJ3eYV8_ePtoPGIjt_2n_vm4lK44NpI53XFF3LuUb5VzO9MrQx7H_w>
    <xmx:eJ3eYcXxnGmEHkt8YL7oBx8vR1k5xKJ_S86-Z30G_RfgwZCSYDLgyA>
    <xmx:eZ3eYRSf5bQozSvczJvW58RTM7y15QEiyclZ3HrGsbXqwPyCUkM6UQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jan 2022 04:20:55 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:20:54 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     ulf.hansson@linaro.org, wens@csie.org, samuel@sholland.org,
        andre.przywara@arm.com, jernej.skrabec@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc:sunxi-mmc:fix clock division for timing mode
Message-ID: <20220112092054.4agh3lydvibea5wh@houat>
References: <20211222031521.34170-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fymmmzrzovlh7ofo"
Content-Disposition: inline
In-Reply-To: <20211222031521.34170-1-michael@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fymmmzrzovlh7ofo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Thanks for your patch

On Wed, Dec 22, 2021 at 11:15:21AM +0800, Michael Wu wrote:
> When use new timings,all speed mode requires a doubled module clock
> if speed mode is ddr,requires a four times module clock
> When use old timings,only 8 bit ddr requires a doubled module clock
>=20
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index afeefead6501..7b47ec453fb6 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -774,20 +774,23 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_=
host *host,
>  	if (!ios->clock)
>  		return 0;
> =20
> -	/*
> -	 * Under the old timing mode, 8 bit DDR requires the module
> -	 * clock to be double the card clock. Under the new timing
> -	 * mode, all DDR modes require a doubled module clock.
> -	 *
> -	 * We currently only support the standard MMC DDR52 mode.
> -	 * This block should be updated once support for other DDR
> -	 * modes is added.
> +	/**
> +	 * When use new timings, all speed mode requires a doubled module clock.
> +	 * if speed mode is ddr, requires a four times module clock.
> +	 * When use old timings, only 8 bit ddr requires a doubled module clock.
>  	 */

I found the original comment to be clearer, maybe we can change it to
something like:

    /*
     * Under the old timing mode, 8 bit DDR requires the module
     * clock to be double the card clock. Under the new timing
     * mode, all modes require a doubled module clock, and DDR modes
     * require a quadrupled module clock.
     *
     * ...

> -	if (ios->timing =3D=3D MMC_TIMING_MMC_DDR52 &&
> -	    (host->use_new_timings ||
> -	     ios->bus_width =3D=3D MMC_BUS_WIDTH_8)) {
> -		div =3D 2;
> +	if (host->use_new_timings) {
>  		clock <<=3D 1;
> +		if (ios->timing =3D=3D MMC_TIMING_MMC_DDR52) {
> +			div =3D 2;

Shouldn't that be 4?

> +			clock <<=3D 1;
> +		}
> +	} else {
> +		if (ios->timing =3D=3D MMC_TIMING_MMC_DDR52 &&
> +				(ios->bus_width =3D=3D MMC_BUS_WIDTH_8)) {

This creates some checkpatch.pl --strict warnings

Maxime

--fymmmzrzovlh7ofo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYd6ddgAKCRDj7w1vZxhR
xaLiAP47v9sW+jH0z6DXKRDumXm1PSSMgqdjfsjbfy1lddD97gD9FGv36UyHu+Do
VjNu5T34Utzn7S9mZeT4p/pUA5ic/wY=
=F8YC
-----END PGP SIGNATURE-----

--fymmmzrzovlh7ofo--
