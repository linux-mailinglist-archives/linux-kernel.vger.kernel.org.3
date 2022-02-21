Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58684BDCC7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348910AbiBUJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:23:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349727AbiBUJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:12:52 -0500
X-Greylist: delayed 530 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 01:05:52 PST
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7A2CC86;
        Mon, 21 Feb 2022 01:05:51 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ED5B45C0112;
        Mon, 21 Feb 2022 03:56:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 03:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=GuQIZ2iZqIrEQEflPSXrk8GW5VDt9CYqd8elpg
        nUzwA=; b=q9tvO2zYfehBWwAthoML4tuldJGHH5qeZCO5nuuOyTnGgfjaqewO3K
        hwWlZWjv9BVuI8ycEiMUyEfXPmJ1HeFA+j0dyv9e9IHAso0m2i73ezhUcOPNcFBj
        WaYdyPt351hF2AGQu3vtfIbGW0cZrBuuu6dVlD2i9RXQYu3Fc7oAYBhnfC3J05/L
        q4uDL1HY/x6SWUr1WiUP6XMlhtOWtc7yZ0kIhl+HuvNFN1XEVebaXpWfOdZrj6fy
        Z25CQNn0yZ4NSC6iji6A4PinRW5uJlfFrBaWN8U/X4jRuuDd645POzr06shXfrcY
        ZJ3/EjjO6oNYocvVIgJk/Xa7cgmeS5Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GuQIZ2iZqIrEQEflP
        SXrk8GW5VDt9CYqd8elpgnUzwA=; b=nmMnI7VHIGfRzaG6PRSKtTE6jQVvD9kta
        CXS+Oz19iOLMdrHwGEv+FLCsX9yO5N97SLJ1RR0Xy/1LLb/xaPyeQx9XAkIVL00H
        1IAdlT6cdEyjAaURNzABnCUVa1ZQeJKBTW23wY81Zehc9ilb2pfyoHjuyPPLsvOY
        XKcCfndRkgzpfIQlwoWIn135H33HDgXUzxK4L53jbIIO8lnfcswm70r2xtg8OQKM
        vRLg8bG/ucYuEbpGcqaMJvo2ft2TxUsTlmby3PIzMgVwxfOyeWX8HdXMDwKDGCXY
        5komf+wPlVoCbd30D4P/SYgUPNFR9kHIl+GrFJX48Q24J2EMc2+8g==
X-ME-Sender: <xms:tVMTYg1d8MmLyU1nY1Os2gEKIeY6hr2ZaNzlwTY5MIFuKN3AD8E6nw>
    <xme:tVMTYrFo40QPH8RC59s_Fz3UpE_7zSN4U09a3pwXGj8Jp80JJrRGOjNX2tAOfcGBP
    Q02C-KTYVLnVuQj9TQ>
X-ME-Received: <xmr:tVMTYo7xbp3-lPXR_wxxtdkjQiPb20Dth4IgD2tZ1KFSWrhafVXdG6RvWvta3OBq-VUH0N1BB5J_aagXMh2-idtSm2HBAJTfpeCheQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tVMTYp3ZDc2dutWoYagaZiGdUcVydtJlheCR0viksTc0IrYVXjLu3w>
    <xmx:tVMTYjF6aL-sANvVxWIN-44MYNmT7FBx4DCKuJBmoGKgnPXCKykfiA>
    <xmx:tVMTYi-pVgGcJ4gfirP7OpRvQzn9bha6H4aTi5tKpAFw0B4w2xdIGA>
    <xmx:tVMTYo4fE9zY91To63P92_EfnvrEUtPsqlqgGBGMTrF_ilCuHA_PxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:56:21 -0500 (EST)
Date:   Mon, 21 Feb 2022 09:56:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rcar-du: switch to devm_drm_of_get_bridge
Message-ID: <20220221085619.bqyr2etq4xjjqa4p@houat>
References: <20220221073757.12181-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ofdvmxr6sl77fz6"
Content-Disposition: inline
In-Reply-To: <20220221073757.12181-1-jose.exposito89@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ofdvmxr6sl77fz6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 08:37:57AM +0100, Jos=E9 Exp=F3sito wrote:
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
>=20
> Switch to the new function and reduce boilerplate.
>=20
> Signed-off-by: Jos=E9 Exp=F3sito <jose.exposito89@gmail.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_lvds.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-d=
u/rcar_lvds.c
> index 72a272cfc11e..99b0febc56d1 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -712,18 +712,12 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvd=
s)
>  {
>  	int ret;
> =20
> -	ret =3D drm_of_find_panel_or_bridge(lvds->dev->of_node, 1, 0,
> -					  &lvds->panel, &lvds->next_bridge);

I guess lvds->panel can be removed from the rcar_lvds struct as well?

Maxime

--6ofdvmxr6sl77fz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhNTswAKCRDj7w1vZxhR
xU/eAQCmw1HQxm098L+p+YiwegyR3+twcrqcOxK/DodXRAomOgD6A8vHaRQWuB1Q
D5yYUwJMY5F66g25xbAN1hUn0IQd9g4=
=bNix
-----END PGP SIGNATURE-----

--6ofdvmxr6sl77fz6--
