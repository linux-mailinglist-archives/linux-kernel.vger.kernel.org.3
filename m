Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3C4D1A9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbiCHOcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiCHOcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:32:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF84BFF6;
        Tue,  8 Mar 2022 06:31:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0AC5B818F0;
        Tue,  8 Mar 2022 14:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78347C340EC;
        Tue,  8 Mar 2022 14:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646749878;
        bh=MUULwWIn8CitNcmjbps4vjw/fQMuYQ5BVVsCxE3+FVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nxc0J8WTHPk4nDHJ7Ys7SncaZglaenwMF/++ttQKOA5+l9A1ifEvYbWNp1c2fS/UU
         dM8R5UGWXBHfLjtytZgckZiU/aVWypQmx8EIst8IOiBcgedqQVUIoGdEheG7UZQLPY
         RhmGEAoRwwX8Mg6kLRyjyxZRRm0+MyjVZGFpkWp/iPkKZLztCiSNY7RkVdUcP3ajcK
         l7aur4odRHoBiMLH5hEbg/Ho3p9TySw4/EXBTUh2a/qxcEVL3o0jRekazehHZpEuBU
         YS7xLg4UWbIYBfriy9Zl5y8sD6ZabqQYYeaSQvi8pCEaM9jGG0/UTpix34ybl48jdy
         osTANaCRoySJg==
Date:   Tue, 8 Mar 2022 14:31:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        andi@etezian.org, linux-spi@vger.kernel.org, linux-fsd@tesla.com,
        Adithya K V <adithya.kv@samsung.com>
Subject: Re: [RESEND PATCH v3 1/2] spi: dt-bindings: samsung: Add fsd spi
 compatible
Message-ID: <YidosChLIwIAKDmG@sirena.org.uk>
References: <CGME20220308120701epcas5p3d3d2f5c01055e8c1721ae0ec6c2aa681@epcas5p3.samsung.com>
 <20220308121640.27344-1-alim.akhtar@samsung.com>
 <YidY+ncMVhp7bBvh@sirena.org.uk>
 <Yidg64QGGzIbduQ2@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jyxo28c6xJeJOF6f"
Content-Disposition: inline
In-Reply-To: <Yidg64QGGzIbduQ2@google.com>
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


--jyxo28c6xJeJOF6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 08, 2022 at 01:58:03PM +0000, Lee Jones wrote:
> On Tue, 08 Mar 2022, Mark Brown wrote:

> > I either need a pull request for the MFD changes or to wait until those
> > changes have come in via Linus' tree.

> You mean this one:

>   https://lore.kernel.org/all/YiYC7eYx2SpPILyl@google.com/

>   spi: dt-bindings: samsung: Convert to dtschema

> Or something else?

There were changes adding the FSD SoC as well as DT stuff IIRC.

--jyxo28c6xJeJOF6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmInaK8ACgkQJNaLcl1U
h9DQxQf7BcPWuE4vF1XdXLMunwK6rdr5BBcGadp7gvfZ3/10wdnVycVGXUseB52i
YEDqvwa9CpQN/JU1GHzMtZ+cO6q0em+6YQEJYgQUs2TNhimUMomUGK3LDnDnBxzm
c2wRMsR9Gu7CrxKbcn7mKhne+PzqRzUEkDENLrStKUxA45+H7RqlRNriCRvNo5KR
SRlV9LUoerNJNk2ikspS5uOmKFRJPAB7IU47PgcvSDcLWsn2Gdmm1NeSR+k0lbie
LnMqc3nrjpKYV4i9IMlqiBii0+YmDm8Vw+sGvGIUJSqC22xmOg+N8i+MbRC6muP4
lmz5D8KwbJvmUytwqbvzHRWGK+lLkw==
=L8gW
-----END PGP SIGNATURE-----

--jyxo28c6xJeJOF6f--
