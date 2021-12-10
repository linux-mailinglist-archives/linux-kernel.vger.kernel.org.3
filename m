Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A594E470633
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244104AbhLJQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:51:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53310 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbhLJQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:51:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC6CDB828D7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 16:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F41C341C5;
        Fri, 10 Dec 2021 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639154871;
        bh=6ULRFlF6ggAUebNwOsW20mMAGwZd17GitGH1nC/qLc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S86sY7tCtmaIad9AR7OGz+bxVwKLFTNZr/3GJs5jBRVv+nc/sx/7x6ySIqhVjSfZm
         Ng3QoJfjsey7EeJ3Q/k3s2slWZmePliSrV5yI2rAbjZfHtVuoiyA1rSau0tXBA9O4y
         mD4/vN0vfpvOJ6WmzyR7iofd6YWoHyVcWuXIL4ykgKYtwgn9gJbHg5rBMzNY0RjgvY
         3tXtUhcitAmwbEPnSpg1PJNxc+2X4ZjvqFM+210itrQBzKoErD1tru2Ko899QRt/mt
         +D4G6vWmTtSH7zR8mD2lhkIqIHjk5EwLwlzO0+Q3UIZF8CD4z2aFP+OuS1/LvqvPYm
         srqPUpYR3dGzg==
Date:   Fri, 10 Dec 2021 16:47:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shumin Chen <chenshumin86@sina.com>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/2] ASoC: convert Everest ES8156 binding to yaml
Message-ID: <YbOEs4HCdJYA3j/1@sirena.org.uk>
References: <20211210151041.108751-1-chenshumin86@sina.com>
 <20211210151041.108751-3-chenshumin86@sina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sZ83QS/cFF5Ofdsn"
Content-Disposition: inline
In-Reply-To: <20211210151041.108751-3-chenshumin86@sina.com>
X-Cookie: One picture is worth 128K words.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sZ83QS/cFF5Ofdsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 10, 2021 at 11:10:41PM +0800, Shumin Chen wrote:

> +properties:
> +  compatible:
> +    const: everest,es8156
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock for master clock (MCLK)

This was optional in the code but is mandatory in the binding.

--sZ83QS/cFF5Ofdsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGzhLIACgkQJNaLcl1U
h9Aywwf/bCaMMeg4FUrNaO8S3/ctSVTmAVyydCmnsYgPm74lkejOxnCZld4ngSK7
oE+sJqtPCCWgv0N4MFkJmjHZqmDQZGUDiLHhcmPnlNxoZcpH/hVGz9wk5EIEPn0I
xC7vilb8j6ps7H5g/y4E7JrcMt7Smb6t9l9WbcreLp7EWPGr342wW+ZJH7yNwbnR
nWvhSWlBgpRWfgywA52ZHNvEav44GA6UVJzamV2jAn3JRUrsEFI4sYBsMlxGv4Sh
/2wQiGJQA4hErHQAQIXR3P22YeSzQN2Q5jVmASJi3DRVqB6yLdWp3MNl6LQ4wgN2
Xb+mSBqCgZliigQPnFNdwPqSNjKHnw==
=o+40
-----END PGP SIGNATURE-----

--sZ83QS/cFF5Ofdsn--
