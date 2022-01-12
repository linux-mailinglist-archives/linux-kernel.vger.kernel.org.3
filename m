Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FAE48C10F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352091AbiALJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:34:19 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47699 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238079AbiALJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:34:18 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 37BCF5C01D9;
        Wed, 12 Jan 2022 04:34:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Jan 2022 04:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=nSi69K8gaCgxD8PERPpX2MbEXfG
        odendEfrDj5aR6zg=; b=PXInPjp7CShsxgmDyZXuJmRtSJ1aWAcINblm17yKHuG
        uN2NBTHcY8rrYLGDBkvgd05VYrkZCHQs5tN0WD4xerEXEOLtsvkj1ycnb04EUktI
        LdlmehsTJoO4V+ARTc9CGCaXAtfncVIxCGYtUOpvxoQF3oaQ63VqRRTyVn8ZzMGV
        y0ztAZEs5GI0ySqaBULEruxJ9Lxn18130OmWrFqoLVc4cL2FmelYUZo0ifYjeKr1
        cKJ5z2koX2PHtW3W5UfscBwuBKe/eu94uwf8Swa7LIejkxC9HwtRpj4u0/DtChAH
        LYFUmVmOZ07p/mvuOby4qd3DBFg6jC/a7NhXR2gdGGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nSi69K
        8gaCgxD8PERPpX2MbEXfGodendEfrDj5aR6zg=; b=CyIrNRVubvEw5KPJEY2iNX
        +Qhxie9sFBuV9CKDJNM94M+t3ZRTOnsL/xPQb8WDXZLke4bgtvRwr1qR1AGrEakp
        sbn120YNRZo2AcvKA8plNiF5g8tyreaNligFMvNDpY/GrtqbD4CSA/oFn2m644n5
        ymNY0jQ9Lm85m1xCoug6NwMPcizZmwyurGt/r7M4BPDR/yqNmCCTSD83KRd0DxJI
        F3hq+jJDVMg1bDbJxLBpv/momrKHbgvhP1NBdnGgngkdSNtdUUt2R2OgGgb03fCw
        MgjD0oE9nplYsaHXzyM82ffLNHL+UY2tjm4r03OPM0DuN4TMfGbZUkBm95x5vCFQ
        ==
X-ME-Sender: <xms:maDeYWKDVRLD8PxbQ6poUErvN6XbjHYDZ4MgmVl8f69DdgLzGt0tHA>
    <xme:maDeYeIYwQRZBtrGYMmQNro2sBcN0vnE6RKxSHrf9vOmBJnbbTQoIHW_wB9XrJz5O
    0Evywo_iqsxRvMuaoE>
X-ME-Received: <xmr:maDeYWv8SmZzMYPLWGauYO1ajzNR5-fglAcLx0oaQ1fScJjUFejGqv-elOOsF9zejeodA8Drp4DPikzzSEsXKpGUT6e2ymYgpQWSmW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehhedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:maDeYbYHPa7gRM4h0Xv7o4CDKtZmCOmr0JAGuq_4b0GZp4dIrdICAg>
    <xmx:maDeYdaQ9TD5USGKXqM3Bh3xH8hojFjovuPJcy-SiSJuxYP3H4-WoQ>
    <xmx:maDeYXCL3RJV5pPCc--ev-VpJQT4WFzdYLhLBfEojKmDxORMKDXsTA>
    <xmx:mqDeYbPVLUe_l9UW2ZW8FCNrLSPVA_0gUwfCM7M88tAm1RctSSTDiQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jan 2022 04:34:17 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:34:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     ulf.hansson@linaro.org, wens@csie.org, samuel@sholland.org,
        andre.przywara@arm.com, jernej.skrabec@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sunxi-mmc: check ocr_avail on resource request
Message-ID: <20220112093415.wdy3ht5yizw5lffl@houat>
References: <20220104060325.3957-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pow7a6h6ea2halol"
Content-Disposition: inline
In-Reply-To: <20220104060325.3957-1-michael@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pow7a6h6ea2halol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 04, 2022 at 02:03:25PM +0800, Michael Wu wrote:
> Some platforms have no regulator, discrete power devices are used instead.

Is it really the case? vmmc at least should be mandatory so a platform
not having a regulator would violate the binding itself.

> However, sunxi_mmc_probe does not catch this exception when regulator is
> absent in DTS. This leads to sd or eMMC init failure.

This will still happen with your patch though?

> To solve this, a fixed vmmc regulator must be hooked up in DTS, like this:
> reg_dummy_vmmc: dummy_vmmc {
> 	compatible =3D "regulator-fixed";
> 	regulator-name =3D "dummy-vmmc";
> 	regulator-min-microvolt =3D <3300000>;
> 	regulator-max-microvolt =3D <3300000>;
> };
>=20
> mmc0:mmc@4020000 {
> 	compatible =3D "allwinner,sun50i-a100-emmc";
> 	device_type =3D "mmc0";
> 	vmmc-supply =3D <&reg_dummy_vmmc>;
> }
>=20
> In this patch, we print an error message and abort the probe process if
> the regulator is not specified in DTS.

I'm fine with the patch itself, but it's really not clear to me what
situation is being fixed or improved here.

You're first mentioning that this is fixing the driver probing even if a
regulator is absent, but then states (rightfully) that in such a case we
should use a fixed regulator. So we should always have a regulator then?

I assume that you want the driver to properly error out instead of going
on if either a regulator is missing or if its voltages are out of range?

If the former, then we should probably check if host->mmc->supply.vmmc
returned an error. If the latter, then yes, checking ocr_avail is
probably fine but we should make it clearer in the error message that
it's what it's about.

Maxime

--pow7a6h6ea2halol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYd6glwAKCRDj7w1vZxhR
xYMDAQDOvoByLoNbucD0rg09oRxg0ac/oM8XXvRnOEoOgNtc6AD7B4fNMTPoPSrt
SOyuoXTJa0OcH67vLGECca6JGG6L/gg=
=5+yC
-----END PGP SIGNATURE-----

--pow7a6h6ea2halol--
