Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5231470582
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbhLJQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhLJQYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:24:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E00C061746;
        Fri, 10 Dec 2021 08:21:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E09DDB82885;
        Fri, 10 Dec 2021 16:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9CAC00446;
        Fri, 10 Dec 2021 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639153269;
        bh=cUhcGYK4VM1LULJA1kfurmuc37a7h1De+Z2Q50OMrXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5/H2zqu9VS9oSra9pT1sQBFd/gRgsEWlKGX1ERP0ZYTMV4YASaAHQFCcMXVSliEh
         mrvP1y4tM7cKXxxP1a3DeGUZgN3RHV5oLyIB7Z3f0lu7/Ftp9r/p1rHcLyQawKbqgi
         CmEckcxgmqPgAG0XKTCeMUJsAejgBb1iFz1+F4UtQVdUbQw7QXjbMif0c2Tht9KFJV
         dq9dUOaCh+MaGGDabbPutS0V1t2a9WDaE0v+tF7OauVxLUegFK+EOC+i9qzYHYgi3h
         a+V55JnaePKTta4qiZKRTkNFSMTCIGVI8BY1/n079xAtEUTHVQ6yiMuGa0HqLvj7FW
         R2AeFRy3U4cGA==
Date:   Fri, 10 Dec 2021 16:21:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH] spi: Fix incorrect cs_setup delay handling
Message-ID: <YbN+cBQlsLprirxW@sirena.org.uk>
References: <20211210153634.171580-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oG67rs8uVZrsEPMF"
Content-Disposition: inline
In-Reply-To: <20211210153634.171580-1-marcan@marcan.st>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oG67rs8uVZrsEPMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 11, 2021 at 12:36:34AM +0900, Hector Martin wrote:

> We need to wait *after* asserting CS and before the transfer, not before
> asserting CS which isn't very useful.

This needs a better changelog, there's multiple delays being handled
here and it's not clear from this which are affected here or what the
problem is.

--oG67rs8uVZrsEPMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzfnAACgkQJNaLcl1U
h9A4bwf/b5ig1twJHTduDBL0ev7T+NRdsZ9+C1sx62KV55e9YuvX2iTSxJHbp3PD
MLRiqMqO1mZDymkZZItw4JkID51gxg5HiGyzHzl3bFPwKxP4oPB0nmKGfIxnolte
dw/KdHHkzGvUw1Fx8PCWylWYGWHirf7SERUKR06LiVlyjEbcrzjZxU9P0kllVgcl
+XvUF2/IOLxH7goamQYrbniTfZkQs+kUTLk8ij7PtyHit/Y9Wga3we8VLxgs+1/J
b1cO5FzoT2sl2jqHJCAiYdmXUFJ0YZrFHQN2u99hu/U/ls/xqVqdJHRkybYDsNMC
Yx4ehk+jJbFByRvRKMdS/tyIYHGoOA==
=EnUb
-----END PGP SIGNATURE-----

--oG67rs8uVZrsEPMF--
