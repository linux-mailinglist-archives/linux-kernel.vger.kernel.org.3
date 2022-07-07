Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161056A16F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiGGL6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiGGL50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D595A2DD;
        Thu,  7 Jul 2022 04:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 775E9B8213C;
        Thu,  7 Jul 2022 11:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD74C3411E;
        Thu,  7 Jul 2022 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657194933;
        bh=IQJDPVLJ4H47AUx8Ljjae/JPRhou/gHAHrF0+znEb8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+rdZAHylfBWCoO2RrECPmnBMH0cZjere+QAfwBFw8GFnHbrSoQT9D9ZlBfqxyrTb
         PDPXgBP0RriwGv9jRQO5zvcI02Yi0lTaKT5WCoAYUQJxOartyudNb39sMYX2mruqXI
         NaE/l4mBa7S4H9cttaqmX+ineSZwlndYxZy8NiB/n81J3M43BsENl5bQCzH+nwnb4s
         KYOGHyr0j2yDziaK8UDrBzUkQZv5dAfVOS+R+GsHxBSXRZUpcQaANgM2JhJb85Tplr
         zi1lcv+vf15CVi5jAQB4RztIlt1oyAu9AwvDwJw2rWvbZIW+2I95qN5h0piVa9qmdl
         4DYwd0CMJqueg==
Date:   Thu, 7 Jul 2022 12:55:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <YsbJsMzNVUpxBMNh@sirena.org.uk>
References: <20220707200428.3eb1a20e@canb.auug.org.au>
 <872891aa-11ea-ed60-5090-940e8e7e4458@amd.com>
 <9f4d8898-eb5f-aa91-57d3-66a78e9c4316@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NixQ1HU3mERZ+lRc"
Content-Disposition: inline
In-Reply-To: <9f4d8898-eb5f-aa91-57d3-66a78e9c4316@amd.com>
X-Cookie: Tell me what to think!!!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NixQ1HU3mERZ+lRc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2022 at 05:12:31PM +0530, Mukunda,Vijendar wrote:

> If we have to submit the patch freshly then earlier patch should be
> reverted in for-next branch.
> Should we resend the fix again or else should we submit patch freshly?

If you have already sent a fix there's no need to resend.

--NixQ1HU3mERZ+lRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLGybAACgkQJNaLcl1U
h9AFMQf+KDF7TnuBRZxBUkRorxs4XsvW9Yli+TPSF+Ak1MOL1pC/Dw83uEygrEeM
iVGuhmJ/xhnrsi9oUdKhHHZmKnqzY1jt8rWKFgwiJ9VAOuPw90WwBJkBb+d7rJmT
bFCSK2kzg3fsEWapNjZnEe8kcJh4Qc1M5yMkWdjHLgyRhZia9415z07nP/+mYmyp
ls9Sbc3fQKR5SQ2VNMCl7RzmyDKFN9W3umOUiOkDtceM+SinUP9HfogEKZMTaVyf
7GEwdStTkNW23kZ3aG7MfBdlc5GeJ4jauoJjtrKDNBizzp5Rf+FMMIEVAFFqH2GW
Z8m29KJ4J/r8HWTwX42V4ggsT6eqPg==
=Hhnj
-----END PGP SIGNATURE-----

--NixQ1HU3mERZ+lRc--
