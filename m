Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C543554F364
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381352AbiFQIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381382AbiFQIpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1B6A028
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9FEF6119F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD5C3411B;
        Fri, 17 Jun 2022 08:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655455523;
        bh=yqzhLHcKPAJYHbRZbKXDOvARyleooSL+Wl+IzjUN4p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcxHZnnNY9YJMK/0j7CavYwMR4LNBIcWcBMa62qHUvOAEXrVqtH6V+LS5oz+jZJS0
         qT3ZRdlvEcrhBCUzfISNq/c15rlmZyHYbMtG/IQ1ZMcwSCRgR8tqWt6Su0WOpDfQZm
         yvwQYttfIBB+6uaRfR5uD1uLtRCWyc+XQVrKF6yVaxAYhr0lLUvDerQGnT7b1tj8Eh
         K+Ojta6jA3AFtXowcVyEOZ6WSccsFNoPm6lcNxSWIHyVHr0qbyqDec3VGeuoR8Ld8t
         Ipq/iCF/S2AQiIWP0AmmCfkROXNAacAy3UsBgGLK7d3+pIXCZ6eLkTlMDSXJj4ag9R
         pLZ2vAdO16r9w==
Date:   Fri, 17 Jun 2022 09:45:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <Yqw/HbgbdkFPht8D@sirena.org.uk>
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
 <20220617044251.4029697-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aLv2GpDJ47ZFHIwQ"
Content-Disposition: inline
In-Reply-To: <20220617044251.4029697-1-judyhsiao@chromium.org>
X-Cookie: 98% lean.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aLv2GpDJ47ZFHIwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2022 at 04:42:48AM +0000, Judy Hsiao wrote:
> The patches series is to fix the unexpected large
> DC output voltage of Max98357a to burn the speakers=20
> on rockchip platform when BCLK and SD_MODE are ON but LRCLK is OFF.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--aLv2GpDJ47ZFHIwQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKsPxwACgkQJNaLcl1U
h9C/VAf6Ah6++LNhpFFUJaZ0Bc+FLeKDMzIEESVc0bMzROauZlkjBbR2EunJMmq4
BhlzGKMafwI0RT4sGVbO7nPwVr5ltH7tfcIxMz57xvVwie7Bb2tld2ZTSAqP5xXq
bJUNA+bJVHSW8KwiYfcydoQeCvcNMuik4ywZ6nubQPX806JQLxM9cQFdu0ayaMzM
pjFAFbXkeyJKUrsbvXfP0BQ+PVAoqnJe53NAHwd7GkTOw/vHO7zx+0Mz5HSSZ3p5
HEM9h42NagL4ZomdmeStvS2zUxms/g62hrgi9KcWiclSYGBWXDfvL4nbJ3MFugRY
ZufRWrarft2pGXl6wfWVsQwSmx05Rg==
=tvsr
-----END PGP SIGNATURE-----

--aLv2GpDJ47ZFHIwQ--
