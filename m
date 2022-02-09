Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116444AF29C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiBINZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiBINZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:25:40 -0500
X-Greylist: delayed 66323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 05:25:43 PST
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C81C0613CA;
        Wed,  9 Feb 2022 05:25:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BCCE2CE20EF;
        Wed,  9 Feb 2022 13:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C2CC340E7;
        Wed,  9 Feb 2022 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644413139;
        bh=KnEdtyNQvBe13yAnGufKUy4D6NJm59JN16PeMLZLvpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0e5h6G7DBvcZTKB/9sOvv4ZW8JHbbB2VhRCA4NbNA9uCq82z6WJTgGi0QO4bSU8J
         +dDjoRNyB4uAi8Rz3YRmuv/zh5EC8nUCI68Nw0AwF4MkVqXolLfIjq0nLmEuOEZno8
         UaLfLAm9XW54DZVdeerUjnL0F75Zj075FHAH6omj6aCT3snMHNTcvZzMw/IjHhDUiD
         R1rhmHJDTrqA3doZorjtO9VEGRIpENe+MJ53Q91sB0+4BE52dNFO4Hbqt0+4jDJEqK
         J+kf311/Ksdqqns1YVMolbsKnDGED7OcYP3tJ6o5yeno3qNPeLvexdT2J7pwHZsfAp
         QJsXb1UQ8v4zg==
Date:   Wed, 9 Feb 2022 13:25:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tejas Prajapati Rameshchandra <tejaspra@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH] spi: spi-xilinx: fix for_each_child.cocci warnings
Message-ID: <YgPAzIlkrnbn8Vy6@sirena.org.uk>
References: <alpine.DEB.2.22.394.2202082148490.52266@hadrien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Un6/uN6zMyynudji"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2202082148490.52266@hadrien>
X-Cookie: We just joined the civil hair patrol!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Un6/uN6zMyynudji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2022 at 09:51:30PM +0100, Julia Lawall wrote:
> From: kernel test robot <lkp@intel.com>
>=20
> After for_each_available_child_of_node, of_node_put is needed before break
> and return.

This doesn't apply against current code, please check and resend.

--Un6/uN6zMyynudji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIDwMsACgkQJNaLcl1U
h9AaXgf/WI3VQow30fC5RaiDNuIWK9VwJnxwVMp1iAxvJXW1W/0cvFTzlavLwbpB
xF9IiAKz/XYusEmtp4n+1sDi1Vzg6kmUZhGMTDoofPq8TTTVPfpkPoMMbGFzfjr+
ER/rxRzlvZXJmRT9amDoJ0eHBG2xN1Ode5Q+qb4XQ1Ap5dQqTAqQDt0YmExA+Zuy
xki7MV8nGTzqXysUu7LTc3SZy/DZ60fENkHByRiO6QQnvX8OnwRIPX/W2I8Bcygb
mVDQQRzsN4ZUCQNTgp8Q3p8f21LvcJ+gqvYPgQO+HX30mDOVPolRzCxlWAkKDeEv
EF4WTYAEEPXskDwVzgYni7jNiSCR3g==
=5X3P
-----END PGP SIGNATURE-----

--Un6/uN6zMyynudji--
