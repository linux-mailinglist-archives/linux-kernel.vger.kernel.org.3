Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B247A9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhLTMbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:31:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49070 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLTMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:31:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CB2EB80E63;
        Mon, 20 Dec 2021 12:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D67BC36AE8;
        Mon, 20 Dec 2021 12:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640003477;
        bh=i25KeYvLqv8bmnNiXOuTvfwiv8T+bOL5zwFzIAnI7yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYzm9Jmv9h4WIy0H423pWluJsb9rDkATgoPPgzOMwCEDNvcFh4ZS/YYWpHFIcxJJo
         xANLCiA+d0H/u1UxIvTaZ8C2hZndQsbONXIThDFMJZ7A2Yu9U6DqaToGP5AAcubVvA
         ANl6cPIT5egHtLjFrf/0yWPJqWdN0EOWWzMI2gwohEU5rXTqk8dfDhsfjc/kBkNmjk
         QR+EGNwVjohV3qD8J+gSVU4+CNsGsHGSbQvi+pcMWAsmAYNkVFHPRTLMjmizAHA/E2
         saO9DXoEPqq/1o8F56tuqfzLRatsPbtN54PR7nwxG2Q6T+sSop7+0+kYxdnnimU7gg
         Y/8LfLSALIVtA==
Date:   Mon, 20 Dec 2021 12:31:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: Remove "spidev" nodes
Message-ID: <YcB3kTelEHBvcsGA@sirena.org.uk>
References: <20211217221400.3667133-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eQZIqh1wMxp77hgz"
Content-Disposition: inline
In-Reply-To: <20211217221400.3667133-1-robh@kernel.org>
X-Cookie: Christ was born in 4 B.C.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eQZIqh1wMxp77hgz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 04:14:00PM -0600, Rob Herring wrote:
> "spidev" is not a real device, but a Linux implementation detail. It has
> never been documented either. The kernel has WARNed on the use of it for
> over 6 years. Time to remove its usage from the tree.

Reviwed-by: Mark Brown <broonie@kernel.org>

Thanks for cleaning these up.

--eQZIqh1wMxp77hgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHAd5AACgkQJNaLcl1U
h9AmbQf9G/i81z0y9A3tciRvrblQ24v7aDb4HyS/CjCPbTIAvDwEY75F3UuSQdiX
u66pm9EGC4x/cbRWdnf7slxhhevUGpv9WrxH1WvY9BDGo558GP0ApQd2bd5ifdFr
zsrABMp7ee5dJeBq7zYtLY560AIgypoP3331L+kKiNkeoozARrHbUrtANG4SVaVD
RkdKO1efkdyas9B0npaDBFQIFhFDBo2y8Wq+/e/CMEHNHflyKlEjVl5vHZ6OuOsS
GdCAKCnyTnKbs9Wjckq0ibX42HKX9dxxcGxBvoK8TVMlUXoCIu/AOxN0t63DcarF
wUv9MQWnRMXWZlEskQZ0Ym5tM5oqOw==
=sdX5
-----END PGP SIGNATURE-----

--eQZIqh1wMxp77hgz--
