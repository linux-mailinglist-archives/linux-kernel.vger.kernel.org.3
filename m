Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76A49FA28
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiA1M5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbiA1M51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:57:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADA6C061758;
        Fri, 28 Jan 2022 04:57:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18282B825A3;
        Fri, 28 Jan 2022 12:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E13C340E0;
        Fri, 28 Jan 2022 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643374644;
        bh=+Ixj8+mwsxgR9ruEsP4UQqZCZGNpeDr9spdJUI0YA4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIpiTtwgaN3x58xvsEaWDwvEwUAYvIKMmctzZ8WU6WkYn1AWbTniZmWQU7Cw2KL7A
         VbTWKEKRdHWflyzBqiLblSBflHxJ47YgpSn8972xOQNxIAzBd+TzVscq8zUK/IzMb8
         iYZGrGHT1JgMADg6e8k8t45HhiRynj/JB6vY4/k8Si7c0f763lwcsynvVRNcy50w4Y
         RCom0lyqdCWVCf4TXi+vzcJB3unq/nZOX4GLZ9v+gEC3NAPmsFdXhY4gPo/K+fvEFN
         fJLz7xjEFSoVwiNgoGkG4tYZL05EtWEoBUpHDGQQfXIiM/6tfycS+jNCEY7IL5JCuQ
         6NJ4muz5HTYqQ==
Date:   Fri, 28 Jan 2022 12:57:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com
Subject: Re: [PATCH -next] dt-bindings:spi: Fix error for test.
Message-ID: <YfPoMJsJVfaRFtx+@sirena.org.uk>
References: <1643337290-1376-1-git-send-email-lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lEuCL9K5tjFKUEJD"
Content-Disposition: inline
In-Reply-To: <1643337290-1376-1-git-send-email-lhjeff911@gmail.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEuCL9K5tjFKUEJD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 28, 2022 at 10:34:50AM +0800, Li-hao Kuo wrote:
> Fix error for test remove the include path and modify parameters
> ---
>  Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--lEuCL9K5tjFKUEJD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHz6C8ACgkQJNaLcl1U
h9B89gf/Vb0bzYVnbPBV+yG99E4EcgE4YxHAYTOwjM7ljvk5c2NNtvECe96mGydU
4rNJTVZvOBGXOG/ZpOUAxgYAVWj7okjXliti1Y7plq7VOlcOlkQGWhQDNEqDOpq5
IUkd5HZyJQtH9CcNZh7SyxouDDdcMTlYkOLzoSiJNGbYFrv63srH98RR+u1w4oyH
39+oVZXtxpq/AU/tv8VayOvT5IzKTa7bP1z5Fyes8w4UITVCaaOWiEx8X4bTuGqa
v4jyjmOnaIJVSfSoKeb1QY3tacgVaHQT0/34TGXPQ7BB/u9LwnTRxc1TrkAg962P
L36u6hETTeSUEUjRSdxBQZ/QI81sUg==
=JWR3
-----END PGP SIGNATURE-----

--lEuCL9K5tjFKUEJD--
