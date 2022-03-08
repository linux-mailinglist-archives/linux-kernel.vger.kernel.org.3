Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655A84D1B48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347760AbiCHPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347778AbiCHPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:03:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0D4D9C9;
        Tue,  8 Mar 2022 07:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ABC3B818F0;
        Tue,  8 Mar 2022 15:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053E7C340EF;
        Tue,  8 Mar 2022 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646751723;
        bh=lbiOCENiKzV0l6VKyrVyuJsQgczqHpyQAumIADRX13w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NdcQyOVs9Fby8nijGaLbuWWzj6UwhNyJLRkmo51z74unpAStHy6pXGZLp3zNbr5ec
         sP4qx+y+f/V1HNQlrGcPR7zsZ9XItIsEGMcgC3HMSMec1FWWPhNTDIJrNzjSdyY0Mu
         aUN2PGXmZVFPXPwqpM1Oax33cr9UrhBMraDqBLezWSAGqwxMwPkEZ7+TisPMhILuKC
         9/YQbMay7EEwyWR8PMhI5uxb7zvv9hxK6adoicxlUD8gpypyuoEnb7wD+7CpAFNYWW
         UqJXF9MPcdI/NsM8dWRVxeABQtV6D5esmBjLnE19FZJEbFbTBWtWKkVfnjqygi+USO
         YIRiWzEbpqm4Q==
Date:   Tue, 8 Mar 2022 15:01:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     'Lee Jones' <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        andi@etezian.org, linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        'Adithya K V' <adithya.kv@samsung.com>
Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Message-ID: <Yidv5aGB3CljCEWg@sirena.org.uk>
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
 <20220308121640.27344-1-alim.akhtar@samsung.com>
 <YidY+ncMVhp7bBvh@sirena.org.uk>
 <Yidg64QGGzIbduQ2@google.com>
 <YidosChLIwIAKDmG@sirena.org.uk>
 <010901d832fb$212124f0$63636ed0$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jzZHKask1XwDH5wi"
Content-Disposition: inline
In-Reply-To: <010901d832fb$212124f0$63636ed0$@samsung.com>
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


--jzZHKask1XwDH5wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2022 at 08:15:15PM +0530, Alim Akhtar wrote:

> >There were changes adding the FSD SoC as well as DT stuff IIRC.

> FSD SoC DT changes are already in -next.
> I think this can go with MFD tree because of immutable
> branch between MFD, SPI and DT due for the v5.18 merge windows.
> I am not sure if there are better ways to handle this.

I need the changes that are hard dependencies to actually be in my tree
so my tree is not broken, -next isn't good enough here.  If there are
dependencies for things you're posting you should explicitly say what
they are when you post (not just vauge statements that there are
dependencies), and when you post things that will be dependencies for
other trees it's good to mention this so that people can think about
putting them on a separate branch for easier cross merging.

--jzZHKask1XwDH5wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmInb+QACgkQJNaLcl1U
h9CDLgf9GwB+d+ke1yyxR+lxSveYjvqXqsOiAoVeXlpr1AE2KMzU72/apoLlE8YJ
F8gFctTU9Qk9atjp0TWQf6TiovyZVmPtGNcWJT80z2wZHADJvV1TPh63MJOoqdHK
Yr8aTu5Dv/uMaIVKQvkn/Ds+JD9ssGzR4Okn6SaMJmAMa5Q1rvM/injJPLIWGeUk
HOxJC4XdX2vgpgMbjcDlNhrhidwlnYsLSdxyUAoNo1ZW82modnuoX++7nBOgsnxf
p0WjSr462KANi0dH2egxA0wbypxJ6r8/l+qmzcaZv9w2uFvtUPFAXOLc856ynGTZ
GGyTEzC+9lHlmcTwV3x8vu/Luj4j7w==
=PZ4j
-----END PGP SIGNATURE-----

--jzZHKask1XwDH5wi--
