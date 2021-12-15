Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86544476141
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbhLOS6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:58:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34316 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbhLOS6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:58:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F06161899;
        Wed, 15 Dec 2021 18:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADB1C36AE3;
        Wed, 15 Dec 2021 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639594684;
        bh=76eb7VDWfPRd7pvYjeAKY4dcwiM5H0xLKfZAlmiztxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0iSKh3vKhdbFk1neCcrSe+Pzz9B7uk/gXVZqa7cqsyP5e3NuDNJ6g3TlIYzqioxP
         AsT6VSjdWNFxVYu2mzZyIhobGGJ3HWcSKXOmNHTIGdWY1eFuySt7/uVz3zlrPtmzMz
         KiCDM+GnCReT/Hi62TTcJXfML0VhsVLvJQYRPe93KdkP5Yxb13RLRf1GB1vO+mIxyE
         656/TTsEcb+IGbWvQ4YUj8y1RRZfJVcHlxwZ4hEOIo+7Kk7I16v/5gkbL8QyQSjniv
         S/YgMUg4h1cCmeud1uX5gJECCwHGHVlXCwHrq9aDuc55ANZuTgmJtNC3OyH9pgfMiJ
         ayYMGgNNP1Eaw==
Date:   Wed, 15 Dec 2021 18:57:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 00/22] Support HDMI audio on NVIDIA Tegra20
Message-ID: <Ybo6tsnQM6OacoZs@sirena.org.uk>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r8pMqbbDVxb335U5"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
X-Cookie: No solicitors.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r8pMqbbDVxb335U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 04, 2021 at 05:37:03PM +0300, Dmitry Osipenko wrote:

> I based S/PDIF patches on Arnd's Bergmann patch from a separate series [1]
> that removes obsolete slave_id. This eases merging of the patches by
> removing the merge conflict. This is a note for Mark Brown.

That's not in my tree so I'll need either a pull request with the series
or a resend after the merge window.  It's also not clear what to do
about the DRM bits, I guess it's probably easiest to just apply them
along with the ASoC patches.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--r8pMqbbDVxb335U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG6OrUACgkQJNaLcl1U
h9CG4wf/R0NhMevfJzcrxbAImYtw8MIQXIBeRXJNM+viHozogArxj5HSQNArbEYW
VBlrS/tCW9uXaIoqZgIAAkU5UoH8r01iharsCnm/GLer4aFfvFJqYfc6KPZAVhgu
zu1AwsHPBiv59YBPE5eMNxwluv5AORqy98wy0i5eiyEBCpEeKgt3lLoFDr/GFIKt
tXWuheE/2fqKASDvQvTHfbQ75Nb7oiCqdc/0xRkjmUgJX6JDrUPPASiQ38YfHgHw
0X6L1Y2tWlLlGsQpdoXOceu0pnc0WdWWAxnLvJHjv6o+nMGECYBCZB/AmHYkqzrj
vAkNiHZXRi+f3RikU7TRzEHgXszS2Q==
=rihE
-----END PGP SIGNATURE-----

--r8pMqbbDVxb335U5--
