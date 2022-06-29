Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9156024A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiF2ONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiF2ONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C774F2E08E;
        Wed, 29 Jun 2022 07:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6476361EDF;
        Wed, 29 Jun 2022 14:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A6FC34114;
        Wed, 29 Jun 2022 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511978;
        bh=EbqWCUmkOVRPmKo9U5c7kwf3+1fDeL89NaXTTnq2qdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVNqWtRI9u+FhLGwOW3OoEb2agjG76ew4Wx9RSKCHMMp64esjHd4Sguxf8obVT5qe
         EBnHld+5LCGIZW3VIE1LLqG35KbO1JJiQUSl3OPEJ8v7z+i7fsb48RNROsYdOPI+yV
         mJDs57tda06z3UTPxcj5yLYxO92kWz4kCXyrWx08j2ZVlfGisAcDkw9u+7k8nFpbkz
         hGx5W8PhkSYpTtfKaemVBmEbEcQJSShyBQ6wQ9SSvk/Ib1o+7cjlBoN33ov/K2QlOy
         lhmC04+URPyjUVmSlDeL5dIUIY9XH+ebqcJLDOsiD5sFl6hqLyriz+jMLpvAQO5tLT
         WMtFfYlH3fWIA==
Date:   Wed, 29 Jun 2022 15:12:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Message-ID: <Yrxd5X+HukjXMsFM@sirena.org.uk>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6Fr1hisQKkx0fTv"
Content-Disposition: inline
In-Reply-To: <20220629125804.137099-1-sergiu.moga@microchip.com>
X-Cookie: Booths for two or more.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y6Fr1hisQKkx0fTv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2022 at 03:58:04PM +0300, Sergiu Moga wrote:
> Convert SPI binding for Atmel/Microchip SoCs to Device Tree Schema
> format.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--y6Fr1hisQKkx0fTv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8XeQACgkQJNaLcl1U
h9DKHggAhqvZ5m00XXbVGEv+zfYbQyLYu7CVIRqTluLo5sjG+6iqIqqkJHgK7+MW
Z4V40OW+I2fiRkDHJ5zMra+NQb0JBVIfaLTaaVrJ2hTFcG2OvGtpmJkqTCDt6PEb
ZgY9SkzftbJNkylrKa5SlaaMYfxkIQ8uVdBrtoe70hSI8OyI3lSg7TbAmEmT6ppA
x8g1CknheYBYmq34ccjW4B/Q59kTrIepjsMjedN00bPnQ3pqSoYxPzfx5I8WSzAl
r6D2lMegUozHah3ofx3iG0pAXrwhi8GhnCVx3wVfzGtc1WTdYBbDOkaOmFe+OCBz
DU4zzSoCeIZb3sGWGBN3SphWe8QzkA==
=raYG
-----END PGP SIGNATURE-----

--y6Fr1hisQKkx0fTv--
