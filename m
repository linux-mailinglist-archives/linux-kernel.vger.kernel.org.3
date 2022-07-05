Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25823567476
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiGEQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiGEQc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:32:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1219292
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 09:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98858B81873
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 16:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC40C341C7;
        Tue,  5 Jul 2022 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657038744;
        bh=ELTHKRlGh2TFVwLiCwnTc8wlXdeQ+pD6rYi563gQQ6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgT7xZwlPFkbHzVDL4FfLEz+K3+F0eqFtJeBULjpARFv44dCZBP8Tm6Jfvg5o9/AH
         6zvB4+zEv9Y40JhDbbNDKTmOzP50QvvQdLfjaZVVXMBJr6q2E+f8XHTIDrBzc00Obc
         lyDwMpFlmhH3HQB8FrHioEdFazMU3NPn2KoSlFzIDzdxPm/DKcjY7kKg27PJ+m3kd4
         IPvWjPL5pHPcNMJx1tyLZRFC1H0+8S481xJSzRo8ZaJQRPdv/MMfZpN3MBORe3SI8D
         9QZJR9HqKtsQNcBV+p03sNN8eg/2A2wAPsc/iVY6+wxAMEg+YtKCEQ+fHPVX54z2iB
         cp6E822nyYKxQ==
Date:   Tue, 5 Jul 2022 17:32:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: equalizer cfg in max98088 driver
Message-ID: <YsRnkxcBWCgtRIn7@sirena.org.uk>
References: <20220705075500.GA1987744@tom-ThinkPad-T14s-Gen-2i>
 <YsQd7mub0KJdYUDw@sirena.org.uk>
 <20220705162956.GA2676656@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LoH50+dDeMaAE155"
Content-Disposition: inline
In-Reply-To: <20220705162956.GA2676656@tom-ThinkPad-T14s-Gen-2i>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LoH50+dDeMaAE155
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05, 2022 at 06:29:56PM +0200, Tommaso Merciai wrote:
> On Tue, Jul 05, 2022 at 12:18:06PM +0100, Mark Brown wrote:

> > There's plenty of examples of equalisers in the code already.  I don't
> > know how this specific device works but generally these are either
> > exposed as a series of volume like sliders or as binary controls.  This
> > doesn't restrict people to settings from the firmware, making
> > development of new configuraitons much easier.

> Thanks for your reply.
> I meant somethings like this:

I understood what you meant, like I say this should be a runtime control.

--LoH50+dDeMaAE155
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLEZ5IACgkQJNaLcl1U
h9AiKQf+McrQlmTh3R3eoil6IjzxS5r8PRIouf93sdRTuAKMBxPiVDQyl+zbeywm
976+jJEsliyD7V3tJqBivh1bNsbn0Ai3WJ+5wpKqOy0LZdFvCyQgWI+84BrGBzKz
dkITYXpzVNFOChRNaWjh/LOgpebSATjvwUFpcM0oSxygn8Kez7sdXgZA8Mzxj7Ws
37/OUPASXphF2cYpiKVx2N+FN63S0a5ZWoRrkd136Zf83bwnzsAZ7jgy3vFwfVd3
jy6s6biSmxzAEiV2YLvPpJtH3z558y3ILqmtV1HbjtU1LrB9f9sL0F+iBIov66R2
FpKjgyoX0TEJ7ku7aCKiB5LV32v/2A==
=nQpp
-----END PGP SIGNATURE-----

--LoH50+dDeMaAE155--
