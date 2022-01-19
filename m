Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7930493E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356227AbiASQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:46:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34812 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiASQqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:46:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C0BFB819A8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D772C004E1;
        Wed, 19 Jan 2022 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642610811;
        bh=jcFYJMa4KHuzmvPQKCs7JdmJXADGOrQOZ7yiO5vDztM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufL4z/Kq1K7yccutI10koc9w/C/Ue7o6ubD5rp1l79h79Z7FIFu+0LwtIG6T8yzHP
         7tjEGxGQBcosFEhSwZcWkjNaNPRA4PThoZWefyDJiVcpRHLqArASg+i4fxGQ+KTAcF
         vPpfN6iTnXt9MezWt4gUCi2YftxdJkUVbMS+oiuCcrxiXTmIcBlndjVH1tbVC/yUY/
         1RCmWEzn94bQ9LVQB6aIEe9CM0jiXrccBRwMpeV10vWJ0uqk6bSVnXLyD/2Aa8jCbG
         rfDEwGy37njcfmFSyXui/bMj1Mz/Gu+Mhs10CTcmrZku/9zTT/lw5T/m/vKuUkEv29
         nEXXIoZV45s6w==
Date:   Wed, 19 Jan 2022 16:46:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: codecs: Check for error pointer after calling
 devm_regmap_init_mmio
Message-ID: <YehAdeQAlPubkNZ3@sirena.org.uk>
References: <20220114065713.1246619-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JFhvXVQvk5tjTnut"
Content-Disposition: inline
In-Reply-To: <20220114065713.1246619-1-jiasheng@iscas.ac.cn>
X-Cookie: YOW!!  The land of the rising SONY!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JFhvXVQvk5tjTnut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 14, 2022 at 02:57:13PM +0800, Jiasheng Jiang wrote:
> Since the possible failure of the devm_regmap_init_mmio(), it will
> return error pointer and be assigned to the regmap.
> Then the error pointer will be dereferenced.
> For example rx->regmap will be used in rx_macro_mclk_enable().
> Therefore, it should be better to check it.

This doesn't apply against current code, please check and resend.

--JFhvXVQvk5tjTnut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHoQHUACgkQJNaLcl1U
h9DHWgf/dwBXaKQcvpj3mwPc9R2yoQkwmc8zfpixVlq00cQOS0JHq2a1st/qcSBq
iqWL4AtENPGRIrw9Lnw6a9u+nwoE76TS7yzt5PNqq1jq2T+kqaO+fMGj62QoVX/u
wNLWTfd0SebMrchZKSXkursHv0CBUydYiF6n/yjgJb3VVj/fhcrrrZ9SOGbfxdyq
17cm7S+bc0r6EMEVIUeSFcSNsWnRayIzP2O5OLkImC0+hUgy6uaI2Vjndg7yCqbZ
WApyAOyqm8Pfhb9CU3PcMupfgB4MqISA+PyeayR5gX6TtxhoGxZbapmDHVB8nN+4
q1liOHkZa9rg2JIg8M1DOzY7R4n0OA==
=MJdS
-----END PGP SIGNATURE-----

--JFhvXVQvk5tjTnut--
