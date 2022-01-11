Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E69348B3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbiAKR0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:26:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43084 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbiAKR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:26:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6568EB81C01;
        Tue, 11 Jan 2022 17:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C43C36AE3;
        Tue, 11 Jan 2022 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641921979;
        bh=+USC2U210eNPZ+gGshSrTxgkE8++ZidiVRNzC37IG8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUslgCvzMWyjlcrZ6gTSHZAyRbpXwq56Pos/HFPUqTWplqQtjCYmXA3t8yBCHDuyO
         sk0YWNpoVY416UjjHojvnooAsygaXWxvkXu4uma7+Hmt9Ez8vaSgBoQe3TpozY2Pls
         g4n6Cmsi3JCT1vVw8sWtM2c01DBtdOs8OOkDBgvlR53h73Z0ZTPoDU+Kf+k/rjkTsM
         w6DYvgbwPDd+nFl3CmHKLorS23ug/0byIO/xvaWOsfEbt9Wc9esRYcB1YojSaGm+++
         9c2rL2ybunT1F9GKF7MIo2hyTL0ZffIvZ6gZwFrL9xma/hYYVGaDQ1Y/SZEmz8xlIi
         iVrSEbsFJ9QYQ==
Date:   Tue, 11 Jan 2022 17:26:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: add bindings for TI TAS5805M.
Message-ID: <Yd29tk6ZJgDFDvVI@sirena.org.uk>
References: <61dccc5c.1c69fb81.9af91.0df6@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pespAewDyHzmcXC6"
Content-Disposition: inline
In-Reply-To: <61dccc5c.1c69fb81.9af91.0df6@mx.google.com>
X-Cookie: Many a family tree needs trimming.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pespAewDyHzmcXC6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 01:00:09PM +1300, Daniel Beer wrote:

> +  ti,dsp-config: |
> +    description: |
> +      A byte sequence giving DSP configuration. Each pair of bytes, in
> +      sequence, gives a register address and a value to write. If you
> +      are taking this data from TI's PPC3 tool, this should contain only
> +      the register writes following the 5ms delay.

This doesn't look appropriate for DT, it looks more like it should be
loaded as firmware since systems might want to support multiple
configurations at runtime based on use casea.  It would also be good to
have code to validate that any supplied coefficeints/firmware don't
overwrite registers managed by the driver, just in case.

--pespAewDyHzmcXC6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHdvbUACgkQJNaLcl1U
h9B+qQf/RAvCDjhhHqPNniWnFRpjbe5z/2NuAauqqYPNQYky/skCoi7zrmxcDK4w
rT59+xQSENPoqc+ribF28qL5PE1XMPyqU+IoplUZ01rwJ+gXBScRECdnpK0geABv
jWnM2ofpoy1pgAweDEbTi9NiSBGrcOZUrIsN+vVEvKIe45BZ5mV+BmCTMY7m2zl7
gY0Vvo2wNEhWQmL7B9+6WxNijM7V5SoS8S3KQ/kLudr6Q2ey2ZkD5qq2VpxAUV6t
qqyDh/agk+j8uhyvn9Rpxem25jDl/7fM4kBMsKAKokYvvKb79rmwcA46mqYwK5D6
mPevtQRnZDGKTZ/mC2IrK8t8xYx2pA==
=uhKS
-----END PGP SIGNATURE-----

--pespAewDyHzmcXC6--
