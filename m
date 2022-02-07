Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610DC4AC857
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbiBGSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiBGSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:09:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A61C0401DA;
        Mon,  7 Feb 2022 10:09:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADD7AB81633;
        Mon,  7 Feb 2022 18:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5936CC340ED;
        Mon,  7 Feb 2022 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644257353;
        bh=Kl0piouUQfOB7fbbAm8eY6+azL6dVYJyutb9M6s+a0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGgSc+JBy7Ew6szwM3g69hmlSyZ2mEXB7uq03KRN2paiXZIGo6GalaHhq1MS+NE0E
         CsrgvUDvGoOt3GnBhRooyDQ7Eok9g4R5kIfwQntxIKbxVLrCnWpUOJeIDHpEq51Jlb
         UWUDFyHWDmO+QdSCWHKs6yVNx2kQVWnm9ZCG5S73iCl6j6Fy/6Lz6/mxHyuUoIPqEn
         t2f/3uIeXpttpJYlSONJKxWcRGlL0shBIqa4K9hXo/MD8KVsvA2EH65GEQCoi7yj+d
         bk+p/r5kiF6GU69gQERH0RXEZTfiJRURWu8LGIhWoXGMkRWiEIElL1/+4nAKkTs38D
         4OGSPAYPRB3Og==
Date:   Mon, 7 Feb 2022 18:09:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 1/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <YgFgQsV2bJS6mjQs@sirena.org.uk>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0Fh6jDwau3COtXX+"
Content-Disposition: inline
In-Reply-To: <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
X-Cookie: Never give an inch!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0Fh6jDwau3COtXX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 24, 2022 at 09:23:44AM +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> controller bindings to DT schema format.

Reviewed-by: Mark Brown <broonie@kernel.org>

--0Fh6jDwau3COtXX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIBYEEACgkQJNaLcl1U
h9BWCwf/QlO6tpWgGKNywXLMUCQhFw1RGfA95Q+PNRnzwaCmGN0l4/An56Rgb4SW
UhhtOACAolo021awaq675c6d0alEl4KBHg9koUWCZk1jWFSoDprNEatcf7gJ1+f9
utrTIN4mAjZr8qfhrhLcFEk1+rtPTAUXunuC5pk6xFdEwNai3BQOrEJU8XMZozNo
d/wB/Pnch0lhMIcyFlxJd9FNyw9OMTDqEwcLF6xqYQAgJCk298dgo3O/igNdACpg
aJTA6p7kb4zUsbxoEcZByGukfR/3nX+PRdpJVs4KiTl8VX6SCSFWjUDRyYPGUJTR
f7lrrFr3kSwkML3mUj6A7WIc0dDwHA==
=FDZd
-----END PGP SIGNATURE-----

--0Fh6jDwau3COtXX+--
