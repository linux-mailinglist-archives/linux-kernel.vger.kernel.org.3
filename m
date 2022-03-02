Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B953E4CA638
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiCBNpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiCBNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8F5C347
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102F5603E0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D05BC004E1;
        Wed,  2 Mar 2022 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646228672;
        bh=7SdohgjdZwr8XTSeKb1Wfr0MU6JR/xVezniOJDAD0D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbdUZEy5XWy9rag6+3KL0fKGXtDHwJbOs58Xoe1Y/Il9vAAzHO5wrJYKdcwelbc1q
         BMnnpOmqKSwlv+cw/jKa3gdKliTrZF9HnwgT995w/R0yDaBuxar5n0Gut+vwTa7+OW
         8QGikadkhVEeivYvv12FpuYwWDne5f32adLp8zePja/q3EiAEj6csKS9J7aro2qt8L
         bmCVTS0nDWPmAlA3QfKIUNvvcqFu0W4YFtn6ReNmfRGqkzKw1v6cfpUi7trfL/CL06
         wbumDzA5RDt26Fpcn00WI9M/1ALSxsM0mFXmpK+qiXAFZwZegDLYsN1KIXIDveajzZ
         XO9xZiaZmm2UQ==
Date:   Wed, 2 Mar 2022 13:44:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: Fix error handling in pcm030_fabric_probe
Message-ID: <Yh90u+E3RTuGEDWU@sirena.org.uk>
References: <20220301075351.31691-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zPKg93Nv3+dx0TgJ"
Content-Disposition: inline
In-Reply-To: <20220301075351.31691-1-linmq006@gmail.com>
X-Cookie: All men have the right to wait in line.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zPKg93Nv3+dx0TgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2022 at 07:53:48AM +0000, Miaoqian Lin wrote:
> This will call twice platform_device_put()
> if both platform_device_add() and snd_soc_register_card() fails.
> Fix it by using goto label to avoid duplicating the error code logic.

This doesn't apply against current code, please check and resend.

--zPKg93Nv3+dx0TgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIfdLsACgkQJNaLcl1U
h9DSmggAgh1dqp4/bgEI+eYNLVecexRuzd1XFEdwTsACPSdAnD3VV5YWjgHO2p5/
SAVJpJ9YQFWEtlCG+wA+LHiEv4BwzBCk0ga7fCzfju5x4PaNh2WyQ9hu2ZjyAHu5
9mHMiKGa2zhEUz8K7yrEEg/diJKIYAi5C+9HwjjJMj7M+N5OF//sW2Oso5zaiC7L
j/wVzr1lvjnkkF0lNdBEUhPM6AIptIRmq5bXGraLaBda23wNrC2pXQEcumpXjzRF
e1Ru2AfhkpDS+0RmXtrZOpiAm2AsDfjlU21QCC51c1JrxLikvrTsrc24QBoDJtN/
mpMt7ItjjJ7ryuxZDCThtJQLAj2WhQ==
=l523
-----END PGP SIGNATURE-----

--zPKg93Nv3+dx0TgJ--
