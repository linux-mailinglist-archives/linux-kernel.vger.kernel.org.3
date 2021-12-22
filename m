Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3A47D1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240547AbhLVMc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbhLVMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:32:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E10C061574;
        Wed, 22 Dec 2021 04:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99387B819C9;
        Wed, 22 Dec 2021 12:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FB8C36AE8;
        Wed, 22 Dec 2021 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640176345;
        bh=W7F//Rlq5WYu/4RjwUNC1gQcNwfJyIZJX7Z0BZK3Kk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NMO4jt7pwj1eGopvEW1DaeHEYYS+zDKgz6of5HMvWtISM4ic2IPIrRz+qvkjFOxtw
         7/J3dGRQzN9p8QaDlSwsVz0Tteqyvt+R0RqZy7QBA9k8/XFQRfwDXH0yRJzOEfld0o
         b8aU3xY6mNw6Js2/en5ieXHIPTWfxIV00dXFwym9vFyym4MTxc3T15bqfvQNt8EjvW
         k64INXlaMvs7CYoyTBHtYwOBPnInvrEaUYaDKliRQPW3HzlhYgmk7yE4xeLkD20qxG
         1s6L0+pw6ktKJWrpCbvyyWRYTvEVUR7qj9R9PPIYr4uY7FNtzwJ/Ri33cI9q76Hh1O
         rogIXcHSIfgfQ==
Date:   Wed, 22 Dec 2021 12:32:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: ar934x: fix transfer size
Message-ID: <YcMa1TIg3x3oBKBl@sirena.org.uk>
References: <20211222055958.1383233-1-oskari@lemmela.net>
 <20211222055958.1383233-2-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1lzwZ4JX7pCGOlVU"
Content-Disposition: inline
In-Reply-To: <20211222055958.1383233-2-oskari@lemmela.net>
X-Cookie: Weekend, where are you?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1lzwZ4JX7pCGOlVU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 22, 2021 at 07:59:57AM +0200, Oskari Lemmela wrote:
> If bits_per_word is configured, transfer only word amount
> of data per iteration.

Does this actually materially affect what the hardware does?  How much
data is transferred in an internal loop in the driver is completely
immaterial, bits per word only matters for formatting of the transferred
data.

--1lzwZ4JX7pCGOlVU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHDGtQACgkQJNaLcl1U
h9DWywf1H2cmOZR+vwhWCGZJZXUwAGQJNX/i0zxtnHxwpwhgMqcVglgORuqAH0H6
HvFC5LwYKg0a997Jw9yFwjfFQkmXj0zOrqtxIy5HBG/u7k3EW0Fo45l8Ks0qFjRx
oDP78b/kDfoeAUUmZUfjncvF46lTdfEruGO0jf8Gh96QET1dQoYtUZAhdfwiOE2K
9qdYrJ11BblECAmRj7TxYvl+IVxbhprHxnzDlhI4BSWcjsDTihKfmPQgRyhFNBh/
KGTviYb8mj3bl7MMa154/vbK/8aI509MNUSXnH/pRDFZKtTDoousZ03kfJcFKnLx
jZjE4ANjrcaC25Wf9GnR/9CnQ0vC
=LRZo
-----END PGP SIGNATURE-----

--1lzwZ4JX7pCGOlVU--
