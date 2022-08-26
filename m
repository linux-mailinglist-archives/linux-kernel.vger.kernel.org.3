Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810E45A2E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiHZSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiHZSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242D4CA01
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:24:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F32961D25
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B0CC433D6;
        Fri, 26 Aug 2022 18:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661538241;
        bh=fDJZJ3AeiKD9D2LjbTJDLiT5RrB5WN+nB7JpXBvjlnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWIqnfn9d+OsCtFDKIiyGcfAeVrHpOoMVzlcqSZRBwbl2sRwBYQmSszCQwLZObuBD
         ZyY3dj6+t4VaQA5v+cBAeTm5cmiiw0p/AZ4aTDDtYyoaWt0BZ49KZtIYYy99IX8tZA
         GVLptnAtwx2Z0N5Cn4ulM0RuT57Sl0WxMp0+SFVH4YyEd2mTbu4siFBw0HQm5f3ZMt
         g7+0W9YNijQ1zzuqOu9fnWjQQaNuS0ZJ1khTCIkjgkXfWj10cFm+NvfxHjs9Lt8Ekc
         y2xEloopbPRn9U09fdCE8K/+YBa+lXS2OjPuyup1aa1m0n3rp8HR6CAJiitPHa36WF
         omf/5GEEoD/5g==
Date:   Fri, 26 Aug 2022 19:24:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maurycy Z <10maurycy10@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: Fix misspelling of 'system' as 'ststem'.
Message-ID: <YwkPwFQapBz6gFPO@sirena.org.uk>
References: <YwgAi68IzghNf0Dl@thinbox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2vlFT4VlBjIBHCeB"
Content-Disposition: inline
In-Reply-To: <YwgAi68IzghNf0Dl@thinbox>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2vlFT4VlBjIBHCeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 25, 2022 at 04:06:51PM -0700, Maurycy Z wrote:
> Signed-off-by: Maurycy Zalewski <10maurycy10@gmail.com>
> ---
>  sound/pci/ice1712/ice1712.c | 2 +-
>  sound/pci/ice1712/ice1724.c | 2 +-
>  sound/soc/fsl/Kconfig       | 2 +-
>  sound/soc/generic/Kconfig   | 4 ++--

This has an ASoC tag in the subject but also covers ALSA

Acked-by: Mark Brown <broonie@kernel.org>

--2vlFT4VlBjIBHCeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMJD78ACgkQJNaLcl1U
h9DZvgf/RMNK90WuuI02JCzni10BvcEpIfIyz2ZMSSmNwtFBHHm+WMDGJNpt0EoE
6gfb5thSwCQ0k/AqvbtKV9k+R/zoBFqyPOecVHjf5VvET2NDTH7ifguMEI7OkuYN
qrXCnIA8U/rF4VMHA3viyE5u9UV4ISbW9bg7Mkx9+86cuEm8tgHmYtCULMC7BzMN
VoaS7k0wDYGD8cvh6oW+pc+0AbwuUC/zm59OoijAkcUxrD4KkRA+URLbbqeJAx5G
1J10/3H0I4liJ5ruX28lNTw0/+oPL6FRGRa0ht2qxipVIRboOn+bR2/bIdoNGwMF
UWxCldv5VD4ZDxXas7IAQ34b8cPrzg==
=AIGx
-----END PGP SIGNATURE-----

--2vlFT4VlBjIBHCeB--
