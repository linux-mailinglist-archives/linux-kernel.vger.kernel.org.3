Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26A94D0285
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbiCGPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiCGPOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:14:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638C54F89
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:13:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5780FB815B8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B68C340EB;
        Mon,  7 Mar 2022 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646665998;
        bh=QRW2RyTSOhboFthSYoyDRc4nKPsN9M47AoNVFFmLTzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTTg8qiFESfVb3+Dtnxu+MSTKtwVEAo6cIs+ry6615RmrhGucYmGEVKVBDkaiQxZC
         I+afnOArHT1cxt7dYjW1CAaQJQKn7UlLBtYH/ybR/Pj2YbMCCTTXdimMt/w6u9hzFc
         8uHUwavMgd7k1LPoGjHMj0dXp9WoHFNc2bIyA555hxo/F9Yq76VRmXe/xfDRZT7UYG
         +soacU/X2yFL/xtmiVh47VC4E7GgH/JIQFaGXQWzyDPxwPZovCH/QunLY+tgwYFCMf
         SdzNaYWqjnjl+xtl3ez2OxZEvKHcrxTaoTT4i85rQvSYDaRC/BEDAuQYoH77un21qZ
         akZ8w/p6o7Z9w==
Date:   Mon, 7 Mar 2022 15:13:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alifer Moraes <alifer.m@variscite.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        eran.m@variscite.com, lgirdwood@gmail.com, perex@perex.cz,
        pierluigi.p@variscite.com, tiwai@suse.com
Subject: Re: [PATCH] ASoC: simple-card: add bindings for amplifier support
Message-ID: <YiYhCEgHILYoDH4H@sirena.org.uk>
References: <20220307142923.28365-1-alifer.m@variscite.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OHnuGjMM4wK2ZTjf"
Content-Disposition: inline
In-Reply-To: <20220307142923.28365-1-alifer.m@variscite.com>
X-Cookie: Whatever became of eternal truth?
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OHnuGjMM4wK2ZTjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2022 at 11:29:23AM -0300, Alifer Moraes wrote:

> +	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->pa_gpio)) {
> +		ret = PTR_ERR(priv->pa_gpio);
> +		dev_err(dev, "failed to get amplifier gpio: %d\n", ret);
> +		return ret;
> +	}

This would need to update the DT binding document.  It is not clear that
we can't just use the existing simple-amplifier binding here though?

--OHnuGjMM4wK2ZTjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImIQcACgkQJNaLcl1U
h9CPwAf9HbpzVhWhChyQy+Fwd0TYD3iOOJ1H6RF/w62+TZlyS43sN2gaXswUiWhL
mf5lJSl26f7a2i+ZmC6WTZI9IAcmws5GzZ8btqzwCbq8P1//5OOi6j3oB50a7pBg
DK6xFxdv2xs9jdBeHAnvhR5UH81T41BQKBg2CexHPfmBjwAZi8wY315hOpG/rb5m
IxXZWw7mSy1VzAjBIYkDuULoNizQtdwTAdsEuAykAWRb5H9VtjLvyRdkWL65Es2U
Y4djQ20MFT4Ie1VbHIJyAoItBAtbbDl6CeaPVtMs7dVjZ9X5iSg+FH9GWCzfXXSc
Rr1GGoZ5cU6G8TbD5kxS2av/ncCIKw==
=Yhyl
-----END PGP SIGNATURE-----

--OHnuGjMM4wK2ZTjf--
