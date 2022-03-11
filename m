Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006564D6120
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348467AbiCKME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbiCKMEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:04:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC399129B8E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:03:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308EA61BD6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 12:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BB9C340E9;
        Fri, 11 Mar 2022 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647000200;
        bh=4HqIUdAejX6Wm0p0O/9WPDB8wevECYxP6SoZVcoOkpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxPRwB6yfowPMf3pv9E2ecWZb9RpuF/DUswsqrwmFl/Yx/QAinqNU53ttaB0v24VZ
         wVEovQnXPTglyWehBEcwmEARda3vg9eP9fGtx3U7D9pbmBp/5pk3GFoBt3L2+o0VRd
         sxjMiyEaKihk6Mozsy6nW4t6hzodvjlTtNnfK9id9VS0ECcfYK5NE6eI+0/6pV6Zjj
         QyV8ztllVV9NFYX0HsqzPie0oDyJqeaLApm52gEdq1KHqC7lOeBR0TN3tJcBlyO7FI
         zc6LEDRm9TDn6xb2j0HWfPtK4pT7Yg6rBcy5jm2EpVGVlijoQNo3WYzaE3v7GXN6Pl
         waGa4NR3kojKA==
Date:   Fri, 11 Mar 2022 12:03:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas5805m: fix pdn polarity
Message-ID: <Yis6g1VSWfl7I8cS@sirena.org.uk>
References: <20220309135649.195277-1-john@metanate.com>
 <YijOHNT0eqDyoviP@sirena.org.uk>
 <YijTk0/UTXpjFiRq@donbot>
 <YijVrgZ+Ysv9J/8E@sirena.org.uk>
 <YikLB4+xHVxjFTSL@donbot>
 <YikiXAseSiODXfrD@sirena.org.uk>
 <YipbBti4yeq2HzCe@donbot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ue3Ft+ZyXNvUs6rC"
Content-Disposition: inline
In-Reply-To: <YipbBti4yeq2HzCe@donbot>
X-Cookie: A fool and his money are soon popular.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ue3Ft+ZyXNvUs6rC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 08:09:42PM +0000, John Keeping wrote:
> On Wed, Mar 09, 2022 at 09:55:40PM +0000, Mark Brown wrote:

> > Sure, I still think it would be good to update the binding document to
> > clarify things as part of your patch - the binding currently just has it
> > as the "pdn" pin not the /pdn pin or anything.

> I've been thinking about this but I can't really think what to say.
> tas571x's binding says:

> 	GPIO specifier for the TAS571x's active low powerdown line

> Is that the sort of wording you have in mind?

Something along those lines, probably also mention something about the
flag.  If the DT has to specify the polarity for things to work
(basically, if it's not active high) then that should be in the binding.

> To me it seems like a general principle that the GPIO_ACTIVE_{HIGH,LOW}
> flags should be used to indicate how the pin works so that the driver
> consistently uses logical levels regardless of how the hardware is
> wired.

Every layer that introduces an inversion is a source of confusion - if
the physical signal needs to be set low but the code in the driver sets
the signal high that's a surprise for people, and generally if the user
needs to specify that the polarity is inverted every time they bind the
device that's a gotcha people won't tend to expect.

> Maybe this just means I'm approaching this "down" from the software
> abstraction more than "up" from the hardware.

Think about it more as being about making it easier to follow what the
physical state of the GPIO is.

--ue3Ft+ZyXNvUs6rC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrOoIACgkQJNaLcl1U
h9CSJwf/To5CYtIziBuS54e+GW2lDzBvZwgCuFLgS9CHWvsAd7Aruvx8692etcPQ
duLqthmmsVX7Gt1UxtNw7Kw6pn1gWEEC2YTjJlOoOAiJ3cfdYrxJ3gZ1MgHKwBfo
mAri9fABt7VxeFBEuC1tuZXgsxueLNQLbxW9hOhHuD/nkih+nEBye1RulCmdZmwB
mX0rW2Df1OcHjynho8zkPzs8JTLmJaogQ8+j7orHSg7BRMVtsqx0AoBxw8MJHtXS
iP9tFcRPVAhpbQB9pXaRocEjdYr46FrA4wkaaceBuKJ2yK7rKzVkFRGszD6Y2fql
TTNEz3fL/H+CukasYWbd2qWgcWt3Yw==
=J7Dn
-----END PGP SIGNATURE-----

--ue3Ft+ZyXNvUs6rC--
