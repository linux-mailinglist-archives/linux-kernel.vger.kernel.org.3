Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EC24D610C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbiCKLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbiCKLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:55:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7514CCA7;
        Fri, 11 Mar 2022 03:54:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B829061D00;
        Fri, 11 Mar 2022 11:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F1BC340E9;
        Fri, 11 Mar 2022 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646999662;
        bh=ykSXSV6tQWA2E+or1u18GiVLKsanR1JUBZpDAnWso2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESQc/AGN91K3UbGs/tXKANTj5neQ8S1R9b4+VBWDYIfim/6FhHVMZ3b0qqbQt5pUL
         umocvHubvU6PbxqKaQgRuwO9P6keUe5pZ7hL4Vs5m/tWuBl4ypT4wwzBhHf8qAUkAv
         CVMl4zq7zOdx0As2GMaqVSLbZc7SiGUVD23Dvb9XCJgL6cVE15t8xvEezbtQzGbYfb
         BjY8PT6R4DI9Kd9rDMB1ZUdLcRk4Pm5Nb3+J44PUuNqJGehiCqJjVD2azxRB1ReDBQ
         bMFJQjIMYpBcHrV58lKGzRmX/7qs8bfa7z08WjEqAJPtMYi7/4CaWmZtE+cdDCXf9C
         69QjueolzFRgQ==
Date:   Fri, 11 Mar 2022 11:54:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Kumar Mahapatra <akumarma@xilinx.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>
Subject: Re: [PATCH 2/2] spi: spi-cadence: Fix kernel-doc format for
 resume/suspend
Message-ID: <Yis4aZmoO3ANXigm@sirena.org.uk>
References: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
 <20220310164235.32230-3-amit.kumar-mahapatra@xilinx.com>
 <YipHjjg/sLRqQVX6@sirena.org.uk>
 <BN0PR02MB7933108D2F4C657D850CE131BA0C9@BN0PR02MB7933.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3T6Cyi7jzuUct+9P"
Content-Disposition: inline
In-Reply-To: <BN0PR02MB7933108D2F4C657D850CE131BA0C9@BN0PR02MB7933.namprd02.prod.outlook.com>
X-Cookie: A fool and his money are soon popular.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3T6Cyi7jzuUct+9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2022 at 11:32:57AM +0000, Amit Kumar Kumar Mahapatra wrote:

> 1/2 patch of this series aligns the runtime suspend/resume API prefix wit=
h the=20
> rest of the functions by changing it from "cnds" to "cdns".
> 2/2 patch of this series fixes the kernel-doc warning in runtime suspend/=
resume=20
> APIs.=20

The warning being fixed is that the name of the runtime suspend/resume
functions which were just renamed doesn't match the documentation.

--3T6Cyi7jzuUct+9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrOGgACgkQJNaLcl1U
h9B1nAf9EIt9LcIFxF2fFRJ4cWaxW6H6fYMllvbXw+QaMCodrtaNyd9KBZapOPsK
pgZKRxyC8x4PrXGZhab2lzv+jPKwaqiVJgP81slxi90ZwexMfO3KYoOGZM6c3bfE
6NcCyQB8dF653GLZImX9F+39YIAeRvctU+Yzn4ihLIm7lbsOlpyoGTRphY5MBP9O
AazijygAnSxS0gjkWQacfAmBaopHMx5BPsUk6PP/s1Ekq/DQMVxG13wUE9u3G90B
4iO89KYADda/8MOZ3IV0Zjc5o5WbxOQAIgPMZBNeluWmA5vMS2Wn2UcyVz6THzfz
dj1gw4RZqUBqIPI4HNxYFwRFeOG9Mg==
=zhAd
-----END PGP SIGNATURE-----

--3T6Cyi7jzuUct+9P--
