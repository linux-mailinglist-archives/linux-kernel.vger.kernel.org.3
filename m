Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7A54BE93E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354721AbiBUKZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:25:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354472AbiBUKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:24:52 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E322654BB;
        Mon, 21 Feb 2022 01:44:24 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id D573358024F;
        Mon, 21 Feb 2022 04:44:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 21 Feb 2022 04:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=YFa5jUU3KrF/YDxKOJgoW2+M7u2R0uJhrpf1z1
        0gtxA=; b=cYcUCZ1jNfC3HeQ5e4s4sPFXlx/VPIBplIIXDGQAx78Vzw2nHiJXNP
        YQi5tNuJTSjEZo/jBGXBgmEFPr33GkK0bNcB4QpXwxw7J/r1QeCPa6mDulm1cA5g
        tE8a/ZnL099cQJSNBW+NlZDbEyMq0rQ45EGNvpzZebqRhOp62HnfUoCdgaphMTJ/
        7pB07Jn+UdkOK5Rrb02VC04Cj0T2gMonASPatdRD6i9Vs6c+QhyR5NiS9YuvKYmv
        Qo9nriRSm4Ywzyt9HCJPUnx7pPNG/7NhcMk68NdO3WJrLpAzmBVjqBL9u0+NTixu
        9FmqCQbYuTL3loH6/RvOga30pVP2EfaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YFa5jUU3KrF/YDxKO
        JgoW2+M7u2R0uJhrpf1z10gtxA=; b=CuGmbBH2yZM/tN0RF6gQ2JojEipFEGFeL
        BZKGcqEBRbwBonXWIFGs+1ZkYxkZ/MF1agHLnOdN76U17Ao9TtGdAYhDrX0oLHSm
        ePu2JuXtouG7Z3WNix5Yc0LJLzyQ1lgvBr7Q2x5qZbS3bfiBvpznJN3Bmcqcu4Tr
        WtZU40qTjlDE2v/h5MJy+cCD4mbq2JKcspRgXo1/jRFttXGdw/400nMPy7Y5VJCV
        9IXIgle3LSWBgih8Wt2pnOvV4ovCwlcRbcazJ8MgPtuNY4eAusAbJjE0Xmfz8mvJ
        QjHuMi0+CCPlmILYFg5nr8bBVo91Q5vL73MnFfJS0KNTBVlVdHFrQ==
X-ME-Sender: <xms:9l4TYsl7BF6bRbMBrUgQcmy7gQowavSpHguRPSbuFr_xV1MbagVNpg>
    <xme:9l4TYr1mYcIKK54M-C_uozcekH7xA4_ClAMTDyk6ZE7q8FPDPYiDJJGa92tYiP0HU
    XhznIF0VzLZuuVTZ4c>
X-ME-Received: <xmr:9l4TYqrkYtlZ1ytkayfzv_4T8Y8z67vq_tlZ9fOhNdVmEnWkwWmXc8UFQ5301MIr--7Gs3f7PvFuyL29fTfWQZOzjYvV0-2JCWx9P_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeeigddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9l4TYomEJ-ZjCs_92YwnwIBcgV-gp4Ar3PG7J4I8mr07NwHmjm3zLg>
    <xmx:9l4TYq1Idrh8P3UZnU7ND2lqCQEkwdTefvHzkTLdEeI1k5jMkMsUdQ>
    <xmx:9l4TYvv7ClZcd6sG4OksiD03IEpV94CIiTZ04MAnBxPGt-CNPb6QTA>
    <xmx:914TYoku-Hhj0D6W8qhR3GE9FNbBY8R6VKHRd7il7dVACwnTMzDoFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 04:44:22 -0500 (EST)
Date:   Mon, 21 Feb 2022 10:44:20 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        matthias.bgg@gmail.com, chunfeng.yun@mediatek.com, kishon@ti.com,
        vkoul@kernel.org, deller@gmx.de, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH v8 13/19] drm/mediatek: dpi: Add dpintf support
Message-ID: <20220221094420.5oqsydyjvub7d7h3@houat>
References: <20220218145437.18563-1-granquet@baylibre.com>
 <20220218145437.18563-14-granquet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxtxdllufu67cl2f"
Content-Disposition: inline
In-Reply-To: <20220218145437.18563-14-granquet@baylibre.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxtxdllufu67cl2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

(Now I remember your series ;)

