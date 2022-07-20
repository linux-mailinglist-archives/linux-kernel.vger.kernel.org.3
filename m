Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C857BAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiGTP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiGTP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0D813D75;
        Wed, 20 Jul 2022 08:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74DE761D1D;
        Wed, 20 Jul 2022 15:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF3DC3411E;
        Wed, 20 Jul 2022 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658332563;
        bh=il+GD9poJShJWI14gZhT7IBvu//dKO0zDrWfhSFXc5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asD5ZzRdhE8zGOEUUbRd3+rQ3bFGt7le3l0CUXjZXpiW9PLf2VvfNECzcd/wY2BEY
         64AwKTckonWO87iJRQuMAPwECeu55s0m7Ex2bixPANF5co8qim5Qnks48FlAfm6tWJ
         hHLBMgSdB+IsfrF9yEtJuEL5UMCSDjXQi9j7NODcPTRUjoMAFHz2eeQsuPuxPjZFiT
         qrxsyqgS5zh4++BFAM/sqlEKz4VGB8CMBA/bnf24+tENkljiQRxmcZRmarZWb2X4ju
         0a7x/NRsTzqDxLnGfnOPaSINmAAwh5HpKfwcnuQPNlVN4j1Ei92z3C5ai1yw8Vw+Rn
         U9PW6gQXnQGmw==
Date:   Wed, 20 Jul 2022 16:55:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, sai.krishna.potthuri@amd.com,
        amit.kumar-mahapatra@amd.com,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: Re: [PATCH] spi: spi-cadence: Fix SPI NO Slave Select macro
 definition
Message-ID: <YtgljnS88C+4hmKD@sirena.org.uk>
References: <20220713164529.28444-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rcauQ3t5gZ3FJM0h"
Content-Disposition: inline
In-Reply-To: <20220713164529.28444-1-amit.kumar-mahapatra@xilinx.com>
X-Cookie: Do I have a lifestyle yet?
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rcauQ3t5gZ3FJM0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 13, 2022 at 10:15:29PM +0530, Amit Kumar Mahapatra wrote:
> From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
>=20
> Fix SPI NO Slave Select macro definition, when all the SPI CS bits
> are high which means no slave is selected.

This doesn't apply against current code, please check and resend.

--rcauQ3t5gZ3FJM0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLYJY4ACgkQJNaLcl1U
h9A4aAf/XaY3bAFcoKDO8v0y7SlQp8g4+gwZeO8J9TZtRFK9Osc+2+b+c3gPvwcS
itj34BbBzaU+8vWdPxBvBzJIyobkN1I5mTKcDeVOR7rct8LliHfJde1DcE2T3mQD
NYSZ13rAlAk4a3fzQSjLJbDQBTgQsBggZOc9L0NKbJnaAzdy3pdCp3pPEec8RN4U
8ppnFCajTl5jxMVVlrPMSe/BP2yWeoWGGYYLJqFiiJE2BfH+vMWpTcD9iW0HhlQT
suqrbhiOOQA1yFg9LG55fh9/ooIb0fZoRu/J0MxGaaPzjjCChoyJfm8fmQoYee1N
uYic8Qyf4G9q0nW19/DaG9eAMiuDXQ==
=/4yI
-----END PGP SIGNATURE-----

--rcauQ3t5gZ3FJM0h--
