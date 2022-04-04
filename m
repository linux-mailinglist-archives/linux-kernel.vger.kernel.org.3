Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE334F16BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376819AbiDDOGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357098AbiDDOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:06:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BF11D306;
        Mon,  4 Apr 2022 07:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78C1E613EF;
        Mon,  4 Apr 2022 14:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5C3C340EE;
        Mon,  4 Apr 2022 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649081072;
        bh=+YodnbKNfkD+6Cay2I53zzP9Fet7F7fDGOH+q3ST2WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgkScUB9MqKjZwqfpE1regXlQ5YzXGwZsjnqo4dN0muVS235eUAjnw+BKIJMC3P4m
         z3OHgXZpTOB/WHZYJA9jUwZzTmJMOfGhlDEdCeTQBFZwBNyKINzUgpQKS7N9cgTE2t
         2G5Sbbdk0eOTP5DXRKBy9PSppWpPGWb8xPvzHh65q1nQ5gGnS+LN3ubFpTGJ+HcY5Q
         Wo6wNLTqeOCXaF+xSe11nzC86MLLXuMbYh0aSPF7hzFPIazdaUw5VM4TDyTXCcL+lT
         fNKMei4vhBaiGivTLUqzE0n4UGyL6/BR7ZN3io5o+HtGVmolDL8eSoEDVPFMRnH1Rn
         EprzCWdbSK/tQ==
Date:   Mon, 4 Apr 2022 15:04:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
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
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
Message-ID: <Ykr66c+KEaO8vltj@sirena.org.uk>
References: <20220404131818.1817794-1-gch981213@gmail.com>
 <20220404131818.1817794-5-gch981213@gmail.com>
 <14c921b5-4240-a026-252a-d5fb60836b34@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/iF9jkJodygiQRcM"
Content-Disposition: inline
In-Reply-To: <14c921b5-4240-a026-252a-d5fb60836b34@linaro.org>
X-Cookie: Did I say I was a sardine?  Or a bus???
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/iF9jkJodygiQRcM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 04, 2022 at 03:52:19PM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2022 15:18, Chuanhong Guo wrote:

> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - ecc-engine

> Slightly slow down resends (max 1 per day). You sent v3 without giving a
> chance to review this.

> Wrong name here.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--/iF9jkJodygiQRcM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJK+ugACgkQJNaLcl1U
h9DovAf9FvUfyz38jWX01k0PPwcjlxGKC4qUprMZogZ5XZdSB9lbzlD1miFEYdQz
UmBtAiLNTO9ZfPHJnyV5Wl2Xkdfoc8+InivnS9xjXylc98GlA5FHzjTEiSiJz8ZU
k0lp3kaJX6E0Q76hUKDEt66W3Su90IfnKfOal2MuUzS2JGIeR0zE8bQneXElLoAw
cXKz/Xz6py2LiOtIoJ86NRLOV9h0lGFgRmKgG0CAIV7a+xPpkfBpxrX2dFKtZKYw
/sBjRC5tpXdt1TFrzhgkKPH2srhbxZXmIZmtgjId78zdrF2vX5GJJiYs19dc/7jq
tOAfJXMJ8GTUrroa2H6zauEsIlxtJA==
=yGjl
-----END PGP SIGNATURE-----

--/iF9jkJodygiQRcM--
