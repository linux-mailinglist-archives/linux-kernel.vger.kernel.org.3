Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6F49F9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348631AbiA1MmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiA1MmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:42:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599BEC061714;
        Fri, 28 Jan 2022 04:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F6761B9F;
        Fri, 28 Jan 2022 12:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020FDC340E0;
        Fri, 28 Jan 2022 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643373730;
        bh=wUt7Lpv1ipKqJDvhHGWAjln9cnXm1I4jIhfmigOT+f0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXx0fuchgarQKfN1TwtXWoLv0qRHQG9XgBqVx2cCrIGnPPBz5e6GzXpYfRXjsPcrZ
         sMFDj+ismMZ+Cr33Wji66LdLve8fFwBIe/GX7uqFLSP5B9bBFNnVxwREnjwdmH12/N
         9/YoNapQS6dPuFvPfZhu0BJn5LF+V2cgYs8zuYiVjqtP4tu2x2U/VMeAgMOuplbNs3
         MGHK9HdOcZ8YvX01wfEeNUmafmB2y4d4crzETAU+5sq0idbr8FW9SqP2671RzG4SFb
         6+lKTEWq67rhdmS+NrlLYYZZAox2U8avBWj4d6Oop+mxOMmDkFJj4wAc+FWHESLsm2
         HsAkGhksydPEQ==
Date:   Fri, 28 Jan 2022 12:42:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: ops: fix signedness bug in snd_soc_put_volsw()
Message-ID: <YfPknO6si9CpotgS@sirena.org.uk>
References: <20220128112007.GA24806@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jOCcIIG5A6qPTuKn"
Content-Disposition: inline
In-Reply-To: <20220128112007.GA24806@kili>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jOCcIIG5A6qPTuKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 28, 2022 at 02:20:07PM +0300, Dan Carpenter wrote:
> The "val" and "val2" variables need to signed for the checking to work
> as intended.

This means that the helpers won't support controls that use the top bit
of a 32 bit register.

--jOCcIIG5A6qPTuKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHz5JsACgkQJNaLcl1U
h9DaKgf/cTmyNoSTqkw9Z3Ey0dOvYM7t57pbtbOZ0g5wy0D/1tX/fClL/peSKXGU
60vA83fZ9RnX561xmKWv3E5Tqwj0+DK589nth2LcuJcSaZn0jyPgETF19uaXkACU
aJ8QkIIlNT3OkVDgbAN0QYqSuL9TCBhsOGR6eaBwbG8NsoPrphIPae/RBBn/z1Jv
IQGG1dcjervKJPw3bK7tzrdytvLnn8jqwMEkycxcxzrO7kw5vk2Dfu7vOzBLi2bt
y3cDSD+87ybKxsEt92XZZrSOey79pKIj7kCDB1k0LuLNB5hlSdiQfbfXt/PTB3ws
op+pdqiC8o5GDfLooYthOkZYHU/rSQ==
=2D81
-----END PGP SIGNATURE-----

--jOCcIIG5A6qPTuKn--
