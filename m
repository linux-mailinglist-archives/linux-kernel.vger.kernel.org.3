Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F3D4A747A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345450AbiBBPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:20:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42186 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiBBPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:20:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B3D6159A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDF9C004E1;
        Wed,  2 Feb 2022 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643815210;
        bh=iAS7oOr+MtnvcoB4zZxYaKMHIzJ3kCZIiHcPahXEhSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0FFig69YhCXs7I9NFSqo8a3jKFumvHNh5dyeAv6OwE80AYU4jXWxG+3hFrU/ZgFd
         RY2g48NkPqT/cnFpWSX1s/o/WPVx1icwkbYY6jylnV+2NatBAzctaXkO5E+7nb0CPU
         r76NwwBAMstsmFaV60t/ltGT6K35zcWmJsBFTFN+VGr5eFeSocLL0AuJnXcypDfdY0
         wuRHSivVohk0qJ7VCxNO3fpupnj7oI8KEGrnQmrLzsCMg66xOoMmoPxXemwrvL5Xqj
         DZA3eFAs7kHdAjzYuoVDKnSxnxDOVqh3RFJIjGDo5VmTds0l33FiLAjDoeYcBulcxs
         /7CWU08hLXO2g==
Date:   Wed, 2 Feb 2022 15:20:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 30/30] ld.lld: error: undefined symbol:
 nand_ecc_unregister_on_host_hw_engine
Message-ID: <YfqhJZ+BzfMrpN4Y@sirena.org.uk>
References: <202202011308.a6RlPiGp-lkp@intel.com>
 <20220202154504.7737deed@xps13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T1wQBRmK9/t3duci"
Content-Disposition: inline
In-Reply-To: <20220202154504.7737deed@xps13>
X-Cookie: Quack!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T1wQBRmK9/t3duci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 02, 2022 at 03:45:04PM +0100, Miquel Raynal wrote:

> I've failed to prevent faulty configurations with regular depends
> on/select keywords, so I've come with a new solution which received a
> successful build coverage test from the 0-day robots.

> In order to still be able to use the spi controller driver (=y) while
> mtd is =m or =n, I need to add an IS_REACHABLE() check in a couple of
> headers. This way we can just imply the right MTD symbols from the
> SPI_MXIC Kconfig entry.

Isn't this just a case where we shouldn't allow MTD to be built modular?

--T1wQBRmK9/t3duci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH6oSQACgkQJNaLcl1U
h9Au7wf/R0uqM9DDKOOEgwQvhjYIHEA2CvjiNitRy1d6JNCCuVmFNaMHlQCkqS2B
I+s0rWiy5H1X/wdfpkRKa1EKiOwFjA3BlrP+bwNlThWaS7tgMRYJa3Q0RmpDq2QJ
Ji1VKhH1CMoTptU9QtjyYExth2A26vG9eEPHbvjnYk9ORwopsb2z3WTjFquynNi6
aX5bTI12+YXDr46E2syYspaOjvQhlJLH0vMLUSs3whPExMxAzEis40h7fma7PbPZ
7Ji/+aO+bRhHhRqXUIpr4ZxUb3UQe1GIRQgd0LzUEAM1jomNxyQ8hLoVYXE+qkiW
o+/sIsjI+QBuqhOalGmZJJohovzRUg==
=4cXN
-----END PGP SIGNATURE-----

--T1wQBRmK9/t3duci--
