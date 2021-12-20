Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6106F47A9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhLTM5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhLTM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:57:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD27C061574;
        Mon, 20 Dec 2021 04:57:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED2136104D;
        Mon, 20 Dec 2021 12:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611DEC36AE8;
        Mon, 20 Dec 2021 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640005072;
        bh=pewh3AlWMe5plAWePnKDnUBSLaArfevPs/u+jV6kgLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=at4Wqri4EnCyzlcrOTehdUmeiLD+KwpiApzE8sJfQ1VI9wXwUAklMHO1qzmGrS4Xo
         Mj3E/kUMMDsAgDE+6F2kMqhN+W40DXkgnl3Ov2zPgk6sOKOg8eWDMJg+ObgkmGy0JY
         R03KkJizMeAc/9H1bxYg2DHtT+NU8WAPcfrn2eF6i0xcA5KHX6tRcZC3Y6iUoDN1B8
         ThefWEEPo8Gf5DXC9z9HjNOJkMC+NFWliSR4fg8/v0kPZ2WC61Jgyh9dw1kXBx97fx
         j7JmBis8qv+8raaw7960yXNRq9CT8AQNLNoinc2ygaXZNAuMKj6NBZXWym7JJfh7ww
         2Vcy6uFV1PccQ==
Date:   Mon, 20 Dec 2021 12:57:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, bgolaszewski@baylibre.com,
        sean.wang@mediatek.com, bayi.cheng@mediatek.com,
        gch981213@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7 2/4] dt-bindings: spi: spi-mtk-nor: add new clock name
 'axi' for spi nor
Message-ID: <YcB9ygan0g/13Uz5@sirena.org.uk>
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
 <20211220121825.6446-3-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TR47X5VnHL9xPYNY"
Content-Disposition: inline
In-Reply-To: <20211220121825.6446-3-tinghan.shen@mediatek.com>
X-Cookie: Christ was born in 4 B.C.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TR47X5VnHL9xPYNY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 20, 2021 at 08:18:23PM +0800, Tinghan Shen wrote:
> Some mtk spi nor has dedicated dma(s) inside. Add a new clock name, axi,
> for spi nor dma bus clock.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--TR47X5VnHL9xPYNY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHAfckACgkQJNaLcl1U
h9Da1Af+K65qLUvTTB2A+4DEfiym3syrCFx3PTWGF/cCBhyV8nzoEtsYcqGUOTFi
AoS7keXjHItQnMdIhdJKLoIWVBxaYPq6kYzmSRNauSh+nYZmPD+6MDCWW4Kytj6w
tjbpSyxR3kQVv0dcMyVd+s7tajVRhYalDTDR7BUNMhA8hAvlxm9zm0Og/hxY1sUl
hY8M2Tc+DftJEY2B298TfS53ZwaHhI+m8rs7xLBQOg1UpObq1tqWJ/Hkt4nMbMxg
bdB8oVMMHLWHFoNpWoHJymPXXgZ35SqQxLnmBnAhHjwBnzFtwSl0ErFCiQ+2HdoJ
VvRxydsrTOpysC3/AWesYz9Ej3ghUQ==
=hs52
-----END PGP SIGNATURE-----

--TR47X5VnHL9xPYNY--
