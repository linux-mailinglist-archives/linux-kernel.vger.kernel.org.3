Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E1357E341
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiGVOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVOwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:52:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77AD7B79F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 607D0B8291C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BB6C341C6;
        Fri, 22 Jul 2022 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658501559;
        bh=1BEtoYPylhGjmfmo73nwCT+Vb21TSaq/b0cgNtuS4G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrqP/xYIKVA+e9udPABysN08f7ZQCMm9pczHjOj5b+x/zZTnFPgnrUZiCm+FtL8Qf
         QkkhzmxZ7GnQXs6/WdkOvrgLcA+sfXayj+GHXrMWVXqelPRwA9H6tP/fuFA9asZgM9
         uGOa7h+OzT/b9lJP93/5YKip/exShyyZTZPf/83/gVpC1mBVA8+k8G/PWgnHG500LW
         HGH4z6DKdUKilkmhBGQBoglGc8bW5gfnaedkWy/dGtDchI0UJX5dU1mJNS/PpGam2b
         a2+cRUVnhdW/O0CeDnN0QT8DQC+hyFqwRLYM7TlqgTBBNuUpcdVJbnJEEFH8ZCj7NM
         Qhn2Wsrukl14Q==
Date:   Fri, 22 Jul 2022 15:52:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Modify dai_id macros to be more generic
Message-ID: <Ytq5rlr/er0wDTae@sirena.org.uk>
References: <20220722141705.3340440-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c9gJw1Vm+Pd8epQJ"
Content-Disposition: inline
In-Reply-To: <20220722141705.3340440-1-venkataprasad.potturu@amd.com>
X-Cookie: Yow!  I want my nose in lights!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c9gJw1Vm+Pd8epQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 22, 2022 at 07:47:03PM +0530, Venkata Prasad Potturu wrote:
> Update dai_id macros to make code generic for all platforms.

> -#define I2S_SP_INSTANCE			0x00
> -#define I2S_BT_INSTANCE			0x01
> -#define DMIC_INSTANCE			0x02
> +#define DMIC_INSTANCE			0x00
> +#define I2S_SP_INSTANCE			0x01
> +#define I2S_BT_INSTANCE			0x02

This looks like it's just an indentation/formatting change which isn't
what the changelog said?

--c9gJw1Vm+Pd8epQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLaua4ACgkQJNaLcl1U
h9DeHAf+NeqVmTKoGIQtNBMWmDLZYi9Nw8C3vk912kGDjJD5KFG3qk9BJJa1B1LI
PCUDhiRQ5Ct+Wgcg6BSgZvkb5scNRHUT2MAB6NZ74Cdr7jJoXnlqcOtreNxHOBh6
LtOkrbZH2XvUO3WvEFxL7pUq7Z52DHrmdREfOcfk+lJUKdEXEAk1HaQHypNBiRSP
QvzpTH85w/1KPkxY7evr+cvcLcc5+xqWRDBKVnja9p2aGdmmWGGDC8WKSJf1xUed
BMawcR9gLBnOKVYz81gHQQQBoc9YTdV+bsBasZ5AyxwppstNwReG6tu83eQW0ACz
1n+UtC+BO+9Mj8kCLCBilA3Ye3koDg==
=1d7o
-----END PGP SIGNATURE-----

--c9gJw1Vm+Pd8epQJ--
