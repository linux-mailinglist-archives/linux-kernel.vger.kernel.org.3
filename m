Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAB4B29DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbiBKQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:12:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbiBKQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:12:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2E1D84;
        Fri, 11 Feb 2022 08:12:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 600A7B82A9F;
        Fri, 11 Feb 2022 16:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB90C340EB;
        Fri, 11 Feb 2022 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644595945;
        bh=rgSRG/wI/UvP1JIcRcANguOObOhXqt/uGPw7rZYmMLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TH0MAjBSPqE4IvkEaG/RqqjT//6OxDhIaX4ubPKeBufLBVs+dhZOSFK76aUYUIrFu
         qm3Q+9OuINork29yHWxhWekK77boma+MX+IjD6R9YfY+PtYB1WtxsvcQq3H0qzE8kj
         fMEaAzT+nHQQNoA75Wd2N3/mqGMd4UAWe7pz/iO6v8MFKpcQFelNPDWbiXMKx2T8N2
         hyCknDNwaFNyJff8KDVIr5Ndy2b12grxjQXCyMli2hTx9y4czC4fWzJLiLhwgw3iNh
         c3RgLyGb5dSSXN9m5nZQ3qGxBkZsW6/C2qS0l8OzNN2wMfOS0SLqDusMgBWWe5+25A
         e310hORe+8+Xg==
Date:   Fri, 11 Feb 2022 16:12:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] ASoC: mediatek: mt8186: add platform driver
Message-ID: <YgaK4hiRjEJi9wQ4@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
 <20220211103818.8266-11-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gYCP5ior9YtfvDdG"
Content-Disposition: inline
In-Reply-To: <20220211103818.8266-11-jiaxin.yu@mediatek.com>
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


--gYCP5ior9YtfvDdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 06:38:13PM +0800, Jiaxin Yu wrote:

>  sound/soc/mediatek/Kconfig                    |   44 +
>  sound/soc/mediatek/Makefile                   |    1 +
>  sound/soc/mediatek/mt8186/Makefile            |   21 +
>  sound/soc/mediatek/mt8186/mt8186-afe-clk.c    |  719 ++++
>  sound/soc/mediatek/mt8186/mt8186-afe-clk.h    |  210 +
>  sound/soc/mediatek/mt8186/mt8186-afe-common.h |  245 ++
>  .../soc/mediatek/mt8186/mt8186-afe-control.c  |  262 ++
>  sound/soc/mediatek/mt8186/mt8186-afe-gpio.c   |  211 +
>  sound/soc/mediatek/mt8186/mt8186-afe-gpio.h   |   19 +
>  sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3030 +++++++++++++++
>  .../mediatek/mt8186/mt8186-interconnection.h  |   69 +
>  .../soc/mediatek/mt8186/mt8186-misc-control.c | 1729 +++++++++
>  sound/soc/mediatek/mt8186/mt8186-reg.h        | 3433 +++++++++++++++++

I know it's already a long series but perhaps the clock and GPIO bits
could be split out into separate patches?  This one patch is over 300K
which is a bit much in one go, especially when it's not just all big
tables.

--gYCP5ior9YtfvDdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGiuEACgkQJNaLcl1U
h9CJtQf7BDZBnFCixO3E3MMHZvLzF2Pnw7+W3qm+6WvLPzVSD0iOyTc1J3ZrilB9
06VgI3G0b0T12wP+S0o0m4nWBfjBuFcSm0SlMQ8tNHm4VNZz13RJWL/HFKOWBmyL
j3orzapgV2Q46cYWkZpRu1ghoNt8yHbXOtj9fM847nykba62lkcTCCMQkGZCxPuU
wSQvZko3pHCRhRV24sQuIuLE2XhP+trDjSJzEG7EpcgPC2OLioAtCOZMaqbjLT1P
7K2gfHPXcBfiCOAn4p/Ns4votdDgBcoPwnyKmcn1V+wuRKdGQT5E15QOAyRi6s3Q
9pCv5S38o6lxca49gRWRCRt7T79E8g==
=dsn2
-----END PGP SIGNATURE-----

--gYCP5ior9YtfvDdG--
