Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5A5B1B78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiIHLb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiIHLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C365C6FF0;
        Thu,  8 Sep 2022 04:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A3D161CB6;
        Thu,  8 Sep 2022 11:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E61C433D6;
        Thu,  8 Sep 2022 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662636715;
        bh=Gx9EBlgO2Bqzbdb7MMDBfkrSeePtZm8kTIdRWWYF0Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8V8oNrHvYalaCxsTonTabUx6HyWkAXsziB1v3VBixK/RiGk5yfy/HBmECl0rbB00
         ix80mv3ds2Mfe6j8bQsBEsLGTn9vPj2xrNdXxeA1/H2yVbS53eGTvqIYtTtffvtYbq
         UjCCiWWwxPRKQYMcWH4MI5fDBgsFQln+URVYAuKE7qo4eqcdVUKLq09tddZtuZmA3E
         JmX9jZG5joav1RQeiBFN4jWVSuieIMdK2dyZQR1p7cHEfauEQxhmVZqgopAjNHlB6W
         HgZHrLDKK8hG5IfDP62b2+0Uy7ZgCH0lzoF23aJEwZpv5QIi2WpB9+TkyeJFhZdZsT
         UvObv2OAfNs7w==
Date:   Thu, 8 Sep 2022 12:31:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        shengfei Xu <xsf@rock-chips.com>
Subject: Re: [PATCHv2 12/13] regulator: rk808: add rk806 support
Message-ID: <YxnSpE7/oNti9KKK@sirena.org.uk>
References: <20220908003107.220143-1-sebastian.reichel@collabora.com>
 <20220908003107.220143-13-sebastian.reichel@collabora.com>
 <88f6110b-94b7-484d-cc37-d7f72c88090a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zfjnbY86D6IxZX3o"
Content-Disposition: inline
In-Reply-To: <88f6110b-94b7-484d-cc37-d7f72c88090a@gmail.com>
X-Cookie: Metermaids eat their young.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zfjnbY86D6IxZX3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2022 at 10:45:40AM +0300, Matti Vaittinen wrote:
> On 9/8/22 03:31, Sebastian Reichel wrote:

> > +static int rk806_set_voltage(struct regulator_dev *rdev,
> > +			     int req_min_uV, int req_max_uV,
> > +			     unsigned int *selector)

> Hmm. Maybe this is not necessary? I wonder if we could get away just with
> the .map and .set_voltage_sel (regulator_get_voltage_sel_regmap() and
> regulator_map_voltage_linear_range()).

Not just can, should.  Drivers should not mix and match voltage based
and selector based operations, and they should always try to implement
selector based operations unless there's a specific reason to do
otherwise.

--zfjnbY86D6IxZX3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMZ0qMACgkQJNaLcl1U
h9A3iAf/RV6xulcLF3Uiq6Nup7Itd0N4Nsi3t+C2+D49b18Gq28gAKZucesUpjfz
gVO5YeJnNX6gJnia1jDhxTAVa8r+Xy1K+6WmQGpYbfCECmTmS1v9GB3uIfOPyp5m
iWrne12WJjo1b0a52D6/EyFT2okKjmR6qNYf37LVcomneLWl/KnXnPQmcK6vhbkY
gwBklAF5YL822NCgx65aO4cgqkfIm/w7KK+y6h5DTzmXw5h+Ldi11+tMS65g5Oax
77RzRDaU91PhGv9DSN94iBnvEmXGigofOJQ9vz/HRYOTmBUNPsu5dVxXdgeVhWqY
4b6pMpBw61OJXeC3ETKEaS/j2jQfeA==
=GRVt
-----END PGP SIGNATURE-----

--zfjnbY86D6IxZX3o--
