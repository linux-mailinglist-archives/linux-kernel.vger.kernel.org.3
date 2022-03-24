Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE0B4E63A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350288AbiCXMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbiCXMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:53:02 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92BA9977
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:51:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0DDD23200F72;
        Thu, 24 Mar 2022 08:51:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 24 Mar 2022 08:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=aWC+KLJ/QqIPERdjUhA4LBP2Tm/D1WXxZnjiQ0
        EPcew=; b=ieUTR1YmqzB4Pemnlmi0V/QXqIRYmRNHze63/oK623/C+HLpzDE2lt
        dtesLI3M3dFYurnDIe0VX1b/Rwmoe1j5oGJXRQdsx5QpCrXmYaf7S+NDa0dS42RG
        4qOB923KRyvNoq3+hr2ztvID1LTbRvH4MZfPFklKJpDSpJs8hcORFb0g9Aqv0YsN
        B4OskrAy3/dMht4SSAN81wCaZqP3TH96FKrfde65Um/kMVidxYIQvPXMH6KxpX6u
        l9LYANF4ularOBwSftZ2J1JEUXuFIxlJXJavfAvrid/JckHeb2D0+ZjVLg83UHL5
        8MsdOJkW6ajmeBEHA+YYHQpdMhwUD8Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=aWC+KLJ/QqIPERdjU
        hA4LBP2Tm/D1WXxZnjiQ0EPcew=; b=YY6Lh1sQlX8ytSrGIPRgnRPDivUFCHfo0
        w9YawLeQZLWNePOuNOxDDmkCoFsK2lu+piRj1YGLszu02aYvzDkr0RdQFZlwEz5u
        sJKcwX2rhhOFSjqfHVdUu2BjV/Ljm4Qn88MHdnbm40jfk4bEtSuP+CZ8gL2gyHdZ
        SdL2hAzxE5YUi8LnDKcUppa1Le7Mm7jKw2TD7+s7Ok/cVBWAykq8xy/cXyTz1eUc
        wkSfizk1rIU+MYO3ZyDeE06YOiG5EZvAW9CmEHMZgSG8NQg87esg1Zv0K08ryLc6
        MJoWFM24K9bZleYOtb9H7NoCIjD+OgDqrKF38wAR2eDhk/SePo72g==
X-ME-Sender: <xms:UGk8YgZ8tqIA0aVevueCO0fU5PhZiLdNpcVlKdyV3NuLnSPIYMKqtw>
    <xme:UGk8YrZOngzdK3QqFOgPC2DJP112vbUTX-gdlPsrBEZhFLIHJpV6YjYJ2FQtzkTgT
    e7tvJR9OOKpeBzdpsE>
X-ME-Received: <xmr:UGk8Yq9fR_UbjrEKUVGya8hdYeeIE3bzmruieKX1i173agFgtuQOnMd7Ubu0283Q-m_Vt4ABG8a3w2hkpFWgzQNcsPn8jLmhRmIRCE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UGk8YqpjksuN7xvz5sEIcZCkqvPbStTS3tjT_1lbO8SfLdusoEG0Aw>
    <xmx:UGk8Yrrv2rthS2TTYK82X-5cDo9Nmowi8QBBiSKKRBFC6O5uZy1BDA>
    <xmx:UGk8YoTK93tdydxeqsnbt9u3DLe4s9YurI4vKGMYTDGX3fQane7WHA>
    <xmx:UGk8Ysfuctt2exq-kztrDUoODO2NH8r8GnME39A5zqy4R-DrPNqPMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 08:51:27 -0400 (EDT)
Date:   Thu, 24 Mar 2022 13:51:26 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        limingming.li@huawei.com, tangyizhou@huawei.com
Subject: Re: [PATCH -next] drm/vc4: Fix build error when CONFIG_DRM_VC4=y &&
 CONFIG_RASPBERRYPI_FIRMWARE=m
Message-ID: <20220324125126.bycrcx7b2j76xagd@houat>
References: <20220324072542.1238122-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u4tiddmcamrazvhr"
Content-Disposition: inline
In-Reply-To: <20220324072542.1238122-1-zhengbin13@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u4tiddmcamrazvhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 24, 2022 at 03:25:42PM +0800, Zheng Bin wrote:
> If CONFIG_DRM_VC4=3Dy, CONFIG_RASPBERRYPI_FIRMWARE=3Dm, CONFIG_COMPILE_TE=
ST=3Dn,
> bulding fails:
>=20
> drivers/gpu/drm/vc4/vc4_drv.o: In function `vc4_drm_bind':
> vc4_drv.c:(.text+0x320): undefined reference to `rpi_firmware_get'
> vc4_drv.c:(.text+0x320): relocation truncated to fit: R_AARCH64_CALL26 ag=
ainst undefined symbol `rpi_firmware_get'
> vc4_drv.c:(.text+0x34c): undefined reference to `rpi_firmware_property'
> vc4_drv.c:(.text+0x34c): relocation truncated to fit: R_AARCH64_CALL26 ag=
ainst undefined symbol `rpi_firmware_property'
> vc4_drv.c:(.text+0x354): undefined reference to `rpi_firmware_put'
> vc4_drv.c:(.text+0x354): relocation truncated to fit: R_AARCH64_CALL26 ag=
ainst undefined symbol `rpi_firmware_put'
>=20
> Make DRM_VC4 depends on RASPBERRYPI_FIRMWARE to fix this.
>=20
> Fixes: c406ad5e4a85 ("drm/vc4: Notify the firmware when DRM is in charge")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---
>  drivers/gpu/drm/vc4/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> index de3424fed2fc..640907945b5b 100644
> --- a/drivers/gpu/drm/vc4/Kconfig
> +++ b/drivers/gpu/drm/vc4/Kconfig
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DRM_VC4
>  	tristate "Broadcom VC4 Graphics"
> -	depends on ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST
> +	depends on ((ARCH_BCM || ARCH_BCM2835) && \
> +		    RASPBERRYPI_FIRMWARE) || COMPILE_TEST
>  	depends on DRM
>  	depends on SND && SND_SOC
>  	depends on COMMON_CLK

Wouldn't it make more sense to add it as an additional depends on there?
It doesn't look related to the architecture, and we'll still have that
dependency for COMPILE_TEST.

Maxime

--u4tiddmcamrazvhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYjxpTgAKCRDj7w1vZxhR
xZWMAP4trCaIrBddC/7hYw+ymxIe51WRUWaq0AxzoIR5KPrIzQEA+s/qi9bCpsEo
1D0WWfBORkna8n4LKVscBPQYWUfWOQs=
=Lko9
-----END PGP SIGNATURE-----

--u4tiddmcamrazvhr--
