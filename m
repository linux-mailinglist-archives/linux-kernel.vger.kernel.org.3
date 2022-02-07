Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7078D4AB7BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiBGJ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbiBGJOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:14:46 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0529C043181;
        Mon,  7 Feb 2022 01:14:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 33CCD580162;
        Mon,  7 Feb 2022 04:14:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Feb 2022 04:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=fRedpbJvF62LRmBCsc4UAgTChCDz35rCa9c3ci
        2rzcE=; b=E3qLLFzZ7x27Y6LGYr9p5KyryCJBq0fTvrNw8LxbhkWgm7tWSOr5Wc
        JbnbxsFuSUsPU3AMWGoXXkwVyYzsPpd7cKMxraS+vfBOsAP6RXX6VIAxE6T7K9GL
        tch10X6ZnAE59xSqMoY1qbzvn0B6EbWLJyrbGQ/2MLZRp6tQikW8gCgm3Jd5Q1Na
        SpU2MQFalf6xGxasAd4dASM241RuGZeLsOA5OmgA/u3y8UVxzYwIowmaFwju4phk
        g25SMC1J+QSqQOhim6zIu7/GvlE94Pu0yc17hjRWbrcZn6DDmaesxNi3IZvGSx27
        UP7+Iz5lBA1oCr6o61fS4vzkmD1FtNQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fRedpbJvF62LRmBCs
        c4UAgTChCDz35rCa9c3ci2rzcE=; b=QP8p8FYH3pvD7d5o73KBj4vhjRLiR+z9z
        TRrN7+R3EANMTHy3iMoJMNC7TaEO9SRLNwbd4oD3WyehaIsrK3qPRbW738g6Qj4u
        v0jkHQNQFJ0EyyGGnEcd8A9CkKtVRUDIzQQAxkj1uZ3QkunlEnPKJgSimILD9k3d
        5GlvvDy3zSDfGQSR8WooaX9GvuckVe/r2+Y+llLHLftrxSxEvbxB++ifo57gXMBs
        ErTLfM0lQ8nNwkPwXXzzQyeU7CS3Liz+ryqSQC+hT4zqQgIpmwWWdfi+YT5TMKAT
        6LH46blhcSIhS8POJVIkcI0LJL+bWGEogY7QQBlxLTuIrEDyIy4uQ==
X-ME-Sender: <xms:BOMAYof3azcAMomihQa81XeO9zKQSU-8KIHkUfBbEyybbkjMAd5aEw>
    <xme:BOMAYqPKxSP612NB0OXpxSqHnFK0CizFjiKI7LR-8tqS0E9rVVKyW4fqNIiBBrx87
    T0v0ERqN-yZ47h8D50>
X-ME-Received: <xmr:BOMAYpgR6g7_ov9BmI-SHxq4Ybisztl25b3RuX-0aEACVGWdtOp4HBthtUMm0tpFIgUUpPYXseaykQMhFR5GAN0nJYtDZuasCRdSggA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnh
    epleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieehgedunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BOMAYt95e_K_S2BJ39m6qk3bwJtnzmCnYmQakNATBSOYfQNFsOE00Q>
    <xmx:BOMAYksC6SXMDwIp4SsPpfxLzLUKyOnUEDIYn_WB1qgqGKjjAXVPng>
    <xmx:BOMAYkH4TyTnCiaOxgClyHSG7EGI69UQ6mn8MtCJKjN8CCV9Nzjd5A>
    <xmx:BeMAYvmg5KmshTQre1NNgPJa3WL6YlgrtRHk_zHrWpDIsD7YlpNEiw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:14:44 -0500 (EST)
Date:   Mon, 7 Feb 2022 10:14:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 21/66] media: sun6i-csi: Always set exclusive module
 clock rate
