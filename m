Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB60554716
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356224AbiFVKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356021AbiFVKyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317BA3BA69
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F0E6128E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C635C34114;
        Wed, 22 Jun 2022 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655895241;
        bh=G4XroPUQxa6e/wOY4UG53P8PsXH1RZHdojRCRxtIFkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYovtcRPdYqEUX1Yg7P6xGKNzlkeHiuI8UBV2EJsEeVSqkz0989+AH4S/1o3VfUC8
         p1UFB8Ycr54oZ2Y5Mm1LPKyXTMD4CIf+bp13SgdufvpiqCqGwLhwFsAkuOlPHxMTvf
         g/j3fKfAf+oQ805lgMLxegAaE2H3V3ujhgKbdzLm1brWB0sxgkBufBup+s/QNjG13J
         yM/h1pNKs7fLedLBxqkk2Oze5iTqBXWbXJW8nR+OMZY0RTRc1WSwr/EeVuvXUn9gd9
         WiQkL/7orpicNW2QwOWP9tSsMxrhB2e/RWtwyvL/M/yOy9Cl/qMjjTUToUCLuNvNR9
         y3NeBX07/dQeQ==
Date:   Wed, 22 Jun 2022 11:53:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     judyhsiao@chromium.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>, wenst@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        briannorris@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: (subset) [PATCH v4 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <YrL0wzzfeQwmyHfK@sirena.org.uk>
References: <20220619095324.492678-1-judyhsiao@chromium.org>
 <165583076931.271995.9857794745310978104.b4-ty@kernel.org>
 <CAGb2v66+ZjKFvCfq-H3F_ZdyxiKHY6=7juhSCmHPK3o8kgw+Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4AruQWY53Tdw7RRr"
Content-Disposition: inline
In-Reply-To: <CAGb2v66+ZjKFvCfq-H3F_ZdyxiKHY6=7juhSCmHPK3o8kgw+Og@mail.gmail.com>
X-Cookie: Truckers welcome.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4AruQWY53Tdw7RRr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2022 at 01:58:40AM +0800, Chen-Yu Tsai wrote:
> On Wed, Jun 22, 2022 at 1:00 AM Mark Brown <broonie@kernel.org> wrote:
> > On Sun, 19 Jun 2022 09:53:21 +0000, Judy Hsiao wrote:

> > [1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
> >       commit: 44f362c2cc6dd0c5e3cb499c4fb4ed45b63a6196

> Seems you applied v1 instead of v4?

b4 will reply to anything it knows about that thinks is close enough to
something that got applied.

--4AruQWY53Tdw7RRr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKy9MIACgkQJNaLcl1U
h9COkgf9HKKAvRzjNs2p5CEqeFNtnVzhD95omRkCIyXAyPgMzsXQ86HrXzkr7Qf6
6aty2J1RMF1ryi1b4Jw+B8DfhbDCjmS9nB7H4IV/GlQCmkoUzbFmCdf8qSPLuQNk
bVTyLRDSCh0FUFJXvc894JrLpg1DkjGqfTKmT3OWmAENtixWknby7elcr+CnNAqM
hZujXhxdwazBRH5RtQLO+z8cMOnLgpEWoklHTmzsPrW7EPGMzgBaCbFe4fNac1oI
teB7zkGZqX242LJoeBs9m/yIzPhQYGBAtAie5witncajUnxnAFaWx+Zrbr7PTGci
LOU8M7FkgC0tpcUbs+Eec0tfnEZLsA==
=nzIr
-----END PGP SIGNATURE-----

--4AruQWY53Tdw7RRr--
