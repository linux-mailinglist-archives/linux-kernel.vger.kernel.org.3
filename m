Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CC65351AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243178AbiEZPv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiEZPv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:51:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEEA2873E;
        Thu, 26 May 2022 08:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E675B81EBC;
        Thu, 26 May 2022 15:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D4C385A9;
        Thu, 26 May 2022 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653580284;
        bh=bLNoPbPwCmwyCR+NJ+TRrrvs2lHwOgW0hzEn8QBEVNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq1gShDXXAc3MRDX8bc9A29ZQz+jpzlUhUpGggL0GJI/FIB376XuRhxScUASRpuI4
         7k8G7yE4HEqSqqrupxU36uT/7C3AwFbXPImLoLqFffJ3NFZXj/wZrw0A6L2H7k59NF
         bZsK7k7oUcq6Mj58XK7L73nPb37OW15hJMqbx0s9SkQnU94qEOkF/vvqwWabUtubOp
         A4PpxYpCSCzlxSFpGcOOnssuegCVxDGdJ5Es6nf/fpDnpgAM5G11NgxUPFt9+UjgkX
         rNINPznMwAQWCw60asMbvZ8EG0CsIieX0UtMSoC4TZycKG5DWtsYa7qXlx+0VbsLC2
         Iu3UVtQJbx8SQ==
Date:   Thu, 26 May 2022 16:51:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1] spi: imx: mx51-ecspi: fix clk polarity and phase
 configuration for CS > 4
Message-ID: <Yo+h9ssyWfb19aey@sirena.org.uk>
References: <20220523073143.778664-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5Gf4wftgSOCveZ2"
Content-Disposition: inline
In-Reply-To: <20220523073143.778664-1-o.rempel@pengutronix.de>
X-Cookie: A grammarian's life is always in tense.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l5Gf4wftgSOCveZ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 23, 2022 at 09:31:43AM +0200, Oleksij Rempel wrote:
> Fix support for boards with more then 4 chip select lines. Other wise if
> CS > 4 is used, we will write trash to the clk configuration register.

This doesn't apply against current code, please check and resend.

--l5Gf4wftgSOCveZ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKPofYACgkQJNaLcl1U
h9D3yQf+OV2CFz1fNbHBV9KYOKYh3/BqWU4qz96kpVbPgijVSOvPKKQWiGzLRGWt
cT2VFbQ2+UW0lX1Z6Rj/uLzOg26hswFHadI3sQeLHaUZF6uOBddUOWemoTSznXtL
pCOY8/RXsix9BdVv37OBcHzpJthASh66WILcCPwEAN0R/zImB7AOSL9ZfD2dCV8z
boiWBKKOn/DCZSSY8JffowmUE15KRTxtwvQwvgJ/VYUA/i19vJqvsVqWg5y4GhoX
SbvDl+r06pmfHicBFOXa/OjNKF7t54mbmUMn0UzvJJkj4kVGlD83zah7z0pQ32nW
Afylf4DwCbahIgh4zfF+4OAv258VdQ==
=u4BK
-----END PGP SIGNATURE-----

--l5Gf4wftgSOCveZ2--
