Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612BA57CA49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbiGUMJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiGUMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA8D863C2;
        Thu, 21 Jul 2022 05:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4975061D2E;
        Thu, 21 Jul 2022 12:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBBBC3411E;
        Thu, 21 Jul 2022 12:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658405385;
        bh=Is1b7K1zP/3u0FK9rRtUZbsH5NcbGby4sQBDfEtE5P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iG7EuUC2eFEtuAh9lO7Gdb5CUn8qCMad1EgCcxOwxHzuvUoEM0rb9jyJKnagNwX4e
         x14GZunev8iP+CVXaIXKY+Jd2fUKr64cDGB96MzonyMGUo2jhq+50mgaBU35MDTp3e
         k10+toz3abomP3mzXn0H+Ksr7uLRyeTIjh7HU0sJO5pbTJ2WhHdnEZE7QuwwI82fKF
         laLspgKV1boLi+I3YAW/ndz+nbYv2Uo+SLNLijH5g0/P3lXjYM9jAmP82gcsu6zhR2
         /Cg4u83F7TDCzt4pqBdVzfSvBW11AcX8/wHLTyIeXD9hb3VuBBMN4VDUUQGAg/T/6X
         ZAZJn755a82Pg==
Date:   Thu, 21 Jul 2022 13:09:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
Message-ID: <YtlCAvJK/pb4PbJ6@sirena.org.uk>
References: <20220721101556.118568-1-tmaimon77@gmail.com>
 <20220721101556.118568-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fAOdgDIIiCA86x/O"
Content-Disposition: inline
In-Reply-To: <20220721101556.118568-3-tmaimon77@gmail.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fAOdgDIIiCA86x/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 01:15:56PM +0300, Tomer Maimon wrote:

>  Required properties:
> - - compatible : "nuvoton,npcm750-pspi" for NPCM7XX BMC
> + - compatible : "nuvoton,npcm750-pspi" for Poleg NPCM7XX.
> +				"nuvoton,npcm845-pspi" for Arbel NPCM8XX.

You've not updated the driver to accept this compatible and this doesn't
say anything about fallbacks.

--fAOdgDIIiCA86x/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZQgIACgkQJNaLcl1U
h9BwuQf+MgqHMK5RNzIBd69yNdZ64oCneh+BsjdFstytLx4t07xWCOv5+XBZ68ct
cDoz13GzxwS2bysHegbH30+oUEmGQBb6LRB3+IGyLc5XGFWIzf4idBGXQI4c25zK
jEz8cK7i9q548YD+pwtpVzPyPW5DC2+llPoyKFIzECn8+UmaxR3OTTrFDabmV0+m
KonNrnoWCLggYz+t/DVkVLdECAnQwbatCXOKKwSn5atkrGpzd3kHTNGzXv+FB/qp
9pSPrfNMRFXl9tRuUISkFx0iqhiyCpMlVoJx00jZYq9Vw7Y5ZW1y/4/nRrQkqR1j
KGsll59OiewC/YZvU8L2dM8Z9DWYCQ==
=Pul1
-----END PGP SIGNATURE-----

--fAOdgDIIiCA86x/O--
