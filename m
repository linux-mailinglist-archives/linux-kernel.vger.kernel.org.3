Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DF463BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhK3QfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244059AbhK3QfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:35:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6D5C06175E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:31:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49679CE1A2E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9374BC53FC1;
        Tue, 30 Nov 2021 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638289900;
        bh=Hn/gufx2Ts0ISAwRB5X7upcVUqCZvs5DpWa838hs99s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNa1/ptPw3AaWHCgIxEEItjwrC2O9F9CY6IQUjwCgjYPPEjuJE2uW8XYiyNXUwK0G
         LEZqcQQq+1eV3z+N0Je/hC5stCCiyiSH3NiwX+MYq+pZN9lRKBg8dK/gd9Bx1rFnvW
         aK6y6mxusFsTQRRLFMh1dgA2p8kSTKlNU8J/0ZJnamyN3UNz1eiZjBNXHMZQWo/cWc
         CxXzWnKlKlIq9cyMjSmqAhwRFi+09bQw1nMK4wJPn8mvwbGancriTtuO3kvQB9keId
         obGXMMyH67GDLHZqkZ/8EUiP83HZWm/yjj9wy/YKm9rdYwUiGIO5z1ZgSPtHk+IES6
         TGTJjJ3XwegWQ==
Date:   Tue, 30 Nov 2021 16:31:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: remove redundant ret variable
Message-ID: <YaZR56MLanjnQH1p@sirena.org.uk>
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
 <20211130160507.22180-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="daY3+6YO0XUW/PY/"
Content-Disposition: inline
In-Reply-To: <20211130160507.22180-3-srinivas.kandagatla@linaro.org>
X-Cookie: Check your local listings.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--daY3+6YO0XUW/PY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 30, 2021 at 04:05:05PM +0000, Srinivas Kandagatla wrote:
> return value form snd_soc_dapm_put_enum_double() directly instead
> of taking this in another redundant variable.

Cleanups like this should come after any fixes in a series.

--daY3+6YO0XUW/PY/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGmUeYACgkQJNaLcl1U
h9D1Igf+ML51uzuukMaxTAvRykBe6gdAkhbLos/H1FCBvk6bgoM5uedaC2O9DQ5/
01Yr99udo1dL8IacLmCVkaM8XW/W6YL++ZSIi+iNkxFVo7FSmwNY6U3YwWFjUWfs
Nu+w6KtqgF0/qD//ZK9bHhPk2L9OoaBaVTYPVGmDRlJ0mH0t1WUgfiZJaU91vohT
K+4/EMDRcARgZ3j+CQAF4L9uBfCtd5MOYgW5ma1Ep/Hj/iwUdYx7tUZUj1fvhd8e
3GBvU/Yw8bIlUyqPyJ2jQXXb36LjgfpTCtT0MUENYw/aAUIqoY/86hlIzcKWCQ4n
+gDaorzAGYngDZBy5y6tFEVvbi0Rew==
=IFQw
-----END PGP SIGNATURE-----

--daY3+6YO0XUW/PY/--
