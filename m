Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E2E511D05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiD0PkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239893AbiD0PkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A924084
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5636D6170D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C07FC385A7;
        Wed, 27 Apr 2022 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651073815;
        bh=aFL2D9S6TNyMN59BIGxxXq7oqqxw61XP8Y8c5BFS/lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8cJcTDB3YKiztI3+QUpKP53J9ITpDZKSe40fyHDqeTzqyT8DTgR28Qb6gwF20iES
         PiKL/89GkRHS3S59YXo+mqImgaAdD38GxiCbEuegJVgS9tUMVN2f9UYUuwt1OKukzy
         RuraTLn/YCHthNUrb0rrFR31vNzszSUzJMdb3w34FOXazgNid9ChkBOziKMMuh5Ogq
         qq/wxWGDIqso0ufFuGxWsjd99+AdqQvVt/ankmeCNFK0fpXXOtwYOTa6nGb+pEyidK
         7PIHLggF7ep7tT87wxJAqKKGbL+hFp0AhdSWc7iNKC8FPR/QIEYgDm2UDCt0Ov6ZgC
         Q8pfY0sYjYbeg==
Date:   Wed, 27 Apr 2022 16:36:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Message-ID: <YmljEm6jUr3Odsv9@sirena.org.uk>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X7yUBoxLMeMMXIgb"
Content-Disposition: inline
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
X-Cookie: Buckle up!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X7yUBoxLMeMMXIgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 27, 2022 at 04:06:54PM +0100, Vitaly Rodionov wrote:
> The CS35L41 Amplifier contains a DSP, capable of running firmware.
> The firmware can run algorithms such as Speaker Protection, to ensure
> that playback at high gains do not harm the speakers.
> Adding support for CS35L41 firmware into the CS35L41 HDA driver also
> allows us to support several extra features, such as hiberation=20
> and interrupts.

There's a bunch of changes for this driver in the ASoC tree, it looks
like the bits that touch ASoC will need basing off those.

--X7yUBoxLMeMMXIgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJpYxIACgkQJNaLcl1U
h9DKKwf+MeaWWgSaxNDHpr0/70ctpJeHHvJ3M21phiaLehf1qZxLzgiOITexBvhW
6F33LKztXhX6FYu1Y/zPPHWEfMdTamU4BK+9253iPAXmJ+5rYmzsq4ycpUzuI0T+
42Ja5EZx4wA0RdJd92gMkp0XRI1mYdRQGB3G2gBaD53qKtlB+t3cIhze6n+IiDI1
6/hQPZxj5CfCIJcqbtqmV+fWaNcjTRAqs39syqGeF8+htGekq4kAWca/8fdpb4WP
vnq7CcSsaLnHrnAQhjXWliK7p5QhBWi9dvnHZNVSW9c4c2CjjcK2g2xd9hAkTsvj
DgzgksWda4GEreArh/Hswz7GIoLZDA==
=Io8o
-----END PGP SIGNATURE-----

--X7yUBoxLMeMMXIgb--
