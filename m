Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E95A5F26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiH3JTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiH3JTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:19:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10217D59B4;
        Tue, 30 Aug 2022 02:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C61D615A9;
        Tue, 30 Aug 2022 09:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F37C433C1;
        Tue, 30 Aug 2022 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661851154;
        bh=SwPjHCLKYYZo24pNWoHi/EzQ8Bw9XL5Yz5pDnG3V+DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbCSUVon7sw4HNCpIxOWkNjxIheA8aBDH7GpnhuC5f17G5emIxDAUlxOM+Fvp0iRU
         FBedVhNtRijDmUb9/HB8nAKECD8ery+IibBSd61630U56L/dxXOUzNYFphU7LjFowR
         OiHPPnlETwDA3aygoFhuKFRyurJqk+UtVWvjTO2RyHYD6Eb+36sk/sdA4HgPQGqPzV
         DJ7+p1lJeYXN9IdrTiDj6xa5QOCONzrKEwYcttJuW5BlsID/br+T4MQ2j1jiHAnq0G
         TY23Ik5nw1Pc6qhDeq5Cp1Ln4lwU8XM1d61ImVipqs01FqOwOHBQIRlNpYMtYzyJUd
         8Gb6dOZ2kcR9g==
Date:   Tue, 30 Aug 2022 10:19:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0
 support
Message-ID: <Yw3WDjj7MzQjG8z6@sirena.org.uk>
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
 <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="08m2eXtZ8XzZJMzf"
Content-Disposition: inline
In-Reply-To: <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--08m2eXtZ8XzZJMzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 24, 2022 at 11:43:24AM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Not sure why you didn't CC me on the cover letter for this?

--08m2eXtZ8XzZJMzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMN1g0ACgkQJNaLcl1U
h9ClDgf/SDwK/LNps9Cff1VWwkXo1k95/kyxZy34bAEQUzp0gRk/qqq31U1cfJSk
9kvw/fPwTEmVSIr8IuP8mGCuXrqpe7R/6wjVEzF0oaA32YoA9l1q0FGHCHKyLx4c
Y6OfXt/0O6lxrbpzxu+zfBAJDSh6GPUXMstquq6Yzzfg4GzILeKo7uN2fVEvxZKC
7r1BSlMnzkS8Kyn17OwIJ3sWrzheLoEXqcG+PtOgQoLh6V9TE0/cBaSd8VSbMbfc
1CViGUPmXv2Lcu/GzK06iSa/QtcSCnQ0+Q7o1Rgsdbs4z5fWxLHHQQJl1aoC0nKz
zlOVOs8ocdu2lpBVvhcN0KW91nFtKQ==
=ZhSd
-----END PGP SIGNATURE-----

--08m2eXtZ8XzZJMzf--
