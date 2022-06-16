Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8846A54E57E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377430AbiFPO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiFPO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:57:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFC24F3E;
        Thu, 16 Jun 2022 07:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51554B823E0;
        Thu, 16 Jun 2022 14:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B281C34114;
        Thu, 16 Jun 2022 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655391458;
        bh=Q/PnTzhXRBmKrI0PFPrXpgukiy9ng7otJtD++t+syas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSqYvQr14hkhuxDT1yqOrr+i4qHaWON6KtgtBD7V4tE1J8Dx7+Nheja2S8ISmL7/R
         cWZTMYVBFDgkSIHGPrLSR7SVflZuov9jVVgQqA45iGv2dDNigOU9Gks+JSGdscrdIL
         2uiUGXsSzbxulyTEP5YtmSoyECR20Eab+qQ38MeDydLE1wWEVxYstTtHhRhwZ1pH2E
         71ucsOabMGOtPXzvsXo7S8V1HoUtptE7zgeOJjZUheaBifwR1IgP7cFkaprIkJP3AX
         xzAMKt+gb76pcKhq9VO9YKKtClpaAKETxGNWyDMQ6RzFIU/GmmmjVVLcuxfyH+8oa4
         +rVFHxpQ2Q/kQ==
Date:   Thu, 16 Jun 2022 15:57:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Owens <dowens@precisionplanting.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: ti: omap-mcbsp: duplicate sysfs error
Message-ID: <YqtE3Wu4Ku7fh7D4@sirena.org.uk>
References: <20220615150955.4140789-1-dowens@precisionplanting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtd9UxDP2fBlpOtG"
Content-Disposition: inline
In-Reply-To: <20220615150955.4140789-1-dowens@precisionplanting.com>
X-Cookie: I think my career is ruined!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtd9UxDP2fBlpOtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 15, 2022 at 10:09:55AM -0500, David Owens wrote:
> Convert to managed versions of sysfs and clk allocation to simplify
> unbinding and error handling in probe.  Managed sysfs node
> creation specifically addresses the following error seen the second time
> probe is attempted after sdma_pcm_platform_register() previously requsted
> probe deferral:

This doesn't apply against current code (either for-5.19 or for-5.20),
please check and resend.

--dtd9UxDP2fBlpOtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKrRNwACgkQJNaLcl1U
h9A8dQf+OVItQpQi15+ykEglfxmtFxqiwDLZB/YmOYAJcJ5MQ30z+ZlB/KffQ1VS
PF7MzKVQFXT1QSsTDsasRla7+U+TlIweloDb0VL8RnIIua42Oz5WtDWuksTtl54z
J3UBrBzeo4SQwRHCFJhpCGpv7wRPUyKE2XzACuCK19UGyxroKiqLROqS6C359XKt
ekpRODoc5on1BugbOvEgRYdRL4GuKfkt32GY1zfNlPXa0VTMTVVHg92XYQQqBilf
N3EF/pAnOIljK/k6UJNhAaM4xCSAPeupRWZZsaPizrEWFqHMYIs7E2kGsS0URGaB
x6sda4Z59uT4xrSCsYP7lIRz70cPWA==
=c5ec
-----END PGP SIGNATURE-----

--dtd9UxDP2fBlpOtG--
