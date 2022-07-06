Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4645688CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiGFM6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiGFM6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:58:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC4122;
        Wed,  6 Jul 2022 05:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98ED4B81CE2;
        Wed,  6 Jul 2022 12:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A908C3411C;
        Wed,  6 Jul 2022 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657112279;
        bh=QrNdip0xbegVVlOqR8agmJ+S77ZMuuDeifkGOEZ2+TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9Uig1t7Ar00l00Xt4taBoCN6h5RQu9EZAnamu3fXB/uTXiccnGvppLS0jB7hHFwT
         R6EgCw1YnyZnV27o8IufOEasTu1V/4W0a2exQ0itloEXU/4Ls985hwAu0KFLeRe5X5
         9E7J25N/jFGJXtz63JHueVtN/ibiJyPHbVTgYOwik9BJH++cP14ve0p09F/aYmTCr9
         oV6LTQ3RSqgQ/tPvYNR2Iifqa8NqiLWDa7SqekSZkXXhfdYA6eHdurHqbCt/EuaVPK
         Bm1NTBotjtAIxC2i6JL1/bZESfFwBOsYJOhoZe3cLB7mL9aOJ6ckd/LfC2nHgo7xWY
         vaeeeYSWrKA1Q==
Date:   Wed, 6 Jul 2022 13:57:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 RESEND 0/4] MediaTek Helio X10 MT6795 - MT6331/6332
 Regulators
Message-ID: <YsWG0jfqAf4EqojE@sirena.org.uk>
References: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
 <YsV9IerWCoa/xtwM@sirena.org.uk>
 <57367b11-f2d4-476b-b92d-16c1726316c0@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MIMUgHtOMspXsyrA"
Content-Disposition: inline
In-Reply-To: <57367b11-f2d4-476b-b92d-16c1726316c0@collabora.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MIMUgHtOMspXsyrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 06, 2022 at 02:49:56PM +0200, AngeloGioacchino Del Regno wrote:
> Il 06/07/22 14:16, Mark Brown ha scritto:

> > This previously got 0day failures due to missing dependencies which
> > need would need a merge with IIRC MFD, I see no reference in the cover
> > letter to dependencies?

> The only blocker for this series was the MFD patch, which got picked and
> it's present in next-20220706 (as you suggested me to resend when things
> were picked... I decided to wait until they actually landed on -next...)

Right, I also said I'd need a pull request - if I apply the patches
without having the MFD bits they depend on in my tree then it will fail
to build.

--MIMUgHtOMspXsyrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLFhtEACgkQJNaLcl1U
h9ALhwf+LcbvrKU5D7gTwFnixM5NNn/A9PB/fB/gEcbgteuZ6nZvu7YIWEjhmeik
ZSY3RIskvA/4Ms51cN1SlkhylcUXcqeT5+/p5iI4Oaa6UEfvxtN1TE6rWwaLU/9/
7DbQEJJdZvyEm5BEI51pGX8cYLlacS+izmLX28NNXB6gloekTUP7212Ip8x7FYas
yTQueiiLvH1oUJfRRnqp80BoT12VnABkilqA7RLAVpn4ZlkmOqC9Fd6v4LVyBv0G
QV7BPsE+qpR3K53VEGqCRhkmbf5elbDpf5FGy5FVsb3izC80yUT2RDY2FELtXwD3
n4McJcj/rC50Pqj1PYrv7xOy4ErKsw==
=BF98
-----END PGP SIGNATURE-----

--MIMUgHtOMspXsyrA--
