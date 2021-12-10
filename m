Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DDB4705F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbhLJQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhLJQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:42:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD05C061746;
        Fri, 10 Dec 2021 08:39:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53E05B828D7;
        Fri, 10 Dec 2021 16:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E644C00446;
        Fri, 10 Dec 2021 16:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639154359;
        bh=32AdGksNyXfVNrp8Rvh7BE8TKQa1lauYtfnUpfoLono=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fv2Qkat3XjWJID0EjqzIlO0BfZ+E9JL3VYmE5oh4bSZ+464QnMdzQskb61QQts+vl
         RJkK5ho2fH38e3/HCn3CPST6R6WPqjsIlJP3H3+86TXQLtv7ZK63QzH3/hF0AcQKzV
         gyVsq4AZiKSSId4f/pXP9dfkYNee7XDsEndupMUl6slmCgvqcIOd1aNKbpG6qSB1FZ
         EPIjGJQa2wHuxgqk2gP8i4+RMg4LwHgP6plymL6W4l/A9X131Zmwq3f6MbWDfAznTT
         nCAx7GCMhsv5GPl0GQK49WhNgvxzMS8QUFgs2TqwdQ/w/zjKjqFScRWceOJ1DTs1BN
         kPxEyuyMajQ/A==
Date:   Fri, 10 Dec 2021 16:39:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH] spi: Fix incorrect cs_setup delay handling
Message-ID: <YbOCqbah03qdLQhK@sirena.org.uk>
References: <20211210153634.171580-1-marcan@marcan.st>
 <YbN+cBQlsLprirxW@sirena.org.uk>
 <3c94fa29-6c21-9fbd-b1f5-eb6c846054bb@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n+nKIqKK51EAnd7+"
Content-Disposition: inline
In-Reply-To: <3c94fa29-6c21-9fbd-b1f5-eb6c846054bb@marcan.st>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n+nKIqKK51EAnd7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 11, 2021 at 01:32:06AM +0900, Hector Martin wrote:
> On 11/12/2021 01.21, Mark Brown wrote:

> > This needs a better changelog, there's multiple delays being handled
> > here and it's not clear from this which are affected here or what the
> > problem is.

> cs_setup is affected, I thought at least that was clear from the patch
> summary :-)

This should be in the commit message, the subject line of the e-mail
isn't super visible when people are reviewing - basically, the body of
the commit message should make sense standalone.

> If you prefer, I can resend it with a reference to the spi.h comment.

Yes, please resend with a clear commit message.

--n+nKIqKK51EAnd7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzgqgACgkQJNaLcl1U
h9D8NQf/RH4/0pNggDaJpqCJvUSfbIE6AlkDCulr3IsGAFEAIbhq3OzJjQr4eXLh
qwj2n8VfvwWc5Wb7iGuS6F4JnQsC2zIpyvjGbo7XcsGTWrka1XNQ0xKzGdDtuYma
ubLIIVE1ZlRZM2VFJ4KjOdau0LvX+BMTaMLcP4pnSRl/+bGYdiQAZV/o5cw0sNjA
MQOX9MGy9KapSg3xxa0geijbz9sPeLv10wf2ua7uA9ml32juhcwXEpjB+K/FK+sW
OSe4fsTZQqqlsPCO9jui470WUOv5SoFA81wZPG+7YQeByGSDbuahZpOg/JZstnsS
P2LihXEXipvHDD1rTLTCDI2KEki0FQ==
=9uj2
-----END PGP SIGNATURE-----

--n+nKIqKK51EAnd7+--
