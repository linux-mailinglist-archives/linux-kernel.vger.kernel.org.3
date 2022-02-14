Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83884B505B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353278AbiBNMk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:40:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiBNMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:40:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47C4A914
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAE461371
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4250FC340E9;
        Mon, 14 Feb 2022 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644842418;
        bh=IQKHs148sOwzSOJ9x7YM1yay1qSuKlbeZzKnX8pviEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWhH+LSokZ3Zs/QiXpu8o5Ki+KnAslQZ/LWSTzG9fMRcf+8pxIVHNAgtUU1oj6cvU
         ueXKCU7WZKJ/wRK68K+zEAjeJMdaM7s47AyvQ25N8LoFbUMh7pKIayN3VgCmqiQ99S
         EQR52sV8lX24QDh5Y6RmFhExf1wnMLker7AQ7F8D4NFlTeWtaasxrCVfhF99LVv4oK
         GCeaHeVIzO4MU8vxm/xgXbvG8u+tFoMpgRZSLd4+HwKHyKf5X75+YbpnFVMkkgUSk6
         fDvjyddaRrvSTNImWVKyRUoZuzRyOMhMV3cPUcakLZra9OnBOGXZW/szRhs+oQ3MYF
         1e2CJ3Ew+jpfQ==
Date:   Mon, 14 Feb 2022 12:40:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        James Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        iommu@lists.linux-foundation.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>, srv_heupstream@mediatek.com,
        Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 20/23] ASoC: codecs: wcd938x: Make use of the helper
 component_compare/release_of
Message-ID: <YgpNqLQzpx4J6d8K@sirena.org.uk>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-21-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kmbocLNYrfZ7Ic0Q"
Content-Disposition: inline
In-Reply-To: <20220214060819.7334-21-yong.wu@mediatek.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmbocLNYrfZ7Ic0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 02:08:16PM +0800, Yong Wu wrote:
> Use the common compare/release helpers from component.

What's the story with dependencies here?  I've just got this one patch
with no cover letter...

--kmbocLNYrfZ7Ic0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKTagACgkQJNaLcl1U
h9ChNwf9H0Bf8Q4NJFX6MpkURJU1WTUkJZ8s9zjT9F5003kszR2qdhtG8TCUYisF
m+Ywr7okO1EGsbMSae1gxr0q5In/J/buVsEnIjl42Be7doIn1xXcDB+3tjDyi4aH
ZN/sHluDMyiwzeBgN2jiu99gsgHDVXThtPOdyMLab2QMCVo6PEox6vsKyIb6vO2F
Rl7BLwS916U45mWEFF/XAJLWV7QPG5f43JvKlSkjKLgJhFP8H/cxKzlNZclRAdEi
fSWK497fgwmyoHrXr2inZNyDmAh20f9np1WMgLBl2sJwN8LnmWSDpp76C/XfRV0T
Qp7CAMe19I/TqvJsaFw7oluNeBT7Yg==
=2URH
-----END PGP SIGNATURE-----

--kmbocLNYrfZ7Ic0Q--
