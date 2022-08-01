Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CA6586B24
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiHAMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiHAMpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F5E47BB4;
        Mon,  1 Aug 2022 05:33:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62DBC6115D;
        Mon,  1 Aug 2022 12:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2247CC433D6;
        Mon,  1 Aug 2022 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659357228;
        bh=cUtyBDgVVj8a2DbWuYT23A9XZzN6tatVF6DfpqOHBm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ClllzYyOR3dE2PIjBhiD9mIY0evMgFfq96zdfbiZZoJpUaM3xfKYvT4OJLpl/+hwn
         wAmAQHl59WTf3EmMFJwyj1uh4dteRpGUtPJ+XGqAmPSM9miXINyvlG8jbT/Mx6VQ8b
         30L9Efuvo6xM5QgI1c19qvmWZcg2hIRplCFsW/csfP+qXz9jXKI4SeXTDGEy9iItpE
         ZFf4sLJCmB50r/kXG0a4Dv0Su6fduhwhabIqj0GE+9zQ/63+CbpRkXvMIaVkMlOQTE
         wOWV67NWq3v6V9J8xNR+GZzQ80A27Xiy2j7qhpIOq3qtW18nVeOZG5ptihphxuSeum
         uI7wpsyEFm2ew==
Date:   Mon, 1 Aug 2022 13:33:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     Nagasuresh.Relli@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: microchip-core-qspi: Add support for microchip
 fpga qspi controllers
Message-ID: <YufIJ9JtTKaUjRqZ@sirena.org.uk>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-3-nagasuresh.relli@microchip.com>
 <283bdfef-cbd9-5d87-f77d-10f007c37a0c@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wK8xglAK6STQSGFE"
Content-Disposition: inline
In-Reply-To: <283bdfef-cbd9-5d87-f77d-10f007c37a0c@microchip.com>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wK8xglAK6STQSGFE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 10:40:33AM +0000, Conor.Dooley@microchip.com wrote:
> On 01/08/2022 10:42, Naga Sureshkumar Relli wrote:

> > +	qspi = spi_controller_get_devdata(ctlr);

> Is there a reason to use spi_controller_get_devdata() rather than
> spi_master_get_devdata() ?

We are trying to move everything away from the old terminonlogy to using
controller, this also applies to the the other API functions.

> > +clk_dis_all:
> > +	clk_disable_unprepare(qspi->clk);

> If we move the clk prepare & enable later in probe, ie after
> getting the irq, this goto could be removed too because the
> only place requiring teardown of the clock would be the error
> path of devm_spi_register_controller().

Is the clock needed for handling of the interrupt?

--wK8xglAK6STQSGFE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLnyCcACgkQJNaLcl1U
h9DxVwf/W1ICkrqkCv2q0uPZM2Bc0iszQetiS5Eo6c4OxfHShFWnnGBHw3fT+EaL
dLlNzAB4FXCohs4U8rnww3yqyW9cGJDxLiROxdvWKvZUEmVCFqUX1xrJWXQAPorN
z5TIgfJA0lAaDuAywSBNP/v2NIojASHEp2bY8Qk2WhUkDy4KYd2lei5H6T9MenHO
r0kmbaG+Q366FrANMcHQBrmn5OaTIcmtEKbyqJYzE71uFwTYHR5qrVdTDC/dCiPm
H9c+jB4t1cZ+krcxnqWxM5KJlsSk3TReAEY0Z8FPz00iVLpY9Gisdj88NF6lkNOy
eof9krPC1BSU5fJZWWGBuxzbvteqtA==
=hglu
-----END PGP SIGNATURE-----

--wK8xglAK6STQSGFE--
