Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1953E6FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiFFQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiFFQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD0E5DE76
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:52:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11FD7B81A93
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D5C385A9;
        Mon,  6 Jun 2022 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654534353;
        bh=MXysSCdlCXdhPysWEuy4446I/A++jIP/2fCry28Y4Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nITYHmySBT4H2ndTozjcWvwwVDaUHkoReUGsb96w+9AhYWuODnEeqBgMUUxpJEJcv
         i7kbSac7dUwa6EFpbS26Opd5UKckgunkfeyJsC8eLz8p1vlOoBrpQ+CnM1CZxDyIvn
         K8nDU0Hp7hZptDnVyjeFBVx5KdC5Ps8HHJAlTz1eY9+TBU5I0D6Nj3w3HPGVDv7q8O
         Gx9Zjf3ImtSKtbe2+xtjXjgGcoEkyiC8lrbsJ2UMtEYBr3NkF20K5iPwZJCis7da1m
         K6AgiooMZ6mRItSBZl5c8wV4N9J7sh87u5H9Z4UWDquIs+oXElZBehmuxck6za1zg+
         YTYsN2Q8dHM4Q==
Date:   Mon, 6 Jun 2022 17:52:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ASoC: wm8940: Remove warning when no plat data
Message-ID: <Yp4wzS0aLEo5werI@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
 <Yp4iGvGFD9jo4WUP@sirena.org.uk>
 <20220606181731.04b6f771@ktm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DnUb2V3oewQhXa9l"
Content-Disposition: inline
In-Reply-To: <20220606181731.04b6f771@ktm>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DnUb2V3oewQhXa9l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 06, 2022 at 06:17:31PM +0200, Lukasz Majewski wrote:
> > On Mon, Jun 06, 2022 at 05:44:39PM +0200, Lukasz Majewski wrote:

> > > The lack of platform data in the contemporary Linux
> > > shall not be the reason to display warnings to the
> > > kernel logs.

> > Given that the device requires configuration and doesn't appear to
> > have any other firmware interface support that's rather a strong
> > statement...

> My point is that - similar codec - wm8974 don't display such warnings.
> (this code was not updated/refactored for a quite long time).

Perhaps those drivers are buggy, or those devices lack this specific
configuration that's being adjusted?  The changelog should at least
address why the driver was warning about configuration being required
but it's safe to ignore that.

--DnUb2V3oewQhXa9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeMMwACgkQJNaLcl1U
h9Dfdwf7BcW0Luwaf8iLkn+kS1NPDO2F0CgLVz9wodRDv4DvL2A3SUWnkJpnXJ9m
78MEIJoERftkH+Rq91eh7AZdeNGOV4tS7ClPQTT7pBlo5W31In2ze7zIzubVXNB7
LenThDkhWRLHemUN0uJLBXOPsHhj2FcSHXHlDzzw251gIHLnIPDQXNq6JYhKEDjM
2NQkcxBknKwDkWvjHfZVtz2ZbDLuj0RulTq/nZIPzqagh8rSNSX0xt6X5xy9y1Ro
XMaWYO1QXAZgzgB1TQnMfVP3I5MRR0nJUfa+0zSuhcsv44heFMys4zTOIdXbljKH
B86nzaXNknlgutl3b0GpxPe8N9KPQQ==
=WRfG
-----END PGP SIGNATURE-----

--DnUb2V3oewQhXa9l--
