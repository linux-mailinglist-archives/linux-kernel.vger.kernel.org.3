Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0248A493E53
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356146AbiASQao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:30:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56892 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356145AbiASQaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:30:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 095FBB80E09;
        Wed, 19 Jan 2022 16:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955B2C004E1;
        Wed, 19 Jan 2022 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642609836;
        bh=NPkrUgRYzcxwa3lnZh2dJ3qyPo1V5StcWneeKtWaOTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GMhWu7C3B60BdL8/99pPFWzH0CB7LU7Dz7GFXyQtbGWeKeKQJEE+V2fEbRhv/QrJW
         yYagtUm7pysfgqkJMyR27/xktDwbdWcoif82n5bf4F716uAgvyW4CrM7nnlUKhGZf0
         FU8zZ8ZvZl+QEyzj+ByrVczubpcuk9CdfXWCIEjg23SntmAfLaHiquJ5KbvTGWQWfn
         Hr8GUX32FKay/k82RyllkJOyRWhWEFPpRz5SEs7TiLsMcVgix5+RDcoF6No3Mm8HeE
         dgP9NlrSSG2qLfoDBPumyLb9lbK1A0ADtU3DkLXQ9hZS91Urze/uzDqpkaas6/c5dZ
         OCMIIrEVF0X5A==
Date:   Wed, 19 Jan 2022 16:30:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        - <patches@opensource.cirrus.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] dt-bindings: Drop unnecessary pinctrl properties
Message-ID: <Yeg8pWYUwWKqOjhe@sirena.org.uk>
References: <20220119015325.2438277-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pa3KE12yHs9Xnd2D"
Content-Disposition: inline
In-Reply-To: <20220119015325.2438277-1-robh@kernel.org>
X-Cookie: This bag is recyclable.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pa3KE12yHs9Xnd2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 18, 2022 at 07:53:25PM -0600, Rob Herring wrote:
> For a single pinctrl mode, it is not necessary to define pinctrl
> properties as the tools always allow pinctrl properties.

Acked-by: Mark Brown <broonie@kernel.org>

--pa3KE12yHs9Xnd2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHoPKQACgkQJNaLcl1U
h9CK5ggAgSoOi6gEd+9fFCP6FCxOQatzUUojOHSGhmWyvIDZNwu17IQjUqhzZ5Lk
8Z9Or7iFzVcEVfaKQ0w1HRWHQIrPLjnGtm1pnD26p3iqmdDC/1hDvKb/kd7EjOmF
NEx6LRQoJL0LQX9I/c8rkwoW5mXpxaBck270IlQAaOI5/iOQFHp2oDn02Csbli0e
XtJH3S6dPtjKQN/+SC9ruVF3usw6u4Vxi5FNXA1ABQYeKP+4/lyft2SWzGZEShhy
Kmn6JJCH6fa4Aqbz85d4dpvuG9t9ukvdK8zrRCpsH2xw8AlHDeJtcDG6/LXw5hPG
u+NgtzFSWl0tPBvoyeSNpNi3YEkbyg==
=vG1Q
-----END PGP SIGNATURE-----

--pa3KE12yHs9Xnd2D--
