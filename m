Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009A74843D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiADOwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiADOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:52:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDCC061761;
        Tue,  4 Jan 2022 06:52:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA52F61493;
        Tue,  4 Jan 2022 14:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9950CC36AE9;
        Tue,  4 Jan 2022 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307957;
        bh=ZCPX5ZuwUTQCHJSWO8jxjREVpLRUwnoOPoTIL6oh1Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QDDg/rh15NWsflL344WkBl/vH2+x6dFITHfnMnLw0reJhKtLUdXniloiqNFFGrBQ8
         R02UhkvbVl5m0lKELjocVNaHkBWj7LF2zyo2JsvJSVmL8XY2WdKMPKSF8mWuEULMaM
         Esl1NsEacXU0x8Ye1obEGrWIdMivJsauDEhkgO4p8fKO5FdbouEt46tlXoLyfEXpAf
         3XvuYRIT+4uVQYkt/oXBZg/p3padUccdXyN5Oci6jYBkEOmjsnrX81tKKkq2x85P2E
         GRmhat4aT4estD/nwibBG7UTWNwsF391/244gtd+XVdpJjX3R1PxCemtiacaaKwMmO
         C3zLl6ZKjzirA==
Date:   Tue, 4 Jan 2022 14:52:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, p.yadav@ti.com
Subject: Re: [PATCH v3 01/17] spi: spi-mem: Add DTR templates for cmd,
 address, dummy and data phase
Message-ID: <YdRfL4gC6LimCmRq@sirena.org.uk>
References: <20220101074250.14443-1-a-nandan@ti.com>
 <20220101074250.14443-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ddlCfAFjpBbRrVn8"
Content-Disposition: inline
In-Reply-To: <20220101074250.14443-2-a-nandan@ti.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ddlCfAFjpBbRrVn8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 01, 2022 at 01:12:34PM +0530, Apurva Nandan wrote:
> Setting dtr field of spi_mem_op is useful when creating templates
> for DTR ops in spinand.h. Also, 2 bytes cmd phases are required when
> operating in Octal DTR SPI mode.

Are people OK with this?  It looks fine to me, if nobody objects I can
send it in the next merge window so it's there for the MTD bits.

--ddlCfAFjpBbRrVn8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUXy4ACgkQJNaLcl1U
h9C9RAgAhWTy/5TFqW6cERJG0k6uFOv5Ys++XJ2F4/EKvq8z9xDI1GaDv89IqJZi
w/5sjP9gHrJyfzSEKBWj3ZV8JhEVXOo2Bd4wv8N0jN7kZ3qZ8AMJ/whh70k7OAXw
oepi9u/d/5R5CmUZji6fFR6hPx4wjbUw9i4cUcoMYDuLY9gz73xWKykD0mJi2Md/
bGj+mddou0YC1me9ldcoonez8mgHJjMYenu609JjyUFNICxRIomisOZ9ccBlKZ/a
pxFwMJBzyZc6uApEf9iJhsqaAZ5a9GyK73Nmb1iHeJmZhN/uDB7E/0ncA6oqGz8X
pG2kyoz8SYexBv11/CtScht6TjwAnA==
=93ql
-----END PGP SIGNATURE-----

--ddlCfAFjpBbRrVn8--
