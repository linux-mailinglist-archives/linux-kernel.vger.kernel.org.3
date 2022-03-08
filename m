Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5473A4D191A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347128AbiCHNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347076AbiCHNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:25:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B284419BA;
        Tue,  8 Mar 2022 05:24:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 921C861021;
        Tue,  8 Mar 2022 13:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB05C340EB;
        Tue,  8 Mar 2022 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646745857;
        bh=2OP/eO/kKD41zP+nPYneJuXvy2X1h4oBHVDkq7AXBHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VDSjQmdkbKuyhd+55xQKCz4GtjwszGiCDUkEuKpCSR8hE5cqNfiCrTop7XwCOqgAN
         1DCg6OGXKqMBYmljJfaAAW2B3cr9nfxT+8pG4AQerKxBIT3qNnPAOlQ6wSvNTLS9Qz
         GjOquXI0OsKXbaeHE2DYJgV+JoIgeZm6TZPqUAinV86ccj3ZP0p3v3iJc1tLU4gqBO
         gHQ3ERipbupWZyPgSGU4gGB8+1wrOKyctli+bCj7yRBOnbCjOi5YeGtaSJ7Zqdz+4W
         eGCnciKbDn0s/hrMjzwmTKWj4yC/VuxFgh8MdLMHLH268MbIt9bsKM6g/r2kSzN7If
         0GYYGJ4Szwjgg==
Date:   Tue, 8 Mar 2022 13:24:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        andi@etezian.org, linux-spi@vger.kernel.org, lee.jones@linaro.org,
        linux-fsd@tesla.com, Adithya K V <adithya.kv@samsung.com>
Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Message-ID: <YidY+ncMVhp7bBvh@sirena.org.uk>
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
 <20220308121640.27344-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ay8euQKf9LBmoJfJ"
Content-Disposition: inline
In-Reply-To: <20220308121640.27344-1-alim.akhtar@samsung.com>
X-Cookie: Dental health is next to mental health.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ay8euQKf9LBmoJfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2022 at 05:46:39PM +0530, Alim Akhtar wrote:

> - Resend of FSD SPI support patches as the dependencies has landed in MFD
>   tree, hope this will go via MFD tree (as there are dependency between
> MFD, SPI and DT)

I either need a pull request for the MFD changes or to wait until those
changes have come in via Linus' tree.

--Ay8euQKf9LBmoJfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmInWPkACgkQJNaLcl1U
h9CUfwf/Qzn9eCU7vhJ5e9qENOzG4TrHBFrMB0oR7Ps/0JjlDi5kpsuIw0h8uWUB
kkOSVcSj+z0SjLkdRc3/hJrHOQhnUfVM/XWdBwD4O2PZyvof2jzedOWnktKxihh2
NdVl+aYTWEv8PZKwMrSzGfdCS2vucqpekU5qzqa0Xls0sHcv8pBq/tWhVBlKHGGj
SXcmdagwZ444x9lCPYoz8rF4L2+kv5tmW8RX1AXOyP8r//ZI1IGvZXXBle0exhgk
KJAioG9R+eE9NroiaFLojLlLLc2SOvcH15KYSQy+xVURr4SZg3xwrvNSBkcaSTkj
sbAKgQabKLFPE1QDvtsmaGfxqMcRaw==
=IP6W
-----END PGP SIGNATURE-----

--Ay8euQKf9LBmoJfJ--
