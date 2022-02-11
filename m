Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3A74B2861
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351076AbiBKOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:54:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiBKOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:54:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B4D131;
        Fri, 11 Feb 2022 06:54:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E4B4B82A7B;
        Fri, 11 Feb 2022 14:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9778FC340E9;
        Fri, 11 Feb 2022 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644591280;
        bh=bxAUhKGpof08/VSFAF/LODZ1CrGcjJunAUPVk+bKa1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2yhIiXOQJRaIajP29LJOZGHUZ49NqmL5XSbf84yvJD0Cw2RNDpIGCzeh6pq/cxqX
         uMjolHWJhWpBzvViLbTxleRtgSRANAN1ctsOwk806VP+3Sx/GqaykpD6jf5dDFbQGD
         HJWdgA3AanLR6avnq77f2sQ8yMIizJCJW4CsjxGC+pF/oVUJ8aUS835nn5eyix7gsf
         FIRqJFZtb/mfdN1fgHqd9D6ovpuzZbhGfFejkRBvi0WBh7FkoqCRHRoLGDtw+hhfgR
         Hpa9+82grgIKShn00SCZvCnsCpRVfHQ2hBBiwrKffa++rXwr7RuAv4SakvArbBEnR2
         thCnb2uM5iDFQ==
Date:   Fri, 11 Feb 2022 14:54:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 01/15] ASoC: mediatek: mt6366: add codec driver
Message-ID: <YgZ4qdYWeAutC2Jo@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
 <20220211103818.8266-2-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QlW9pqOvflC+sGV2"
Content-Disposition: inline
In-Reply-To: <20220211103818.8266-2-jiaxin.yu@mediatek.com>
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


--QlW9pqOvflC+sGV2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 06:38:04PM +0800, Jiaxin Yu wrote:

> Mt6366 is a new version of mt6358, and they are same about audio part.
> So we can reuse the driver of mt6358.

>  snd-soc-mt6359-accdet-objs := mt6359-accdet.o
> +snd-soc-mt6366-objs := mt6358.o
>  snd-soc-mt6660-objs := mt6660.o
>  snd-soc-nau8315-objs := nau8315.o
>  snd-soc-nau8540-objs := nau8540.o
> @@ -465,6 +466,7 @@ obj-$(CONFIG_SND_SOC_MT6351)	+= snd-soc-mt6351.o
>  obj-$(CONFIG_SND_SOC_MT6358)	+= snd-soc-mt6358.o
>  obj-$(CONFIG_SND_SOC_MT6359)	+= snd-soc-mt6359.o
>  obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
> +obj-$(CONFIG_SND_SOC_MT6366)	+= snd-soc-mt6366.o

Why build a separate module here?  That'll just make the binary larger
but not otherwise do anything.  Usually we'd just add a new ID to the
existing driver.

--QlW9pqOvflC+sGV2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGeKgACgkQJNaLcl1U
h9DIMwf+Pw2HnVc26RpFgDOHvR1H5BYRLyHgSJCd6JQpE2TKhMORPogTaAy1fbkv
Z5OLAx1KFg8nMeSJuCXzny8VmMmY+MLyp4c8kuIdowe+ClR9PrF0XkA+IOLy/eLJ
GF6OxinUeozGJ2rjC58quKQ0cW187ZimFRHTnD7oMDvFI8o9utLHA1Uu7/qQEHDC
J7jBMlvxGdd+rXgKTC7qcL2tFsoUT4VXcTugl3snvv6NqoKw+oAbDKzDKCCfBJRh
nWFWTgMaFIF2GLUoWUP2Z/s42wATKLOBpA0HrwxK8dAx3Q7rvLNLROLlr7efJ9Ou
DXPbM6WV2+luGql1tBWKti715JibHQ==
=+wGZ
-----END PGP SIGNATURE-----

--QlW9pqOvflC+sGV2--
