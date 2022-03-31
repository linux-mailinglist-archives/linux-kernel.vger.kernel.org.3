Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164824EDBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiCaOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiCaOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CE05AEF3;
        Thu, 31 Mar 2022 07:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAEC561A38;
        Thu, 31 Mar 2022 14:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52949C340F3;
        Thu, 31 Mar 2022 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648737246;
        bh=lq4kFVmBrrELd5KxAUjOFSmUYoJsLhv9w+gM5KI4LGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKUpenpOcz38WkEz0G293nQngR5L34C91OxZPwKHQz2sf4hcWbhvj2nHa1KtBkeQM
         8wxc55MeZMi9ohX5ou42yb2C5f6NJ+K11ATKWR2Y9ctjvkspCfBfzoZiAVglKy4/DK
         ozsr4YZehOuHDn2xkeJnrhxEMsgR0H02AXqqDzldoCjzr81uqch7lZaopmR1jswMQf
         EQ75//raK11lvESnRPX1Kxzy8jjJ5C0GbTmQFNy7q/xR0EJeqoL93JVykyXv2wFHnm
         g4t9YamB9pGOfzEI7imh3EAjSVSAcjPo50VlyJ033STJMpGZCMEFHJlYOOLWhlwqkr
         VoaP4vzeB7MnA==
Date:   Thu, 31 Mar 2022 15:33:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
Message-ID: <YkW71sAktr/U0Kje@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <YkWfziQzprEsWL72@sirena.org.uk>
 <ea0e8079-a184-996f-47ac-3e00b63166c9@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5r4Opt+oeZpWRK1s"
Content-Disposition: inline
In-Reply-To: <ea0e8079-a184-996f-47ac-3e00b63166c9@marcan.st>
X-Cookie: Reunite Gondwondaland!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5r4Opt+oeZpWRK1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2022 at 10:28:56PM +0900, Hector Martin wrote:

> The problem with this model is that, in particular in the case of
> speaker amps, incorrect settings can cause your speakers to blow up.
> This has been a longstanding problem with ASoC platforms (I should know,
> I *melted* the speakers in a Chromebook by toggling the wrong alsamixer
> control once, it even warped the external case, all without making any
> audible noise).

Yes, that's why we have platform_max - it was added for use with
Chromebooks originally, someone else had the same idea you did.  It's
used less often than I'd like since most embedded systems and even
things like Chromebooks have a software model where the actual sound
card isn't accessible to normal users but that's not the case once you
try to run a general purpose distro on there.

> kiosk-style software with no user control. It is completely unsuitable
> for a desktop Linux system, since it means users *will* destroy their
> hardware accidentally. So, some way or another, whatever is exposed has
> to be sanitized so that it can't go outside the envelope of what is safe
> for the hardware design. That cannot be known at the level of codec
> chips and speaker amp chips; it requires platform integration knowledge.

Yes, we should be trying to exclude configurations that could be
physically destructive but that's not what had been articulated and like
I said in reply to his last mail it's really not clear to me that what's
being proposed would actually accomplish the intended goal.  Targeted
restrictions that protect the system are fine and good, random "why
would anyone want this?" or "this is how you accomplish use case X" ones
are not since we do get users turning up with new ideas.

This is one reason why it's important to articulate what the intended
goal of changes is, what you've written above is perfectly fine and
reasonable but there was nothing about this in the original changelogs,
just statements about how silly it would be to configure these controls.

--5r4Opt+oeZpWRK1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJFu9UACgkQJNaLcl1U
h9AIAAf/cUel6bE+mDxbI8cbqZccf0srWX39DgijpGGwXFwXVqh7zwNKiGn5lp6y
zg8du4D9qekF87mySTin4MN/i/t4q4IaDNeHPIHFpc3U37FzDWKs8n05nvIr0lm+
WHfIlB1zK/CVVBcmK430DGMBmgMwvrgz37+VvH/xdMb0Xrx2dg/ebbt+4wnv9TXa
zBkH9OBQcqe7GCixvZ3Ijn6duye5COf2LhjW9L8iIyAFn0qGWl7f2an68dvIH9EG
XNK/i5frYmN+kIlSjAxQ0YKX5Nbsps0GXch5/o7PNn8n94a/rUeT1MAL5YVZ+IcF
x93x38l8DB6DB5/f9gLhipNOTHsY2w==
=37zx
-----END PGP SIGNATURE-----

--5r4Opt+oeZpWRK1s--
