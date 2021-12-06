Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA74696F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbhLFN2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:28:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41416 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244297AbhLFN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:28:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F117CB810AA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0FAC341C1;
        Mon,  6 Dec 2021 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638797101;
        bh=23bWVipbi4lQe7/wbua2k2oEGCpFGNw9N0040dL29Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVcLpM3WUMdsxyWLGN9cEr9kcyzceJY24/tBFQ/LkCyxpL5lR8/C83yQ/WeFyXxr3
         3l61rgFn+5kHUa0liy1Wp5PyCxxF+dyjntuHqVHd+hNL0uYP2Upj2wJHffcQetEGhr
         cBXiJ08oGQ4Ejxacp/D/1MpuZRpM9FMrpbgYeQbtLO8e+IBKTOiPaFTU/PksidMUFU
         5dMRrSsApdjGs5+geP3HcMB9qW/SsT+B3cE6LYsu3UQXa9ccOQUoMkd4oeoo/NxlpP
         3mgderEZ7IP10vnpSPdXPRkubOpqX+EnrwrsdamMgpDt/uDo/64XWYMLFXx5/IYGoC
         6/vwUDINR8Jtg==
Date:   Mon, 6 Dec 2021 13:24:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc: remove useless bool conversion to bool
 variable
Message-ID: <Ya4PKMFCP1n5Sthz@sirena.org.uk>
References: <20211206021100.321170-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IQbEZeBX9Rukd5iP"
Content-Disposition: inline
In-Reply-To: <20211206021100.321170-1-bernard@vivo.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IQbEZeBX9Rukd5iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 05, 2021 at 06:11:00PM -0800, Bernard Zhao wrote:

> This patch remove useless bool conversion to bool variable

> -	classh_config->classh_algo_enable = classh ? true : false;
> +	classh_config->classh_algo_enable = (classh != NULL);

There's no bool variable here...

--IQbEZeBX9Rukd5iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuDygACgkQJNaLcl1U
h9Dv3Qf3XG7gVlM3Kturxyb43OVC6b6mRkv+is7OA5mf9kilrBwbUQe3yBUwXvFG
kkWosDZFuFwdyDaeU+0htZhJDIUOvwXMX8NL69GCyS2Kc0wumOj2zsQ2GCKqgRmD
8izZQotqMC86KK0hXmJUY3TKGolt33k8xrXzJ2K/noaMpBcC5aEWmqitFOmsc9mF
lnODiutQarhVX0w4h4s5ndag5HoLuMFEjL1jDY8LuN4kAEfuShg3JF39k1MTtRZy
ShXAFbszJfUoPsM4Z9BZ0/FWMYGpfzKJWrkoKWileC0OhAInGkHUt/L+UvayBnEC
EVzHDkj/bYekXOfvuIdfkVAsh3kg
=Q00E
-----END PGP SIGNATURE-----

--IQbEZeBX9Rukd5iP--
