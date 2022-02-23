Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0C4C0756
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiBWBrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiBWBrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:47:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779142DD6E;
        Tue, 22 Feb 2022 17:46:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102A96149D;
        Wed, 23 Feb 2022 01:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DCAC340E8;
        Wed, 23 Feb 2022 01:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645580802;
        bh=kq6USJWNWAdd4WjJ5SUgl+zm+/C8pAycD+nNSOOXRpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8m+5QSAFaPP5qrmOlUCiEnVZVYa98ZAHpHuB81oHdkLZM+W1JhGN4cq/JDDFJETa
         gvSWMqf2sgZyqJj1bTKSYfugJiO3MmrRN9mvRYDCL2F2+hqN2LHdeUsn3HpcnysPqN
         lyfbhJC71n10KZwB9UwAITjvj7pcvLafIZyLIY9v40gwPzm7IXX9BbLRDr02MEV+do
         3W9Zpw6F/KKDkGTpWGHQLfIB+h6MpItABA1Ur86iaivWCIob+BXCXuIV7SLtu9FqiU
         e4DP5xarC4D8eGHC+Ls5yzjfNDgn5jIYkaKhnPiSdr4e091qkHnwrTBS5mZxJEmoBm
         eQzSQZY1eozaQ==
Date:   Wed, 23 Feb 2022 01:46:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] regulator: dt-bindings: maxim,max14577: convert
 to dtschema
Message-ID: <YhWR/c3YA7bAK8iS@sirena.org.uk>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
 <20220215074759.29402-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LTqaq5MlgYQrYrkx"
Content-Disposition: inline
In-Reply-To: <20220215074759.29402-3-krzysztof.kozlowski@canonical.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LTqaq5MlgYQrYrkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 08:47:58AM +0100, Krzysztof Kozlowski wrote:
> Convert the regulator bindings of Maxim MAX14577/MAX77835 MUIC to DT
> schema format.  The existing bindings were defined in
> ../bindings/mfd/max14577.txt.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Mark Brown <broonie@kernel.org>

--LTqaq5MlgYQrYrkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIVkfwACgkQJNaLcl1U
h9Cb8Af/aQmUImSwbFOZ8Xx0IfIC9QqE3DeSueHN136ZjUiUlyvx7mhqOGfBTxXq
+n1duwdpmXlxXjyXauz1ky2KnEk6ErHx1UmyXXbMe+RzkAqNgMw9LVI64IpezdNf
gZBvzBvSJQlZQeb7TegAL2ithIIBh02tQH9TKT5vXwmro16BfBZm7lA7qYeBH5Jo
IihtsSkcgVrO5UBOznu+pFvb0sel0yprLVRmfpXYcjyW1M69pamfF9JyJDWw3rs4
KEd5QGNc7dPGqHNopHJZHpVxEB3Pm7EUz+vVu52UbB1KoWcMbeFHfF+DfJi2fiQp
Ce+n3iK/Mc+pWQQZzlVJBVpyBUM7Rw==
=gKbJ
-----END PGP SIGNATURE-----

--LTqaq5MlgYQrYrkx--
