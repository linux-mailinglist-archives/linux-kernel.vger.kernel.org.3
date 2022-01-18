Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13A4492C82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346912AbiARRfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347532AbiARRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:35:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3462DC061746
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:35:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6609B8170A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DC9C340E0;
        Tue, 18 Jan 2022 17:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642527337;
        bh=qMzBU33o1h25dpmtWo89Wxg5l+7hKomR8KeOL5BKubw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ptaUXx4yuwtxtmAf2YCCFHlmgKVe5rLE3JdBPRpYiFe1tK995MGhuRvcSJs3b3tAT
         IFLklJ15uxxD2KYX03VAkD1RfTIwYuRfV8sTJkQ9e6f9x96Kxcx0uBSeMuKYp4ulxL
         NGN74ojNX7IYCk3A5ibHMbDm3TVSadNhRUEF9EOjgejsOrysdVcEibKxCpeA/A2+S8
         hL1ee4vPUzWlCX465p2Ik5yLwjgzq8NKPGHGy34sgusZheKQodnHenInFeso4XEy8q
         BkXWmC2ASJlfIJ/KIpSD+I7iaM7CrTgYhgYia8z7bt2loFm6xgcTDAirx/r3MQ7oR6
         /zwU/xoJNTilw==
Date:   Tue, 18 Jan 2022 17:35:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Julian Braha <julianbraha@gmail.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com,
        AjitKumar.Pandey@amd.com, kai.vehmanen@linux.intel.com,
        tanureal@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, fazilyildiran@gmail.com
Subject: Re: [PATCH] ASoC: amd: fix unmet dependency on GPIOLIB for
 SND_SOC_DMIC
Message-ID: <Yeb6YzIugFSmidQY@sirena.org.uk>
References: <20220117041528.59958-1-julianbraha@gmail.com>
 <Yeb0n9AVXeVzBHrT@sirena.org.uk>
 <26ec72a7-effa-7553-fc0f-4e016b651c09@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bBU/pd3VrGlA9S/Q"
Content-Disposition: inline
In-Reply-To: <26ec72a7-effa-7553-fc0f-4e016b651c09@linux.intel.com>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bBU/pd3VrGlA9S/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 18, 2022 at 11:21:50AM -0600, Pierre-Louis Bossart wrote:
> On 1/18/22 11:10 AM, Mark Brown wrote:

> > Why is this a good fix and not removing the dependency on gpiolib from
> > DMIC?  While a DMIC *can* use a GPIO it's not something that's an
> > intrinsic requirement and it's entirely optional in the code.

> We also have similar 'depends on GPIOLIB' for Intel boards that are not
> really useful. see e.g. 4262ddc2ad63 ('ASoC: Intel: boards: add explicit
> dependency on GPIOLIB when DMIC is used'). IIRC we had this discussion
> before about doing a larger cleanup.

At first glance it's just that the gpiolib dependency on the DMIC driver
is spurious and should be deleted, the code looks fine and I'd not
expect any need for an actual dependency (but I'm out of office this
week so probably not going to actually poke at things properly right
now).

--bBU/pd3VrGlA9S/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm+mMACgkQJNaLcl1U
h9CyEgf7B4or95KreNOOC9KGSpHw3O2RfRdk8iBHMJYbjN4fPEMZ7C1kyER7j3F4
DvTXfw5BTamOl04W1YNmP6xms/S2OZ6Jxc+p/wTyQEKS64GRl9t8SWX090V3kUUo
ggwCXzb1TYG4Pb4DqpeQrCI34UbhSDa1twH73P9YBg9VtEIw0Hw9drxa8dZE22As
HFiidQGiTd89jhY/omGjudeFdCTutSaE+ROL4FZHK3Y4X+3eubptlbL6M2f9jbhw
3TCz/o0ZP4rUvu09r7CDutmHNyavRNLhfv3fz9UouO8aVMgyPJGOerehK8bhjOTc
3Rey2MR3FItXaOIt0R1UrbVxkMq+ww==
=3kwX
-----END PGP SIGNATURE-----

--bBU/pd3VrGlA9S/Q--
