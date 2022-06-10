Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1854665F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348538AbiFJMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiFJMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:16:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF43B2B2;
        Fri, 10 Jun 2022 05:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7523CB834E1;
        Fri, 10 Jun 2022 12:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B861EC34114;
        Fri, 10 Jun 2022 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654863396;
        bh=zB3k8TqYI+NLDCnckqerXX2X3aCo7zmeZE9wRHMRpuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=og1OdUK1MEcxYSR7cQpq966zbZ2CCjLdGq9dARdRx4/tdhxzdl39YW95T0bwIx7QI
         FeLWGkkfH4dhfM7UXdkrCG8KzdXFaZPtSUzbQe1P9/g0knunqp2p2t9Wa7VZZJUDQN
         zG7iGhcvq1n6f84728p3geqcUUg0Oxn/h2lzDIpof6SIR8EHXCnY3wPBTUn1EiMJF2
         8PqDBJcteEXquFTunLwc535Dvy+c/fikAc5yUWmtCC1uptnBJEyNFOXp10Ed9jOgBn
         Az+eWtfEfvLfxv5ksUDSSJhcdRiA7piPq2yZerKUTTJK6a9QiwgLs9BFXt0eoFhWWc
         nSjLSXwEpwblA==
Date:   Fri, 10 Jun 2022 13:16:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 2/2] spi: Use device_find_any_child() instead of
 custom approach
Message-ID: <YqM2H8iG5Y2MKrNK@sirena.org.uk>
References: <20220610120219.18988-1-andriy.shevchenko@linux.intel.com>
 <20220610120219.18988-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lLUmA+2Xem4TZBVE"
Content-Disposition: inline
In-Reply-To: <20220610120219.18988-2-andriy.shevchenko@linux.intel.com>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lLUmA+2Xem4TZBVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2022 at 03:02:19PM +0300, Andy Shevchenko wrote:
> We have already a helper to get the first child device, use it and
> drop custom approach.

Acked-by: Mark Brown <broonie@kernel.org>

--lLUmA+2Xem4TZBVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjNh4ACgkQJNaLcl1U
h9AK6gf+JOkepmDgAErfr3ruTqIWTWi3qZ9vVXOdiFmPpmTKjdmBq/AoWTaYuw7H
dV5yx3vu4TztiGhf4p4X9KM/gswe+Ybr2BrxmlYMuqNVowDHAOCNZnlzTlqutOkr
+Rj8aS47joDZr80IdEr8RfX2bkWmZxiYHPuwocxJeTn5dCRHyXqyD4i/4XrBSNr7
CEeFd1gMDRlYF0gy0qK/PvMEzIYvdBWp3DQW633A7oFtEgpDH9GOzgdoA8uNv0GP
ge5IfF15siva4tnWvxBvdmurCLl7O5M1R5L8t9rJCCkLkNrXVI8RNpR7n2OyHyNJ
4Nnrh/VmWTcQp7Z2F6DtwqhP/LRvXg==
=X6d1
-----END PGP SIGNATURE-----

--lLUmA+2Xem4TZBVE--
