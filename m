Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAC459C526
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiHVRkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbiHVRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:40:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6340BFE;
        Mon, 22 Aug 2022 10:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 742F7B816DD;
        Mon, 22 Aug 2022 17:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0915C433D6;
        Mon, 22 Aug 2022 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661190000;
        bh=6CmQdowko0m3VEWl0fKzK9C0KmgTv5BlYHbJQN96nP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Js2/6HWDWg4NXMH8+tRxvjuUIGmcjy7run71WD6MSM/AxdIYKI24l4Ioagg88clJu
         2OzQ7ZBhMhpWBnwp/SZPh9w5cseL5P2hF97CMWTZgVA2ZE1MOnngKTyk7qjWTx7Bzn
         muUfo1KOOLzrLJuD6zJviWHZqgR18jy/i0xheu4oaLw6QWqIz0bRa+RusaLpDceMx3
         ppgHLAjtcNjQoe8fMxYi+VPx7eFoUbXWY3PvgVnf2ioweZ6w7Mvqg/4pZsVoiBi2er
         WYGY+r0QaqCUC9PyMSjr5JqJgrcLw9cisr2i5bCF+clJc+QQ62deyf/Z8sYERWKsZX
         FDQVzbkUemRDw==
Date:   Mon, 22 Aug 2022 18:39:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: apple: mca: Start new platform driver
Message-ID: <YwO/aqs7eqZx07kS@sirena.org.uk>
References: <20220819125430.4920-1-povik+lin@cutebit.org>
 <20220819125430.4920-4-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qCefvYX0tdeieUPa"
Content-Disposition: inline
In-Reply-To: <20220819125430.4920-4-povik+lin@cutebit.org>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qCefvYX0tdeieUPa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2022 at 02:54:29PM +0200, Martin Povi=C5=A1er wrote:

This all looks good, one style nit and a couple of requests for
clarification below but basically this is fine.

> +++ b/sound/soc/apple/mca.c
> @@ -0,0 +1,1149 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Apple SoCs MCA driver
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + *
> + * The MCA peripheral is made up of a number of identical units called c=
lusters.

Please make the entire comment block a C++ one so things look more
intentional.

> +#define USE_RXB_FOR_CAPTURE

What's this all about?

> +static int mca_fe_enable_clocks(struct mca_cluster *cl)
> +{
> +	struct mca_data *mca =3D cl->host;
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(cl->clk_parent);
> +	if (ret) {
> +		dev_err(mca->dev,
> +			"cluster %d: unable to enable clock parent: %d\n",
> +			cl->no, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * We can't power up the device earlier than this because
> +	 * the power state driver would error out on seeing the device
> +	 * as clock-gated.
> +	 */
> +	cl->pd_link =3D device_link_add(mca->dev, cl->pd_dev,
> +				      DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME |
> +					      DL_FLAG_RPM_ACTIVE);

I'm not clear on this dynamically adding and removing device links stuff
- it looks like the main (only?) purpose is to take a runtime PM
reference to the target device which is fine but it's not clear why
device links are involved given that the links are created and destroyed
every time the DAI is used, AFAICT always in the same fixed
relationship.  It's not a problem, it's just unclear.

--qCefvYX0tdeieUPa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDv2kACgkQJNaLcl1U
h9Apnwf8DfhwTXhkRk42QdwLlD8jY+ALJxnAnI9N0WL27+ro0ik9D4csIFZ0yyep
peioVGWLjZDtHb8hU/MA6iwVIjrGfFOaRzacALHikXMaknAqzNGAcY3iYt2PrivX
l6glTR9aQZ9wqdVYbHjSpStEu4D1Fb+QzdgtJyPTFiduuGhv13pAGscTUmpTHaiL
Oy80EJMZ1T/TUXevPew4EALeIZiT3dBch98K5VAEhpLpAQlyGjNAaJNMcHHBVyrB
0NRvDmrVO+pXfiXQb0Fb/NtDm3jT6VJuBvOE7tmIDXL9RTk1NAEJC0qm56IQv1hR
lDk432wlomyUxhOKnc6xZD51i5We8A==
=y4jf
-----END PGP SIGNATURE-----

--qCefvYX0tdeieUPa--
