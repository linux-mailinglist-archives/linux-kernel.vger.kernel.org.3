Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE545659F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiGDPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiGDPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E621012
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3A9EB810D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 15:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B10CC341C7;
        Mon,  4 Jul 2022 15:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656948949;
        bh=xvKuG9NnPSr3QqLCYuINjvdhaWm9es1akuixSQ2TA/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tc6qToJLUE3OcWTZdyvzzNRaVUwRTsH54pdLaOiR5gCXly4ruxBEpe/fflrtvkbU/
         AlUhUpyQCebYStNIDjdTXNbyNiOxwwan19EOdHUfxPc9POt2XNR4O2aBsKAIEB0now
         WQ902D/1Pxi9ja1DQwchP/G4GPbbyrzzxQ17t4P6w++SXO6eS7USCO409U8Tuu5qfF
         yutihF0/CZTOrg/Ne43lAHfsFFpjAmgRd8ZmhpYFue8eMb3Z+1TBbji6B3C7XF1SVb
         ngFnxoXIXcxTxHd6FG2DIqV1nK8mIvsWBtDxc2EXbeNwXyBtZrC5mYxbuF2OZBUXvB
         LTvXON7qZjmdA==
Date:   Mon, 4 Jul 2022 16:35:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        patches@opensource.cirrus.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: madera: Replace kernel.h with the necessary
 inclusions
Message-ID: <YsMIzz6JkTLw7heY@sirena.org.uk>
References: <20220603170707.48728-1-andriy.shevchenko@linux.intel.com>
 <1b5ba014-44ca-e753-141a-d8ff5fd248bb@opensource.cirrus.com>
 <YsG3kKwmoqF2MxU2@smile.fi.intel.com>
 <YsLCwQM0gbhFhSke@sirena.org.uk>
 <CAHp75VeCTEE4-O1LLYNunf_ZU164i8rnqeRf9dvp=R=_eEC=ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45MOapQtPozrAD4p"
Content-Disposition: inline
In-Reply-To: <CAHp75VeCTEE4-O1LLYNunf_ZU164i8rnqeRf9dvp=R=_eEC=ig@mail.gmail.com>
X-Cookie: MERYL STREEP is my obstetrician!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45MOapQtPozrAD4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2022 at 05:30:41PM +0200, Andy Shevchenko wrote:
> On Mon, Jul 4, 2022 at 12:45 PM Mark Brown <broonie@kernel.org> wrote:

> > > +Cc: Liam, Mark

> > If you needed to add me to the CC I've not seen the patch...
> > for review.  People get busy, go on holiday, attend conferences and so

> The question here is about MAINTAINERS. That's why you are in Cc list.
> Do we have an issue in MAINTAINERS that causes you being not see the
> patch?

I have no idea, all that's showing up in my inbox is these content free
pings.  You'd have to ask whoever didn't send the patch to me.

--45MOapQtPozrAD4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLDCM8ACgkQJNaLcl1U
h9CdmAf/bckH9oNhcWHT2zx8i6ZCpIMCbbSkVPDnh7G1w0gmEZWDdmn24VhC/hX2
ngMwMZaCDTaguM6tyTRucSZ+2D7YHQ6kMXa5JP50SOJO7POPDNp1wik21YsQZigE
L3sZ0wbl5g3EbYjRIFNjlJlKTR6bsZjnZ83J3Q4CUdtQ0blwDpRuV/Qk+KIF6KeH
xz75VyVUJVPuNLBUhmPqaEXquXM7PyFLXnPBsrxP37FDaYZROhv2rj2k/iyl/Xq9
UMyBfJleqsXdxKy+QkdgOB4zDJ9B4FQvL+VU+qONO71ymfXP57QiGtFsHJ1Buune
HO6rqKOVdyXjjjlG8C0skIdZ0JpprQ==
=UhJ2
-----END PGP SIGNATURE-----

--45MOapQtPozrAD4p--
