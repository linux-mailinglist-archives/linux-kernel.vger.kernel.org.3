Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C65B08D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIGPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiIGPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:42:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F6EB1BB4;
        Wed,  7 Sep 2022 08:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A26CDB81E0C;
        Wed,  7 Sep 2022 15:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055C0C4347C;
        Wed,  7 Sep 2022 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662565311;
        bh=/S/dkwp5ZVEfvkT7cXSM0abXRYV90A8gHsHvynV/bE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPtjXj7LVbgPklwL0BtFQvBJBVKud+/mTLi/X4cto7mqTclBGsTV5WwwKD3WqEfDF
         e/DsY8llF4okC8r2/W0d0lQB6ZbA9lp+7glaGqUGmR+x+AQTRgeYuk08kjCZ1p1sh4
         07dzUdk/zH2pQQi4tpM+2Gq3YIpN+7KLYlHT5GZEiXivxlxzJx7W5GVihL44Jk4/UB
         F8wBZ3dkj3JzlzP++jXMeDpKXRwIP2D0f07e1K0rhORMmh2Afmf/Ern3ep24TrmItB
         WW4zBCxRmcXz9zok5DZGvfLZy5VZWr95emKxduMAtdBwt+Hckdd1u0jmklJAzQdmtA
         k+6k19kHtCyyw==
Date:   Wed, 7 Sep 2022 16:41:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     luca.ceresoli@bootlin.com
Cc:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 0/8] Add support for the internal RK3308 audio codec
Message-ID: <Yxi7uD6RKeR3uHcF@sirena.org.uk>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9EHz1xmrlXau4N0B"
Content-Disposition: inline
In-Reply-To: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
X-Cookie: You have a truly strong individuality.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9EHz1xmrlXau4N0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 07, 2022 at 04:21:16PM +0200, luca.ceresoli@bootlin.com wrote:

> Luca Ceresoli (8):
>   ASoC: rockchip: rk3308: add internal audio codec bindings
>   ASoC: rockchip: rk3308: add audio card bindings
>   arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3
>   arm64: dts: rockchip: add the internal audio codec
>   ASoC: rockchip: i2s-tdm: Fix clk_id usage in .set_sysclk()
>   ASoC: audio-graph: let dai_link->init be overridable
>   ASoC: codecs: Add RK3308 internal audio codec driver
>   ASoC: rockchip: add new RK3308 sound card

Please pay attention to the ordering of your serieses when posting:
generally any bug fixes should come first so that they can be easily
sent as fixes, and normally DTS updates are at the very end of the
series rather than mixed in the middle since they go via the platform
maintainer tree normally rather than with everything else.

--9EHz1xmrlXau4N0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMYu7cACgkQJNaLcl1U
h9CKzAf8DdI+J5miR4E6cIrTXKZoGqR7qZhfHqflFl1gH1Y4ikj9fbdxe4vhlxEz
nUlD7rd8x8u/c8l0lkObG4gKpZ3VMuT6Pvr5cxCHzlGyCgKb3NEMme5JhSuV8TCW
qchsRF+ZGTXUcPqBN5ey6fl2KAboGemFxyuDLWaVD9CVsKDpoMtyOsgE8PC7sTRO
Vdqkl33gsJZP8XRlRomBFUpC/ziINrHXBW+hBoyQBNBLJxdUT7OM7WXVsxJaJsJf
o+lK+dLy4RD8Pnbt28qgvhMDFxNKCSGX6B0iI8lgMls3j/ZJme3+MnrNA9DwDTjM
wKQ4TTmanyrMK0yzQd4uThtlEm/FfA==
=rYHs
-----END PGP SIGNATURE-----

--9EHz1xmrlXau4N0B--
