Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC5A47910B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbhLQQNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:13:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51500 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbhLQQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:13:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 78E22CE2547
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FCFC36AE8;
        Fri, 17 Dec 2021 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639757614;
        bh=4wOYAtqEbK69OSQibt2ZtBO/menDZY2LaKMDtoqas4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEwKpG70bMkEVxM261CxIJM2yLmgPuvIw8vFpWOZJZDJ4cw+8ZkCfuH/OEL6br4On
         PmfihrrIlryRrIlgKqwnLdsDN05HVFg4/pnwzsbMntKgyeJhTGOIw7bIyyH69K1Vbj
         yJkRTjJiaZhhlBOyvr1AntR+u60YGjRBKBjkCzhqBvW6yA9HkZUbHWkARG3F3SLsFR
         sOxUgi2SZIuu7QLsuGe7qbFRO0xv+EBdcHl+Oxp3mnUBQl2IDd9h79GTuJqNT7tC5u
         mIJ48aG+JfpXI4+o9JN8ZQDyuw44nu09Qq7pzNjixi5N3ixAeipEIb2NSzW2x3oO9d
         hVbG84eMo4NrQ==
Date:   Fri, 17 Dec 2021 16:13:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isoc: mediatek: Fix dereference of null pointer while
 alloc fail
Message-ID: <Yby3Kk0SzEZwNkNu@sirena.org.uk>
References: <20211217152044.675428-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b6+QGlVr4tfa7Dj9"
Content-Disposition: inline
In-Reply-To: <20211217152044.675428-1-jiasheng@iscas.ac.cn>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b6+QGlVr4tfa7Dj9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 11:20:44PM +0800, Jiasheng Jiang wrote:
> The return value of devm_clk_get() needs to be checked.
> To avoid use of error pointer in case of the failure of alloc.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

I'm getting really annoyed with this...

--b6+QGlVr4tfa7Dj9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8tykACgkQJNaLcl1U
h9DQJgf+LWui0F0zp3H7cavKZQQNOaoXP8fwZwuHoKfVx807JPO42fGl0JyJpARY
wilxOhyTo+iwRlL17k91DhtZtYaMt7DnVU/hdWwYVPAQKBYSch4CMeqSCpabufRy
R1Jb8aAe2/NNG0p5UYDfw6mMTvAs0OHR9skp8xwBm/dEB7nNdwoskAC6uAH9KwaX
fXP6830m0EJ0kLmWaMsr7w4+9uBsc/mmYGVdD+i1gFGF+yGPakNPn0o7Sa/k1uDJ
e/qr7XEeLlLiwPjVWozmUGY0nxn5PcX1vw81e4GbXexqAsWQ/nf48eoWuPKsC0Yc
o8nVrgDaNnWUpZMdBHw+VStMyzYBVw==
=Cnk2
-----END PGP SIGNATURE-----

--b6+QGlVr4tfa7Dj9--
