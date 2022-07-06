Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E371568822
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiGFMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiGFMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:16:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693E624971;
        Wed,  6 Jul 2022 05:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C0BAB81CA8;
        Wed,  6 Jul 2022 12:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFCBC3411C;
        Wed,  6 Jul 2022 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657109798;
        bh=5fgKlm0G+8WGoMRZqsVbzcsJbuj3EfsJIbIyfKGJR6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGRvBzGpYTzumBNvTzv6Eue1beyF5ALxTKiqmKi/DznjkoUpbt73aXe9FSGRvoi2s
         EaTDs0UoMLcClhosM5wHV2q9KRNY1sw217bBfg5Pb67fbeQPmxCmKw4G6dVXL50Y3B
         7WimtQqEWjaNRg3m3vtJ9/n9tk7d84VNfQJmOJD/3Rnz/ucFoA3xd++wNKcFHZxk0w
         YoZNNh7rSkXh+I8fRUcmhnT2IVIeHVCoHzjjusLyeU1pss+4rJUOQrkD25ROQ0D80U
         6IWvIcVjhsxLJCOrexoqTMy0ewRYr5E3508D/Ueemaz9X019qy8guHvRoVjY8UiM9x
         X4yhye68/zUCw==
Date:   Wed, 6 Jul 2022 13:16:33 +0100
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
Message-ID: <YsV9IerWCoa/xtwM@sirena.org.uk>
References: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3plkxhfqWD9h66t"
Content-Disposition: inline
In-Reply-To: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
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


--u3plkxhfqWD9h66t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 06, 2022 at 12:09:08PM +0200, AngeloGioacchino Del Regno wrote:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.

This previously got 0day failures due to missing dependencies which
need would need a merge with IIRC MFD, I see no reference in the cover
letter to dependencies?

--u3plkxhfqWD9h66t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLFfSAACgkQJNaLcl1U
h9BLEQf/WbdGG7PHABzm2fm6ugNRQfoy3Fefmeh9klqvS9ZuEOev+7iE6O7PQDpK
0v+Sap6zB7+L1A8+B4LVMgunnAVfmGClRhY8/FaJXjJ1dF14sOEvn7yW1GFMmqrH
XisVnT2VK3CxZSDab9gfpt+rUqanrXLFhTTgEYzEek4S2mSP7wUt4MWgwNU+/8sY
4BLly2rUWlwYVoiN+6IbM/bqHnFvipJdNKiaYGlu2iDk+taD47Yof/HIt+Zchh4s
tTvWwbQLAIKXHoiQHPLmRyVpGiJqjZXRquzMMVM8nphi0LNsXKpMGq/8hPxe5I32
VVvI0DvdrZ72C+eQhqIqTnJSDDzeIg==
=P5FB
-----END PGP SIGNATURE-----

--u3plkxhfqWD9h66t--
