Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C0567559
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiGERLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiGERLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260491EEDB;
        Tue,  5 Jul 2022 10:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B48E26160B;
        Tue,  5 Jul 2022 17:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F66C341C7;
        Tue,  5 Jul 2022 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657041054;
        bh=GdGjLgP2hej3ldK4b9osehRvOxBgWOs0Sc84SjxL3+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SvzZbxsBDIl4Sg4BusQpWxsWDdR+TfhHde+9hiBq7eA+t/BUmC7YH8qssPIi6HYvV
         b/ajSpUlbeKGlokMFHnY+X+wUB5+kalNj7Ikm1+UNB4xYqJ1w/nvxVCjokO/YhvdYR
         hIp4Yx0Qal358q2+2zIGLpxv9tLS25BMku40lqe1rqzxcBLy0zGbgd/ZSl3MfTRqFd
         3UG4dKngZ7zxExdtauPX+bGOhRHXeUD+Wbsdv2Ooo8GaThLJbrxDTDG+bcrQYVBYa7
         wN2TWgk+6FYIh3Ci0Fj69xYO95i0QFTffUsxBL3HZala87CmNgxsnMPyTSLsejWZYv
         /1K7AM+LgN5PQ==
Date:   Tue, 5 Jul 2022 18:10:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan.Wanner@microchip.com
Cc:     Claudiu.Beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.berna@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-binding: sound: Convert atmel pdmic to json-schema
Message-ID: <YsRwmEZBJZRJuqSt@sirena.org.uk>
References: <20220705162142.17558-1-Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2q7rNxc8LUBNXqkk"
Content-Disposition: inline
In-Reply-To: <20220705162142.17558-1-Ryan.Wanner@microchip.com>
X-Cookie: Avoid contact with skin.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2q7rNxc8LUBNXqkk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2022 at 09:21:42AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>=20
> Convert Atmel PDMIC devicetree binding to json-schema.
> Change file naming to match json-schema naming.

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--2q7rNxc8LUBNXqkk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLEcJcACgkQJNaLcl1U
h9BqRwf/ec39qezUmPHDc1zriQaDiK1SQf+WeiHqR/VlgQ8XqoPPQpTfh0AEKLlG
WEiiTq+4AxBbd1wZZngJ/iWOXXK3tSVgcfYI3RBtCaPK346QyYqqt8uPj6ozz+++
tuxmHAWreDlZ72snrrZhSJm+SelvFYLbIe9RQ37N/y2FCaY+FRLEnleuv1Ct5rfx
5pKeqYpuqpZrATCsEubdAwLg4TiwYPgvweQufcGvUYYTSlICgYLIOuON6eXontQQ
2K5iQFxXXYAJZhuAUBS2p679hyTmwUVRPUy/KlQbvLw9op+1g1JWxsvD1Ph6DKX8
6T1zDLuzHG8nFoJK7bT4KZM6T1u3Ig==
=3QL5
-----END PGP SIGNATURE-----

--2q7rNxc8LUBNXqkk--
