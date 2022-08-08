Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F4258CE36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiHHTCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiHHTCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:02:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC221A4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 980AAB8105C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF63FC433D6;
        Mon,  8 Aug 2022 19:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659985317;
        bh=hF4l8QFriGU1eOWUnU7PWiZ4z9ikvwdpSd6+DkCK1xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fcWEFkrtp6LsdBp9rhhKiVlKk9AyTkzjezSOPaF7Zr1upGlxOh6LxCSvl3DLc0juM
         5ozsbleaOgL3Mxdq2UKsjUAfCB6xjaCuIS31gyMU8yuw+JiqEyuYdQo7EmbLYQPwIZ
         Yv59hSgK4nVV0x+H026l4xtYRcpMykZPAVRl82cWcfGbH7Jcb7KiMYZRsWgtEHFFII
         rHMffbmZy+hixY0/fCyqhRK+WlfBrCKZy1oEFo33Jm5s5Lkg6TX4WWf+ga27bPl8x7
         ePa0fnnPwm6Fw0MGowRfQLYrK+uWYBNfYJl/DjTGUWYg9VPmkKoo8Ck0vQ43Ldx2BB
         Nspu92s2Gh1Yg==
Date:   Mon, 8 Aug 2022 20:01:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
Message-ID: <YvFdoLAj4x3FRVC4@sirena.org.uk>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <YvEKgkhRWCKtXdD4@sirena.org.uk>
 <CAHp75VeeZAgKdZhJffNouFh26rwGzmqGuJX7bcObSVV+dFS-tA@mail.gmail.com>
 <YvEUJ12TmgRaR4Ub@sirena.org.uk>
 <CAHp75Vd_wks4d4HyFQpWWUQO-DPj7bmm6e66LSZ3F0+O6fC6bw@mail.gmail.com>
 <YvExSVixNUpOivja@sirena.org.uk>
 <CAHp75VfL2kKqP5m1SZfBdd0Z-kLg=rcccAxmQ4LOd88gOuFcww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W7E4tre6vxSM9BnJ"
Content-Disposition: inline
In-Reply-To: <CAHp75VfL2kKqP5m1SZfBdd0Z-kLg=rcccAxmQ4LOd88gOuFcww@mail.gmail.com>
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


--W7E4tre6vxSM9BnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2022 at 08:23:28PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 5:52 PM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 08, 2022 at 04:42:28PM +0200, Andy Shevchenko wrote:

> > > > I think just for symmetry so it's obvious that error handling is
> > > > happening if people want it to be.

> > > So, the only user of that API calls it explicitly. Should I rewrite a
> > > commit message somehow?

> > No.  Your commit would just introduce a bug.

> There is no bug with the existing codebase after this commit. Are you
> talking about out-of-tree modules? Or maybe there is documentation
> that says that regmap clears all additionally attached resources?

If the regmap code prepared a clock it should unprepare it otherwise we
leaked a reference - the caller shouldn't have to worry what enables
are done by regmap inside the implementation (and conversely regmap is
making sure the clock is prepared and enabled when it's needed).

> Okay I may admit that Fixes tag might be wrong due to potential users
> in the past. However, in the current state of affairs either we can
> proceed with a patch, or amend documentation (if not yet done) to
> clarify this aspect of regmap MMIO. From the above I may assume that
> you would rather expect the latter to be done (if not yet).

I don't understand why you think we need any change at all here.  The
only effect I can see is to make the code less robust in the case where
the user doesn't explicitly detach the clock which is not something we
document as mandatory and doesn't strike me as something where there's a
pressing need for it to be mandatory.

--W7E4tre6vxSM9BnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxXZ8ACgkQJNaLcl1U
h9Dg4wf/Yi1gkgbrwRTCZisVK49mT6spurF29s3Y+7jEwoSmMpRREJzNfu0K4SY7
Q2Gh41aA5fdrmq0RpZE+zUNjqndW54EPrH9pI6JKtYuMfN5+32odfqgJlGo5VPGj
56jGXnwCbX2SYD0l3sS+8evsiwm5B8bm7l6gfpqyemiOX2ZAUf3EKCefDRivPX7s
POCxv1WTyBXZVdVJA+iv/pNuU3tBSXylPR5PIu8eJp7RcFCp4Te+Bwf4o1bkCNR5
daJ9LebnED4Sf+U5esSEX/6E9ZymWNQuWHr32q4R4SYqmaOJkuS+HN3bHqAxf/Ja
sp7dKEUC7avlEI+7H00VTx/hUcOwTw==
=nTGk
-----END PGP SIGNATURE-----

--W7E4tre6vxSM9BnJ--
