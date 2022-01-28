Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD9A49FA2D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiA1M6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiA1M6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:58:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D793FC061714;
        Fri, 28 Jan 2022 04:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC00619CF;
        Fri, 28 Jan 2022 12:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6740C340E0;
        Fri, 28 Jan 2022 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643374692;
        bh=2zFtY4ywev4idGtRc08xO+guV8Xkojj1XaMjNDAXsMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWJncS1LqhBH/pw+OCJzmn0sdnvoTgFMyPau/Bzs3JQzmp8AfwxqiWDiy2mGF7f1q
         9K8YfGE1ZKwBG775DfciBjeUKVV/ZvPVgSkfO9pNUo409DgwlcuymRydFxA9hzCRgz
         b4Dc8hCYBNk8Nc1Wm/Gl36d71qCBhpFSPd062XvRDzpTGG+3sSgGgQxonSgcuxHsQI
         vPwp6mWe6K5q1Mru9gUGqHZar9PtRp0BdIUsH5lxJkukhztLzMRtihsr0DWYAErP0w
         Ngc1e7QPcrs6CpYeJ3tIXgtHGERxtHhum6vzH8PDXmFx2AjTHcWS13naMDqRBqK+f0
         FS75J1PChZ+5Q==
Date:   Fri, 28 Jan 2022 12:58:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH -next] spi: Modify irq request position and modify
 parameters
Message-ID: <YfPoX/msPy6jSAyr@sirena.org.uk>
References: <1643338760-17577-1-git-send-email-lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FebS8+3y7LUwpJL4"
Content-Disposition: inline
In-Reply-To: <1643338760-17577-1-git-send-email-lhjeff911@gmail.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FebS8+3y7LUwpJL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 28, 2022 at 10:59:20AM +0800, Li-hao Kuo wrote:
>  - Change irq request position to the back.
>  - Add temporary varilable and setting (as suggested by Mr. Andy Shevchenko)
> ---


You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--FebS8+3y7LUwpJL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHz6F4ACgkQJNaLcl1U
h9DEcgf9FpHwtbUtHbgTwNkmzm7h9+rssc/sso0/ZVl488s1uZptxS9BJXGMoIdb
NEoJsrCqvrNNzI7e2ZfaeOD3MsHgQFfRZPAV+gw1qZW8uB2L3JlunH9b8I/fgQ9B
3m8LwXHCGVJoJwaQxc+mm1l3hgcYweMRhsjQFPefv5Ga0ff3mEw/aewSmh7ALc9x
BH923XZ7wluDE9X1T3abt708q2aRy0LQYRDcQRcc81AwQuFDTdsmwupQAn/cchPd
9bg4KOLrOVF8pP5Ula2/eIPcXIHucUJKLoCVrUmbseT0srRx4pBVnlK9aD2DCGx9
QvFqNykm3z/Pi1VTRH0epXSimgdtoA==
=9Kr5
-----END PGP SIGNATURE-----

--FebS8+3y7LUwpJL4--
