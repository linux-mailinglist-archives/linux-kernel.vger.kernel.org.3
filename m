Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3DF470CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbhLJVmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:42:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34138 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbhLJVmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:42:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6BAC6CE2D3D;
        Fri, 10 Dec 2021 21:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45154C00446;
        Fri, 10 Dec 2021 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639172332;
        bh=LV9ui+LoZ09dCLi3M8fgKyg0G4ZmmnOP+h8yd9lluKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRwvYATMjYz4Nm2aLuSC+YipI9kwGzq8XIk2Eg99optMxBRkpbYEGJZUkux+CoAKP
         Ne5KJxnOLlI63dji3RFtyUq6nPQrVrFFKCIbLuUtZTrE3sS8PhePPg43i/hcXb+lIg
         mB6WwhLdUCD3eXmdot8Uay92v5aQx1PWJfzR2SxmtTHqzSI8GEBB7nZWE+gh0rW33Q
         iIBkR9uWSUj4VnJAxiQQwD/i0oHWJUdgh+j8Ke+8DUkZdzZ5M6zkEfZOtOoy+B0HAb
         bWK5LHIHqEr7zIeUG4bFq5pVkDDpN3hUwapVcO5Zqm2h9k00N+tnPeI3Ph7CV4Tg9/
         yjmVGOa/i6/pw==
Date:   Fri, 10 Dec 2021 21:38:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     sfr@canb.auug.org.au, linux-next@vger.kernel.org, jeyu@kernel.org,
        mcgrof@bombadil.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Next/Trees: update the modules tree
Message-ID: <YbPI6Novz3ikiKEI@sirena.org.uk>
References: <20211208195931.3369500-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bUaiORlw3qU9OGY1"
Content-Disposition: inline
In-Reply-To: <20211208195931.3369500-1-mcgrof@kernel.org>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bUaiORlw3qU9OGY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 08, 2021 at 11:59:31AM -0800, Luis Chamberlain wrote:

> pull request which was merged for v5.16-rc1. I'll queue up fixes
> on the modules_linus branch.

> those in the modules_next branch to match parity with the same style

Actually, note that your e-mail says the branches are modules_X while
the diff says modules-X which looks like it's the correct thing:

> -modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git#modules-linus
> +modules-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-linus

> -modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git#modules-next
> +modules		git	git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-next

--bUaiORlw3qU9OGY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzyOcACgkQJNaLcl1U
h9At9wf/XiQIUoVnn5gjhBAUrkFwuGr8OUFGp+pgYzzr5DdsJmdxpn5zq2v+f1WN
Nxfbob7TD633b8tLlCoiPh1ucdAFKyAyeTMZHnAuSRu11n6orjgEXhuAv7IgapOi
MW8nWBJL1Pco4nQspBsLigNyrjxwPrb+NLAGgXcD0F1E80ohcxnGRBjxLW4xwfrO
zf2PZKvyoZoiULFaA3LykkR1V0c7IPw1s+5KIS46D3/+IYLpEBgUZaKTb5V2Epdc
hlX9faQH6rgK1JCVuTY9PR+FaCwPdpieMJteEmSEFVe507M81OGvzBsXtSPnFGEB
lCp+rEZUZpDjVLQs3bSsWeC93UBgew==
=kUqG
-----END PGP SIGNATURE-----

--bUaiORlw3qU9OGY1--
