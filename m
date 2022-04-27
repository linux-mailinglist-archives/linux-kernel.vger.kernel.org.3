Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3009E511B14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiD0NOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiD0NOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:14:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCD1C1DC9;
        Wed, 27 Apr 2022 06:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9304F61B98;
        Wed, 27 Apr 2022 13:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FC1C385A9;
        Wed, 27 Apr 2022 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651065090;
        bh=tpIYWICrW+Xe2NYo9+47DtMMvdK4RGp2TzuVJyjTpZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7unDFzV3JJ93notz6nFF8qVCFjJ34yZONp6aEjymzwqcKThuj8hPwyIEQp4oyGjH
         Nc8Jwo6xRw7wqIP7Ns8of9TW2BnweRHUiYUyrMjQd1DIb/sLx9hQOnbS/xVOVBlv5D
         jpweLVNSIvktWp6sp2qD0AeGPbAvvsw9GSj5Ubo+mhE7jJs0Z6hnFu8O2reeakEaLB
         nPLS2QiotHoSXJ2c9gVDgnvYgW4X9HhFztis9wB6kcWMjX6hXOyg4MLlwCCTNp8Lsd
         AB4wZIhMFlANHQU5JDN2+CIqPmx13fGtsyUgPL929Tsl5VD/ZlR4FVRmhmN8ti2Q2M
         0XpGV3FuVmuYw==
Date:   Wed, 27 Apr 2022 14:11:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v6 0/5] spi: add support for Mediatek SPI-NAND controller
Message-ID: <YmlA+tqqigjkRyMZ@sirena.org.uk>
References: <20220424032527.673605-1-gch981213@gmail.com>
 <20220427112857.7ddd7fc8@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3/axAlvjop7jo6tE"
Content-Disposition: inline
In-Reply-To: <20220427112857.7ddd7fc8@xps13>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3/axAlvjop7jo6tE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2022 at 11:28:57AM +0200, Miquel Raynal wrote:

> The patch actually look independent, so if it's fine for you I can take
> the two mtd patches and let you merge the spi/binding changes.

> Would this work for you?

That sounds great.

--3/axAlvjop7jo6tE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpQPkACgkQJNaLcl1U
h9D1ngf/VxXyRrmMrFHXOQIT/K9jzEroGCHRoT3IkpzG2UwCERVkL3XY1VX8Bem6
oeIQERn5z5pFMCvgeLOWDvW4LuV0J0E2Wp9IjvFxdX8fA5K7Tbg3albH0isMfcUp
FZcnMXUynnhcg/dTJYMXHunlQH+8yv84MjxSqq1wDmrHWCy76vraVev5n2eoBdo9
fQ06pKoqMEgkf1ICdUnlW8i9Y8LgmlZSyj7iGRhfw3H2MxBIHVmi2TOdAYM2u/eC
sanKESRfPqRjsbK6kkTy4oePpH0uR+aRLqzqtX9qcF/Wnw+A+WZBc8gQPZZqLvjX
9YGhLRk4sIgGwjyxbojuoeAw+pqSrA==
=3uM/
-----END PGP SIGNATURE-----

--3/axAlvjop7jo6tE--
