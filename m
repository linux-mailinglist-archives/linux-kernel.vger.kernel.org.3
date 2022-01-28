Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261AB49FA52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiA1NGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:06:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34298 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiA1NG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:06:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C89C61C50;
        Fri, 28 Jan 2022 13:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F72C340E0;
        Fri, 28 Jan 2022 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643375186;
        bh=Is4olLhsk3j3j8qTWxE/Zeo3FckilHNlsQ9Vsr92LR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxHVqdphzE5X65rhBYzku+ROQZ7aH2C2kVbgzXgCFeRoMOCeiHDTKzyYC5JXPCx8O
         qLJIElrOFLMEc6J7VO8RKxlV06WAYysknXqJ/90758o/XCcmaZwOUEkZYhg+xnHe8P
         8KIa4AQMDgUwzwjeJvYg8IfmtPPcDN2Xopvt1l3bUCe599gs10SVIB3J1bO5OYifU0
         rtkA+fCVMLIjBMkb0pYl7JvLOeqDVmVun9zBrVvQF1MQRXPF7xeLmYDXkMZPx4uN6H
         KVZy/JdC6uSH2CyrpJCCu9yJh/ASWXV+aQj4LcD8oIsWXHJ+ig92ZcxWx+sdeutxQk
         ClKOKWSVWEsnw==
Date:   Fri, 28 Jan 2022 13:06:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: Centralize the 'sound-dai' definition
Message-ID: <YfPqS8v7ZtT6HDyS@sirena.org.uk>
References: <20220126231427.1638089-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YNdayVbVmdPYqrJn"
Content-Disposition: inline
In-Reply-To: <20220126231427.1638089-1-robh@kernel.org>
X-Cookie: The Moral Majority is neither.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YNdayVbVmdPYqrJn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 26, 2022 at 05:14:27PM -0600, Rob Herring wrote:
> 'sound-dai' is a common property, but has duplicate type definitions.
> Create a new common definition to define the type and then update all
> the other occurrences to just define how many entries there are just
> like other phandle+arg properties.

Acked-by: Mark Brown <broonie@kernel.org>

--YNdayVbVmdPYqrJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHz6koACgkQJNaLcl1U
h9B49Qf+Jhz1zqYprzEs4mjpHmY22CKnG6zMmgy5bCBIfVwqA0nwKfsC9ul8fXXL
NcltbAqGcCxr7u0lJoXY3h/Oob0gwpuqzMMyS+bUHzXQPnK994clJApOdV/J7UXC
YJpbL78jiNhLsi9SZP9cTucY/LJTMEpN595HZ2+LPO6xeY6tq9RP4EWQj/0zvSn/
dO3Z1egfcbsjKVGilRNKIjeK9WfKUdpRAwv3AS+0wSglY+fsSrpNe7Fij2CUN5zs
nNlnVrsIvRZ45CK8pgK3YOkcvaWp/9GgS4+4+DJXwtVH8V8shpAsK/dxY+ddPhdK
5xeCdZoQNFc+Ixkd9EQwLZLSUgKTOw==
=AKJ7
-----END PGP SIGNATURE-----

--YNdayVbVmdPYqrJn--
