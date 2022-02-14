Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976744B5767
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343536AbiBNQvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbiBNQvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:51:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCF4CD3;
        Mon, 14 Feb 2022 08:51:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43C2DB811F2;
        Mon, 14 Feb 2022 16:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929B4C340E9;
        Mon, 14 Feb 2022 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644857487;
        bh=1N7hGnNYxDbCgnmxgrSOedPmpfF0d28FIzo1Mg2GxPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooBbGKMvE5TWtlEfYyKz2MAmgLTPOQn3mdeZgYu6wT88qD/hpd2960PvAtzcZwPcY
         4WtkarZG2z8GU5Sxlwn9H8OvoNDj7KZwoSFZxvc6CGBx7kCshNUIqD0e3j2ooEhogk
         zANx41JPAc/600O1/ZCJRdIbaPNkiOfuNCU7xJPts/exaaCDkAHZN9N2qRP91IYW16
         Mu4lGHKqp1rV7JcJ+LVQaqsDbQEQQ4l7lfibSF7i/eVpJxH4XMl7IsFPnguED+oP9M
         8gpwFxAgkJzNGRgkmfhwKejxqcA/2hWAQbHFVetzqhZ//LGcNq3yTysHVSd3FRCFSq
         4FCn1ef4kS5WQ==
Date:   Mon, 14 Feb 2022 16:51:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max77693: convert
 to dtschema
Message-ID: <YgqIiv8fZeqFFUHX@sirena.org.uk>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
 <YgqGT999nsjUGp9Z@sirena.org.uk>
 <12c66ced-c4a4-3a4e-f84b-83edb9e3fc58@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="htkRvpnxR2kejon2"
Content-Disposition: inline
In-Reply-To: <12c66ced-c4a4-3a4e-f84b-83edb9e3fc58@canonical.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--htkRvpnxR2kejon2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 05:45:40PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2022 17:41, Mark Brown wrote:
> >> +    properties:
> >> +      regulator-name: true
> >> +      regulator-always-on: true
> >> +      regulator-boot-on: true

> > Why are these specific generic regulator properties enumerated? =20

> additionalProperties=3Dfalse is used, so all properties, also ones from
> regulator.yaml, have to be mentioned.

> Why this approach was used? Because the hardware here is very limited,
> so no other properties are expected. No other features are supported.

That's not going to scale well if we add any new features in the core,
and doesn't include things like coupling which could be applied to any
regulator.

--htkRvpnxR2kejon2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKiIkACgkQJNaLcl1U
h9BEBwf9FYrsr+67OYGeYSJYNBOIHamIvegwEvoFCMdube3nMDmIxYlsyXUZe5sT
UVvOrbbCZDK0nR8SvbZsys5qflPNs3Ao4fYNF2s2CJmXPS661LB6IpkjFOI2MtCV
kfRvsLIo3KT9IUBU/TZvBPyg4cEhrlKN4hCk4SFGVx0TydZQqAXNSCWYgbQWQE6v
8uUFlI5Cx/rHiyemwl9gSVssQ2JViJ4bYyR3wMbutZ7/kZqz1BZc/m+k6EZYuT62
rE9Mc8Ff/S8yCjikcW1Usixp/YnMP4m3dQ/p0/M6oG3dA08+uXVFzyK7SvoySehV
fAyz5bsjcOq563rVT9h/sXGz9p1JRg==
=v2zQ
-----END PGP SIGNATURE-----

--htkRvpnxR2kejon2--
