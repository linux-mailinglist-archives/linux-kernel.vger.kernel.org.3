Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2419A4B29E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiBKQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:14:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350775AbiBKQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:14:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB2F21D;
        Fri, 11 Feb 2022 08:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03BE9B82A77;
        Fri, 11 Feb 2022 16:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE074C340E9;
        Fri, 11 Feb 2022 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644596055;
        bh=sNz2tFUsc7yL/pDTYZgBpCU9uV+JsVM0G9jqqLqvVS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwgNsAej4XLRiZXEwDL7bwZAM73hhCpGYFCmS8Y6u8dtAKyi+fmfSTv9AJWAE2NeI
         KSzDwuVt9HFRbOvvpN1ayO7UN31FXA0Ceo6ao0md5ccyywTJcUwoi2C3JOV0sQrSGt
         RZWXUqS2O9OMReelWJYHPAB7PXNi3OMmTa9QRQXXRJYF1XB3VyhQGb3qQ2Nfq+2NN2
         KSVm73tUGepdEjLf02jl4IMwtYVaoUpB/Pp/TusIqrBCYPrpslzBOQOTE4Jsbz+4+V
         y/7LQF9rNVOomWzPV/XJkGr3z8oe/friRlhBR40sQwaU4/hcZbxA8/Fs7Rjw8Z3r7k
         B3GU6bwsnq+YQ==
Date:   Fri, 11 Feb 2022 16:14:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] ASoC: mediatek: Add support for MT8186 SoC
Message-ID: <YgaLUNQXnGsZHuXQ@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xkn+amad5HrevOtl"
Content-Disposition: inline
In-Reply-To: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
X-Cookie: do {
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xkn+amad5HrevOtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 06:38:03PM +0800, Jiaxin Yu wrote:
> This series of patches adds support for Mediatek AFE of MT8186 Soc.
> Patches are based on broonie tree "for-next" branch.

This all looks basically good, there are some issues which I've
highlighted on the patches but like I kept on saying they're all fairly
small and hopefully easy to address - there's no big structural problems
or anything that I noticed.

--xkn+amad5HrevOtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGi08ACgkQJNaLcl1U
h9CKkwf/SLonnfl3fV+46O1AC+u/WFZePStG+cGxvOGhs2iKcs612qJNEAOgEy0T
5lZRM+tTsja54tt7keZXc+AulVVpMOu2ROqTU4BJp3Zygt++snT8v2OTC3XSnjcI
vJOrvxSUxA3zKxdquTHgcCG+MQOjQi2B1MfD5gU5ZrJLhO9u6CjOSkhTFGwCdhn5
O38VRqcD17TbQXKnSqWKGOKJJWywGW84Gv2P7M7QlZqugFHkEzo21Fw+Y6m0SSQI
I/LKyDgTu+Me3OIweHSNrFO9WDAE3Pv8Q9V8alHjd+iGpGLJWBoHk3SMXVnCZEe2
xr5Jvd5fZyGKpL/T//Iyhxzqx84fDg==
=7jLS
-----END PGP SIGNATURE-----

--xkn+amad5HrevOtl--
