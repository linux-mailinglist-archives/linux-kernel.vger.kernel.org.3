Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86DA5119D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiD0ORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiD0ORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:17:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0506053B50;
        Wed, 27 Apr 2022 07:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B06DFB82751;
        Wed, 27 Apr 2022 14:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34185C385A9;
        Wed, 27 Apr 2022 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651068829;
        bh=YRr62X1KC5ng1LU4kmCYYrPiYAa/FMG0PmYtGBvTSd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jp0majI7UjWwC8FLYui36TU6U/wwA7CUyylwj6NAoHTeojNVT550lHLbgA9aJK/wQ
         FZPc6pqY5naKiec48+BKfQ0t/jX/vAdL0OtqiAX8k19DOMyKpVTnW2Ktdsp96uu7rX
         v4O6lToN80jNleN/6Esd/qgLAGp8P9d1mlG4pLM9rpCsXZARsaAJwG4y2QZgQ9PClm
         vy7yzzSgGcmZvjTBUVl7NsoFkbM6BCfH1kMJaDukYik5lpdF0umPockeea8qrSdSG9
         2JXUx3CRyi7l32931F9MEKFdqS271YDlMhQGk8QO4hYB2viStfjD+TiF90nywvNTh9
         5n49mp5csBdgg==
Date:   Wed, 27 Apr 2022 15:13:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <YmlPlhKTrRXZo/Sx@sirena.org.uk>
References: <20220424032527.673605-1-gch981213@gmail.com>
 <20220427112857.7ddd7fc8@xps13>
 <CAJsYDV+DfBEmWr7D1aO8F=3WMurAg6aEhf5gY86BXOUSyJ2nXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4i1ELcqcSD2FWPzu"
Content-Disposition: inline
In-Reply-To: <CAJsYDV+DfBEmWr7D1aO8F=3WMurAg6aEhf5gY86BXOUSyJ2nXA@mail.gmail.com>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4i1ELcqcSD2FWPzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2022 at 10:04:57PM +0800, Chuanhong Guo wrote:
> On Wed, Apr 27, 2022 at 5:29 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > The patch actually look independent, so if it's fine for you I can take
> > the two mtd patches and let you merge the spi/binding changes.

> Out of curiosity:
> Wouldn't that break the build for spi subsystem? Because...

> > >  rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

> The spi driver needs this header file which is moved in the mtd patch.

Ah, that'll be an issue indeed - if I could get a signed tag with the
dependency in it I can go ahead with the SPI bits?

--4i1ELcqcSD2FWPzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpT5UACgkQJNaLcl1U
h9CoCggAgr/UCrnXyGYR548Hq8CNekwM2Sb0hIKaUwNi7p1ZqciUlWwzMJKtAYrV
ZTgWlLGUMY476SBCyrtHlucuB+DKBwCikrUnMMsEk39+pMEXSNPdKLnjG7hqd6Qr
u/8Px3mAdyBzOgdcIlxcTl8kgIvR+aqMSzkjsRJaZ3csuqCnN8NVQAHJ+yLBqkrg
bEr083uX8PyGSTCQc+v7HaMXce143J8bJYj0lFWJ23znLRf4Lb6PemUQhcoXCF2H
d+3GC4HLLB9cUfyTT5FqxE17wgACp6rjjIMuSc7BgTmwM9g61EfIqVjUYtRpTBTm
980Mme+EQalOui5TWB1hYXW0VXicHQ==
=2Qhu
-----END PGP SIGNATURE-----

--4i1ELcqcSD2FWPzu--
