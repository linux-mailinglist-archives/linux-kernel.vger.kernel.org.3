Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10D58CB93
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbiHHPwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiHHPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334D0D8F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1BCB61042
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB588C433C1;
        Mon,  8 Aug 2022 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659973966;
        bh=0waKzL6EJvmtz8J3afsiw+tMv5KbHV3THi6rTdS6HNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxuXK0GFGlbIp6x5gazvS1RMYv7Q0SBSySPNJwEVtYaq1E7y6jiPu38kPTm58fwme
         Co91hsCiUOBvvNBsbLaaIhacdy1Dg4G3e7dvVr+pX9uCPJToiUba2Wr8x79Fjaoyzu
         MTEX/DM/ClO4uP8LJMrmVQ70sxrZcVcs0XFCoL0I7r2vZQDArRqAndcELjXZjwhDSF
         u/InyVCRSMU3DN8SW4oYu4bi7J4zsHbdQ6Dmtf6c230/9gGc9MKTzCzzO1F0uLaKt8
         rxjZzXypk0WZAx4FIf26GG5eBbd8AhdKs1FoGaEPybR1dEC3w3AUgoq6T76Fvbpk/W
         +qd2alBCjeUiw==
Date:   Mon, 8 Aug 2022 16:52:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
Message-ID: <YvExSVixNUpOivja@sirena.org.uk>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <YvEKgkhRWCKtXdD4@sirena.org.uk>
 <CAHp75VeeZAgKdZhJffNouFh26rwGzmqGuJX7bcObSVV+dFS-tA@mail.gmail.com>
 <YvEUJ12TmgRaR4Ub@sirena.org.uk>
 <CAHp75Vd_wks4d4HyFQpWWUQO-DPj7bmm6e66LSZ3F0+O6fC6bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4f30vEVZ3LwvC9A3"
Content-Disposition: inline
In-Reply-To: <CAHp75Vd_wks4d4HyFQpWWUQO-DPj7bmm6e66LSZ3F0+O6fC6bw@mail.gmail.com>
X-Cookie: Flee at once, all is discovered.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4f30vEVZ3LwvC9A3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2022 at 04:42:28PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 3:48 PM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 08, 2022 at 03:41:48PM +0200, Andy Shevchenko wrote:
> > > On Mon, Aug 8, 2022 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:

> > > > regmap_mmio_attach_clk() prepares the clock that's passed in, we should
> > > > undo that when detaching otherwise we're leaking a prepare (as we do in
> > > > the explicit detach).

> > > Why do we allow the user to avoid explicit detach? What is the point
> > > of having that API in the case we take care of it?

> > I think just for symmetry so it's obvious that error handling is
> > happening if people want it to be.

> So, the only user of that API calls it explicitly. Should I rewrite a
> commit message somehow?

No.  Your commit would just introduce a bug.

--4f30vEVZ3LwvC9A3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxMUgACgkQJNaLcl1U
h9DQiwgAg+GOOT9iij73zrFpBk62fvrTLnJU0hZ2ReC/ZC0iOcszC5TeG59PSEI+
CBcMzQCf66DxfBkcSUQwLudkbVIVR/datCpXIaGdTVSwPY+dVk4+IKFuvUTVtavk
MMwzHgxbL27ScVFMaRQDB2Dues0ZcYNm9QPwvZVhIid368SD5jE/GxGJ+8ZYc35n
D0Vwxz/knZ/x8pTDWBDj109BcahI4deKj8m6t0dc3dCqxIyEC/UkrOArCLUlCRcs
yh/rJYoMcvzjd4AKpAziYlmQxx+rzUwjSsmfV4HA5WoV33tOVqcrgcIjSnHtVpDn
/AGEyo2smz2UbMsTRlfqY9k8lqo89g==
=NACF
-----END PGP SIGNATURE-----

--4f30vEVZ3LwvC9A3--
