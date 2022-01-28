Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D84A00AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350817AbiA1TL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:11:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34858 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiA1TLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:11:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0086B826E6;
        Fri, 28 Jan 2022 19:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0644FC340E7;
        Fri, 28 Jan 2022 19:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643397082;
        bh=nEtRS4da8A0SmzOxcQ3RPNezBvSUb6/LzZRgw/9lq2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLCC6rhhkXfPKby3V9ApuHBOZplcpuZbCFe2cgd61MP9BTM4XlZ3NQnYkBDcOqHu8
         5XZJMCAObah5qnRXeAu0Sajy4zjDdxf/v6oDFigBHbc2rNwbIXzmQdWo1br2zbWkJY
         J4IngMjXyl+ra+iXhcb2m1jTOEYJPpT5PE70hm72qCKkB8CW3VYQm3q2zrqFg1K4oX
         B26PzSKX7k62V1AevuEqiEkJ8cbK601B+/qhiUK/WVDVBFAVWsJFEvydbcrKcJJ8gO
         1r9UsXgxcKa2x5ttkfK7P/L8rd2J4ns+ep/2beQpzl98t6krTaoTv7c+MnkU96InBS
         /O8YHJDHOnrRA==
Date:   Fri, 28 Jan 2022 19:11:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>
Cc:     sfr@canb.auug.org.au, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?5ZGC6Iqz6aiwTHVXZWxscw==?= <wells.lu@sunplus.com>,
        "lh.kuo" <lh.kuo@sunplus.com>
Subject: Re: [PATCH -next] spi: Fix compiler warning for kernel test
Message-ID: <YfQ/1aJzebxw2GS+@sirena.org.uk>
References: <1643336485-10942-1-git-send-email-lhjeff911@gmail.com>
 <CAGcXWkzM6wbhNFLbYoijq7iS_76nYVod1ySFEDu-BRgnBokEQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CLZg43y2TCF/HuSl"
Content-Disposition: inline
In-Reply-To: <CAGcXWkzM6wbhNFLbYoijq7iS_76nYVod1ySFEDu-BRgnBokEQA@mail.gmail.com>
X-Cookie: Support your right to arm bears!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CLZg43y2TCF/HuSl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2022 at 10:47:41PM +0800, =E9=83=AD=E5=8A=9B=E8=B1=AA wrote:
> Fix compiler warming for kernel test
>=20
> Fixes: f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>

Thanks for adding the signoff but this and the other two patches you
just sent are breaking the tooling - they're sent with HMTL and it looks
like the text parts have been corrupted with at least word wrapping:

> -int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transfer *xfe=
r)
> +static int sp7021_spi_slave_tx(struct spi_device *spi, struct spi_transf=
er
> *xfer)

so the diff doesn't work as-is.  Can you check and resend please, your
normal posting mechanism works fine?

--CLZg43y2TCF/HuSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH0P9UACgkQJNaLcl1U
h9BlpAf/arzffOmwe38Eq6+7Svb1SVF6H10OslQsbhpYHIXILWEO9vxbVKoEKPLm
RrzE+eEN8U8ve8d3fjzZbLkUmH3jU0/dFvVI2J38mg3MoDsinq/PCdw0+XiUKNU7
iUns6AcfJX0GdKSdmm6RwuxAchYUl9OrrvEWkoUG6hY2x42anDHTRyZ2kSPuwwtW
WDNvaZg0UlKwTzuHBp0U55wXLkeML99mQo4Pu3GSaLwLssoWGKrhLGdA7rJKxGg+
Uw+QVmhtAzOONj0n2P5SvdZ8PQ8mBJ69FTooUM+dEuTSGKw+7SW3+x1pTYNwhfRG
CXL+IUmVC32tQAurF/FXqx2RxoSyTg==
=jzUF
-----END PGP SIGNATURE-----

--CLZg43y2TCF/HuSl--
