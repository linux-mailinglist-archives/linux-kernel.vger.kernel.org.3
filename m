Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB5D4864F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiAFNJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:09:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45076 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiAFNJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:09:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4DFBB8210A;
        Thu,  6 Jan 2022 13:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8421C36AE3;
        Thu,  6 Jan 2022 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641474555;
        bh=2l1DW87RTLjlD5d4ykrkd+Y9uf5zuDC4YTgmnjRDJGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjFJuSsW+qB9yjNh9gbpGsIDAHDGRNhLiaLFMbx8hI8Y4Rt9/2a6+EkkcAvMoHQPl
         sVBF2IjGic2E0IbxbCdA733iwMJQJayHKTOYO85f93AY7+kXiosMV05GsMUVWVOIht
         X9D9QP9Mog0CEmlBXenlk0WuO06yFEO6Tdkd7esnVDWhflTFL84RIzSq6xA5Z9MEJT
         pLhpOH5D0f31i5cY8H70hzzmPzS7GGIGGM/3urrHnc1AFs+YMvDMdp2OwdzRAlyqIq
         iVasunEKNRvcLaSevU/LqAP73c31+cHe8kbGwNumDLkTWHiA0YvMd7QqqHA/pGulOn
         mQgxEt30PhbDw==
Date:   Thu, 6 Jan 2022 13:09:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 4/4] dt-bindings: regulator: Add MT6358 regulators
Message-ID: <Ydbp9jFDLcvpiPxa@sirena.org.uk>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-5-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/S1CJoVPmII153IL"
Content-Disposition: inline
In-Reply-To: <20220106065407.16036-5-johnson.wang@mediatek.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/S1CJoVPmII153IL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2022 at 02:54:07PM +0800, Johnson Wang wrote:
> Add buck_vcore_sshub and ldo_vsram_others_sshub
> regulators to binding document for MT6358 and MT6366.

Reviwed-by: Mark Brown <broonie@kernel.org>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--/S1CJoVPmII153IL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHW6fUACgkQJNaLcl1U
h9Bd3Qf/VGYYlc0k3nHmljIk50ogNHmedMadR2yeoWKgB/fCuVp8D2jvPh0K2NQb
YcEL+4v7nnw01FwsMhLWNoKTMwpGREfLJrsGCHPAujHXB0EqN/rMybXrU0F3wsWj
lFlxsttjSiO0iQk0UBrqOj27hztfeUwWRwqydFVvfo47HcUkxnXg7cJga60utgRi
WNx+jtcYP4XNrXGjhRogoGEnyB5VeHaZpumlfRDjrkc4BHq53uJqrGyymNsajXNY
3nj18IKxKe61lBXwWoCKgXve5i0P5Vo/li6x8jrCBYSpjhvmEn9mQq6P/bp6IaMU
jxooUQBFW1i9mFWrle1hZhzGF7qpAw==
=6BYs
-----END PGP SIGNATURE-----

--/S1CJoVPmII153IL--