Message-ID: <20220207091443.cr5udv7fxx65ptty@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-22-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x7fslyfuomspr4ek"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-22-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x7fslyfuomspr4ek
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:44PM +0100, Paul Kocialkowski wrote:
> In some situations the default rate of the module clock is not the
> required one for operation (for example when reconfiguring the clock
> tree to use a different parent). As a result, always set the correct
> rate for the clock (and take care of cleanup).
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 54 ++++++++++++++-----
>  1 file changed, 41 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers=
/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 8155e9560164..2355088fdc37 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -154,9 +154,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_=
dev, bool enable)
>  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
> =20
>  		clk_disable_unprepare(csi_dev->clk_ram);
> -		if (of_device_is_compatible(dev->of_node,
> -					    "allwinner,sun50i-a64-csi"))
> -			clk_rate_exclusive_put(csi_dev->clk_mod);
>  		clk_disable_unprepare(csi_dev->clk_mod);
>  		reset_control_assert(csi_dev->reset);
>  		return 0;
> @@ -168,9 +165,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_=
dev, bool enable)
>  		return ret;
>  	}
> =20
> -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> -		clk_set_rate_exclusive(csi_dev->clk_mod, 300000000);
> -
>  	ret =3D clk_prepare_enable(csi_dev->clk_ram);
>  	if (ret) {
>  		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err %d\n", ret);
> @@ -190,8 +184,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_=
dev, bool enable)
>  clk_ram_disable:
>  	clk_disable_unprepare(csi_dev->clk_ram);
>  clk_mod_disable:
> -	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> -		clk_rate_exclusive_put(csi_dev->clk_mod);
>  	clk_disable_unprepare(csi_dev->clk_mod);
>  	return ret;
>  }
> @@ -819,6 +811,7 @@ static int sun6i_csi_resources_setup(struct sun6i_csi=
_device *csi_dev,
>  				     struct platform_device *platform_dev)
>  {
>  	struct device *dev =3D csi_dev->dev;
> +	unsigned long clk_mod_rate;
>  	void __iomem *io_base;
>  	int ret;
>  	int irq;
> @@ -856,28 +849,53 @@ static int sun6i_csi_resources_setup(struct sun6i_c=
si_device *csi_dev,
>  		return PTR_ERR(csi_dev->clk_ram);
>  	}
> =20
> +	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
> +		clk_mod_rate =3D 300000000;
> +	else
> +		clk_mod_rate =3D 297000000;
> +
> +	ret =3D clk_set_rate_exclusive(csi_dev->clk_mod, clk_mod_rate);
> +	if (ret) {
> +		dev_err(dev, "failed to set mod clock rate\n");
> +		return ret;
> +	}
> +
>  	/* Reset */
> =20
>  	csi_dev->reset =3D devm_reset_control_get_shared(dev, NULL);
>  	if (IS_ERR(csi_dev->reset)) {
>  		dev_err(dev, "failed to acquire reset\n");
> -		return PTR_ERR(csi_dev->reset);
> +		ret =3D PTR_ERR(csi_dev->reset);
> +		goto error_clk_rate_exclusive;
>  	}
> =20
>  	/* Interrupt */
> =20
>  	irq =3D platform_get_irq(platform_dev, 0);
> -	if (irq < 0)
> -		return -ENXIO;
> +	if (irq < 0) {
> +		dev_err(dev, "failed to get interrupt\n");
> +		ret =3D -ENXIO;
> +		goto error_clk_rate_exclusive;
> +	}
> =20
>  	ret =3D devm_request_irq(dev, irq, sun6i_csi_isr, 0, SUN6I_CSI_NAME,
>  			       csi_dev);
>  	if (ret) {
>  		dev_err(dev, "failed to request interrupt\n");
> -		return ret;
> +		goto error_clk_rate_exclusive;
>  	}
> =20
>  	return 0;
> +
> +error_clk_rate_exclusive:
> +	clk_rate_exclusive_put(csi_dev->clk_mod);
> +
> +	return ret;
> +}
> +
> +static void sun6i_csi_resources_cleanup(struct sun6i_csi_device *csi_dev)
> +{
> +	clk_rate_exclusive_put(csi_dev->clk_mod);
>  }

If you're going to have that function anyway, let's use
devm_add_action_or_reset, it'll simplify the rest of the patch.

Maxime

--x7fslyfuomspr4ek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDjAwAKCRDj7w1vZxhR
xSxCAP4jyX8jqgvGvO+h+wEMwjSChH7MxCJCEPSEVX9yx3zNIQD/ZClJPRAMyei5
KPjrNG4XdUDp1/dtKp57fzt1Uh1v1Qg=
=TZbY
-----END PGP SIGNATURE-----

--x7fslyfuomspr4ek--
