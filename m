Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663F24B5738
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354139AbiBNQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:42:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356611AbiBNQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:42:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2E65140;
        Mon, 14 Feb 2022 08:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90CE1B811F0;
        Mon, 14 Feb 2022 16:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE20CC340EB;
        Mon, 14 Feb 2022 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856917;
        bh=6SLYd/bxKhQ+/rlelM3+sCCZp7wn48Y3b7moy1y/3Hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tV6OdadMyBVzWaQW/CUW2uFtaP3iAFQUh031EiBKZby228Nwib/oeNXgpFsn9KwLH
         GqhdVQslrhXfkqXY6ee/RaU+s8cjtAR2yOAHs6lIgRr3Apdy46CacjtwW4U5euATeX
         xDwakiE5h1IXeZny55BiWhhG8drakT699VqpN0lL0lpyH0EbpLyR4IH/Q2qcWsGPi8
         DqZ5WRkUCJhpaGhqlv7SKf7e55JJh3qY+FJqVJ734tPmWplhw24hyfajc1bXacQMXa
         MBJ+vWRN3/UDly55CGVYT+xXex8yekoqi6qX98fPEIeXExxSjXHP235sjJxtvgt7Rx
         3ob90tccSNSMQ==
Date:   Mon, 14 Feb 2022 16:41:51 +0000
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
Message-ID: <YgqGT999nsjUGp9Z@sirena.org.uk>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N+2aKcE8moLeJ6DF"
Content-Disposition: inline
In-Reply-To: <20220111175017.223966-4-krzysztof.kozlowski@canonical.com>
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


--N+2aKcE8moLeJ6DF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 11, 2022 at 06:50:16PM +0100, Krzysztof Kozlowski wrote:

> +    properties:
> +      regulator-name: true
> +      regulator-always-on: true
> +      regulator-boot-on: true

Why are these specific generic regulator properties enumerated? =20

--N+2aKcE8moLeJ6DF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKhk4ACgkQJNaLcl1U
h9Cihwf8Cj6XwM5rF53JA8jXEjvihpSHHGlffCjSJxcdmnGhORrx5+mJPm9c6WKz
xSHjjsj281UTFhcwol6WQlbUNtJCvw3f0fueOaB1xlNm6bRhDNNtRJnDfYvv9RnE
T2qEAuYALCKub9I0OWvImJS+rOBwsEuTEYC4ogqrCe4Ay7WYzg6wOnd6WW+l6XQW
RkXymk/QVHs67njk1UhTs0SsTRY4TNNigBLLS0YjNpBnaA6lVq+Ibn14nCpD9Myg
/13kIMMeDdqdmgmH3NH06yKEQ2ZzyYIL6gv2pDg91az9GWNSpdZ2VXNSeBbzqpT9
sxtWZaJeHCd4Qfz2amE/Tu0O4hTK8A==
=SSJW
-----END PGP SIGNATURE-----

--N+2aKcE8moLeJ6DF--