On Fri, Feb 18, 2022 at 03:54:31PM +0100, Guillaume Ranquet wrote:
> dpintf is the displayport interface hardware unit. This unit is similar
> to dpi and can reuse most of the code.
>=20
> This patch adds support for mt8195-dpintf to this dpi driver. Main
> differences are:
>  - Some features/functional components are not available for dpintf
>    which are now excluded from code execution once is_dpintf is set
>  - dpintf can and needs to choose between different clockdividers based
>    on the clockspeed. This is done by choosing a different clock parent.
>  - There are two additional clocks that need to be managed. These are
>    only set for dpintf and will be set to NULL if not supplied. The
>    clk_* calls handle these as normal clocks then.
>  - Some register contents differ slightly between the two components. To
>    work around this I added register bits/masks with a DPINTF_ prefix
>    and use them where different.
>=20
> Based on a separate driver for dpintf created by
> Jason-JH.Lin <jason-jh.lin@mediatek.com>.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c          | 164 +++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_dpi_regs.h     |  38 +++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   8 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   5 +-
>  include/linux/soc/mediatek/mtk-mmsys.h      |   2 +
>  6 files changed, 198 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediate=
k/mtk_dpi.c
> index be99399faf1bb..c5639ada868f8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -63,6 +63,14 @@ enum mtk_dpi_out_color_format {
>  	MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL
>  };
> =20
> +enum TVDPLL_CLK {
> +	TVDPLL_PLL =3D 0,
> +	TVDPLL_D2 =3D 2,
> +	TVDPLL_D4 =3D 4,
> +	TVDPLL_D8 =3D 8,
> +	TVDPLL_D16 =3D 16,
> +};
> +
>  struct mtk_dpi {
>  	struct drm_encoder encoder;
>  	struct drm_bridge bridge;
> @@ -71,8 +79,10 @@ struct mtk_dpi {
>  	void __iomem *regs;
>  	struct device *dev;
>  	struct clk *engine_clk;
> +	struct clk *dpi_ck_cg;
>  	struct clk *pixel_clk;
>  	struct clk *tvd_clk;
> +	struct clk *pclk_src[5];
>  	int irq;
>  	struct drm_display_mode mode;
>  	const struct mtk_dpi_conf *conf;
> @@ -126,6 +136,7 @@ struct mtk_dpi_conf {
>  	const u32 *output_fmts;
>  	u32 num_output_fmts;
>  	bool is_ck_de_pol;
> +	bool is_dpintf;
>  	bool swap_input_support;
>  	// Mask used for HWIDTH, HPORCH, VSYNC_WIDTH and VSYNC_PORCH (no shift)
>  	u32 dimension_mask;
> @@ -384,6 +395,25 @@ static void mtk_dpi_config_disable_edge(struct mtk_d=
pi *dpi)
>  		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
>  }
> =20
> +static void mtk_dpi_matrix_sel(struct mtk_dpi *dpi, enum mtk_dpi_out_col=
or_format format)
> +{
> +	u32 matrix_sel =3D 0;
> +
> +	switch (format) {
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422:
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL:
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_444:
> +	case MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL:
> +	case MTK_DPI_COLOR_FORMAT_XV_YCC:
> +		if (dpi->mode.hdisplay <=3D 720)
> +			matrix_sel =3D 0x2;
> +		break;
> +	default:
> +		break;
> +	}
> +	mtk_dpi_mask(dpi, DPI_MATRIX_SET, matrix_sel, INT_MATRIX_SEL_MASK);
> +}
> +
>  static void mtk_dpi_config_color_format(struct mtk_dpi *dpi,
>  					enum mtk_dpi_out_color_format format)
>  {
> @@ -391,6 +421,7 @@ static void mtk_dpi_config_color_format(struct mtk_dp=
i *dpi,
>  	    (format =3D=3D MTK_DPI_COLOR_FORMAT_YCBCR_444_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, false);
>  		mtk_dpi_config_csc_enable(dpi, true);
> +		mtk_dpi_matrix_sel(dpi, format);
>  		if (dpi->conf->swap_input_support)
>  			mtk_dpi_config_swap_input(dpi, false);
>  		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_BGR);
> @@ -398,6 +429,7 @@ static void mtk_dpi_config_color_format(struct mtk_dp=
i *dpi,
>  		   (format =3D=3D MTK_DPI_COLOR_FORMAT_YCBCR_422_FULL)) {
>  		mtk_dpi_config_yuv422_enable(dpi, true);
>  		mtk_dpi_config_csc_enable(dpi, true);
> +		mtk_dpi_matrix_sel(dpi, format);
>  		if (dpi->conf->swap_input_support)
>  			mtk_dpi_config_swap_input(dpi, true);
>  		mtk_dpi_config_channel_swap(dpi, MTK_DPI_OUT_CHANNEL_SWAP_RGB);
> @@ -438,6 +470,8 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
>  	mtk_dpi_disable(dpi);
>  	clk_disable_unprepare(dpi->pixel_clk);
>  	clk_disable_unprepare(dpi->engine_clk);
> +	clk_disable_unprepare(dpi->dpi_ck_cg);
> +	clk_disable_unprepare(dpi->tvd_clk);
>  }
> =20
>  static int mtk_dpi_power_on(struct mtk_dpi *dpi)
> @@ -447,12 +481,24 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  	if (++dpi->refcount !=3D 1)
>  		return 0;
> =20
> +	ret =3D clk_prepare_enable(dpi->tvd_clk);
> +	if (ret) {
> +		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
> +		goto err_pixel;
> +	}
> +
>  	ret =3D clk_prepare_enable(dpi->engine_clk);
>  	if (ret) {
>  		dev_err(dpi->dev, "Failed to enable engine clock: %d\n", ret);
>  		goto err_refcount;
>  	}
> =20
> +	ret =3D clk_prepare_enable(dpi->dpi_ck_cg);
> +	if (ret) {
> +		dev_err(dpi->dev, "Failed to enable dpi_ck_cg clock: %d\n", ret);
> +		goto err_ck_cg;
> +	}
> +
>  	ret =3D clk_prepare_enable(dpi->pixel_clk);
>  	if (ret) {
>  		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
> @@ -462,10 +508,11 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
>  	if (dpi->pinctrl && dpi->pins_dpi)
>  		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
> =20
> -	mtk_dpi_enable(dpi);
>  	return 0;
> =20
>  err_pixel:
> +	clk_disable_unprepare(dpi->dpi_ck_cg);
> +err_ck_cg:
>  	clk_disable_unprepare(dpi->engine_clk);
>  err_refcount:
>  	dpi->refcount--;
> @@ -497,12 +544,21 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi =
*dpi,
>  	pll_rate =3D clk_get_rate(dpi->tvd_clk);
> =20
>  	vm.pixelclock =3D pll_rate / factor;
> -	if ((dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_LE) ||
> -	    (dpi->output_fmt =3D=3D MEDIA_BUS_FMT_RGB888_2X12_BE))
> +	if (dpi->conf->is_dpintf) {
> +		if (factor =3D=3D 1)
> +			clk_set_parent(dpi->pixel_clk, dpi->pclk_src[2]);
> +		else if (factor =3D=3D 2)
> +			clk_set_parent(dpi->pixel_clk, dpi->pclk_src[3]);
> +		else if (factor =3D=3D 4)
> +			clk_set_parent(dpi->pixel_clk, dpi->pclk_src[4]);
> +		else
> +			clk_set_parent(dpi->pixel_clk, dpi->pclk_src[2]);

You get a reference to these clocks using:
>
> +	dpi->pclk_src[1] =3D devm_clk_get(dev, "TVDPLL_D2");
> +	dpi->pclk_src[2] =3D devm_clk_get(dev, "TVDPLL_D4");
> +	dpi->pclk_src[3] =3D devm_clk_get(dev, "TVDPLL_D8");
> +	dpi->pclk_src[4] =3D devm_clk_get(dev, "TVDPLL_D16");
> +

So if the clock isn't there, you'll get an error pointer, won't check
it, but will dereference it.

If the clock is optional, you should use clk_get_optional, otherwise you
should check the error returned.

That clock setup is weird though. I don't have any knowledge about your
platform, but either the clock should be a single one if it has multiple
dividers, or the pixel_clk clock should behave as a mux and just pick
the best parent for the rate it's given.

Maxime

--mxtxdllufu67cl2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhNe9AAKCRDj7w1vZxhR
xZD9AP91O+iCA+oHunP0FdQgpbmuusRwiSwUSKnC/DDy2qhn1wD/cICG3LEZZf3T
pPzKNzBqV1wgRv3Wjk2f8NN2kJEmOA0=
=kmtj
-----END PGP SIGNATURE-----

--mxtxdllufu67cl2f--
