Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07314D51AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbiCJSrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245575AbiCJSrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:47:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EA19D74B;
        Thu, 10 Mar 2022 10:46:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B28C761E8F;
        Thu, 10 Mar 2022 18:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDD9C340EC;
        Thu, 10 Mar 2022 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646938003;
        bh=GKrZ2gUQwydnsjB5YvHl0U13LckJkTI0hMtoBFCtOm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nnlP5vsLU77QzUy/SWAKZVugjxUvjQgorliXzc5uc5d2bJy6FjeXc/TZe0oP5ynq7
         3AX4ThoBBtO17cviH5BEjosqf5md8Ef6BKH8Xe89B9miWBfMSARxkJWpgqxagxVG4D
         hmey667/FsdOsgYQCh4IQhhvVb8zL5TkWn1j1JtZoC/Ahhn+o/ScOHK93pH2EqgbZU
         igKSr5lzVxzybaiXcvETZOiobKF4MSthBT3XWgVS0tuHSI2RrcYYNxz28zfYVqTeba
         T39Xwp9ssJrT7U5YTdPsYq+/885qspqgCRxnrTykgKdr8aN1eXOQ2UcUUa+ZYdseq6
         CRN9hK3EQkegw==
Date:   Thu, 10 Mar 2022 18:46:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, akumarma@xilinx.com,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] spi: spi-cadence: Fix kernel-doc format for
 resume/suspend
Message-ID: <YipHjjg/sLRqQVX6@sirena.org.uk>
References: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
 <20220310164235.32230-3-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zGu91EIOk7veEsar"
Content-Disposition: inline
In-Reply-To: <20220310164235.32230-3-amit.kumar-mahapatra@xilinx.com>
X-Cookie: Package sold by weight, not volume.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zGu91EIOk7veEsar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2022 at 10:12:35PM +0530, Amit Kumar Mahapatra wrote:
> From: Michal Simek <michal.simek@xilinx.com>
>=20
> Kernel function name don't match with function name.
>=20
> Error log:
> drivers/spi/spi-cadence.c:662: warning: expecting prototype for
> cdns_spi_runtime_resume(). Prototype was for cnds_runtime_resume() instead
> drivers/spi/spi-cadence.c:691: warning: expecting prototype for
> cdns_spi_runtime_suspend(). Prototype was for cnds_runtime_suspend()
> instead

These errors are introduced by the prior patch in the series, that patch
should be fixed to just not introduce these errors in the first place.

--zGu91EIOk7veEsar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIqR40ACgkQJNaLcl1U
h9D6LAf4ySVpzHmfvga8kAdanxFVZF5MBBcNlY4bjjSUk9zGiv/LRXleptZCdQWc
ykabXiwwg//Jx8+PJ1biJLWsvhRh21W/APFlFEhUpFcEYQPHruUOWa+4viNuCRnD
UU+6X67mP3qQQ29HpqaE7fVc34hp69yk89Q6/yjhnAjN/jfl/rFIG2NmfSBEkz40
P0uDuGlmfdggfSqZ263GBZNOJX5HPXtidna11JrWKquC489vwwodOk4paVUy0ib9
8brfxlmUDlJXYia4HiAqWbvoJxQfwc5KbD215fIHdop2zd20Qb47hc2ipNGW0x5b
dFQg3sx8DMfgLXeluzGru3Hoolzc
=pg1e
-----END PGP SIGNATURE-----

--zGu91EIOk7veEsar--
