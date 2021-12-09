Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1E46F3C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhLITUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhLITUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:20:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9110DC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B083B82614
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 19:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43FCC004DD;
        Thu,  9 Dec 2021 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639077388;
        bh=VqPjE74hUiM+wV9wag+bjqN/URzt4NeUOb8KYkowL5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjEvlS5+hQU4fB/H9lpg9Ts/lSab8T1RBLIEr589scWZqkl2Bkc/dPI+bzGs41I1O
         BUFfIjluzuUFhqYpPFUf0nc7HO5X2+z0sJkezTb4W1fNDBrAnLSdcZ1p86+5bNkA77
         N1Me/mr3L1zj2Oqq22/KDABOSN66s2/TffrX0dp4AQY7sMTgf/tfmUBtdhdfFTkyXb
         Pv88yhhaO1I4+7uHsMV4Srg/ENdeH4OoXslRUXnguMCWvz/mBK7ekTpI7lhYidVpWB
         iKRDjFboULkE8YiJBUnEV02p6l9yjJkg/tq/RRjzsL6Yofwc7BBSCkghSZZI5e6CBn
         Mb0i4gW2ffuDg==
Date:   Thu, 9 Dec 2021 19:16:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        perex@perex.cz, linux-mediatek@lists.infradead.org,
        lgirdwood@gmail.com, Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: Remove pm_runtime_put_autosuspend() for SOF
 OF device
Message-ID: <YbJWBpxHo4zN4zFJ@sirena.org.uk>
References: <20211209174657.141268-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hEvhH7N569Hzdzpj"
Content-Disposition: inline
In-Reply-To: <20211209174657.141268-1-daniel.baluta@oss.nxp.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hEvhH7N569Hzdzpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 07:46:57PM +0200, Daniel Baluta wrote:
>=20
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---


You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--hEvhH7N569Hzdzpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGyVgUACgkQJNaLcl1U
h9DXDAf/V9WKvYxWtyKZWaVx8aEh0kubvlvQRgFVA9NuUrK8ERYh83ykeUpVX6JC
3x8VgygJLVz00vpIZ7/+Xe6kmpHTezjzdhKayOtXEdBr8uGA4UaTErSb8DWpYJ5f
Es7u+0jIIOJa2QvHRgTmAq2EllPEEgQ4rt2aISxj/tUEhWHdF6ElY//3EzZXxf82
U0fQq8LHRPfPdjrywngBPVbyGOUgXzM3FAYCatVYdG2cclJejWWHPD6Zc44TRIc9
H2qDFnaEzZTvdQ6ZNvhkK9w4QLeh80YSWplXHoSLWuG/vqdivqNJkqgPqFDra4Iw
bPaNP6k50hPDeiFdIWPFIhUH989GSQ==
=BmDs
-----END PGP SIGNATURE-----

--hEvhH7N569Hzdzpj--
