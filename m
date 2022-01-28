Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C6649FA25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiA1M5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiA1M5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:57:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF66C061773;
        Fri, 28 Jan 2022 04:57:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 470C0B8258F;
        Fri, 28 Jan 2022 12:57:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA507C340E0;
        Fri, 28 Jan 2022 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643374628;
        bh=OUNWORdT2fAauA98ItYXD+/7qB1ryClyihleXqDHqWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7vmxPbtf5jvtacwxfj4fJytloabvxDAAtFCZWM1j5AdEFoJJH/T6Q69lB0V6RVCM
         FlChNLgVhoATqaSjjSgriyiq+XXF9nj9wakJNryVHrHEziQ07VIIFioTT7wZNxQqrr
         NovHiWPi1AEkRPEvktLqaQCyZvfMVOBhaq5Ptmgo7TI+gS5CfQKPc/ePZxlDYQZge9
         7XdMy1tcxuT1EsUj6LsRPf9dRWVzCArZZDQ8PTN4vElk5NzpZh/9MoPEhXhgtrSSfR
         p5QeBnRqbiGmgZBgqm1MixOXydzouYbO6v36G3U6I7CBtU8xmvv4NSVtkKElG1kRGP
         OZffX+9ubzoSw==
Date:   Fri, 28 Jan 2022 12:57:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     sfr@canb.auug.org.au, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH -next] spi: Fix compiler warning for kernel test
Message-ID: <YfPoHpHegT6pGMNk@sirena.org.uk>
References: <1643336485-10942-1-git-send-email-lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JKxvsvdJ16wt6aRI"
Content-Disposition: inline
In-Reply-To: <1643336485-10942-1-git-send-email-lhjeff911@gmail.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JKxvsvdJ16wt6aRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 28, 2022 at 10:21:25AM +0800, Li-hao Kuo wrote:
> ---
>  drivers/spi/spi-sunplus-sp7021.c | 10 ++++++----

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--JKxvsvdJ16wt6aRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHz6B0ACgkQJNaLcl1U
h9ASlgf+KfgjQC621cNBhzosr+ib26hM2ORxjb1gQJQLhkCU5aRIocW+ypcG5I88
a9EMlYMx1MnEJ/htY6UFPQDAJQtMG1Tj/XGmpes2vvh42okCK/ZtzKMEJjYU3L/T
xud8XiIT8mDmXXaJkpejw0Yy4Fq4XCdqKkgd7CweVPJzPC9Wfo6X+Nw0mqqZwhF7
sUChQ4ztwaOsM34djScNVgSFz9pK6rd2Q3nTpmZy++cxSLYGZYpbrqBAXw2eZL7J
L7Tl1lf4tv/1fTOwYPHSbs/lqHweKYMFGvnAkULxX/BKZBwa1Mn1NA9vWDYR8aTg
b1Ka7sTifSkT7WtK/txI41jT+A6v8Q==
=D7Jx
-----END PGP SIGNATURE-----

--JKxvsvdJ16wt6aRI--
