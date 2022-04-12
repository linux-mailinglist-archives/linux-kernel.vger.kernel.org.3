Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFF4FE435
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356782AbiDLO4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352437AbiDLO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:56:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AF16397;
        Tue, 12 Apr 2022 07:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56DBEB81B79;
        Tue, 12 Apr 2022 14:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F850C385A9;
        Tue, 12 Apr 2022 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649775249;
        bh=jn+HPq0xNAFgDzP8V3hRx5PLN2FH+2mWWa4YP6ifmQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYqWByj1LGRWd62VvgVb06IMVNi8O8thYWoCvZ0da27JkCm19VykUoT9sWoSuQ6Vu
         wo+aNoJffdwEjC5hNOUSVAIUSASxptGVk9VTzNqmh/QvSXCUlLich339ISRK1YuwgH
         YGSe1e84Np5ZgdwfBJ01dZNwQzWH1ZehsGsrngFyaXThpCyPl18W0kF5XGOjfqb81/
         Cm9KEBAMtwToNEi/et1gd41BWlQom/If85rOttrBaOf0pjeJ6Lzob+zY8quiPmXY1H
         Zogvcn21MeSoussmKdnhe2gubm2Y2kWun5w9xfKe+8rsaKkHKCXOz5gG3fc+O3gzVl
         stdlieOa4WmeQ==
Date:   Tue, 12 Apr 2022 15:54:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v6 16/16] ASoC: cs35l41: Support external boost
Message-ID: <YlWSife2zTxAXY2u@sirena.org.uk>
References: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
 <20220409091315.1663410-17-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VIQAQDLg4VJbto2M"
Content-Disposition: inline
In-Reply-To: <20220409091315.1663410-17-tanureal@opensource.cirrus.com>
X-Cookie: Approved for veterans.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VIQAQDLg4VJbto2M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 09, 2022 at 10:13:15AM +0100, Lucas Tanure wrote:
> Add support for external boost voltage, where GPIO1 must control a
> switch to isolate CS35L41 from the external Boost Voltage

Acked-by: Mark Brown <broonie@kernel.org>

--VIQAQDLg4VJbto2M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJVkokACgkQJNaLcl1U
h9CeiAf+MUH9JwPfSJSPk+FELVgYltt6oeP0bUojWxoTfsXCB7Alv6dSt8iGR98p
YG5d1451qcl+cPeJEER1IFpY6MyHOGa69eFWUJ+n/8wMXk9M1oFSEuL8M3ttQMuK
ivYRnYwut283M6kBom3W7m+Tqc6lYO8X0PXuvAstQWf6kMWijnhfzMn2wE/QO4OL
Cjj9vjXEQbtFPfOokaug3I5OaiZ8Y3+5y6S74ja7HQ3vh6bk4o8E9ivOJ3Mi9fHg
ilKPmX9n1/OggwkIIreU7fr4SBTIQ5C9ZR4ATDLFulqtSz07D1bed5SEeZQhVisr
0V4PR55aQD2Tp/lp1W4ngcBUTKMW1w==
=D+Z6
-----END PGP SIGNATURE-----

--VIQAQDLg4VJbto2M--
