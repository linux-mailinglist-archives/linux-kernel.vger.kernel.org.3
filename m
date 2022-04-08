Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC354F95CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiDHMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiDHMaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5133DF84;
        Fri,  8 Apr 2022 05:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70F3B620CC;
        Fri,  8 Apr 2022 12:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F3EC385A3;
        Fri,  8 Apr 2022 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649420880;
        bh=N5V72NGw/oH3V7jhL2eqxDT7AtT93lmGpSFjPpUk84o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XseQyrskrKHG2ZYifsSWw4C0ORCYktjrfjWSS39eovOSoMO70/BK0nmdZOGe8uAF7
         nKHlITp70+P8S0fd+qQJKPAgFNDqnYWtysO05tDP6ghJh2fYhJPqQ6GgRtHFwy3rPu
         bseVljcG6Btzk+eq4LvPQqWFKCdu63bpDcbMiXjEUtkTnZKsNitovhrBcQNiTI1fXl
         rw65czT4wA2biLWos9N6btp2k8Qwm1fuY8d8ndxnc/DNxkMSdUOwyCip/QzvW0HLo6
         uQywsCY3cal71kllpexhjuoo/Re0tlIlEPRLL4/IMR/dXK3oeND7VV5XRw95GdGJZH
         dlRqLt/vN92aw==
Date:   Fri, 8 Apr 2022 13:27:53 +0100
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
Subject: Re: [PATCH v4 1/5] mtd: nand: make mtk_ecc.c a separated module
Message-ID: <YlAqSQ5w3y39aOy+@sirena.org.uk>
References: <20220407150652.21885-1-gch981213@gmail.com>
 <20220407150652.21885-2-gch981213@gmail.com>
 <20220408083214.1473e88a@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZqHgdsk0cLf7iTJ6"
Content-Disposition: inline
In-Reply-To: <20220408083214.1473e88a@xps13>
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


--ZqHgdsk0cLf7iTJ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 08, 2022 at 08:32:14AM +0200, Miquel Raynal wrote:

> Otherwise on the MTD side the series looks good (besides the two
> comments you already received).

What's the plan for merging then?

> I don't know if something changed regarding the comments style in the
> spi subsystem, but using // everywhere looks strange, it's usually
> reserved for the SPDX tag, but I'll let Mark comment on it.

I generally request that, it looks messy if the comment block at the top
mixes styles.

--ZqHgdsk0cLf7iTJ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJQKkgACgkQJNaLcl1U
h9CYWQf/aDU1pdMHOR+7llwkDyWQ1V82hUYybIHSsJissvDGWXzsR2f07fHLNOFM
euloPRzwBaIkluvEtWUg48dvzNObDlNeV93OL5Fx+GQiYlHUq+X4GyfDaLuLGb7o
cLvaD9w6MuQ33+vUy5/+yHIFymOVH7gqcTo2yXe4U23naTjMP4fedx8VW9BcztrQ
kcQ7315oY/dOUy/We5tewUENw4MaXshvpPdaMAue4qU+C1vxygPIMdze3oPi6t3R
YC1PjdjMaAC7HDqENoCzW97DuTNb43yj5Upg+9ZaRA/na0G2e/Q29+R7t5kuEYRx
jOOZiAm5s7dtfFVI5Xy0BYSh/5sysA==
=WOzd
-----END PGP SIGNATURE-----

--ZqHgdsk0cLf7iTJ6--
