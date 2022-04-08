Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AF54F93A1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiDHLUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiDHLUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB50E3A37A0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53983B82A51
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5B1C385A3;
        Fri,  8 Apr 2022 11:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649416692;
        bh=/m0sOMkIY+YH/xMizj3AEsdT5/nMANVS7C4zn00Dcoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUfg3W95tcHxKLDG6N0ysbpPiIz+skActS1vj4iycbyIagilzHpBXbQOC3rKJ/Ly/
         hDo9o6/SouLzvC2CWO43syU8n87BIyPd7Rkxy8EXYOX5fIZ52ZUEynkZ5BH+znJnrC
         S62qrTks/jec/1uxiKywIohunzOGdt841Jg3xM3STgO7qc4zsAiuv67y5yXUXgEhOU
         k+1O5QX5XU/WP16f1zKD9Ph72cU1LF5qiMb0ODLYMyUSe+LFQJ3Batc5CfsAXpjtzq
         oCenxiCprcaXXoj7GxNrgwnZPbW1SQPmvTPKDWY9DjY1w6MGflVdwYveIWuh1sXI56
         WqEQS3s3BiFxA==
Date:   Fri, 8 Apr 2022 12:18:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH 5/5] drm/solomon: Add SSD130x OLED displays SPI support
Message-ID: <YlAZ7gl7aHjIrYn9@sirena.org.uk>
References: <20220407200205.28838-1-javierm@redhat.com>
 <20220407200205.28838-6-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g1yK6P6SAt6g6CTu"
Content-Disposition: inline
In-Reply-To: <20220407200205.28838-6-javierm@redhat.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g1yK6P6SAt6g6CTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 10:02:04PM +0200, Javier Martinez Canillas wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over SPI.
>=20
> There is a difference in the communication protocol when using 4-wire SPI
> instead of I2C. For the latter, a control byte that contains a D/C# field
> has to be sent. This field tells the controller whether the data has to be
> written to the command register or to the graphics display data memory.
>=20
> But for 4-wire SPI that control byte is not used, instead a real D/C# line
> must be pulled HIGH for commands data and LOW for graphics display data.
>=20
> For this reason the standard SPI regmap can't be used and a custom .write
> bus handler is needed.

Acked-by: Mark Brown <broonie@kernel.org>

--g1yK6P6SAt6g6CTu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJQGe0ACgkQJNaLcl1U
h9AIOQf/WM+DQ3uZHPaIQ5Aa2QPhp1jUAe6hJOZPDcPKGVkxfwwWLN0Dv0AS6MNv
RrM5wv7Yvqp1vvAQ1srOtZJgLWYpVyzWQEpr2i2CUvX5rIiX6d8iAspK5HbcbMon
RSWXcItCHZjj/CacdEkjZp1ZHCwmxLmPJ6BajKoZCdnDWu/1/+Y5V6C3kHUbPgl7
46wTkUzXoPBS25rHOyAQmhcsEgvP9mL9mQ7JwSfEI6gsBAy61fxrgZiPcxJWef0Y
P8jnTv65wR5m7KNc09i0m9MaMubatw9laXRYRc3UHjlVX44vAte1lzvBJdem4+YV
s8o2HpkntpTn+bn87ONIk+eb5Y8DeA==
=rvVz
-----END PGP SIGNATURE-----

--g1yK6P6SAt6g6CTu--
