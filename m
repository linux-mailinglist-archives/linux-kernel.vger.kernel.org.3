Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDEB4962A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381764AbiAUQNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbiAUQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:13:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C2C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:13:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56185B82067
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 16:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22011C340E1;
        Fri, 21 Jan 2022 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642781588;
        bh=/Ctcaw8Q+48jyHUs0o5gNZd++A1+asZFRndUItiRfQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuFcMzz5MNmNLSPwGoiQkwzuDbmXidX2bO5nj9Ky8QR8lOnTfINLgvf40g5lB5RyY
         0a/mQzAfCCSdwtmYH8L6bn0VEnuLunM/a6HRIpS6qfWmsfHDhNu6++Ci+TooUCARV1
         9fsWTU1WsT8A+rWpbZBrsPn9RRNUuIuPxZFecRETclJXd2rBDOTMXSSru4slK+fJYR
         Y1XQyS+4YKU450h167ZL7iRAgQba3TT2EP9aYu+XDIXySbjq53RrAD5Lz9xtGMk0OF
         TDkmUXqGtPrQWT34j9KVveqrf+ofxSdWAOoc9PJ3rGGT8etPys0ArVu3ib8IbXhk/9
         NzHOyZ5o5UFLQ==
Date:   Fri, 21 Jan 2022 16:13:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] ASoC: codecs: Check for error pointer after
 calling devm_regmap_init_mmio
Message-ID: <YerbjgJugYEaDI3A@sirena.org.uk>
References: <20220120015650.1851703-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iJUnwWNON0h2KLfW"
Content-Disposition: inline
In-Reply-To: <20220120015650.1851703-1-jiasheng@iscas.ac.cn>
X-Cookie: Alimony is the high cost of leaving.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iJUnwWNON0h2KLfW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 20, 2022 at 09:56:50AM +0800, Jiasheng Jiang wrote:

> I am really sorry.
> I have already try my best to find the latest code but fails.
> Please give me the url or the git repository.

In general you can always find this in MAINTAINERS:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

--iJUnwWNON0h2KLfW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHq24sACgkQJNaLcl1U
h9D63Qf+O6zHB9Qqif1FXcwwrt74MmnK7jsfmkQVbttSLZqb0GK8BaYdzCdl+qmR
m8RYizNnGOvHm5ipAws+uLVNq5elo2Vf90DUtzTtAABn9ZorCxervbN+oNw2yexA
fo0K52O8aMvHqLe1P5jYWdHnREHnGcwcXwfz4ibkyYCsFrOsxXHPUe1TrIFaVVo3
jj2eXvXnr4HxtEp0bdG9MzjGmjgG8de/gVtdgkXEo3SQ3fD9CoXvmUFu94K71a5N
QBGiFiIIxmbtHSQoQ5Nhmar4PUtX32ZlsxPEH0M0ZMZzcwyBwyNR5yGSskuYrTGu
nJKqXl96xQp1uxqrlDU3p4VJbHOQdg==
=xlYU
-----END PGP SIGNATURE-----

--iJUnwWNON0h2KLfW--
