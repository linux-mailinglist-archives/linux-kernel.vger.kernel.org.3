Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB84D4F8287
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbiDGPLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiDGPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2902898E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE2D61E00
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDB7C385A4;
        Thu,  7 Apr 2022 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649344147;
        bh=m+NDwwT5mnD5vEmEl6tEcP3rbdAB2sPSt8NXHIlxqW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2wZaPySvONmMrEegrR3cpKkl5c3i6zGNE0KwyoAV8inLlfJV50AdFw5NRke2dh7l
         EUpHdxALNtPKCj5aOCmbZuBb0mOCg4ZQWTasZBgGgvYb9hzcv/UyW7eBjBYEuBFrll
         ieWx7eM2wC9EyUtgW4QcKekzrfratW3/1ZFR+tOZAq1K4QLYjLcm02mnoIbIzebJht
         L79XQFZSWS5fzMJRlfJpaN+4N3f/U6ojFibVvrlj6j9rhPrbtJlZl0ft+s3t4DmMdL
         OA3qOLr/TH0RNbC0AttiqQ1aLy5bfyUCujyH9cs+sOAVa5YGtxWZRd0Db3dh8UZdu6
         yzabws6cp8p1Q==
Date:   Thu, 7 Apr 2022 16:09:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Add jack kcontrol
Message-ID: <Yk7+jbQ0KBM0zVh9@sirena.org.uk>
References: <20220407141316.5099-1-akihiko.odaki@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dSCykcoLsRMrrTF1"
Content-Disposition: inline
In-Reply-To: <20220407141316.5099-1-akihiko.odaki@gmail.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dSCykcoLsRMrrTF1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2022 at 11:13:16PM +0900, Akihiko Odaki wrote:

> Create a jack kcontrol manually as rt5682 does not use DAPM pins
> for jack and will not have kcontrols for them.

Why not use DAPM for the jack?  Note that normally the jack is part of
the machine driver not the CODEC - there's no way the CODEC can know how
it's been wired in on any given system.

--dSCykcoLsRMrrTF1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJO/owACgkQJNaLcl1U
h9AEGgf/W3/sjKKCepOxRaMvpQ7VN2uIOJlDIBnK1XFdb4T1ujEE53raK3EDDf7g
a9FFb5FmG1ejbqW1XRe0OHqjuhUNWWu60gao+FhVFB0gdqhJo39i3IQ3Az1lwMDD
/rqeJtfWQMu01WQHkQkPY6Uw2pN2EaJlDQEd5g9r7RoU9GBqnY/+9ksFzFzdt6Cq
zhfjTEWqoVhCcY+ia3PM+BNGAcEl49mLoDyKn8TskVKSatVSEfqA+vq3SbmcnBXD
LwroN3WEfoD5g47ynxxLZIQ44E0lai1QQvpn8+Vuop01UE7Y5AnHwY+0vQ25mLE9
kAI5EKh7qZgRDm+SupMnx2KZ2KOb3w==
=q2D7
-----END PGP SIGNATURE-----

--dSCykcoLsRMrrTF1--
