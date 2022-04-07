Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F874F850F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbiDGQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiDGQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:39:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9161777D0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E107B8092D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAFEC385A4;
        Thu,  7 Apr 2022 16:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649349426;
        bh=anQLnsuZxYc4YusrMg10WYGJTNoSFZFyAbngTsYWJWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MeF0uNyyDZzNOfXb9zUW1ftJBxaHSlt6MObKb6s0BTNxUNtyW0lFoawXT0zMd8biU
         pyqo1BWrOCMPNYTfZ66BNUZnLqrtLxk7pFLwUgqBD5CX0hKn/Y4mpUjHd0Mi4mKaQ8
         YD9TNJta/h9laHydGgegv6HOVBGF2c/eVh+5RwzceEPyjFVqGCbcKON8iKHxpv0zb4
         NIGekAl0KkJJ574m7dBxP1xcotWdLh84f1yCIzzXhL64WdIh50aRoAjeqrtgJKREQv
         M5CGWtlSIYn4PlgnXO/WobFneA1owfz5rpaAb1YEY4qj8vSOeM1lxY5vKevedXQGui
         EQhk7UaTrKtcQ==
Date:   Thu, 7 Apr 2022 17:37:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Add jack kcontrol
Message-ID: <Yk8TLUnEHRKstyxq@sirena.org.uk>
References: <20220407141316.5099-1-akihiko.odaki@gmail.com>
 <Yk7+jbQ0KBM0zVh9@sirena.org.uk>
 <96dae189-c0ff-4054-3d00-41c3b44c2cd6@gmail.com>
 <Yk8Ktyyt0veW4g+j@sirena.org.uk>
 <f86a10e1-b5a7-5c59-8e53-cec65d97234b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K9Hi8t9P2T4/0vtf"
Content-Disposition: inline
In-Reply-To: <f86a10e1-b5a7-5c59-8e53-cec65d97234b@gmail.com>
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


--K9Hi8t9P2T4/0vtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

j
On Fri, Apr 08, 2022 at 01:11:22AM +0900, Akihiko Odaki wrote:
> On 2022/04/08 1:00, Mark Brown wrote:

> > That bit is very common but there's still machine specific aspects - is
> > the required hardware wired up, if it is wired up how exactly are things
> > wired (separate microphone jack, headset jack, one of many jacks?).  A
> > lot of the machine driver part of things is about labeling things so
> > that it can be displayed in a way that's easy to connect to the physical
> > system.  Generally the machine driver would define a jack and then
> > connect the CODEC to it.

> Whether the required hardware wired is told from the user of the codec via
> jack's type specified with snd_soc_card_jack_new(). The other details live
> in the codec.

So I'm confused about what problem this patch is intended to fix.  It
really sounds like there's some issue with the driver not using standard
interfaces that you're trying to work around but the changelog is not at
all clear.  The "doesn't use DAPM" bit is a bit of a warning sign, it
sounds like the audio signals to and from the CODEC aren't being
connected to the jack properly.

Look at how other devices with jack detection hardware handle this and
follow a similar pattern.

--K9Hi8t9P2T4/0vtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJPEywACgkQJNaLcl1U
h9BD0wf/VfBhw9GQTwXU5Qj1Mq/d+fRP1+2jj+kUbV7xuu9nyDuVH7YLFP/Da2G5
dFgQBgY6vSA7++fPrbG4kqzGpvLPcNy6s+kjZHj2anBccZg/4Q9yADqp5ifggHcj
o/ltdaGMidJydvYgAF0EZnoW37eKRXNR/caF2nvE4aa7X9t/e3FOFQsfEP9nYi6Y
8zyr5aUabYQe5NYx903wgSoUKQoc0c8VS820KAxyoSw5T7Y3O/CprXZyFk8Wc05y
OpPLRzW2d/fqjWe/bhzaC2AYICirJSaO7R6fAMaV12fbZJj4i+F5K3+CU/7GlWc0
H3WCDElgw0O9PivSGGwzUasIlzOWYw==
=9nxM
-----END PGP SIGNATURE-----

--K9Hi8t9P2T4/0vtf--
