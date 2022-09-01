Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088845A9F56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiIASpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiIASp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:45:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8A714019;
        Thu,  1 Sep 2022 11:44:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20876B82793;
        Thu,  1 Sep 2022 18:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB16C433C1;
        Thu,  1 Sep 2022 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662057889;
        bh=s/op9FxbvGkr2I6H/gC1I7p8DUVgJEM5L483+D42ThM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrR749S74PopAnNaIl3UW/gVusvXahy69L9YlvBrwa9bniUwUOjmOrXYEmE6THWjt
         6yvBKINFol2Lq3pIfEOwKWMqO30c8RgV97y8ZpRTPVsdtcYfuXPsfNh1hpiiW2eJtm
         i2pk8gb3osKsuKC7eqxlsyWKsPblR1FloGxcMzJmQFk1cgTKRJ59VUT0rM27+TRpYL
         T+fqb2uxggsrTAkLJv59C0zOBNJAnfo/NHsXa9TYpGP3maP32SFfk+Imy30iLnZSxc
         lKqlHeczWoDerw2YcldhdoLdPHfXIOskL+jwjsW3SxV8BMEhrcQA8GJpFmCv0z4ppE
         KOsqIXGqeJXPQ==
Date:   Thu, 1 Sep 2022 19:44:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Max Krummenacher <max.oss.09@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: board regulators: add
 always-on
Message-ID: <YxD9m7sELdTUFFZ3@sirena.org.uk>
References: <20220901110422.1859621-1-max.oss.09@gmail.com>
 <YxD5+RCYtzcxEdjj@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DpOOspaFS25XZtxY"
Content-Disposition: inline
In-Reply-To: <YxD5+RCYtzcxEdjj@pendragon.ideasonboard.com>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DpOOspaFS25XZtxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 09:29:13PM +0300, Laurent Pinchart wrote:
> On Thu, Sep 01, 2022 at 01:04:22PM +0200, Max Krummenacher wrote:
> > From: Max Krummenacher <max.krummenacher@toradex.com>

> > These regulators are switched on by HW during power up and can not
> > be influenced by SW.
> > Set the always-on property.
>=20
> Is this needed ? When a fixed regulator has no control GPIO or clock, as
> is the case here, I would expect the driver and/or regulator core to
> understand that it's always on, as the alternative is always-off, which
> is pointless :-) Mark, Liam, what do you think ?

If there's no physical control setting always-on does nothing.

--DpOOspaFS25XZtxY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQ/ZoACgkQJNaLcl1U
h9Ah7Af/eClop9S6c76OEyEBONEjDIhgOGDj3ZrMnv/zOT+QFavuVcsAQp3uWx9c
sPQ7hXEh6etyMD6WxBO6JcEpOQr7zIZT5aOZELo9zw7wbsW9j/lRt427s/5xh3kM
4wkPYNeKzJKHeGQ6IplTC6M+U9avCVDudzPGJ0oymvFqHjyZpoYZZkYZ6lnpre7E
xIVjs9/60+XQuGWILbnc0I82AWZMBPzmmfXj74I9mMa9lXHHoPo3+e19c61+O6+u
SHIWv/wX6TSyfp1X78NdjfgFhMENwFC5U/FlNGVtfmNyQjrWp0wnA57JdNFzaQjX
GmoNzkdXrb8g/YAbrGoScayspR83Jw==
=F2cr
-----END PGP SIGNATURE-----

--DpOOspaFS25XZtxY--
