Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F155A2EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345628AbiHZSlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbiHZSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34FBEE48A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6583961D94
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5828AC433D6;
        Fri, 26 Aug 2022 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661538956;
        bh=xF0KNsI2IlIUzyH8YZ8MnRxmK+IVlETUPKl64/0iTl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7r7Mev+tcF/CzzQZyLFUkE0G5aCB0QtF3sHVUe1axvDI+WFx91pZSYGU0YCpYsHa
         feJKZL5yk8GtR5XZnW+TWZXZzbT0gF7rbMubqvM6DhtFC/wpwb+DFJ6gpEDo2rXUGw
         NnoqPlpot8EvakJ0pOS/T6K3RlKUBocJb5JwKSCjQBX0Z3duSRI39Ss6gbYyB1XzUB
         Ws6A2d5QlI+74cLb/3GfWth2VAB6l8kC2WbVZeM5EwL22PDMtLobY8XifgtEPNf4A/
         4hUPEvMysFBkYwClzhqphc0a6rlCsCitx6/IQIL7/+MUWToJRSveMC4JmeqrbvyYzt
         ryrNSNHAq03xA==
Date:   Fri, 26 Aug 2022 19:35:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: allow compile testing without MFD drivers
Message-ID: <YwkSi1IIRsW2Hc/u@sirena.org.uk>
References: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c/r7lq7RHI8JSL7A"
Content-Disposition: inline
In-Reply-To: <20220826093659.1059276-1-krzysztof.kozlowski@linaro.org>
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


--c/r7lq7RHI8JSL7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2022 at 12:36:59PM +0300, Krzysztof Kozlowski wrote:
> Motorola CPCAP, Lochnagar Sound, Rockchip RK817 and Qualcomm
> WCD9340/WCD9341 do not depend on parent MFD driver in build time and can
> be compile tested without respective MFD part for increased build
> coverage.

Although generally it's easy enough to just turn on the MFDs
themselves, it's not the same base platform issue as the firmware
interfaces can be.

--c/r7lq7RHI8JSL7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMJEooACgkQJNaLcl1U
h9BjFAf/TBEERO4EdaYIfc9zPGIPzPZihH1I2Kf9uMcL/8bbjjUTFTTD6EZjThN8
AJJNvvlU8K+vJ21+mULAtPZ7V2438t/yjHDHbntubmY4hzcFhDZx30jMUb413+S7
MOFbRePQljnUEkVo62082YtgQxquZ3dAxXv+CB/thTOh6Br+1VoQ7wupKc81uCZa
RuIdpGyXbtKjYEuPJGLaOoUVw25IKocp/hULjpb01sQljTc4ge+a1IGk96oeQNGO
P9qerPHtrEMA7lp0/WeAuZurTNfqu1Z4p+cyrQ10e+CctMGVTqgTgETxMrjVlJRe
ml870sq3S6bw+QmHaqiKZaSwz4vusQ==
=ft5I
-----END PGP SIGNATURE-----

--c/r7lq7RHI8JSL7A--
